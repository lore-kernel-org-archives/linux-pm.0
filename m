From: Ding Xiang <dingxiang@cmss.chinamobile.com>
Subject: [PATCH] power: supply: ab8500_fg: fix obsolete function
Date: Mon, 27 Aug 2018 06:49:15 -0400
Message-ID: <1535366955-12733-1-git-send-email-dingxiang@cmss.chinamobile.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

simple_strtoul is obsolete, and use kstrtoint instead

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 drivers/power/supply/ab8500_fg.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 02356f9..2bdadb5 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2582,11 +2582,12 @@ static ssize_t ab8505_powercut_flagtime_write(struct device *dev,
 				  const char *buf, size_t count)
 {
 	int ret;
-	long unsigned reg_value;
+	int reg_value;
 	struct power_supply *psy = dev_get_drvdata(dev);
 	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
-	reg_value = simple_strtoul(buf, NULL, 10);
+	if (kstrtoint(buf, 10, &reg_value))
+		goto fail;
 
 	if (reg_value > 0x7F) {
 		dev_err(dev, "Incorrect parameter, echo 0 (1.98s) - 127 (15.625ms) for flagtime\n");
@@ -2636,7 +2637,9 @@ static ssize_t ab8505_powercut_maxtime_write(struct device *dev,
 	struct power_supply *psy = dev_get_drvdata(dev);
 	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
-	reg_value = simple_strtoul(buf, NULL, 10);
+	if (kstrtoint(buf, 10, &reg_value))
+		goto fail;
+
 	if (reg_value > 0x7F) {
 		dev_err(dev, "Incorrect parameter, echo 0 (0.0s) - 127 (1.98s) for maxtime\n");
 		goto fail;
@@ -2684,7 +2687,9 @@ static ssize_t ab8505_powercut_restart_write(struct device *dev,
 	struct power_supply *psy = dev_get_drvdata(dev);
 	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
-	reg_value = simple_strtoul(buf, NULL, 10);
+	if (kstrtoint(buf, 10, &reg_value))
+		goto fail;
+
 	if (reg_value > 0xF) {
 		dev_err(dev, "Incorrect parameter, echo 0 - 15 for number of restart\n");
 		goto fail;
@@ -2777,7 +2782,9 @@ static ssize_t ab8505_powercut_write(struct device *dev,
 	struct power_supply *psy = dev_get_drvdata(dev);
 	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
-	reg_value = simple_strtoul(buf, NULL, 10);
+	if (kstrtoint(buf, 10, &reg_value))
+		goto fail;
+
 	if (reg_value > 0x1) {
 		dev_err(dev, "Incorrect parameter, echo 0/1 to disable/enable Pcut feature\n");
 		goto fail;
@@ -2849,7 +2856,9 @@ static ssize_t ab8505_powercut_debounce_write(struct device *dev,
 	struct power_supply *psy = dev_get_drvdata(dev);
 	struct ab8500_fg *di = power_supply_get_drvdata(psy);
 
-	reg_value = simple_strtoul(buf, NULL, 10);
+	if (kstrtoint(buf, 10, &reg_value))
+		goto fail;
+
 	if (reg_value > 0x7) {
 		dev_err(dev, "Incorrect parameter, echo 0 to 7 for debounce setting\n");
 		goto fail;
-- 
1.8.3.1
