function show_product_list_nav(part){
    if(part=="CPU"){
        cpu_filter();
    }else if(part=="Mainboard"){
        mainboard_filter();
    }
    else if(part=="GPU"){
        gpu_filter();
    }else if(part=="RAM"){
        ram_filter();
    }else if(part="Disk"){
        disk_filter();
    }else if(part=="Cooler"){
        cooler_filter();
    }else if(part=="Power"){
        power_filter();
    }else if(part="Tower"){
        tower_filter();
    }
}

function make_list(filter, site){
    var list = document.createElement("div");
    list.className = "nav_filter_list";

    var list_criteria = document.createElement("div");
    list_criteria.className="nav_filter_criteria";
    list_criteria.innerHTML = filter[0];

    list.appendChild(list_criteria)
    
    for(idx=1; idx<filter.length(); idx++){
        var list_name = document.createElement("div");
        list_name.className= "nav_filter_name";
        list_name.innerHTML=filter[idx];
        list_name.addEventListener("click", function(){
            location.href= site+filter[0]+"="+filter[idx];
        })

        list.appendChild(list_name);
    }

    return list;
}

function cpu_filter(){
    var manufacturer = ["ManuFacturer", "Intel", "AMD"];
    var core = ["Core", "16+8", "8+8", "8+4"];
    var ddr = ["DDR", "DDR5", "DDR4", "DDR3"];
    var filters = [manufacturer, core, ddr];

    var menu = document.getElementById("nav_filter");
    var site = "../page/Products/Page_Product_List.jsp?part=CPU&";
    // 제조사 메뉴
    for(idx=0; idx<3; idx++){
        menu.appendChild(make_list(filters[idx], site));
    }
}

function mainboard_filter(){

    var manufacturer = ["Manufacturer","ASUS", "MSI", "GIGABYTE"];
    var usefor = ["Usefor", "Intel", "AMD"];
    var socket = ["1700", "1200", "AM4", "sWRX8"];
    var filters = [manufacturer, usefor, socket];

    var menu = document.getElementById("nav_filter");
    var site = "../page/Products/Page_Product_List.jsp?part=Mainboard&";
    // 제조사 메뉴
    for(idx=0; idx<3; idx++){
        menu.appendChild(make_list(filters[idx], site));
    }
}

function gpu_filter(){

}

function ram_filter(){

}

function disk_filter(){

}

function cooler_filter(){

}

function power_filter(){

}

function tower_filter(){

}

window.onload = function(){
    show_product_list_nav(part);
}