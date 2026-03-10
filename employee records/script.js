const api = "http://localhost:5000";

function loadEmployees(){

    const sort = document.getElementById("sort").value;
    const dept = document.getElementById("department").value;

    fetch(`${api}/employees?sort=${sort}&department=${dept}`)
    .then(res => res.json())
    .then(data => {

        let table = document.querySelector("#empTable tbody");
        table.innerHTML = "";

        data.forEach(emp => {

            table.innerHTML += `
            <tr>
            <td>${emp.emp_id}</td>
            <td>${emp.name}</td>
            <td>${emp.department}</td>
            <td>${emp.joining_date}</td>
            </tr>
            `;

        });

    });

}

/* Department Count */

fetch(`${api}/department-count`)
.then(res => res.json())
.then(data => {

    let list = document.getElementById("deptCount");

    data.forEach(d => {

        list.innerHTML += `<li>${d.department} : ${d.total}</li>`;

    });

});