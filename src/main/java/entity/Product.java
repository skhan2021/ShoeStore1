package entity;

/**
 * Enhanced Product entity with color and size fields
 * @author Student
 */
public class Product {
    private int productID;
    private String productName;
    private String description;
    private String color;
    private String size;
    private double price;
    private String imageUrl;

    public Product() {
    }

    public Product(int productID, String productName, String description,
                   String color, String size, double price, String imageUrl) {
        this.productID = productID;
        this.productName = productName;
        this.description = description;
        this.color = color;
        this.size = size;
        this.price = price;
        this.imageUrl = imageUrl;
    }

    // Constructor without ID (for new products)
    public Product(String productName, String description, String color,
                   String size, double price, String imageUrl) {
        this.productName = productName;
        this.description = description;
        this.color = color;
        this.size = size;
        this.price = price;
        this.imageUrl = imageUrl;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    @Override
    public String toString() {
        return "Product{" +
                "productID=" + productID +
                ", productName='" + productName + '\'' +
                ", description='" + description + '\'' +
                ", color='" + color + '\'' +
                ", size='" + size + '\'' +
                ", price=" + price +
                ", imageUrl='" + imageUrl + '\'' +
                '}';
    }
}