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
	# If the user choose number 1 then a list of services will be displayed under the (menu management) feature
        1) echo "Menu Management"
           echo "1. Add Menu Item"
           echo "2. View Menu"
           echo "3. Delete Menu Item"
           ;;
	# If the User choose number 2 thena a list of services will be displayed under the (ingredient inventory tracker ) feature
        2) echo "Ingredient Inventory Tracker"
           echo "1. Add Ingredient"
           echo "2. View Inventory"
           echo "3. Update Ingredient Quantity"
           ;;
	# If the user choose number 3 then a list of services will be displayed under the (Recipe Database) feature
        3) echo "Recipe Database"
           echo "1. Add Recipe"
           echo "2. View Recipes"
           echo "3. Search Recipes"
           ;;
	# If the user choose number 4 then a list of services will be displayed under the (billing and invoicing system) feature
        4) echo "Billing and Invoicing System"
           echo "1. Generate Invoice"
           echo "2. View Invoices"
           ;;
    esac # End of case statement
    echo "4. Back" # This line is shared between every feature and it is going to be printed at the end of each list 
    echo "Enter your choice: " # Prompt message for the user to enter a chois
} # End of function definition

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
# Function for managing the Recipe Database
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
            2) view_recipes ;;  # If the user chooses 2, call the view_recipes function to view all recipes
            3) search_recipes ;; # If the user chooses 3, call the search_recipes function to search for recipes
            4) break ;;         # If the user chooses 4, break out of the loop and exit the recipe database menu
            *) echo "Invalid choice. Please enter a valid option." ;;  # Display an error message for invalid choices
        esac
    done
}


# Function for managing the Billing and Invoicing System
billing_invoicing() {
    # Start an infinite loop to display the billing and invoicing menu
    while true; do
        # Display the billing and invoicing submenu by calling the display_menu function with argument 4
        display_menu 4
        # Read the user's choice from the input
        read choice

        # Use a case statement to handle different choices
        case $choice in
            1) generate_invoice ;;  # If the user chooses 1, call the generate_invoice function to generate an invoice
            2) view_invoices ;;     # If the user chooses 2, call the view_invoices function to view all invoices
            3) break ;;             # If the user chooses 3, break out of the loop and exit the billing and invoicing menu
            *) echo "Invalid choice. Please enter a valid option." ;;  # Display an error message for invalid choices
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

# Function for adding a new recipe to the recipe database
add_recipe() {
    # Prompt the user to enter the name of the recipe
    echo "Enter the name of the recipe: "
    read name
    # Prompt the user to enter the ingredients for the recipe (comma-separated)
    echo "Enter the ingredients for $name (comma-separated): "
    read ingredients
    # Prompt the user to enter the instructions for the recipe
    echo "Enter the instructions for $name: "
    read instructions

    # Append the new recipe information to the recipe database file in the format: name|ingredients|instructions
    echo "$name|$ingredients|$instructions" >> "$database_file"
    # Display a success message indicating that the recipe was added successfully
    echo "Recipe added successfully!"
}


# Function for viewing recipes stored in the recipe database
view_recipes() {
    # Display a header indicating that the following content is a list of recipes
    echo "Recipes:"
    # Output the contents of the recipe database file using the cat command
    cat "$database_file"
}

# Function for searching recipes in the recipe database
search_recipes() {
    # Prompt the user to enter a keyword to search for within the recipes
    echo "Enter a keyword to search for: "
    # Read the keyword input from the user
    read keyword

    # Use the grep command to search for the keyword in the recipe database file, ignoring case sensitivity
    grep -i "$keyword" "$database_file"
}


# Function for generating an invoice and adding it to the invoice file
generate_invoice() {
    # Prompt the user to enter the customer's name
    echo "Enter customer name: "
    # Read the customer's name input from the user
    read customer_name
    # Prompt the user to enter the invoice amount
    echo "Enter amount: "
    # Read the invoice amount input from the user
    read amount

    # Generate a unique invoice number using the current date and time
    invoice_number=$(date +%Y%m%d%H%M%S)
    # Append the invoice details (invoice number, customer name, and amount) to the invoice file
    echo "Invoice Number: $invoice_number" >> "$invoice_file"
    echo "Customer Name: $customer_name" >> "$invoice_file"
    echo "Amount: $amount" >> "$invoice_file"
    # Display a success message indicating that the invoice was generated successfully
    echo "Invoice generated successfully!"
}


# Function for viewing all invoices stored in the invoice file
view_invoices() {
    # Display a header indicating that the following content is a list of invoices
    echo "Invoices:"
    # Output the contents of the invoice file using the cat command
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

