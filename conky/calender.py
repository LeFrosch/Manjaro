from datetime import datetime as dt
from datetime import timedelta as td
import os
from O365 import Account, FileSystemTokenBackend, MSGraphProtocol

fileName = "events"

def signIn():
    protocol_graph = MSGraphProtocol()

    scopes_graph = protocol_graph.get_scopes_for(["basic", "calendar", "calendar_shared"])
    token_backend = FileSystemTokenBackend(token_path=os.getcwd(), token_filename="ms-tokens")

    credentials = ("f6769c93-9b7f-498f-9792-dcc3e0de23b7", "yP3Vrts-Ym3_-6rusSgAm4j.b8L_3p6bvE")
    account = Account(credentials, token_backend=token_backend, scopes=scopes_graph)

    if not account.is_authenticated:
        account.authenticate()

    return account

if __name__ == '__main__':
    now = dt.now() 
    now = now - td(hours=now.hour, minutes=now.minute)

    account = signIn()

    end = now + td(days=1)

    f = open(fileName, "w")
    
    schedule = account.schedule()
    for calendar in schedule.list_calendars():
        q = calendar.new_query("start").greater_equal(now)
        q.chain("and").on_attribute("end").less_equal(end)
        
        for event in calendar.get_events(query=q, include_recurring=True):
            f.write("{};{};{}\n".format(event.start.time().strftime("%H:%M"), event.end.time().strftime("%H:%M"), event.subject))

    f.close()
