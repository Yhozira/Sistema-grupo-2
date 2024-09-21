const menu = document.querySelector('.menu');
const menudesplegable = document.querySelector('.menu_desplegable')

menu.addEventListener('click',()=>{
    menu.classList.toggle("active");
    menudesplegable.classList.toggle("click");
})