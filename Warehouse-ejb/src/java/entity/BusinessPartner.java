/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author nguyenduckhaihoan
 */
public class BusinessPartner implements Serializable {
    private int id;
    private String name;
    private String phoneNumber;
    private String email;
    private String address;
    private boolean isActive;
    private boolean isSupplier;
    private boolean isCustomer;
    private Date createdAt;

    public BusinessPartner() {
    }

    public BusinessPartner(int id, String name, String phoneNumber, String email, String address, boolean isActive, boolean isSupplier, boolean isCustomer, Date createdAt) {
        this.id = id;
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.address = address;
        this.isActive = isActive;
        this.isSupplier = isSupplier;
        this.isCustomer = isCustomer;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }

    public boolean isIsSupplier() {
        return isSupplier;
    }

    public void setIsSupplier(boolean isSupplier) {
        this.isSupplier = isSupplier;
    }

    public boolean isIsCustomer() {
        return isCustomer;
    }

    public void setIsCustomer(boolean isCustomer) {
        this.isCustomer = isCustomer;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "BusinessPartner{" + "id=" + id + ", name=" + name + ", phoneNumber=" + phoneNumber + ", email=" + email + ", address=" + address + ", isActive=" + isActive + ", isSupplier=" + isSupplier + ", isCustomer=" + isCustomer + ", createdAt=" + createdAt + '}';
    }

    
    
}
