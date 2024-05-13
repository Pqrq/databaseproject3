from django.shortcuts import render
from django.http import JsonResponse, HttpResponse
from django.db import connection
import json
import logging

logger = logging.getLogger(__name__)

# Page renderings
def index(request):
    return render(request, "voleyballDB/index.html")

def manager(request):
    username = request.GET.get('username')

    return render(request, "voleyballDB/DBManager.html", {'username': username})

def coach(request):
    username = request.GET.get('username')

    with connection.cursor() as cursor:
        cursor.execute("SELECT stadium_id, stadium_name, stadium_country FROM Stadium")
        stadiums = cursor.fetchall()     

    return render(request, "voleyballDB/Coaches.html", {'username': username, 'stadiums': stadiums})


def jury(request):
    username = request.GET.get('username')

    with connection.cursor() as cursor:
        # fetchOne() --> bir rowun tammaını çekiyor
        # fetchOne()[0] --> bir rowun ilk column'unu çekiyor
        # fetchALl() --> tüm table'ı çekiyor

        # Average rating of matches that that jury has rated
        query = f"SELECT assigned_jury_username, AVG(rating) AS avg_rating FROM MatchSessions WHERE assigned_jury_username = '{username}' GROUP BY assigned_jury_username" 

        cursor.execute(query)
        avgRating = cursor.fetchone()[1]
    
    with connection.cursor() as cursor1:
        # Number of that jury's rated sessions 
        query1 = f"SELECT assigned_jury_username, COUNT(*) AS total_matches_rated FROM MatchSessions WHERE assigned_jury_username = '{username}'" 
        cursor1.execute(query1)
        countOfRated = cursor1.fetchone()[1]

    return render(request, "voleyballDB/Juries.html", {'username': username, 'avgRating': avgRating, 'countOfRated': countOfRated})

def player(request):
    username = request.GET.get('username')

    with connection.cursor() as cursor:
        # List of players which our player has played at least once 
        query = f"SELECT u.name, u.surname FROM User u WHERE u.username IN (SELECT DISTINCT p.username FROM Player p JOIN SessionSquads ss ON p.username = ss.username WHERE ss.session_id IN (SELECT session_id FROM SessionSquads WHERE username = '{username}') AND p.username != '{username}');"
        cursor.execute(query)
        playedPlayers = cursor.fetchall()
    
    with connection.cursor() as cursor1:
        # Average height of players which our player has played and has maximum height(s) among them
        query1 = f"WITH PlayersPlayedMost AS (SELECT p.username, COUNT(DISTINCT ss.session_id) AS matches_played FROM Player p JOIN SessionSquads ss ON p.username = ss.username WHERE ss.session_id IN (SELECT session_id FROM SessionSquads WHERE username = '{username}') AND p.username != '{username}' GROUP BY p.username), MaxMatches AS (SELECT MAX(matches_played) AS max_matches FROM PlayersPlayedMost), PlayersWithMaxMatches AS (SELECT ppm.username FROM PlayersPlayedMost ppm JOIN MaxMatches mm ON ppm.matches_played = mm.max_matches) SELECT AVG(p.height) AS average_height FROM PlayersWithMaxMatches pwm JOIN Player p ON pwm.username = p.username;" 
        
        cursor1.execute(query1)
        maxHeight = cursor1.fetchone()[0]

    return render(request, "voleyballDB/Player.html", {'username': username, 'playedPlayers': playedPlayers, 'maxHeight': maxHeight})


def check_username_password(username, password):
    tables = ['DBManager', 'Coaches', 'Juries', 'Player']

    query1 = f"SELECT COUNT(*) FROM User WHERE (username='{username}' AND password='{password}')"
    print("Our first query is: ", query1)

    with connection.cursor() as cursor1:
        cursor1.execute(query1)
        result1 = cursor1.fetchone()[0]  
            
        if result1 > 0:
            # Iterate over the tables and execute the query for each table
            for table in tables:
                query = f"SELECT COUNT(*) FROM {table} WHERE (username='{username}')"
                print("Our query is: ", query)
        
                with connection.cursor() as cursor:
                    cursor.execute(query)
                    result = cursor.fetchone()[0]  
            
                if result > 0:
                    print("Printing TYPE")
                    print(table)
                    return table
        else:
            print("girit cagdas ahmet")
            return None

    # If no match is found in any table, return None
    print("ahmet cagdas girit")
    return None


# Credential check endpoint (login endpoint)
def login_view(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body.decode('utf-8'))
            username = data.get('username')
            password = data.get('password')
            # Your authentication logic here
            print("Taking credentials...")
            print(username)
            print(password)
            print("Credentials taken!")
        except json.JSONDecodeError:
            return JsonResponse({'success': False, 'message': 'Invalid JSON data', 'type': 'null'}, status=400)
        
        # Check if the username and password are not empty
        if username and password:
            # Database check
            desiredTable = check_username_password(username, password)

            isDBManager = ((username == 'Kevin') and (password == 'Kevin')) or ((username == 'Bob') and (password == 'Bob')) or ((username == 'sorunlubirarkadas') and (password == 'muvaffakiyetsizleştiricileştiriveremeyebileceklerimizdenmişsinizcesine'))
            
            if isDBManager:
                # If a match is found, return a success response
                return JsonResponse({'success': True, 'message': 'Login successful', 'type': 'DBManager'})

            # Check if the user can be found
            elif desiredTable != None:
                # If a match is found, return a success response
                return JsonResponse({'success': True, 'message': 'Login successful', 'type': desiredTable})
            else:
                # If no match is found, return an error response
                return JsonResponse({'success': False, 'message': 'Invalid username or password', 'type': 'null'})
        else:
            # If username or password is empty, return an error response
            return JsonResponse({'success': False, 'message': 'Username and password are required', 'type': 'null'})
    
    # If the request method is not POST, return an error response
    return JsonResponse({'success': False, 'message': 'Invalid request method', 'type': 'null'})

def add_new_user(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body.decode('utf-8'))
            newUsername = data.get('newUsername')
            newPassword = data.get('newPassword')
            name = data.get('name')
            surname = data.get('surname')
            newType = data.get('newType')
            nationality = data.get('nationality')
            dateOfBirth = data.get('dateOfBirth')
            height = data.get('height')
            weight = data.get('weight')
            mainPosition = data.get('mainPosition')
            mainTeam = data.get('mainTeam')


            # F.d.p
            print("Taking input...")
            print(newUsername)
            print(newPassword)
            print(name)
            print(surname)
            print(newType)
            print(nationality)
            print(dateOfBirth)
            print(height)
            print(weight)
            print(mainPosition)
            print(mainTeam)

            print("Input taken!")
        except json.JSONDecodeError:
            return JsonResponse({'success': False, 'message': 'Invalid JSON data'}, status=400)
        
        # Will be filled (the main logic)
        if (newType == 'coach'):
            # Others are checked at the frontend
            if nationality:
                try:
                    # Adding a new coach to the coach table  (filled_but_unchecked)
                    query1 = f"INSERT INTO Coaches(username, nationality) VALUES ('{newUsername}', '{nationality}');"  
                    query2 = f"INSERT INTO User(username, password, name, surname) VALUES ('{newUsername}', '{newPassword}', '{name}', '{surname}');"  

                    with connection.cursor() as cursor:
                        cursor.execute(query1)
                        cursor.execute(query2)
                        results = cursor.fetchall() 

                    # Process results or return them
                    return JsonResponse({'success': True, 'message': "Query executed successfully."})

                except Exception as e:
                    return JsonResponse({'success': False, 'message': 'Trigger Error: {e}'})
            
            return JsonResponse({'success': False, 'message': 'Nationality empty'})
        
        if (newType == 'jury'):
            # Others are checked at the frontend
            if nationality:
                try:
                    # Adding a new jury to the jury table  (filled_but_unchecked)
                    query1 = f"INSERT INTO Juries(username, nationality) VALUES ('{newUsername}', '{nationality}');"  
                    query2 = f"INSERT INTO User(username, password, name, surname) VALUES ('{newUsername}', '{newPassword}', '{name}', '{surname}');"  

                    with connection.cursor() as cursor:
                        cursor.execute(query1)
                        cursor.execute(query2)
                        results = cursor.fetchall() 

                    # Process results or return them
                    return JsonResponse({'success': True, 'message': "Query executed successfully."})

                except Exception as e:
                    return JsonResponse({'success': False, 'message': f'Trigger Error: {e}'})
            
            return JsonResponse({'success': False, 'message': 'Nationality empty'})
        
        if (newType == 'player'):
            # Others are checked at the frontend
            if dateOfBirth and height and weight and mainPosition and mainTeam:
                try:
                    # Adding a new player to the jury table  (filled_but_unchecked)
                    query1 = f"INSERT INTO Player(username, date_of_birth, height, weight) VALUES ('{newUsername}', str_to_date('{dateOfBirth}', '%d.%m.%Y'), '{height}', '{weight}');"  
                    query2 = f"INSERT INTO User(username, password, name, surname) VALUES ('{newUsername}', '{newPassword}', '{name}', '{surname}');"  

                    with connection.cursor() as cursor:
                        cursor.execute(query1)
                        cursor.execute(query2)
                        results = cursor.fetchall() 

                    # Process results or return them
                    return JsonResponse({'success': True, 'message': "Query executed successfully."})

                except Exception as e:
                    return JsonResponse({'success': False, 'message': f'Trigger Error: {e}'})
            
            return JsonResponse({'success': False, 'message': 'At least one of "Date of Birth", "Height" and "Weight" is empty'})
        
        else:
            return JsonResponse({'success': False, 'message': 'Wrong Type Decleration'})

    # If the request method is not POST, return an error response
    return JsonResponse({'success': False, 'message': 'Invalid request method'})


def change_stadium_name(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body.decode('utf-8'))
            oldName = data.get('oldName')
            newName = data.get('newName')

            # F.d.p
            print("Taking input...")
            print(oldName)
            print(newName)

            print("Input taken!")
        except json.JSONDecodeError:
            return JsonResponse({'success': False, 'message': 'Invalid JSON data'}, status=400)
        
        # Will be filled (the main logic)
        if oldName and newName:
            try:
                # (filled_but_unchecked)
                query = f"UPDATE Stadium SET stadium_name = '{newName}' WHERE stadium_name = '{oldName}';" 

                with connection.cursor() as cursor:
                    cursor.execute(query)
                    results = cursor.fetchall()  # Example fetch method

                # Process results or return them
                return JsonResponse({'success': True, 'message': "Query executed successfully."})

            except Exception as e:
                return JsonResponse({'success': False, 'message': f'Trigger Error: {e}'})
            
        return JsonResponse({'success': False, 'message': 'oldName or newName empty'})
        
    # If the request method is not POST, return an error response
    return JsonResponse({'success': False, 'message': 'Invalid request method'})

def delete_match_session(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body.decode('utf-8'))
            sessionId = data.get('sessionId')

            # F.d.p
            print("Taking input...")
            print(sessionId)

            print("Input taken!")
        except json.JSONDecodeError:
            return JsonResponse({'success': False, 'message': 'Invalid JSON data'}, status=400)
        
        # Will be filled (the main logic)

        try:
            # Deleting a match session  (filled_but_unchecked)
            query = f"DELETE FROM MatchSessions WHERE session_id = '{sessionId}';"  

            with connection.cursor() as cursor:
                cursor.execute(query)
                results = cursor.fetchall()  # Example fetch method

            # Process results or return them
            return JsonResponse({'success': True, 'message': "Query executed successfully."})

        except Exception as e:
            return JsonResponse({'success': False, 'message': f'Trigger Error: {e}'})
            
    # If the request method is not POST, return an error response
    return JsonResponse({'success': False, 'message': 'Invalid request method'})


def add_new_match_session_with_squad(request):
    username = request.GET.get('username')

    if request.method == 'POST':
        try:
            data = json.loads(request.body.decode('utf-8'))
            stadiumName = data.get('stadiumName')
            date = data.get('date')
            timeSlot = data.get('timeSlot')
            juryName = data.get('juryName')
            jurySurname = data.get('jurySurname')

            player1Name = data.get('player1Name')
            player2Name = data.get('player2Name')
            player3Name = data.get('player3Name')
            player4Name = data.get('player4Name')
            player5Name = data.get('player5Name')
            player6Name = data.get('player6Name')
            
            # F.d.p
            print("Taking input...")
            print(stadiumName)
            print(date)
            print(timeSlot)
            print(juryName)
            print(jurySurname)
            print(player1Name)
            print(player2Name)
            print(player3Name)
            print(player4Name)
            print(player5Name)
            print(player6Name)

            print("Input taken!")
        except json.JSONDecodeError:
            return JsonResponse({'success': False, 'message': 'Invalid JSON data'}, status=400)
        
        # Will be filled (the main logic)

        if player1Name and player2Name and player3Name and player4Name and player5Name and player6Name:
            try:
                # Adding a new match session with its squad  (will_be_filled)
                query1 = f"SELECT team_id FROM Team WHERE coach_username = '{username}';"
 
                # Squad addition
                with connection.cursor() as cursor1:
                    cursor1.execute(query1)
                    results1 = cursor1.fetchone()[0] 

                query2 = f"SELECT u.username FROM User WHERE (u.name='{juryName}' AND u.surname='{jurySurname}');"
 
                # Squad addition
                with connection.cursor() as cursor2:
                    cursor2.execute(query1)
                    results2 = cursor2.fetchone()[0] 
                
                query3 = f"SELECT s.stadium_id FROM Stadium WHERE (s.stadium_name='{stadiumName}');"
 
                # Squad addition
                with connection.cursor() as cursor3:
                    cursor3.execute(query1)
                    results3 = cursor3.fetchone()[0] 
                # str_to_date('{date}','%d.%m.%Y')
                queryf = f"INSERT INTO MatchSessions (date, team_id, assigned_jury_username, time_slot, stadium_id) VALUES ('{date}', '{results1}', '{results2}', '{timeSlot}', '{results3}');" 

                with connection.cursor() as cursor4:
                    cursor4.execute(queryf)
                    results4 = cursor4.fetchone()[0]

                

                # Process results or return them
                return JsonResponse({'success': True, 'message': "Query executed successfully."})

            except Exception as e:
                return JsonResponse({'success': False, 'message': f'Trigger Error: {e}'})
            
        return JsonResponse({'success': False, 'message': 'At least one of the players is empty'})
        
    # If the request method is not POST, return an error response
    return JsonResponse({'success': False, 'message': 'Invalid request method'})


def add_new_match_session_without_squad(request):
    username = request.GET.get('username')

    if request.method == 'POST':
        try:
            data = json.loads(request.body.decode('utf-8'))
            stadiumName = data.get('stadiumName')
            date = data.get('date')
            timeSlot = data.get('timeSlot')
            juryName = data.get('juryName')
            jurySurname = data.get('jurySurname')
            
            # F.d.p
            print("Taking input...")
            print(stadiumName)
            print(date)
            print(timeSlot)
            print(juryName)
            print(jurySurname)

            print("Input taken!")
        except json.JSONDecodeError:
            return JsonResponse({'success': False, 'message': 'Invalid JSON data'}, status=400)
    

        try:
            # Adding a new match session with its squad  (will_be_filled)
            query1 = f"SELECT team_id FROM Team WHERE coach_username = '{username}';"
 
            # Squad addition
            with connection.cursor() as cursor1:
                cursor1.execute(query1)
                results1 = cursor1.fetchone()[0] 

            query2 = f"SELECT u.username FROM User WHERE (u.name='{juryName}' AND u.surname='{jurySurname}');"
 
            # Squad addition
            with connection.cursor() as cursor2:
                cursor2.execute(query1)
                results2 = cursor2.fetchone()[0] 
                
            query3 = f"SELECT s.stadium_id FROM Stadium WHERE (s.stadium_name='{stadiumName}');"
 
            # Squad addition
            with connection.cursor() as cursor3:
                cursor3.execute(query1)
                results3 = cursor3.fetchone()[0] 

            queryf = f"INSERT INTO MatchSessions (date, team_id, assigned_jury_username, time_slot, stadium_id) VALUES (str_to_date('{date}','%d.%m.%Y'), '{results1}', '{results2}', '{timeSlot}', '{results3}');" 

            with connection.cursor() as cursor4:
                cursor4.execute(queryf)
                results4 = cursor4.fetchone()[0]


            # Process results or return them
            return JsonResponse({'success': True, 'message': "Query executed successfully."})

        except Exception as e:
            return JsonResponse({'success': False, 'message': f'Trigger Error: {e}'})
                  
    # If the request method is not POST, return an error response
    return JsonResponse({'success': False, 'message': 'Invalid request method'})




def create_squad(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body.decode('utf-8'))
            squadSessionId = data.get('squadSessionId')
            squadPlayer1Name = data.get('squadPlayer1Name')
            squadPlayer2Name = data.get('squadPlayer2Name')
            squadPlayer3Name = data.get('squadPlayer3Name')
            squadPlayer4Name = data.get('squadPlayer4Name')
            squadPlayer5Name = data.get('squadPlayer5Name')
            squadPlayer6Name = data.get('squadPlayer6Name')


            # F.d.p
            print("Taking input...")
            print(squadSessionId)
            print(squadPlayer1Name)
            print(squadPlayer2Name)
            print(squadPlayer3Name)
            print(squadPlayer4Name)
            print(squadPlayer5Name)
            print(squadPlayer6Name)

            print("Input taken!")


        except json.JSONDecodeError:
            return JsonResponse({'success': False, 'message': 'Invalid JSON data'}, status=400)
        
        # Will be filled (the main logic)
        try:
            # Creating a squad for a match  (will_be_filled) (this has lots of stuff)
            query4 = f"SELECT u.username FROM User WHERE u.name='{squadPlayer1Name}';"
            query5 = f"SELECT u.username FROM User WHERE u.name='{squadPlayer2Name}';"
            query6 = f"SELECT u.username FROM User WHERE u.name='{squadPlayer3Name}';"
            query7 = f"SELECT u.username FROM User WHERE u.name='{squadPlayer4Name}';"
            query8 = f"SELECT u.username FROM User WHERE u.name='{squadPlayer5Name}';"
            query9 = f"SELECT u.username FROM User WHERE u.name='{squadPlayer6Name}';"

            with connection.cursor() as cursor5:
                cursor5.execute(query4)
                results5 = cursor5.fetchone()[0]
                cursor5.execute(query5)
                results6 = cursor5.fetchone()[0]
                cursor5.execute(query6)
                results7 = cursor5.fetchone()[0]
                cursor5.execute(query7)
                results8 = cursor5.fetchone()[0]
                cursor5.execute(query8)
                results9 = cursor5.fetchone()[0]
                cursor5.execute(query9)
                results10 = cursor5.fetchone()[0]

            query10 = f"INSERT INTO SessionSquads(username, session_id, position_id) VALUES ('{results5}',{squadSessionId})"
            query11 = f"INSERT INTO SessionSquads(username, session_id, position_id) VALUES ('{results6}',{squadSessionId})"
            query12 = f"INSERT INTO SessionSquads(username, session_id, position_id) VALUES ('{results7}',{squadSessionId})"
            query13 = f"INSERT INTO SessionSquads(username, session_id, position_id) VALUES ('{results8}',{squadSessionId})"
            query14 = f"INSERT INTO SessionSquads(username, session_id, position_id) VALUES ('{results9}',{squadSessionId})"
            query15 = f"INSERT INTO SessionSquads(username, session_id, position_id) VALUES ('{results10}',{squadSessionId})"

            with connection.cursor() as cursor10:
                cursor10.execute(query4)
                results59 = cursor10.fetchone()[0]
                cursor10.execute(query5)
                results69 = cursor10.fetchone()[0]
                cursor10.execute(query6)
                results79 = cursor10.fetchone()[0]
                cursor10.execute(query7)
                results89 = cursor10.fetchone()[0]
                cursor10.execute(query8)
                results99 = cursor10.fetchone()[0]
                cursor10.execute(query9)
                results109 = cursor10.fetchone()[0]

            # Process results or return them
            return JsonResponse({'success': True, 'message': "Query executed successfully."})

        except Exception as e:
            return JsonResponse({'success': False, 'message': f'Trigger Error: {e}'})
                
    # If the request method is not POST, return an error response
    return JsonResponse({'success': False, 'message': 'Invalid request method'})



def rate_match_session(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body.decode('utf-8'))
            matchSessionNumber = data.get('matchSessionNumber')
            rating = data.get('rating')

            # F.d.p
            print("Taking input...")
            print(matchSessionNumber)
            print(rating)

            print("Input taken!")
        except json.JSONDecodeError:
            return JsonResponse({'success': False, 'message': 'Invalid JSON data'}, status=400)
        
        # Will be filled (the main logic)
        if matchSessionNumber and rating:
            try:
                # Rating a match session  (filled_but_unchecked)
                query = f"UPDATE MatchSessions SET rating = '{rating}' WHERE session_id = '{matchSessionNumber}';"  

                with connection.cursor() as cursor:
                    cursor.execute(query)
                    results = cursor.fetchall()  # Example fetch method

                # Process results or return them
                return JsonResponse({'success': True, 'message': "Query executed successfully."})

            except Exception as e:
                return JsonResponse({'success': False, 'message': f'Trigger Error: {e}'})
            
        return JsonResponse({'success': False, 'message': 'matchSessionNumber or rating empty'})
        
    # If the request method is not POST, return an error response
    return JsonResponse({'success': False, 'message': 'Invalid request method'})

    


