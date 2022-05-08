CREATE DATABASE IF NOT EXISTS CVOID2019;

USE CVOID2019;

CREATE TABLE IF NOT EXISTS `detailCount` (
  `date` date NOT NULL COMMENT '主键',
  `provinceName` varchar(20) NOT NULL COMMENT '主键',
  `currentConfirmedCount` int(10) NOT NULL,
  `confirmedCount` int(10) NOT NULL,
  `deadCount` int(10) NOT NULL,
  `curedCount` int(10) NOT NULL,
  PRIMARY KEY (`date`, `provinceName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP PROCEDURE IF EXISTS totalSum;

DELIMITER @@

CREATE PROCEDURE totalSum()
BEGIN
  INSERT IGNORE INTO detailCount (`date`, `provinceName`, `currentConfirmedCount`, `confirmedCount`, `deadCount`, `curedCount`) 
  VALUES 
    ('1970-01-01', '全国', '', '', '', '');

  SET @totalDeadCount=(SELECT SUM(`deadCount`) FROM `detailCount`);
  SET @totalCuredCount=(SELECT SUM(`curedCount`) FROM `detailCount`);
  SET @totalConfirmedCount=(SELECT SUM(`confirmedCount`) FROM `detailCount`);
  SET @totalCurrentConfirmedCount=(SELECT SUM(`currentConfirmedCount`) FROM `detailCount`);

  UPDATE 
    `detailCount` 
  SET 
    `deadCount` = @totalDeadCount, 
    `curedCount` = @totalCuredCount, 
    `confirmedCount` = @totalConfirmedCount, 
    `currentConfirmedCount` = @totalCurrentConfirmedCount 
  WHERE  `provinceName` = '全国';

  -- 全国疫情
  SELECT `provincename`          AS '省份', 
         `currentconfirmedcount` AS '近期确诊', 
         `confirmedcount`        AS '总计确诊', 
         `deadcount`             AS '总计死亡', 
         `curedcount`            AS '总计治愈' 
  FROM   `detailcount` 
  WHERE  `provincename` = '全国'; 

  -- 确诊最多 
  SELECT `provincename`          AS '确诊最多', 
         `currentconfirmedcount` AS '近期确诊', 
         `confirmedcount`        AS '总计确诊', 
         `deadcount`             AS '总计死亡', 
         `curedcount`            AS '总计治愈' 
  FROM   `detailcount` 
  WHERE  `confirmedcount` = (SELECT MAX(`confirmedcount`) 
                           FROM   (SELECT `confirmedcount`
                                   FROM   `detailcount` 
                                   ORDER  BY `date` DESC 
                                   LIMIT  34) AS temp) 
  LIMIT  1; 

  -- 确诊最少 
  SELECT `provincename`          AS '确诊最少', 
         `currentconfirmedcount` AS '近期确诊', 
         `confirmedcount`        AS '总计确诊', 
         `deadcount`             AS '总计死亡', 
         `curedcount`            AS '总计治愈' 
  FROM   `detailcount` 
  WHERE  `confirmedcount` = (SELECT MIN(`confirmedcount`) 
                           FROM   (SELECT `confirmedcount`
                                   FROM   `detailcount` 
                                   ORDER  BY `date` DESC 
                                   LIMIT  34) AS temp) 
  LIMIT  1;

  -- 福建省近10天疫情情况
  SELECT `date`                  AS '日期', 
         `provincename`          AS '省份', 
         `currentconfirmedcount` AS '近期确诊', 
         `confirmedcount`        AS '总计确诊', 
         `deadcount`             AS '总计死亡', 
         `curedcount`            AS '总计治愈' 
  FROM   `detailcount` 
  WHERE  `provincename` = '福建省' 
  LIMIT  10;
END@@

DELIMITER ;

INSERT IGNORE INTO detailCount (date, provinceName, currentConfirmedCount, confirmedCount, deadCount, curedCount) VALUES
('2022-05-01', '香港', 261858, 330670, 9308, 59504),
('2022-05-01', '台湾', 118388, 132995, 865, 13742),
('2022-05-01', '上海市', 20265, 58341, 429, 37647),
('2022-05-01', '吉林省', 1420, 40211, 5, 38786),
('2022-05-01', '浙江省', 804, 3109, 1, 2304),
('2022-05-01', '北京市', 319, 2155, 9, 1827),
('2022-05-01', '黑龙江省', 283, 2943, 13, 2647),
('2022-05-01', '江西省', 256, 1369, 1, 1112),
('2022-05-01', '广东省', 184, 7054, 8, 6862),
('2022-05-01', '山东省', 67, 2717, 7, 2643),
('2022-05-01', '四川省', 67, 2049, 3, 1979),
('2022-05-01', '内蒙古自治区', 59, 1750, 1, 1690),
('2022-05-01', '福建省', 51, 3019, 1, 2967),
('2022-05-01', '江苏省', 45, 2203, 0, 2158),
('2022-05-01', '河南省', 40, 2906, 22, 2844),
('2022-05-01', '辽宁省', 35, 1645, 2, 1608),
('2022-05-01', '湖南省', 35, 1385, 4, 1346),
('2022-05-01', '山西省', 34, 418, 0, 384),
('2022-05-01', '云南省', 30, 2119, 2, 2087),
('2022-05-01', '青海省', 29, 95, 0, 66),
('2022-05-01', '海南省', 26, 288, 6, 256),
('2022-05-01', '广西壮族自治区', 20, 1584, 2, 1562),
('2022-05-01', '河北省', 18, 1998, 7, 1973),
('2022-05-01', '安徽省', 8, 1065, 6, 1051),
('2022-05-01', '新疆维吾尔自治区', 6, 1005, 3, 996),
('2022-05-01', '湖北省', 4, 68398, 4512, 63882),
('2022-05-01', '陕西省', 4, 3277, 3, 3270),
('2022-05-01', '重庆市', 4, 698, 6, 688),
('2022-05-01', '天津市', 1, 1803, 3, 1799),
('2022-05-01', '甘肃省', 0, 681, 2, 679),
('2022-05-01', '贵州省', 0, 179, 2, 177),
('2022-05-01', '宁夏回族自治区', 0, 122, 0, 122),
('2022-05-01', '澳门', 0, 82, 0, 82),
('2022-05-01', '西藏自治区', 0, 1, 0, 1);

INSERT IGNORE INTO detailCount (date, provinceName, currentConfirmedCount, confirmedCount, deadCount, curedCount) VALUES
('2022-05-02', '香港', 261751, 330725, 9313, 59661),
('2022-05-02', '台湾', 136198, 150808, 868, 13742),
('2022-05-02', '上海市', 16716, 59070, 461, 41893),
('2022-05-02', '吉林省', 1209, 40242, 5, 39028),
('2022-05-02', '浙江省', 793, 3111, 1, 2317),
('2022-05-02', '北京市', 345, 2191, 9, 1837),
('2022-05-02', '黑龙江省', 247, 2952, 13, 2692),
('2022-05-02', '江西省', 233, 1371, 1, 1137),
('2022-05-02', '广东省', 180, 7082, 8, 6894),
('2022-05-02', '四川省', 70, 2057, 3, 1984),
('2022-05-02', '山东省', 68, 2722, 7, 2647),
('2022-05-02', '内蒙古自治区', 59, 1751, 1, 1691),
('2022-05-02', '福建省', 47, 3022, 1, 2974),
('2022-05-02', '江苏省', 43, 2206, 0, 2163),
('2022-05-02', '河南省', 39, 2907, 22, 2846),
('2022-05-02', '辽宁省', 36, 1646, 2, 1608),
('2022-05-02', '山西省', 29, 418, 0, 389),
('2022-05-02', '云南省', 28, 2119, 2, 2089),
('2022-05-02', '湖南省', 28, 1385, 4, 1353),
('2022-05-02', '海南省', 26, 288, 6, 256),
('2022-05-02', '青海省', 25, 95, 0, 70),
('2022-05-02', '广西壮族自治区', 21, 1587, 2, 1564),
('2022-05-02', '河北省', 14, 1998, 7, 1977),
('2022-05-02', '新疆维吾尔自治区', 8, 1007, 3, 996),
('2022-05-02', '安徽省', 7, 1065, 6, 1052),
('2022-05-02', '湖北省', 4, 68398, 4512, 63882),
('2022-05-02', '重庆市', 4, 698, 6, 688),
('2022-05-02', '天津市', 2, 1804, 3, 1799),
('2022-05-02', '陕西省', 1, 3277, 3, 3273),
('2022-05-02', '甘肃省', 0, 681, 2, 679),
('2022-05-02', '贵州省', 0, 179, 2, 177),
('2022-05-02', '宁夏回族自治区', 0, 122, 0, 122),
('2022-05-02', '澳门', 0, 82, 0, 82),
('2022-05-02', '西藏自治区', 0, 1, 0, 1);

INSERT IGNORE INTO detailCount (date, provinceName, currentConfirmedCount, confirmedCount, deadCount, curedCount) VALUES
('2022-05-03', '香港', 261716, 330773, 9318, 59739),
('2022-05-03', '台湾', 159324, 173942, 876, 13742),
('2022-05-03', '上海市', 12988, 59344, 481, 45875),
('2022-05-03', '吉林省', 1058, 40242, 5, 39179),
('2022-05-03', '浙江省', 770, 3111, 1, 2340),
('2022-05-03', '北京市', 391, 2242, 9, 1842),
('2022-05-03', '黑龙江省', 230, 2965, 13, 2722),
('2022-05-03', '江西省', 220, 1376, 1, 1155),
('2022-05-03', '广东省', 169, 7091, 8, 6914),
('2022-05-03', '四川省', 74, 2063, 3, 1986),
('2022-05-03', '山东省', 70, 2725, 7, 2648),
('2022-05-03', '内蒙古自治区', 60, 1752, 1, 1691),
('2022-05-03', '福建省', 50, 3031, 1, 2980),
('2022-05-03', '辽宁省', 40, 1651, 2, 1609),
('2022-05-03', '河南省', 36, 2909, 22, 2851),
('2022-05-03', '江苏省', 30, 2206, 0, 2176),
('2022-05-03', '云南省', 27, 2119, 2, 2090),
('2022-05-03', '山西省', 27, 420, 0, 393),
('2022-05-03', '湖南省', 26, 1385, 4, 1355),
('2022-05-03', '海南省', 25, 288, 6, 257),
('2022-05-03', '广西壮族自治区', 23, 1590, 2, 1565),
('2022-05-03', '青海省', 20, 95, 0, 75),
('2022-05-03', '河北省', 13, 1998, 7, 1978),
('2022-05-03', '新疆维吾尔自治区', 8, 1007, 3, 996),
('2022-05-03', '安徽省', 7, 1065, 6, 1052),
('2022-05-03', '重庆市', 5, 699, 6, 688),
('2022-05-03', '湖北省', 4, 68398, 4512, 63882),
('2022-05-03', '天津市', 2, 1804, 3, 1799),
('2022-05-03', '陕西省', 1, 3277, 3, 3273),
('2022-05-03', '甘肃省', 0, 681, 2, 679),
('2022-05-03', '贵州省', 0, 179, 2, 177),
('2022-05-03', '宁夏回族自治区', 0, 122, 0, 122),
('2022-05-03', '澳门', 0, 82, 0, 82),
('2022-05-03', '西藏自治区', 0, 1, 0, 1);

INSERT IGNORE INTO detailCount (date, provinceName, currentConfirmedCount, confirmedCount, deadCount, curedCount) VALUES
('2022-05-04', '香港', 261741, 330880, 9325, 59814),
('2022-05-04', '台湾', 187795, 202418, 881, 13742),
('2022-05-04', '上海市', 11366, 59607, 497, 47744),
('2022-05-04', '吉林省', 987, 40245, 5, 39253),
('2022-05-04', '浙江省', 747, 3114, 1, 2366),
('2022-05-04', '北京市', 430, 2289, 9, 1850),
('2022-05-04', '江西省', 204, 1378, 1, 1173),
('2022-05-04', '黑龙江省', 195, 2972, 13, 2764),
('2022-05-04', '广东省', 168, 7103, 8, 6927),
('2022-05-04', '四川省', 72, 2064, 3, 1989),
('2022-05-04', '山东省', 70, 2729, 7, 2652),
('2022-05-04', '内蒙古自治区', 59, 1752, 1, 1692),
('2022-05-04', '福建省', 50, 3035, 1, 2984),
('2022-05-04', '河南省', 47, 2921, 22, 2852),
('2022-05-04', '辽宁省', 38, 1651, 2, 1611),
('2022-05-04', '江苏省', 28, 2209, 0, 2181),
('2022-05-04', '湖南省', 24, 1385, 4, 1357),
('2022-05-04', '山西省', 24, 420, 0, 396),
('2022-05-04', '广西壮族自治区', 23, 1590, 2, 1565),
('2022-05-04', '海南省', 23, 288, 6, 259),
('2022-05-04', '云南省', 20, 2119, 2, 2097),
('2022-05-04', '青海省', 17, 95, 0, 78),
('2022-05-04', '河北省', 11, 1998, 7, 1980),
('2022-05-04', '安徽省', 7, 1065, 6, 1052),
('2022-05-04', '新疆维吾尔自治区', 7, 1008, 3, 998),
('2022-05-04', '重庆市', 5, 699, 6, 688),
('2022-05-04', '湖北省', 3, 68398, 4512, 63883),
('2022-05-04', '天津市', 2, 1804, 3, 1799),
('2022-05-04', '陕西省', 1, 3277, 3, 3273),
('2022-05-04', '甘肃省', 0, 681, 2, 679),
('2022-05-04', '贵州省', 0, 179, 2, 177),
('2022-05-04', '宁夏回族自治区', 0, 122, 0, 122),
('2022-05-04', '澳门', 0, 82, 0, 82),
('2022-05-04', '西藏自治区', 0, 1, 0, 1);

INSERT IGNORE INTO detailCount (date, provinceName, currentConfirmedCount, confirmedCount, deadCount, curedCount) VALUES
('2022-05-05', '香港', 261678, 330982, 9328, 59976),
('2022-05-05', '台湾', 217774, 232402, 886, 13742),
('2022-05-05', '上海市', 9877, 59870, 510, 49483),
('2022-05-05', '浙江省', 753, 3124, 1, 2370),
('2022-05-05', '吉林省', 728, 40249, 5, 39516),
('2022-05-05', '北京市', 453, 2332, 9, 1870),
('2022-05-05', '黑龙江省', 182, 2977, 13, 2782),
('2022-05-05', '江西省', 176, 1381, 1, 1204),
('2022-05-05', '广东省', 173, 7119, 8, 6938),
('2022-05-05', '四川省', 71, 2065, 3, 1991),
('2022-05-05', '山东省', 70, 2731, 7, 2654),
('2022-05-05', '河南省', 55, 2935, 22, 2858),
('2022-05-05', '内蒙古自治区', 55, 1752, 1, 1696),
('2022-05-05', '福建省', 51, 3037, 1, 2985),
('2022-05-05', '辽宁省', 36, 1653, 2, 1615),
('2022-05-05', '江苏省', 26, 2212, 0, 2186),
('2022-05-05', '湖南省', 26, 1387, 4, 1357),
('2022-05-05', '广西壮族自治区', 22, 1592, 2, 1568),
('2022-05-05', '山西省', 22, 420, 0, 398),
('2022-05-05', '海南省', 22, 288, 6, 260),
('2022-05-05', '云南省', 20, 2120, 2, 2098),
('2022-05-05', '青海省', 13, 95, 0, 82),
('2022-05-05', '河北省', 11, 1998, 7, 1980),
('2022-05-05', '安徽省', 7, 1065, 6, 1052),
('2022-05-05', '重庆市', 5, 699, 6, 688),
('2022-05-05', '新疆维吾尔自治区', 4, 1008, 3, 1001),
('2022-05-05', '湖北省', 2, 68398, 4512, 63884),
('2022-05-05', '天津市', 2, 1804, 3, 1799),
('2022-05-05', '陕西省', 1, 3277, 3, 3273),
('2022-05-05', '甘肃省', 0, 681, 2, 679),
('2022-05-05', '贵州省', 0, 179, 2, 177),
('2022-05-05', '宁夏回族自治区', 0, 122, 0, 122),
('2022-05-05', '澳门', 0, 82, 0, 82),
('2022-05-05', '西藏自治区', 0, 1, 0, 1);

INSERT IGNORE INTO detailCount (date, provinceName, currentConfirmedCount, confirmedCount, deadCount, curedCount) VALUES
('2022-05-06', '香港', 261645, 331097, 9333, 60119),
('2022-05-06', '台湾', 253931, 268569, 896, 13742),
('2022-05-06', '上海市', 8720, 60115, 522, 50873),
('2022-05-06', '浙江省', 738, 3124, 1, 2385),
('2022-05-06', '吉林省', 679, 40251, 5, 39567),
('2022-05-06', '北京市', 502, 2387, 9, 1876),
('2022-05-06', '广东省', 176, 7134, 8, 6950),
('2022-05-06', '江西省', 146, 1383, 1, 1236),
('2022-05-06', '黑龙江省', 144, 2982, 13, 2825),
('2022-05-06', '河南省', 77, 2959, 22, 2860),
('2022-05-06', '四川省', 69, 2066, 3, 1994),
('2022-05-06', '山东省', 65, 2731, 7, 2659),
('2022-05-06', '福建省', 55, 3051, 1, 2995),
('2022-05-06', '内蒙古自治区', 51, 1752, 1, 1700),
('2022-05-06', '辽宁省', 38, 1655, 2, 1615),
('2022-05-06', '湖南省', 28, 1389, 4, 1357),
('2022-05-06', '江苏省', 23, 2213, 0, 2190),
('2022-05-06', '海南省', 21, 288, 6, 261),
('2022-05-06', '山西省', 19, 420, 0, 401),
('2022-05-06', '广西壮族自治区', 17, 1592, 2, 1573),
('2022-05-06', '云南省', 14, 2120, 2, 2104),
('2022-05-06', '河北省', 13, 2002, 7, 1982),
('2022-05-06', '青海省', 13, 95, 0, 82),
('2022-05-06', '安徽省', 6, 1065, 6, 1053),
('2022-05-06', '重庆市', 6, 700, 6, 688),
('2022-05-06', '湖北省', 2, 68398, 4512, 63884),
('2022-05-06', '天津市', 1, 1804, 3, 1800),
('2022-05-06', '新疆维吾尔自治区', 1, 1008, 3, 1004),
('2022-05-06', '贵州省', 1, 180, 2, 177),
('2022-05-06', '陕西省', 0, 3277, 3, 3274),
('2022-05-06', '甘肃省', 0, 681, 2, 679),
('2022-05-06', '宁夏回族自治区', 0, 122, 0, 122),
('2022-05-06', '澳门', 0, 82, 0, 82),
('2022-05-06', '西藏自治区', 0, 1, 0, 1);

INSERT IGNORE INTO detailCount (date, provinceName, currentConfirmedCount, confirmedCount, deadCount, curedCount) VALUES
('2022-05-07', '台湾', 300334, 314983, 907, 13742),
('2022-05-07', '香港', 261514, 331181, 9344, 60323),
('2022-05-07', '上海市', 7296, 60368, 535, 52537),
('2022-05-07', '浙江省', 737, 3126, 1, 2388),
('2022-05-07', '吉林省', 607, 40254, 5, 39642),
('2022-05-07', '北京市', 532, 2433, 9, 1892),
('2022-05-07', '广东省', 176, 7144, 8, 6960),
('2022-05-07', '江西省', 111, 1383, 1, 1271),
('2022-05-07', '河南省', 102, 2988, 22, 2864),
('2022-05-07', '黑龙江省', 97, 2982, 13, 2872),
('2022-05-07', '四川省', 68, 2067, 3, 1996),
('2022-05-07', '山东省', 64, 2732, 7, 2661),
('2022-05-07', '福建省', 56, 3053, 1, 2996),
('2022-05-07', '内蒙古自治区', 48, 1752, 1, 1703),
('2022-05-07', '辽宁省', 38, 1656, 2, 1616),
('2022-05-07', '湖南省', 30, 1391, 4, 1357),
('2022-05-07', '江苏省', 19, 2213, 0, 2194),
('2022-05-07', '海南省', 19, 288, 6, 263),
('2022-05-07', '山西省', 16, 420, 0, 404),
('2022-05-07', '广西壮族自治区', 15, 1592, 2, 1575),
('2022-05-07', '云南省', 13, 2120, 2, 2105),
('2022-05-07', '河北省', 13, 2002, 7, 1982),
('2022-05-07', '青海省', 12, 95, 0, 83),
('2022-05-07', '重庆市', 7, 701, 6, 688),
('2022-05-07', '安徽省', 6, 1065, 6, 1053),
('2022-05-07', '湖北省', 2, 68398, 4512, 63884),
('2022-05-07', '天津市', 1, 1804, 3, 1800),
('2022-05-07', '新疆维吾尔自治区', 1, 1008, 3, 1004),
('2022-05-07', '贵州省', 1, 180, 2, 177),
('2022-05-07', '陕西省', 0, 3277, 3, 3274),
('2022-05-07', '甘肃省', 0, 681, 2, 679),
('2022-05-07', '宁夏回族自治区', 0, 122, 0, 122),
('2022-05-07', '澳门', 0, 82, 0, 82),
('2022-05-07', '西藏自治区', 0, 1, 0, 1);

INSERT IGNORE INTO detailCount (date, provinceName, currentConfirmedCount, confirmedCount, deadCount, curedCount) VALUES
('2022-05-08', '台湾', 342622, 357271, 907, 13742),
('2022-05-08', '香港', 261404, 331231, 9344, 60483),
('2022-05-08', '上海市', 6564, 60585, 543, 53478),
('2022-05-08', '浙江省', 720, 3127, 1, 2406),
('2022-05-08', '北京市', 566, 2477, 9, 1902),
('2022-05-08', '吉林省', 551, 40257, 5, 39701),
('2022-05-08', '广东省', 184, 7166, 8, 6974),
('2022-05-08', '河南省', 125, 3013, 22, 2866),
('2022-05-08', '黑龙江省', 91, 2983, 13, 2879),
('2022-05-08', '江西省', 88, 1383, 1, 1294),
('2022-05-08', '四川省', 62, 2067, 3, 2002),
('2022-05-08', '山东省', 59, 2733, 7, 2667),
('2022-05-08', '福建省', 58, 3058, 1, 2999),
('2022-05-08', '辽宁省', 38, 1656, 2, 1616),
('2022-05-08', '内蒙古自治区', 37, 1753, 1, 1715),
('2022-05-08', '湖南省', 25, 1391, 4, 1362),
('2022-05-08', '江苏省', 19, 2214, 0, 2195),
('2022-05-08', '海南省', 19, 288, 6, 263),
('2022-05-08', '广西壮族自治区', 15, 1593, 2, 1576),
('2022-05-08', '青海省', 14, 99, 0, 85),
('2022-05-08', '山西省', 13, 420, 0, 407),
('2022-05-08', '云南省', 11, 2120, 2, 2107),
('2022-05-08', '河北省', 10, 2003, 7, 1986),
('2022-05-08', '重庆市', 8, 703, 6, 689),
('2022-05-08', '安徽省', 6, 1065, 6, 1053),
('2022-05-08', '湖北省', 2, 68398, 4512, 63884),
('2022-05-08', '天津市', 1, 1804, 3, 1800),
('2022-05-08', '贵州省', 1, 180, 2, 177),
('2022-05-08', '陕西省', 0, 3277, 3, 3274),
('2022-05-08', '新疆维吾尔自治区', 0, 1008, 3, 1005),
('2022-05-08', '甘肃省', 0, 681, 2, 679),
('2022-05-08', '宁夏回族自治区', 0, 122, 0, 122),
('2022-05-08', '澳门', 0, 82, 0, 82),
('2022-05-08', '西藏自治区', 0, 1, 0, 1);

CALL totalSum();