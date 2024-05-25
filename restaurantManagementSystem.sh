#!/bin/bash

# Initializing files to store data in 
menu_file="menu.txt"
inventory_file="inventory.txt"
database_file="recipes.txt"
invoice_file="invoices.txt"


touch "$menu_file" "$inventory_file" "$database_file" "$invoice_file"

# Function to display main menu
display_main_menu() {
    echo "Restaurant Management System"
    echo "1. Menu Management"
    echo "2. Ingredient Inventory Tracker"
    echo "3. Recipe Database"
    echo "4. Billing and Invoicing System"
    echo "5. Exit"
    echo "Enter your choice: "
}

# Defining Function to display sub-menus to choose from after the user choose which service he wants 
display_menu() {
    # Starting a case statement to view details and display menu after chosing the desired service
    case $1 in
        1) echo "Menu Management"
           echo "1. Add Menu Item"
           echo "2. View Menu"
           echo "3. Delete Menu Item"
           ;;
        2) echo "Ingredient Inventory Tracker"
           echo "1. Add Ingredient"
           echo "2. View Inventory"
           echo "3. Update Ingredient Quantity"
           ;;
        3) echo "Recipe Database"
           echo "1. Add Recipe"
           echo "2. View Recipes"
           echo "3. Search Recipes"
           ;;
        4) echo "Billing and Invoicing System"

           echo "1. Generate Invoice"
           echo "2. View Invoices"
           ;;
    esac
    echo "4. Back"
    echo "Enter your choice: "
}

# Function for Menu Management
menu_management() {
    while true; do
        display_menu 1
        read choice

        case $choice in
            1) add_menu_item ;;
            2) view_menu ;;
            3) delete_menu_item ;;
            4) break ;;
            *) echo "Invalid choice. Please enter a valid option." ;;
        esac
    done
}

# Defining a function named ingredient inventory
ingredient_inventory() {
# Starting an infinite loop with coundition( True )
# It is created to display the available choices the user can choose from
# It also handles user inputs
    while true; do
	#Calling display menu function with option 2 as argument
	# Its job is to diplay options
        display_menu 2
	# Reading user input and assigning it to a variable named (choice)
        read choice

	# Starting case statement to handle different choices
	# In this case statement we have 3 function calls which are the services
	# The forth option is the exit choise
	# And for default case it is going to be ann error message for wrong entry
        case $choice in
            1) add_ingredient ;;
            2) view_inventory ;;
            3) update_quantity ;;
            4) break ;;
            *) echo "Invalid choice. Please enter a valid option." ;;
        esac # End of case statement
    done # End of while loop
}
# End of function definition

# Function for Recipe Database
recipe_database() {
    # Start an infinite loop to display the recipe database menu
    while true; do
        # Display the recipe database submenu by calling the display_menu function with argument 3
        display_menu 3
        # Read the user's choice from the input
        read choice

        # Use a case statement to handle different choices
        case $choice in
            1) add_recipe ;;    # If the user chooses 1, call the add_recipe function to add a new recipe
            2) view_recipes ;;  # If the user chooses 2, call the view_recipes function to display all recipes
            3) search_recipes ;; # If the user chooses 3, call the search_recipes function to search for recipes
            4) break ;;         # If the user chooses 4, break out of the loop and exit the recipe database menu
            *) echo "Invalid choice. Please enter a valid option." ;;  # Display an error message for invalid choices
        esac
    done
}


# Function for Billing and Invoicing System
billing_invoicing() {
    while true; do
        display_menu 4
        read choice

        case $choice in
            1) generate_invoice ;;
            2) view_invoices ;;
            3) break ;;
            *) echo "Invalid choice. Please enter a valid option." ;;
        esac
    done
}

# Function to add menu item
add_menu_item() {
    echo "Enter the name of the menu item: "
    read name
    echo "Enter the price of the menu item: "
    read price

    echo "$name - $price" >> "$menu_file"
    echo "Menu item added successfully!"
}

# Function to view menu
view_menu() {
    echo "Menu:"
    cat "$menu_file"
}

# Function to delete menu item
delete_menu_item() {
    echo "Enter the name of the menu item to delete: "
    read name

    sed -i "/$name/d" "$menu_file"
    echo "Menu item deleted successfully!"
}

# Function to add ingredient
add_ingredient() {
    echo "Enter the name of the ingredient: "
    read name
    echo "Enter the quantity of $name: "
    read quantity

    echo "$name:$quantity" >> "$inventory_file"
    echo "Ingredient added successfully!"
}

# Function to view inventory
view_inventory() {
    echo "Inventory:"
    cat "$inventory_file"
}

# Function to update ingredient quantity
update_quantity() {
    echo "Enter the name of the ingredient to update: "
    read name
    echo "Enter the new quantity of $name: "
    read new_quantity

    sed -i "s/^$name:.*/$name:$new_quantity/" "$inventory_file"
    echo "Ingredient quantity updated successfully!"
}

# Function to add recipe
add_recipe() {
    echo "Enter the name of the recipe: "
    read name
    echo "Enter the ingredients for $name (comma-separated): "
    read ingredients
    echo "Enter the instructions for $name: "
    read instructions

    echo "$name|$ingredients|$instructions" >> "$database_file"
    echo "Recipe added successfully!"
}

# Function to view recipes
view_recipes() {
    echo "Recipes:"
    cat "$database_file"
}

# Function to search recipes
search_recipes() {
    echo "Enter a keyword to search for: "
    read keyword

    grep -i "$keyword" "$database_file"
}

# Function to generate invoice
generate_invoice() {
    echo "Enter customer name: "
    read customer_name
    echo "Enter amount: "
    read amount

    invoice_number=$(date +%Y%m%d%H%M%S)
    echo "Invoice Number: $invoice_number" >> "$invoice_file"
    echo "Customer Name: $customer_name" >> "$invoice_file"
    echo "Amount: $amount" >> "$invoice_file"
    echo "Invoice generated successfully!"
}

# Function to view invoices
view_invoices() {
    echo "Invoices:"
    cat "$invoice_file"
}

# Initial setup
# Add any initial setup steps here if needed

# Main script
# Add an if statement for initial setup or validation if needed
if [ $# -eq 0 ]; then
    echo "Welcome to Restaurant Management System!"
    # Perform any initial setup here if needed
fi

while true; do
    display_main_menu
    read choice

    case $choice in
        1) menu_management ;;
        2) ingredient_inventory ;;
        3) recipe_database ;;
        4) billing_invoicing ;;
        5) echo "Exiting..."; break ;;
        *) echo "Invalid choice. Please enter a valid option." ;;
    esac
done
