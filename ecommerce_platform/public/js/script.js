// public/js/script.js

// Function to confirm adding a product to the cart
function confirmAddToCart(productName) {
    return confirm(`Are you sure you want to add ${productName} to your cart?`);
}

// Function to confirm placing an order
function confirmPlaceOrder() {
    return confirm("Are you sure you want to place this order?");
}

// Function to validate the quantity of a product before adding to cart
function validateQuantity(input) {
    const quantity = parseInt(input.value, 10);
    if (isNaN(quantity) || quantity <= 0) {
        alert("Please enter a valid quantity.");
        input.value = 1;
        return false;
    }
    return true;
}

// Add event listeners when the DOM content is fully loaded
document.addEventListener("DOMContentLoaded", function() {
    // Confirm adding to cart
    const addToCartButtons = document.querySelectorAll('.add-to-cart');
    addToCartButtons.forEach(function(button) {
        button.addEventListener('click', function(event) {
            const productName = event.target.getAttribute('data-product-name');
            if (!confirmAddToCart(productName)) {
                event.preventDefault();
            }
        });
    });

    // Confirm placing the order
    const placeOrderButton = document.querySelector('#place-order');
    if (placeOrderButton) {
        placeOrderButton.addEventListener('click', function(event) {
            if (!confirmPlaceOrder()) {
                event.preventDefault();
            }
        });
    }

    // Validate quantity input
    const quantityInputs = document.querySelectorAll('.quantity-input');
    quantityInputs.forEach(function(input) {
        input.addEventListener('change', function() {
            validateQuantity(input);
        });
    });
});
