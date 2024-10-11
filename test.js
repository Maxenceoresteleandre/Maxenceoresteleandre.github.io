document.addEventListener("DOMContentLoaded", function () {
    const sections = document.querySelectorAll("section");
    const navLinks = document.querySelectorAll(".sidenav a");

    // Scrollspy function
    window.addEventListener("scroll", () => {
        let currentSection = "";

        sections.forEach((section) => {
            const sectionTop = section.offsetTop - 60; // Adjust for fixed header height
            if (window.scrollY >= sectionTop) {
                currentSection = section.getAttribute("id");
            }
        });

        navLinks.forEach((link) => {
            link.classList.remove("active");
            if (link.getAttribute("href").includes(currentSection)) {
                link.classList.add("active");

                // Expand the corresponding work-list
                const parentLi = link.closest("li");
                const nestedList = parentLi.querySelector(".work-list-elements");
                if (nestedList) {
                    const allWorkLists = document.querySelectorAll(".work-list-elements");
                    allWorkLists.forEach((list) => list.style.display = "none"); // Hide all lists
                    nestedList.style.display = "block"; // Show the related list
                }
            }
        });
    });

    // Collapse/Expand Work List
    document.querySelectorAll(".work-list").forEach((workList) => {
        workList.addEventListener("click", (e) => {
            e.preventDefault();
            const list = workList.nextElementSibling;
            if (list) {
                list.style.display = list.style.display === "block" ? "none" : "block";
                workList.classList.toggle("active");
            }
        });
    });
});
