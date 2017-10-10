From: Divagar Mohandass <divagar.mohandass@intel.com>
Subject: [PATCH v7 3/3] eeprom: at24: enable runtime pm support
Date: Tue, 10 Oct 2017 11:30:37 +0530
Message-ID: <1507615237-21744-4-git-send-email-divagar.mohandass@intel.com>
References: <1507615237-21744-1-git-send-email-divagar.mohandass@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507615237-21744-1-git-send-email-divagar.mohandass@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, sakari.ailus@iki.fi, tfiga@chromium.org
Cc: devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rajmohan.mani@intel.com, mika.westerberg@linux.intel.com, linux-pm@vger.kernel.org, Divagar Mohandass <divagar.mohandass@intel.com>
List-Id: linux-pm@vger.kernel.org

Currently the device is kept in D0, there is an opportunity
to save power by enabling runtime pm.

Device can be daisy chained from PMIC and we can't rely on I2C core
for auto resume/suspend. Driver will decide when to resume/suspend.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Divagar Mohandass <divagar.mohandass@intel.com>
---
 drivers/misc/eeprom/at24.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 2199c42..a466e40 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -24,6 +24,7 @@
 #include <linux/i2c.h>
 #include <linux/nvmem-provider.h>
 #include <linux/platform_data/at24.h>
+#include <linux/pm_runtime.h>
 
 /*
  * I2C EEPROMs from most vendors are inexpensive and mostly interchangeable.
@@ -501,11 +502,21 @@ static ssize_t at24_eeprom_write_i2c(struct at24_data *at24, const char *buf,
 static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 {
 	struct at24_data *at24 = priv;
+	struct i2c_client *client;
 	char *buf = val;
+	int ret;
 
 	if (unlikely(!count))
 		return count;
 
+	client = at24_translate_offset(at24, &off);
+
+	ret = pm_runtime_get_sync(&client->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(&client->dev);
+		return ret;
+	}
+
 	/*
 	 * Read data from chip, protecting against concurrent updates
 	 * from this host, but not from other I2C masters.
@@ -518,6 +529,7 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 		status = at24->read_func(at24, buf, off, count);
 		if (status < 0) {
 			mutex_unlock(&at24->lock);
+			pm_runtime_put(&client->dev);
 			return status;
 		}
 		buf += status;
@@ -527,17 +539,29 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
 
 	mutex_unlock(&at24->lock);
 
+	pm_runtime_put(&client->dev);
+
 	return 0;
 }
 
 static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 {
 	struct at24_data *at24 = priv;
+	struct i2c_client *client;
 	char *buf = val;
+	int ret;
 
 	if (unlikely(!count))
 		return -EINVAL;
 
+	client = at24_translate_offset(at24, &off);
+
+	ret = pm_runtime_get_sync(&client->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(&client->dev);
+		return ret;
+	}
+
 	/*
 	 * Write data to chip, protecting against concurrent updates
 	 * from this host, but not from other I2C masters.
@@ -550,6 +574,7 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 		status = at24->write_func(at24, buf, off, count);
 		if (status < 0) {
 			mutex_unlock(&at24->lock);
+			pm_runtime_put(&client->dev);
 			return status;
 		}
 		buf += status;
@@ -559,6 +584,8 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
 
 	mutex_unlock(&at24->lock);
 
+	pm_runtime_put(&client->dev);
+
 	return 0;
 }
 
@@ -743,11 +770,16 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 
 	i2c_set_clientdata(client, at24);
 
+	/* enable runtime pm */
+	pm_runtime_set_active(&client->dev);
+	pm_runtime_enable(&client->dev);
+
 	/*
 	 * Perform a one-byte test read to verify that the
 	 * chip is functional.
 	 */
 	err = at24_read(at24, 0, &test_byte, 1);
+	pm_runtime_idle(&client->dev);
 	if (err) {
 		err = -ENODEV;
 		goto err_clients;
@@ -795,6 +827,8 @@ static int at24_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		if (at24->client[i])
 			i2c_unregister_device(at24->client[i]);
 
+	pm_runtime_disable(&client->dev);
+
 	return err;
 }
 
@@ -810,6 +844,9 @@ static int at24_remove(struct i2c_client *client)
 	for (i = 1; i < at24->num_addresses; i++)
 		i2c_unregister_device(at24->client[i]);
 
+	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
+
 	return 0;
 }
 
-- 
1.9.1
