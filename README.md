# Billing-System
Medical Billing Management System in Assembly Language

Working of Program:

● Password input and Checking

First, the program asks the user for a password for security and checks the
password character by character. If the password is incorrect, the program asks if
the user wants to try again or not. An option display there like this
If the user enters 1 then, the program again asks for password input, other if the
user enters 0 then the program exit.
If the user enters the correct password, then a line is displayed.

● Display MENU

After pressing any key, the program displays the main menu.

● Call functions of the menu.

When the staff of the pharmacy (user) presses the ‘1’ option, the control shifts to
menu2 from menu1; when the same person presses the ‘2’ option, the control
shifts to the medicines stats menu; when he presses the ‘3’ option, the control
shifts to show Amount menu and when he presses ‘4’ option (the last option), it
simply just exits from the program.

● Input Validations

Suppose the user doesn’t press any of the following options. In that case, a line will
show up which would say “wrong input”, and then the program will again ask the
user to “input again” This time if the user has pressed the right option, then the
control will shift to its respective function otherwise the menu1 will pop up again.

● Display MENU2

After displaying the menu, the program asks the user for specific input to choose
the desired option. And if the user press ‘1’, the program displays another menu
called menu2. 
After displaying menu 2, the program asks the user for the specific input to buy the
desired medicine and then asks how many medicines the user wants to buy;
If the user enters 1 in order to buy panadol then
after that, it finally shows the total medicine sale today and the total amount earned
at that time.

● See medicine statistics

If the user press 2 in the menu options, in order to see medicine statistics. In this
procedure, a msg showing ‘medicine name’ sold = $“ is displayed individually
unless all medicines statistics have not been demonstrated.
After the msg is displayed, the variable storing amount of medicine sold is recalled
through its name, and 48 is added to each medicine’s amount so that the amount is
shown in its ASCII Value, not in hexadecimal. Likewise, all the medicines statistics
are printed one by one by obtaining their quantity and adding 48 to each so that the
user can get an insight into his sales.

● Show amount earned today:

If the user enters 4 in order to see the amount earned today, then the program
simply displays the amount earned today. The calculation of the amount is
when telling the program how much medicine we want to buy then the
program simultaneously, counts the total amount earned toda
