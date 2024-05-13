document.addEventListener("DOMContentLoaded", function() {
    // Check if the login form exists (for index.html)
    const loginForm = document.getElementById("loginForm");
    if (loginForm) {
        // Access the CSRF token from the form
        const csrfToken = loginForm.dataset.csrf;

        // Add event listener to the login form
        loginForm.addEventListener("submit", function(event) {
            event.preventDefault(); // Prevent form submission
            
            // Get the entered username, password, and type
            const username = document.getElementById("username").value;
            const password = document.getElementById("password").value;

            // Construct the request body as an object
            const requestBody = {
                username: username,
                password: password
            };

            // Configure the request options
            const requestOptions = {
                method: 'POST',
                headers: {'Content-Type': 'application/json', 'X-CSRFToken': csrfToken},
                body: JSON.stringify(requestBody)
            };

            // Send the HTTP request
            fetch("http://localhost:8000/voleyballDB/login/", requestOptions)
                .then(response => {if (response.ok) {return response.json();} else {throw new Error('Network response was not ok.');}})
                .then(data => {
                    if (data.success === true) {
                        const type = encodeURIComponent(data.type);
                        window.location.href = `http://localhost:8000/voleyballDB/${type}Page?username=${username}&type=${type}`;
                    } else {
                        alert("Login failed. Please check your username and password.");
                    }
                })
                .catch(error => {
                    console.error('There was a problem with the fetch operation:', error);
                    alert("An error occurred while processing your request.");
                });
        });
    }


    // Getting references to the buttons (manager.html)
    const addNewUserForm = document.getElementById("addNewUserForm");
    if (addNewUserForm) {
        const csrfToken = addNewUserForm.dataset.csrf;

        // Add event listener to the login form
        addNewUserForm.addEventListener("submit", function(event) {
            event.preventDefault(); // Prevent form submission
            // Fetching common parameters
            const newUsername = document.getElementById("newUsername").value;
            const newPassword = document.getElementById("newPassword").value;
            const name = document.getElementById("name").value;
            const surname = document.getElementById("surname").value;
            const newType = document.getElementById("newType").value;

            // Fetching additional parameters for coaches and juries
            const nationality = document.getElementById("nationality").value;

            // Fetching additional parameters for players
            const dateOfBirth = document.getElementById("dateOfBirth").value;
            const height = document.getElementById("height").value;
            const weight = document.getElementById("weight").value;
            const mainPosition = document.getElementById("mainPosition").value;
            const mainTeam = document.getElementById("mainTeam").value;


            // Construct the request body as an object
            const requestBody = {
                newUsername: newUsername,
                newPassword: newPassword,
                name: name,
                surname: surname,
                newType: newType,
                nationality: nationality,
                dateOfBirth: dateOfBirth,
                height: height,
                weight: weight,
                mainPosition: mainPosition,
                mainTeam: mainTeam,
            };
            
            // Configure the request options
            const requestOptions = {
                method: 'POST',
                headers: {'Content-Type': 'application/json', 'X-CSRFToken': csrfToken},
                body: JSON.stringify(requestBody)
            };

            // Database & Backend part will be added here
            fetch("http://localhost:8000/voleyballDB/addNewUser/", requestOptions)
                .then(response => {if (response.ok) {return response.json();} else {throw new Error('Network response was not ok.');}})
                .then(data => {
                    if (data.success === true) {
                        alert("User sucessfully added")
                    } else {
                        const message = encodeURIComponent(data.message);
                        alert(message);
                    }
                })
                .catch(error => {
                    console.error('There was a problem with the fetch operation:', error);
                    alert("An error occurred while processing your request.");
                });

        });
    }


    const changeStadiumNameForm = document.getElementById("changeStadiumNameForm");
    if (changeStadiumNameForm) {
        const csrfToken = changeStadiumNameForm.dataset.csrf;

        // Add event listener to the login form
        changeStadiumNameForm.addEventListener("submit", function(event) {
            event.preventDefault(); // Prevent form submission
            // Get the parameters
            const oldName = document.getElementById("oldName").value;
            const newName = document.getElementById("newName").value;

            // Database & Backend part will be added here
            // Construct the request body as an object
            const requestBody = {
                oldName: oldName,
                newName: newName,
            };
            
            // Configure the request options
            const requestOptions = {
                method: 'POST',
                headers: {'Content-Type': 'application/json', 'X-CSRFToken': csrfToken},
                body: JSON.stringify(requestBody)
            };

            // Database & Backend part will be added here
            fetch("http://localhost:8000/voleyballDB/changeStadiumName/", requestOptions)
                .then(response => {if (response.ok) {return response.json();} else {throw new Error('Network response was not ok.');}})
                .then(data => {
                    if (data.success === true) {
                        alert("Stadium name changed successfully")
                    } else {
                        const message = encodeURIComponent(data.message);
                        alert(message);
                    }
                })
                .catch(error => {
                    console.error('There was a problem with the fetch operation:', error);
                    alert("An error occurred while processing your request.");
                });

        });
    }



    // Get references to the buttons (for coach.html)
    const deleteMatchSessionForm = document.getElementById("deleteMatchSessionForm");
    if (deleteMatchSessionForm) {
        const csrfToken = deleteMatchSessionForm.dataset.csrf;
        deleteMatchSessionForm.addEventListener("submit", function(event) {
            event.preventDefault(); // Prevent form submission
            // Get the parameters
            const sessionId = document.getElementById("sessionId").value;

            // Database & Backend part will be added here
            const requestBody = {
                sessionId: sessionId,
            };
            
            // Configure the request options
            const requestOptions = {
                method: 'POST',
                headers: {'Content-Type': 'application/json', 'X-CSRFToken': csrfToken},
                body: JSON.stringify(requestBody)
            };

            // Database & Backend part will be added here
            fetch("http://localhost:8000/voleyballDB/deleteMatchSession/", requestOptions)
                .then(response => {if (response.ok) {return response.json();} else {throw new Error('Network response was not ok.');}})
                .then(data => {
                    if (data.success === true) {
                        alert("Match Session Deleted successfully");
                    } else {
                        const message = encodeURIComponent(data.message);
                        alert(message);
                    }
                })
                .catch(error => {
                    console.error('There was a problem with the fetch operation:', error);
                    alert("An error occurred while processing your request.");
                });

        });
    }

    const addNewMatchSessionForm = document.getElementById("addNewMatchSessionForm");
    if (addNewMatchSessionForm) {
        const csrfToken = addNewMatchSessionForm.dataset.csrf;
        addNewMatchSessionForm.addEventListener("submit", function(event) {
            event.preventDefault(); // Prevent form submission

            // Determine the submit button
            const targetButtonId = event.submitter.id;

            // Handle each button's action separately
            if (targetButtonId === "addMatchSessionWithSquad") {
                const stadiumName = document.getElementById("stadiumName").value;
                const date = document.getElementById("date").value;
                const timeSlot = document.getElementById("timeSlot").value;
                const juryName = document.getElementById("juryName").value;
                const jurySurname = document.getElementById("jurySurname").value;

                const player1Name = document.getElementById("player1Name").value;
                const player2Name = document.getElementById("player2Name").value;
                const player3Name = document.getElementById("player3Name").value;
                const player4Name = document.getElementById("player4Name").value;
                const player5Name = document.getElementById("player5Name").value;
                const player6Name = document.getElementById("player6Name").value;

                // Database & Backend part will be added here
                const requestBody = {
                    stadiumName: stadiumName,
                    date: date,
                    timeSlot: timeSlot,
                    juryName: juryName,
                    jurySurname: jurySurname,
                    player1Name: player1Name,
                    player2Name: player2Name,
                    player3Name: player3Name,
                    player4Name: player4Name,
                    player5Name: player5Name,
                    player6Name: player6Name,
                };
                
                // Configure the request options
                const requestOptions = {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json', 'X-CSRFToken': csrfToken},
                    body: JSON.stringify(requestBody)
                };
    
                // Database & Backend part will be added here
                fetch("http://localhost:8000/voleyballDB/addNewMatchSessionWithSquad/", requestOptions)
                    .then(response => {if (response.ok) {return response.json();} else {throw new Error('Network response was not ok.');}})
                    .then(data => {
                        if (data.success === true) {
                            alert("Match Session With Squad Created Successfully");
                        } else {
                            const message = encodeURIComponent(data.message);
                            alert(message);
                        }
                    })
                    .catch(error => {
                        console.error('There was a problem with the fetch operation:', error);
                        alert("An error occurred while processing your request.");
                    });

            } else if (targetButtonId === "addMatchSessionWithoutSquad") {
                const stadiumName = document.getElementById("stadiumName").value;
                const date = document.getElementById("date").value;
                const timeSlot = document.getElementById("timeSlot").value;
                const juryName = document.getElementById("juryName").value;
                const jurySurname = document.getElementById("jurySurname").value;

                // Database & Backend part will be added here
                const requestBody = {
                    stadiumName: stadiumName,
                    date: date,
                    timeSlot: timeSlot,
                    juryName: juryName,
                    jurySurname: jurySurname,
                };
                
                // Configure the request options
                const requestOptions = {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json', 'X-CSRFToken': csrfToken},
                    body: JSON.stringify(requestBody)
                };
    
                // Database & Backend part will be added here
                fetch("http://localhost:8000/voleyballDB/addNewMatchSessionWithoutSquad/", requestOptions)
                    .then(response => {if (response.ok) {return response.json();} else {throw new Error('Network response was not ok.');}})
                    .then(data => {
                        if (data.success === true) {
                            alert("Match Session Without Squad Created Successfully");
                        } else {
                            const message = encodeURIComponent(data.message);
                            alert(message);
                        }
                    })
                    .catch(error => {
                        console.error('There was a problem with the fetch operation:', error);
                        alert("An error occurred while processing your request.");
                    });
            }
            else {
                alert("You shouldn't see this!");
            }

        });
    }

    const createSquadForm = document.getElementById("createSquadForm");
    if (createSquadForm) {
        const csrfToken = createSquadForm.dataset.csrf;
        createSquadForm.addEventListener("submit", function(event) {
            event.preventDefault(); // Prevent form submission
            // Get the parameters
            const squadSessionId = document.getElementById("squadSessionId").value;
            const squadPlayer1Name = document.getElementById("squadPlayer1Name").value;
            const squadPlayer2Name = document.getElementById("squadPlayer2Name").value;
            const squadPlayer3Name = document.getElementById("squadPlayer3Name").value;
            const squadPlayer4Name = document.getElementById("squadPlayer4Name").value;
            const squadPlayer5Name = document.getElementById("squadPlayer5Name").value;
            const squadPlayer6Name = document.getElementById("squadPlayer6Name").value;
            
            // Database & Backend part will be added here
            const requestBody = {
                squadSessionId: squadSessionId,
                squadPlayer1Name: squadPlayer1Name,
                squadPlayer2Name: squadPlayer2Name,
                squadPlayer3Name: squadPlayer3Name,
                squadPlayer4Name: squadPlayer4Name,
                squadPlayer5Name: squadPlayer5Name,
                squadPlayer6Name: squadPlayer6Name,
            };
            
            // Configure the request options
            const requestOptions = {
                method: 'POST',
                headers: {'Content-Type': 'application/json', 'X-CSRFToken': csrfToken},
                body: JSON.stringify(requestBody)
            };

            // Database & Backend part will be added here
            fetch("http://localhost:8000/voleyballDB/createSquad/", requestOptions)
                .then(response => {if (response.ok) {return response.json();} else {throw new Error('Network response was not ok.');}})
                .then(data => {
                    if (data.success === true) {
                        alert("Squad created successfully");
                    } else {
                        const message = encodeURIComponent(data.message);
                        alert(message);
                    }
                })
                .catch(error => {
                    console.error('There was a problem with the fetch operation:', error);
                    alert("An error occurred while processing your request.");
                });

        });
    }


    // Get references to the button (jury.html)
    const rateMatchSessionForm = document.getElementById("rateMatchSessionForm");
    if (rateMatchSessionForm) {
        const csrfToken = rateMatchSessionForm.dataset.csrf;
        rateMatchSessionForm.addEventListener("submit", function(event) {
            event.preventDefault(); // Prevent form submission
            // Get the parameters
            const matchSessionNumber = document.getElementById("matchSessionNumber").value;
            const rating = document.getElementById("rating").value;

            // Database & Backend part will be added here
            const requestBody = {
                matchSessionNumber: matchSessionNumber,
                rating: rating,
            };
            
            // Configure the request options
            const requestOptions = {
                method: 'POST',
                headers: {'Content-Type': 'application/json', 'X-CSRFToken': csrfToken},
                body: JSON.stringify(requestBody)
            };

            // Database & Backend part will be added here
            fetch("http://localhost:8000/voleyballDB/rateMatchSession/", requestOptions)
                .then(response => {if (response.ok) {return response.json();} else {throw new Error('Network response was not ok.');}})
                .then(data => {
                    if (data.success === true) {
                        alert("Match rated successfully");
                    } else {
                        const message = encodeURIComponent(data.message);
                        alert(message);
                    }
                })
                .catch(error => {
                    console.error('There was a problem with the fetch operation:', error);
                    alert("An error occurred while processing your request.");
                });

        });
    }


});
