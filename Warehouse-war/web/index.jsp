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
                color: #fff;
                padding: 8px 30px;
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
            .hint-text {
                float: left;
                margin-top: 10px;
                font-size: 13px;
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
                min-width: 100px;
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
            function openEditModal(product) {
                document.getElementById('editProductId').value = product.id;
                document.getElementById('editSku').value = product.sku;
                document.getElementById('editName').value = product.name;
                document.getElementById('editDescription').value = product.description;
                document.getElementById('editBrand').value = product.brand;
                document.getElementById('editCategory').value = product.categoryId;
                document.getElementById('editSupplier').value = product.supplierId;
                document.getElementById('editStatus').value = product.status;
                $('#editEmployeeModal').modal('show');
            }
        </script>
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <!-- Container wrapper -->
            <div class="container-fluid">
                <div class="col">
                    <div class="row">
                        <button
                            data-mdb-collapse-init
                            class="navbar-toggler"
                            type="button"
                            data-mdb-target="#navbarSupportedContent"
                            aria-controls="navbarSupportedContent"
                            aria-expanded="false"
                            aria-label="Toggle navigation"
                            >
                            <i class="fas fa-bars"></i>
                        </button>

                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <div class="row align-items-center px-3" href="#">
                                <img
                                    src="https://iili.io/3TglYep.png"
                                    alt="MDB Logo"
                                    loading="lazy"
                                    />
                                <div class="text-white font-bold" style="font-size: 20px">StoragePro Co.</div>
                            </div>
                        </div>
                        <!-- Collapsible wrapper -->

                        <!-- Right elements -->
                        <div class="d-flex align-items-center">

                            <!-- Avatar -->
                            <div class="text-white font-bold">
                                [Nguyen Van A - QL Kho]
                            </div>
                        </div>
                    </div>
                    <div class="navbar-nav row py-1">
                        <a class="nav-link" href="#">Tổng quan <span class="sr-only">(current)</span></a>
                        <a class="nav-link" href="#">Quản lý nhập hàng</a>
                        <a class="nav-link" href="#">Quản lý xuất hàng</a>
                        <a class="nav-link active" href="#">Quản lý sản phẩm</a>
                        <a class="nav-link" href="#">Quản lý nhân sự</a>
                    </div>
                </div>
                <!-- Toggle button -->

                <!-- Right elements -->
            </div>
            <!-- Container wrapper -->
        </nav>
        <div class="container-fluid d-flex" style="gap: 24px;">
            <div style="margin-top: 30px; " class="w-25">
                <div style="border-radius: 3px; overflow: hidden" class="w-100">
                    <div class="bg-dark text-white" style="padding: 13.5px 30px; font-size: 15px">
                    Tìm kiếm
                    </div>
                    <div class="bg-white p-3">
                        <form>
                            <input type="hidden" name="action" value="search">
                            <div class="form-group">
                                <input style="font-size: 13px" name="sku" type="text" class="form-control" placeholder="SKU sản phẩm..." >
                            </div>
                            <div class="form-group">
                                <select style="font-size: 13px" class="form-control" name="category">
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
                                <select style="font-size: 13px" class="form-control" name="supplier">
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
                            <div class="form-group">
                                <select style="font-size: 13px" class="form-control" name="status">
                                    <option value="" disabled selected>Chọn trạng thái</option>
                                    <option value="PENDING">Khởi tạo</option>
                                    <option value="AVAILABLE">Sẵn sàng</option>
                                    <option value="OUT_OF_STOCK">Hết hàng</option>
                                    <option value="MAINTAINING">Bảo trì</option>
                                </select>
                            </div>
                            <input type="submit" class="btn btn-info w-100" style="font-size: 13px" value="Tìm kiếm">
                        </form>
                    </div>
                </div>
            </div>
            <div class="table-responsive">
                <div class="table-wrapper">
                    <div class="table-title bg-dark">
                        <div class="row align-items-center">
                            <div class="col-sm-6">
                                <div style="font-size: 15px">Quản lý <b>sản phẩm</b></div>
                            </div>
                            <div class="col-sm-6">
                                <a href="#addEmployeeModal" class="btn btn-dark" data-toggle="modal"><i class="material-icons">&#xE147;</i> <span>Thêm sản phẩm</span></a>				
                            </div>
                        </div>
                    </div>
                    <table class="table table-striped table-hover" style="font-size: 14px">
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
                                <td>
                                    <%
                                        if (product.getStatus() == ProductStatus.PENDING) {
                                    %>
                                    <div class="badge badge-primary p-2 w-100">Khởi tạo</div>
                                    <%
                                    } else if (product.getStatus() == ProductStatus.OUT_OF_STOCK) {
                                    %>
                                    <div class="badge badge-warning p-2 w-100">Hết hàng</div>
                                    <%
                                    } else if (product.getStatus() == ProductStatus.AVAILABLE) {
                                    %>
                                    <div class="badge badge-success p-2 w-100">Sẵn sàng</div>
                                    <%
                                    } else {
                                    %>
                                    <div class="badge badge-danger p-2 w-100" >Bảo trì</div>
                                    <%
                                        }
                                    %>
                                </td>
                                <td><%= product.getCreatedAt()%></td>
                                <td>
                                    <a style="cursor: pointer" onclick="openEditModal({id: <%= product.getId() %>, sku: `<%= product.getSku() %>`, name: '<%= product.getName() %>', description: '<%= product.getDescription() %>', brand: '<%= product.getBrand() %>', categoryId: '<%= product.getCategory().getId() %>', supplierId: '<%= product.getSupplier().getId() %>', status: '<%= product.getStatus() %>'})" class="edit"><i class="material-icons" data-toggle="tooltip" title="Sửa">&#xE254;</i></a>
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
            <% } else if ("create".equals(action)) { %>
                        toastr.error("Có lỗi xảy ra khi thêm sản phẩm! Hãy thử lại!");
            <% } %>
        </script>
        
        
        <div id="addEmployeeModal" class="modal fade">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <form>
                        <input type="hidden" name="action" value="create">
                        <div class="modal-header">						
                            <h6 class="modal-title">Thêm sản phẩm</h6>
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
                            <input type="button" class="btn btn-default btn-sm" data-dismiss="modal" value="Huỷ">
                            <input type="submit" class="btn btn-info btn-sm" value="Thêm">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <%
        String updateAction = request.getParameter("action");
        boolean updateSuccess = false;
        if ("update".equals(updateAction)) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            String sku = request.getParameter("sku");
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String brand = request.getParameter("brand");
            int categoryId = Integer.parseInt(request.getParameter("category"));
            int supplierId = Integer.parseInt(request.getParameter("supplier"));
            ProductStatus status = ProductStatus.valueOf(request.getParameter("status"));

            Product productToUpdate = productService.getById(productId);
            if (productToUpdate != null) {
                productToUpdate.setSku(sku);
                productToUpdate.setDescription(description);
                productToUpdate.setBrand(brand);
                productToUpdate.setName(name);
                productToUpdate.setStatus(status);
                
                Category category = new Category();
                category.setId(categoryId);
                productToUpdate.setCategory(category);
                
                BusinessPartner supplier = new BusinessPartner();
                supplier.setId(supplierId);
                productToUpdate.setSupplier(supplier);
                
                updateSuccess = productService.update(productToUpdate);
                products = productService.getAll();
            }
        }
        %>
        <script>
            const url2 = new URL(window.location.href);
            url2.search = "";
            window.history.replaceState({}, document.title, url2);
        </script>
        <%
            if (updateSuccess) {
        %>
        <script>
            location.reload();
        </script>
        <%
        } else if ("update".equals(updateAction)) {
        %>
        <script>
            toastr.error("Có lỗi xảy ra khi cập nhật sản phẩm! Hãy thử lại!");
        </script>
        <%
            }
        %>
        <div id="editEmployeeModal" class="modal fade">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <form>
                        <input type="hidden" name="productId" id="editProductId">
                        <input type="hidden" name="action" value="update">
                        <div class="modal-header">						
                            <h6 class="modal-title">Sửa sản phẩm</h6>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">					
                            <div class="form-group">
                                <label >SKU</label>
                                <input id="editSku" name="sku" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label >Tên</label>
                                <input id="editName" name="name" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Mô tả</label>
                                <textarea id="editDescription" name="description" class="form-control" required></textarea>
                            </div>
                            <div class="form-group">
                                <label>Thương hiệu</label>
                                <input id="editBrand" name="brand" type="text" class="form-control" required>
                            </div>
                            <div class="form-group">
                                <label>Danh mục</label>
                                <select id="editCategory" class="form-control" name="category" required>
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
                                <select id="editSupplier" class="form-control" name="supplier" required>
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
                            <div class="form-group">
                                <label>Trạng thái</label>
                                <select id="editStatus" class="form-control" name="status" required>
                                    <option value="" disabled selected>Chọn trạng thái</option>
                                    <option value="PENDING">Khởi tạo</option>
                                    <option value="AVAILABLE">Sẵn sàng</option>
                                    <option value="OUT_OF_STOCK">Hết hàng</option>
                                    <option value="MAINTAINING">Bảo trì</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default btn-sm" data-dismiss="modal" value="Huỷ">
                            <input type="submit" class="btn btn-info btn-sm" value="Cập nhật">
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
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <form>
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" id="deleteProductId" name="productId">
                        <div class="modal-header">						
                            <h6 class="modal-title">Xoá sản phẩm</h6>
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        </div>
                        <div class="modal-body">					
                            <p>Bạn có chắc muốn xoá sản phẩm này?</p>
                            <p class="text-warning"><small>Hành động này không thể hoàn tác.</small></p>
                        </div>
                        <div class="modal-footer">
                            <input type="button" class="btn btn-default btn-sm" data-dismiss="modal" value="Huỷ">
                            <input type="submit" class="btn btn-danger btn-sm" value="Xoá">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
