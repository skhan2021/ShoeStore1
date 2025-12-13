CREATE TABLE HD_Product_Catalog (
                                    Product_ID int NOT NULL PRIMARY KEY,
                                    Product_Name VARCHAR(100) NOT NULL,
                                    Description VARCHAR(500),
                                    Color VARCHAR(50),
                                    Size VARCHAR(20),
                                    Price DECIMAL(10,2) NOT NULL,
                                    Image_URL VARCHAR(500)
);

-- Insert sample sneaker products with color and size
INSERT INTO HD_Product_Catalog (Product_ID, Product_Name, Description, Color, Size, Price, Image_URL) VALUES
                                                                                                          (1, 'Nike Air Max 270', 'Comfortable running shoes with Max Air cushioning for all-day comfort', 'Black/White', 'US 10', 150.00, 'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/awjogtdnqxniqqde0vrl/air-max-270-mens-shoes-KkLcGR.png'),
                                                                                                          (2, 'Adidas Ultraboost 22', 'Energy-returning running shoes with Primeknit upper for ultimate comfort', 'Core Black', 'US 10.5', 190.00, 'https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/fbaf991a78bc4896a3e9ad7800abcec6_9366/Ultraboost_22_Shoes_Black_GZ0127_01_standard.jpg'),
                                                                                                          (3, 'Puma RS-X', 'Retro-inspired sneakers with bold design and superior cushioning', 'Red/Blue', 'US 9.5', 110.00, 'https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_2000,h_2000/global/380462/01/sv01/fnd/PNA/fmt/png/RS-X-Reinvention-Sneakers'),
                                                                                                          (4, 'Reebok Classic Leather', 'Timeless sneakers with premium leather upper and comfortable fit', 'White', 'US 11', 75.00, 'https://assets.reebok.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/4c764cb8b6554c4f9b7aad7800aeac60_9366/Classic_Leather_Shoes_White_2214.jpg');