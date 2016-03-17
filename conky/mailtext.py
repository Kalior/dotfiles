#! /usr/bin/python
# -*- coding: utf-8 -*-
"""
Display the unread messages count from your IMAP account.
Configuration parameters:
    - cache_timeout : how often to run this check
    - criterion : status of emails to check for
    - format : format to display
    - hide_if_zero : don't show on bar if 0
    - imap_server : IMAP server to connect to
    - mailbox : name of the mailbox to check
    - new_mail_color : what color to output on new mail
    - password : login password
    - port : IMAP server port
    - user : login user
Format of status string placeholders:
    {unseen} - number of unread emails
@author obb

Stolen from py3status
"""

import imaplib
from time import time

# available configuration parameters
cache_timeout = 60
criterion = 'UNSEEN'
hide_if_zero = False
imap_server = 'imap.gmail.com'
mailbox = 'INBOX'
format = '{unseen}'
password = "password"
port = '993'
user = "email"

def check_mail():
    mail_count = _get_mail_count()

    if mail_count == 'N/A':
        full_text = mail_count
    elif mail_count != 0:
        full_text = format.format(unseen=mail_count)
    else:
        if hide_if_zero:
            full_text = ''
        else:
            full_text = format.format(unseen=mail_count)

    return full_text

def _get_mail_count():
   try:
        mail_count = 0
        directories = mailbox.split(',')
        connection = imaplib.IMAP4_SSL(imap_server, port)
        connection.login(user, password)

        for directory in directories:
            connection.select(directory)
            unseen_response = connection.search(None, criterion)
            mails = unseen_response[1][0].split()
            mail_count += len(mails)

        connection.close()
        return mail_count

    except:
       return 'N/A'


if __name__ == "__main__":
    """
    Test this module by calling it directly.
    """
    print(check_mail())
