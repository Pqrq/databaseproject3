from django.urls import path
from . import views
from .views import index, manager, coach, jury, player

urlpatterns = [
    # Pages
    path('loginPage', index, name='index'),
    path('DBManagerPage', manager, name='dbmanager'),
    path('CoachesPage', coach, name='coaches'),
    path('JuriesPage', jury, name='juries'),
    path('PlayerPage', player, name='player'),

    # Endpoints
    path('login/', views.login_view, name='login'),
    path('addNewUser/', views.add_new_user, name='addNewUser'),
    path('changeStadiumName/', views.change_stadium_name, name='changeStadiumName'),

    path('deleteMatchSession/', views.delete_match_session, name='deleteMatchSession'),
    path('addNewMatchSessionWithSquad/', views.add_new_match_session_with_squad, name='addNewMatchSessionWithSquad'),
    path('addNewMatchSessionWithoutSquad/', views.add_new_match_session_without_squad, name='addNewMatchSessionWithoutSquad'),
    path('createSquad/', views.create_squad, name='createSquad'),

    path('rateMatchSession/', views.rate_match_session, name='changeStadiumName'),

]