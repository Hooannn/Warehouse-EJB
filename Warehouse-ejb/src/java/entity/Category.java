/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.io.Serializable;

public class Category implements Serializable {
    private int id;
    private String name;
    private String unitName;

    public Category() {
    }

    
    public Category(int id, String name, String unitName) {
        this.id = id;
        this.name = name;
        this.unitName = unitName;
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

    public String getUnitName() {
        return unitName;
    }

    public void setUnitName(String unitName) {
        this.unitName = unitName;
    }

    @Override
    public String toString() {
        return "Category{" + "id=" + id + ", name=" + name + ", unitName=" + unitName + '}';
    }
    
    
}
