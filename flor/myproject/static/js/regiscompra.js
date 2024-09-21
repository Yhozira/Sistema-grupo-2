// Obtener elementos
const cancelBtn = document.querySelector('.cancel-btn');
const modal = document.getElementById('cancel-modal');
const closeModal = document.querySelector('.close-modal');
const confirmBtn = document.querySelector('.confirm-btn');
const denyBtn = document.querySelector('.deny-btn');
const productosBody = document.getElementById('productos-body');
const precioFinalElement = document.querySelector('.precio-final h3');

// Mostrar modal al hacer clic en "Cancelar"
cancelBtn.addEventListener('click', () => {
    modal.style.display = 'flex';
});

// Cerrar modal al hacer clic en el botón de cerrar
closeModal.addEventListener('click', () => {
    modal.style.display = 'none';
});

// Cerrar modal si elige "No, volver"
denyBtn.addEventListener('click', () => {
    modal.style.display = 'none';
});

// Confirmar cancelación (lógica para cancelar la compra)
confirmBtn.addEventListener('click', () => {
    // Eliminar todos los productos de la tabla
    productosBody.innerHTML = ''; // Vaciar la tabla

    // Restablecer el precio final a 0
    actualizarPrecioFinal();

    // Cerrar el modal
    modal.style.display = 'none';
});

// Cerrar el modal si se hace clic fuera del contenido del modal
window.addEventListener('click', (e) => {
    if (e.target == modal) {
        modal.style.display = 'none';
    }
});

// Función para agregar producto a la tabla
function agregarProducto() {
    const nombreProducto = document.getElementById('nombre-producto').value;
    const cantidad = document.getElementById('cantidad').value;
    const precio = document.getElementById('precio').value;

    if (nombreProducto === '' || cantidad === '' || precio === '') {
        alert('Por favor, completa todos los campos');
        return;
    }

    // Calcular el precio total
    const precioTotal = (cantidad * precio).toFixed(2);

    // Crear una nueva fila para el producto
    const nuevaFila = document.createElement('tr');
    nuevaFila.innerHTML = `
        <td>${nombreProducto}</td>
        <td>${cantidad}</td>
        <td>${precio}</td>
        <td>${precioTotal}</td>
        <td><button class="delete-btn" onclick="eliminarProducto(this)">🗑️</button></td>
    `;

    // Agregar la nueva fila al cuerpo de la tabla
    productosBody.appendChild(nuevaFila);

    // Limpiar el formulario después de agregar
    document.getElementById('nombre-producto').value = '';
    document.getElementById('cantidad').value = 1;
    document.getElementById('precio').value = '';

    // Actualizar el precio final
    actualizarPrecioFinal();
}

// Función para eliminar productos de la tabla
function eliminarProducto(btn) {
    const fila = btn.parentNode.parentNode;
    fila.remove();
    // Actualizar el precio final después de eliminar un producto
    actualizarPrecioFinal();
}

// Función para calcular y actualizar el precio final
function actualizarPrecioFinal() {
    let total = 0;
    const filas = productosBody.querySelectorAll('tr');

    // Recorrer todas las filas para sumar el precio total de cada producto
    filas.forEach((fila) => {
        const precioTotal = parseFloat(fila.cells[3].innerText); // Obtener el precio total de la fila
        total += precioTotal;
    });

    // Mostrar el precio final
    precioFinalElement.textContent = `Precio Final: S/. ${total.toFixed(2)}`;
}

// Evento para agregar producto al hacer clic en el botón
document.querySelector('.agregar-btn').addEventListener('click', agregarProducto);
