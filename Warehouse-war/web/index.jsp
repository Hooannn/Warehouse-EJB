<%-- 
    Document   : index
    Created on : Mar 23, 2025, 7:57:58 PM
    Author     : nguyenduckhaihoan
--%>

<%@page import="java.util.List"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="warehouse.ejb.ProductService, warehouse.ejb.IProductService, entity.*, javax.naming.*"%>
<%@ page import="java.math.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="javax.ejb.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.rmi.RemoteException" %>
<%!
    private IProductService productService = null;
    private List<Product> products = null;    
    private List<Category> categories = null;
    private List<BusinessPartner> suppliers = null;

    public void jspInit() {
        try {
            InitialContext ic = new InitialContext();
            productService = (IProductService) ic.lookup(IProductService.class.getName());
            products = productService.getAll();
            categories = productService.getAllCategories();
            suppliers = productService.getAllSuppliers();
        } catch (Exception ex) {
            System.out.println("Couldn't create ProductService bean. " + ex.getMessage());
        }
    }

    public void jspDestroy() {
        productService = null;
    }

    
%>
<html lang="vi">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Quản lý phiếu nhập</title>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
        <style>
            body {
                color: #566787;
                background: #f5f5f5;
                font-family: 'Varela Round', sans-serif;
                font-size: 13px;
            }
            .table-responsive {
                margin: 30px 0;
            }
            .table-wrapper {
                background: #fff;
                padding: 20px 25px;
                border-radius: 3px;
                min-width: 1000px;
                box-shadow: 0 1px 1px rgba(0,0,0,.05);
            }
            .table-title {
                padding-bottom: 15px;
                background: #435d7d;
                color: #fff;
                padding: 16px 30px;
                min-width: 100%;
                margin: -20px -25px 10px;
                border-radius: 3px 3px 0 0;
            }
            .table-title h2 {
                margin: 5px 0 0;
                font-size: 24px;
            }
            .table-title .btn-group {
                float: right;
            }
            .table-title .btn {
                color: #fff;
                float: right;
                font-size: 13px;
                border: none;
                min-width: 50px;
                border-radius: 2px;
                border: none;
                outline: none !important;
                margin-left: 10px;
            }
            .table-title .btn i {
                float: left;
                font-size: 21px;
                margin-right: 5px;
            }
            .table-title .btn span {
                float: left;
                margin-top: 2px;
            }
            table.table tr th, table.table tr td {
                border-color: #e9e9e9;
                padding: 12px 15px;
                vertical-align: middle;
            }
            table.table tr th:first-child {
                width: 60px;
            }
            table.table tr th:last-child {
                width: 100px;
            }
            table.table-striped tbody tr:nth-of-type(odd) {
                background-color: #fcfcfc;
            }
            table.table-striped.table-hover tbody tr:hover {
                background: #f5f5f5;
            }
            table.table th i {
                font-size: 13px;
                margin: 0 5px;
                cursor: pointer;
            }
            table.table td:last-child i {
                opacity: 0.9;
                font-size: 22px;
                margin: 0 5px;
            }
            table.table td a {
                font-weight: bold;
                color: #566787;
                display: inline-block;
                text-decoration: none;
                outline: none !important;
            }
            table.table td a:hover {
                color: #2196F3;
            }
            table.table td a.edit {
                color: #FFC107;
            }
            table.table td a.delete {
                color: #F44336;
            }
            table.table td i {
                font-size: 19px;
            }
            table.table .avatar {
                border-radius: 50%;
                vertical-align: middle;
                margin-right: 10px;
            }
            .pagination {
                float: right;
                margin: 0 0 5px;
            }
            .pagination li a {
                border: none;
                font-size: 13px;
                min-width: 30px;
                min-height: 30px;
                color: #999;
                margin: 0 2px;
                line-height: 30px;
                border-radius: 2px !important;
                text-align: center;
                padding: 0 6px;
            }
            .pagination li a:hover {
                color: #666;
            }
            .pagination li.active a, .pagination li.active a.page-link {
                background: #03A9F4;
            }
            .pagination li.active a:hover {
                background: #0397d6;
            }
            .pagination li.disabled i {
                color: #ccc;
            }
            .pagination li i {
                font-size: 16px;
                padding-top: 6px
            }
            .hint-text {
                float: left;
                margin-top: 10px;
                font-size: 13px;
            }
            /* Custom checkbox */
            .custom-checkbox {
                position: relative;
            }
            .custom-checkbox input[type="checkbox"] {
                opacity: 0;
                position: absolute;
                margin: 5px 0 0 3px;
                z-index: 9;
            }
            .custom-checkbox label:before{
                width: 18px;
                height: 18px;
            }
            .custom-checkbox label:before {
                content: '';
                margin-right: 10px;
                display: inline-block;
                vertical-align: text-top;
                background: white;
                border: 1px solid #bbb;
                border-radius: 2px;
                box-sizing: border-box;
                z-index: 2;
            }
            .custom-checkbox input[type="checkbox"]:checked + label:after {
                content: '';
                position: absolute;
                left: 6px;
                top: 3px;
                width: 6px;
                height: 11px;
                border: solid #000;
                border-width: 0 3px 3px 0;
                transform: inherit;
                z-index: 3;
                transform: rotateZ(45deg);
            }
            .custom-checkbox input[type="checkbox"]:checked + label:before {
                border-color: #03A9F4;
                background: #03A9F4;
            }
            .custom-checkbox input[type="checkbox"]:checked + label:after {
                border-color: #fff;
            }
            .custom-checkbox input[type="checkbox"]:disabled + label:before {
                color: #b8b8b8;
                cursor: auto;
                box-shadow: none;
                background: #ddd;
            }
            /* Modal styles */
            .modal .modal-dialog {
                max-width: 400px;
            }
            .modal .modal-header, .modal .modal-body, .modal .modal-footer {
                padding: 20px 30px;
            }
            .modal .modal-content {
                border-radius: 3px;
                font-size: 14px;
            }
            .modal .modal-footer {
                background: #ecf0f1;
                border-radius: 0 0 3px 3px;
            }
            .modal .modal-title {
                display: inline-block;
            }
            .modal .form-control {
                border-radius: 2px;
                box-shadow: none;
                border-color: #dddddd;
            }
            .modal textarea.form-control {
                resize: vertical;
            }
            .modal .btn {
                border-radius: 2px;
                min-width: 100px;
            }
            .modal form label {
                font-weight: normal;
            }
        </style>
        <script>
            $(document).ready(function () {
                $('[data-toggle="tooltip"]').tooltip();
            });
            function openDeleteModal(productId) {
                document.getElementById("deleteProductId").value = productId;
                $('#deleteEmployeeModal').modal('show');
            }
        </script>
    </head>
    <body>
        <div class="container-xl">
            <div class="table-responsive">
                <div class="table-wrapper">
                    <div class="table-title">
                        <div class="row">
                            <div class="col-sm-6">
                                <h2>Quản lý <b>sản phẩm</b></h2>
                            </div>
                            <div class="col-sm-6">
                                <a href="#addEmployeeModal" class="btn btn-success" data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Thêm sản phẩm</span></a>				
                            </div>
                        </div>
                    </div>
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>Mã sản phẩm</th>
                                <th>SKU</th>
                                <th>Tên</th>
                                <th>Mô tả</th>
                                <th>Thương hiệu</th>
                                <th>Danh mục</th>
                                <th>Nhà cung cấp</th>
                                <th>Trạng thái</th>
                                <th>Ngày tạo</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (products != null && !products.isEmpty()) {
                                    for (Product product : products) {
                            %>
                            <tr>
                                <td><%= product.getId()%></td>
                                <td><%= product.getSku()%></td>
                                <td><%= product.getName()%></td>
                                <td><%= product.getDescription()%></td>
                                <td><%= product.getBrand()%></td>
                                <td><%= product.getCategory().getName()%></td>
                                <td><%= product.getSupplier().getName()%></td>
                                <td><%= product.getStatus()%></td>
                                <td><%= product.getCreatedAt()%></td>
                                <td>
                                    <a href="#editEmployeeModal" class="edit" data-toggle="modal"><i class="material-icons" data-toggle="tooltip" title="Sửa">&#xE254;</i></a>
                                    <a style="cursor: pointer" onclick="openDeleteModal(<%= product.getId() %>)" class="delete"><i class="material-icons" data-toggle="tooltip" title="Xoá">&#xE872;</i></a>
                                </td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="5">Không có sản phẩm nào.</td>
                            </tr>
                            <%
                                }
                            %>
                            
                        </tbody>
                    </table>
                </div>
            </div>        
        </div>
        <%
            String action = request.getParameter("action");
            boolean success = false;
            if ("create".equals(action)) {
                String sku = request.getParameter("sku");
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                String brand = request.getParameter("brand");
                int categoryId = Integer.parseInt(request.getParameter("category"));
                int supplierId = Integer.parseInt(request.getParameter("supplier"));

                Product newProduct = new Product();
                newProduct.setSku(sku);
                newProduct.setName(name);
                newProduct.setDescription(description);
                newProduct.setBrand(brand);
                Category category = new Category();
                category.setId(categoryId);
                BusinessPartner supplier = new BusinessPartner();
                supplier.setId(supplierId);
                newProduct.setCategory(category);
                newProduct.setSupplier(supplier);
                
                success = productService.add(newProduct);
                products = productService.getAll();
            }
        %>
        <script>
            const url = new URL(window.location.href);
            url.search = ""; // Clear query parameters
            window.history.replaceState({}, document.title, url);

            <% if (success) { %>
                        location.reload();
                        toastr.success("Thêm sản phẩm thành công!");
            <% } else if ("create".equals(action)) { %>
                        toastr.error("Có lỗi xảy ra khi thêm sản phẩm! Hãy thử lại!");
            <% } %>
        </script>
        
        
        <div id="addEmployeeModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form>
                        <input type="hidden" name="action" value="create">
                        <div class="modal-header">						
                            <h4 class="modal-title">Thêm sản phẩm</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">					
                            <div class="form-group">
                                <label >SKU</label>
                                <input name="sku" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label >Tên</label>
                                <input name="name" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Mô tả</label>
                                <textarea name="description" class="form-control" required></textarea>
                            </div>
                            <div class="form-group">
                                <label>Thương hiệu</label>
                                <input name="brand" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Danh mục</label>
                                <select class="form-control" name="category" required>
                                    <option value="" disabled selected>Chọn danh mục</option>
                                    <%
                                        if (categories != null && !categories.isEmpty()) {
                                            for (Category category : categories) {
                                    %>
                                    <option value="<%= category.getId()%>"><%= category.getName()%></option>
                                    <%
                                            }
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Nhà cung cấp</label>
                                <select class="form-control" name="supplier" required>
                                    <option value="" disabled selected>Chọn nhà cung cấp</option>
                                    <%
                                        if (suppliers != null && !suppliers.isEmpty()) {
                                            for (BusinessPartner supplier : suppliers) {
                                    %>
                                    <option value="<%= supplier.getId()%>"><%= supplier.getName()%></option>
                                    <%
                                            }
                                        }
                                    %>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Huỷ">
                            <input type="submit" class="btn btn-success" value="Thêm">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- NEXT: Tue 25 Mar 23:27 -->
        <div id="editEmployeeModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form>
                        <input type="hidden" name="productId" id="editProductId">
                        <input type="hidden" name="action" value="update">
                        <div class="modal-header">						
                            <h4 class="modal-title">Edit Employee</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">					
                            <div class="form-group">
                                <label>Name</label>
                                <input type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Email</label>
                                <input type="email" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Address</label>
                                <textarea class="form-control" required></textarea>
                            </div>
                            <div class="form-group">
                                <label>Phone</label>
                                <input type="text" class="form-control" required>
                            </div>					
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Cancel">
                            <input type="submit" class="btn btn-info" value="Save">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <%
            String deleteAction = request.getParameter("action");
            boolean deleteSuccess = false;
            if ("delete".equals(deleteAction)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                deleteSuccess = productService.removeById(productId);
                products = productService.getAll();
            }
        %>
        <script>
            const url1 = new URL(window.location.href);
            url1.search = ""; // Clear query parameters
            window.history.replaceState({}, document.title, url1);

            <% if (deleteSuccess) { %>
                        location.reload();
            <% } else if ("delete".equals(deleteAction)) { %>
                        toastr.error("Có lỗi xảy ra khi xoá sản phẩm! Hãy thử lại!");
            <% } %>
        </script>
        <div id="deleteEmployeeModal" class="modal fade">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form>
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" id="deleteProductId" name="productId">
                        <div class="modal-header">						
                            <h4 class="modal-title">Xoá sản phẩm</h4>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">					
                            <p>Bạn có chắc muốn xoá sản phẩm này?</p>
                            <p class="text-warning"><small>Hành động này không thể hoàn tác.</small></p>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default" data-dismiss="modal" value="Huỷ">
                            <input type="submit" class="btn btn-danger" value="Xoá">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
