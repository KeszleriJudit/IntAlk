/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

enabled = true;
function starcolor(color, filmID, number) {
    if (document.getElementsByName('stars' + filmID).className != "selectedstar") {
        if (number == 5) {
            document.getElementById('star5' + filmID).style.color = color;
            document.getElementById('star4' + filmID).style.color = color;
            document.getElementById('star3' + filmID).style.color = color;
            document.getElementById('star2' + filmID).style.color = color;
            document.getElementById('star1' + filmID).style.color = color;
        } else if (number == 4) {
            document.getElementById('star4' + filmID).style.color = color;
            document.getElementById('star3' + filmID).style.color = color;
            document.getElementById('star2' + filmID).style.color = color;
            document.getElementById('star1' + filmID).style.color = color;
        } else if (number == 3) {
            document.getElementById('star3' + filmID).style.color = color;
            document.getElementById('star2' + filmID).style.color = color;
            document.getElementById('star1' + filmID).style.color = color;
        } else if (number == 2) {
            document.getElementById('star2' + filmID).style.color = color;
            document.getElementById('star1' + filmID).style.color = color;
        } else if (number == 1) {
            document.getElementById('star1' + filmID).style.color = color;
        }
    }
}
function selected(number, filmID) {
    if (number == 5) {
        document.getElementById('star5' + filmID).style.color = 'yellow';
        document.getElementById('star4' + filmID).style.color = 'yellow';
        document.getElementById('star3' + filmID).style.color = 'yellow';
        document.getElementById('star2' + filmID).style.color = 'yellow';
        document.getElementById('star1' + filmID).style.color = 'yellow';
        document.getElementsByName('stars' + filmID).className = "selectedstar"
        document.getElementById('button' + filmID).value = '5';
    } else if (number == 4) {
        document.getElementById('star5' + filmID).style.color = 'black';
        document.getElementById('star4' + filmID).style.color = 'yellow';
        document.getElementById('star3' + filmID).style.color = 'yellow';
        document.getElementById('star2' + filmID).style.color = 'yellow';
        document.getElementById('star1' + filmID).style.color = 'yellow';
        document.getElementsByName('stars' + filmID).className = "selectedstar"
        document.getElementById('button' + filmID).value = '4';
    } else if (number == 3) {
        document.getElementById('star5' + filmID).style.color = 'black';
        document.getElementById('star4' + filmID).style.color = 'black';
        document.getElementById('star3' + filmID).style.color = 'yellow';
        document.getElementById('star2' + filmID).style.color = 'yellow';
        document.getElementById('star1' + filmID).style.color = 'yellow';
        document.getElementsByName('stars' + filmID).className = "selectedstar"
        document.getElementById('button' + filmID).value = '3';
    } else if (number == 2) {
        document.getElementById('star5' + filmID).style.color = 'black';
        document.getElementById('star4' + filmID).style.color = 'black';
        document.getElementById('star3' + filmID).style.color = 'black';
        document.getElementById('star2' + filmID).style.color = 'yellow';
        document.getElementById('star1' + filmID).style.color = 'yellow';
        document.getElementsByName('stars' + filmID).className = "selectedstar"
        document.getElementById('button' + filmID).value = '2';
    } else if (number == 1) {
        document.getElementById('star5' + filmID).style.color = 'black';
        document.getElementById('star4' + filmID).style.color = 'black';
        document.getElementById('star3' + filmID).style.color = 'black';
        document.getElementById('star2' + filmID).style.color = 'black';
        document.getElementById('star1' + filmID).style.color = 'yellow';
        document.getElementsByName('stars' + filmID).className = "selectedstar"
        document.getElementById('button' + filmID).value = '1';
    }
}

function checking(rate, filmID){
    if (rate == "1"){
        document.getElementById('star5' + filmID).style.color = 'black';
        document.getElementById('star4' + filmID).style.color = 'black';
        document.getElementById('star3' + filmID).style.color = 'black';
        document.getElementById('star2' + filmID).style.color = 'black';
        document.getElementById('star1' + filmID).style.color = 'yellow';
        document.getElementsByName('stars' + filmID).className = "selectedstar"
    } else if (rate == "2"){
        document.getElementById('star5' + filmID).style.color = 'black';
        document.getElementById('star4' + filmID).style.color = 'black';
        document.getElementById('star3' + filmID).style.color = 'black';
        document.getElementById('star2' + filmID).style.color = 'yellow';
        document.getElementById('star1' + filmID).style.color = 'yellow';
        document.getElementsByName('stars' + filmID).className = "selectedstar"
    } else if (rate == "3"){
        document.getElementById('star5' + filmID).style.color = 'black';
        document.getElementById('star4' + filmID).style.color = 'black';
        document.getElementById('star3' + filmID).style.color = 'yellow';
        document.getElementById('star2' + filmID).style.color = 'yellow';
        document.getElementById('star1' + filmID).style.color = 'yellow';
        document.getElementsByName('stars' + filmID).className = "selectedstar"
    } else if (rate == "4"){
        document.getElementById('star5' + filmID).style.color = 'black';
        document.getElementById('star4' + filmID).style.color = 'yellow';
        document.getElementById('star3' + filmID).style.color = 'yellow';
        document.getElementById('star2' + filmID).style.color = 'yellow';
        document.getElementById('star1' + filmID).style.color = 'yellow';
        document.getElementsByName('stars' + filmID).className = "selectedstar"
    } else if (rate == "5"){
        document.getElementById('star5' + filmID).style.color = 'yellow';
        document.getElementById('star4' + filmID).style.color = 'yellow';
        document.getElementById('star3' + filmID).style.color = 'yellow';
        document.getElementById('star2' + filmID).style.color = 'yellow';
        document.getElementById('star1' + filmID).style.color = 'yellow';
        document.getElementsByName('stars' + filmID).className = "selectedstar"
    }
}
function del(){
    document.getElementsByName('delete').value = "activated";
    window.location.href="helpers.jsp";
}



