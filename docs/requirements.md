# Requirements

## Authorization & authentification

Sign In:
- proceed to main page in case of success
- show error in case of failure

Sign Up:
- check uniqueness of login
- compare `password` and `repeated password`
- proceed to main page in case of success
- show error in case of failure

## Search Page (Main page)

- show filter bar at the top (_locality from_ and _locality to_ - 2 text fileds, 2 date pickers for _date range_)
- show search button
- show results in table view with customized cells, containing info about tickets
- provide possibility to book ticket

## Map page

- show map
- show text field for _departure point_
- show find button
- show error if no locality with entered name exists
- if entered locality exists - show it as **D** - departure on the map and available localities to as **A** - arrival

## Booked Ticket Page

- show booked tickets as table view
- in customized cell show all info about ticket
- make it possible to unbook ticket if it is still actual

## Navigation

- provide an app with a menu bar (Search Page, Map Page, Booked Ticket Page)

# User stories

## Authorization & authentification

As a <b>user</b>, I want to <b>sign up</b>, so that I can <b>use your app further</b>

As a <b>user</b>, I want to <b>sign in</b>, so that I can <b>use your app</b>

## Search Page (Main page)

As a <b>user</b>, I want to <b>view tickets</b>, so that I can <b>choose appropriate one</b>

As a <b>user</b>, I want to <b>filter tickets</b>, so that I can <b>easier find appropriate one</b>

As a <b>user</b>, I want to <b>book chosen ticket</b>, so that I can <b>buy it later</b>

## Map page

As a <b>user</b>, I want to <b>see available directions from chosen locality</b>, so that I can <b>know, where I can get</b>

## Booked Ticket Page

As a <b>user</b>, I want to <b>see booked tickets</b>, so that I can <b>make sure I booked them</b>

As a <b>user</b>, I want to <b>unbook tickets I do not need (if it is available)</b>, so that <b>other people can use them</b>

## Navigation

As a <b>user</b>, I want to <b>navigate through pages</b>, so that I can <b>get all information</b>

# Use case Diagram

<img src="https://user-images.githubusercontent.com/75540967/173223863-0156f530-ff07-419b-beab-6b1384b21a13.png" height="600px">

