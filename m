From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] power: bq24190_charger: mark PM functions as __maybe_unused
Date: Mon, 20 Mar 2017 14:14:15 +0100
Message-ID: <20170320131424.271241-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Liam Breck <liam@networkimprov.net>, Mark Greer <mgreer@animalcreek.com>, Colin Ian King <colin.king@canonical.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Without CONFIG_PM, we get a harmless warning:

drivers/power/supply/bq24190_charger.c:1514:12: error: 'bq24190_runtime_resume' defined but not used [-Werror=unused-function]
drivers/power/supply/bq24190_charger.c:1501:12: error: 'bq24190_runtime_suspend' defined but not used [-Werror=unused-function]

To avoid the warning, we can mark all four PM functions as __maybe_unused,
which also lets us remove the incorrect #ifdef.

Fixes: 3d8090cba638 ("power: bq24190_charger: Check the interrupt status on resume")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/power/supply/bq24190_charger.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 6d80670586eb..451f2bc05ea5 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -1498,7 +1498,7 @@ static int bq24190_remove(struct i2c_client *client)
 	return 0;
 }
 
-static int bq24190_runtime_suspend(struct device *dev)
+static __maybe_unused int bq24190_runtime_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
@@ -1511,7 +1511,7 @@ static int bq24190_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int bq24190_runtime_resume(struct device *dev)
+static __maybe_unused int bq24190_runtime_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
@@ -1527,8 +1527,7 @@ static int bq24190_runtime_resume(struct device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int bq24190_pm_suspend(struct device *dev)
+static __maybe_unused int bq24190_pm_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
@@ -1550,7 +1549,7 @@ static int bq24190_pm_suspend(struct device *dev)
 	return 0;
 }
 
-static int bq24190_pm_resume(struct device *dev)
+static __maybe_unused int bq24190_pm_resume(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
@@ -1580,7 +1579,6 @@ static int bq24190_pm_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops bq24190_pm_ops = {
 	SET_RUNTIME_PM_OPS(bq24190_runtime_suspend, bq24190_runtime_resume,
-- 
2.9.0
