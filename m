From: Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH 4/5] iio: light: us8152d: Add power management support
Date: Tue, 24 Nov 2015 12:59:51 +0200
Message-ID: <1448362792-5181-5-git-send-email-adriana.reus@intel.com>
References: <1448362792-5181-1-git-send-email-adriana.reus@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448362792-5181-1-git-send-email-adriana.reus@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, pawel.moll@arm.com, pmeerw@pmeerw.net, lars@metafoo.de, Adriana Reus <adriana.reus@intel.com>
List-Id: linux-pm@vger.kernel.org

Add power management for sleep as well as runtime pm.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
---
 drivers/iio/light/us5182d.c | 95 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 88 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index 3d959f3..60cab4a 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -23,6 +23,8 @@
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
 
 #define US5182D_REG_CFG0				0x00
 #define US5182D_CFG0_ONESHOT_EN				BIT(6)
@@ -81,6 +83,7 @@
 #define US5182D_READ_BYTE			1
 #define US5182D_READ_WORD			2
 #define US5182D_OPSTORE_SLEEP_TIME		20 /* ms */
+#define US5182D_SLEEP_MS			3000 /* ms */
 
 /* Available ranges: [12354, 7065, 3998, 2202, 1285, 498, 256, 138] lux */
 static const int us5182d_scales[] = {188500, 107800, 61000, 33600, 19600, 7600,
@@ -298,6 +301,26 @@ static int us5182d_shutdown_en (struct us5182d_data *data, u8 state)
 	return ret;
 }
 
+
+static int us5182d_set_power_state(struct us5182d_data *data, bool on)
+{
+	int ret;
+
+	if (data->power_mode == US5182D_ONESHOT)
+		return 0;
+
+	if (on) {
+		ret = pm_runtime_get_sync(&data->client->dev);
+		if (ret < 0)
+			pm_runtime_put_noidle(&data->client->dev);
+	} else {
+		pm_runtime_mark_last_busy(&data->client->dev);
+		ret = pm_runtime_put_autosuspend(&data->client->dev);
+	}
+
+	return ret;
+}
+
 static int us5182d_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan, int *val,
 			    int *val2, long mask)
@@ -315,15 +338,20 @@ static int us5182d_read_raw(struct iio_dev *indio_dev,
 				if (ret < 0)
 					goto out_err;
 			}
-			ret = us5182d_als_enable(data);
+			ret = us5182d_set_power_state(data, true);
 			if (ret < 0)
 				goto out_err;
-
+			ret = us5182d_als_enable(data);
+			if (ret < 0)
+				goto out_poweroff;
 			ret = us5182d_get_als(data);
 			if (ret < 0)
+				goto out_poweroff;
+			*val = ret;
+			ret = us5182d_set_power_state(data, false);
+			if (ret < 0)
 				goto out_err;
 			mutex_unlock(&data->lock);
-			*val = ret;
 			return IIO_VAL_INT;
 		case IIO_PROXIMITY:
 			mutex_lock(&data->lock);
@@ -332,17 +360,22 @@ static int us5182d_read_raw(struct iio_dev *indio_dev,
 				if (ret < 0)
 					goto out_err;
 			}
-			ret = us5182d_px_enable(data);
+			ret = us5182d_set_power_state(data, true);
 			if (ret < 0)
 				goto out_err;
-
+			ret = us5182d_px_enable(data);
+			if (ret < 0)
+				goto out_poweroff;
 			ret = i2c_smbus_read_word_data(data->client,
 						       US5182D_REG_PDL);
 			if (ret < 0)
+				goto out_poweroff;
+			*val = ret;
+			ret = us5182d_set_power_state(data, false);
+			if (ret < 0)
 				goto out_err;
 			mutex_unlock(&data->lock);
-			*val = ret;
-			return  IIO_VAL_INT;
+			return IIO_VAL_INT;
 		default:
 			return -EINVAL;
 		}
@@ -361,6 +394,9 @@ static int us5182d_read_raw(struct iio_dev *indio_dev,
 	}
 
 	return -EINVAL;
+
+out_poweroff:
+	us5182d_set_power_state(data, false);
 out_err:
 	mutex_unlock(&data->lock);
 	return ret;
@@ -577,6 +613,17 @@ static int us5182d_probe(struct i2c_client *client,
 	if (ret < 0)
 		goto out_err;
 
+	if (data->default_continuous) {
+		pm_runtime_set_active(&client->dev);
+		if (ret < 0)
+			goto out_err;
+	}
+
+	pm_runtime_enable(&client->dev);
+	pm_runtime_set_autosuspend_delay(&client->dev,
+					 US5182D_SLEEP_MS);
+	pm_runtime_use_autosuspend(&client->dev);
+
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
 		goto out_err;
@@ -595,9 +642,42 @@ static int us5182d_remove(struct i2c_client *client)
 
 	iio_device_unregister(i2c_get_clientdata(client));
 
+	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
+
 	return us5182d_shutdown_en(data, US5182D_CFG0_SHUTDOWN_EN);
 }
 
+#if defined(CONFIG_PM_SLEEP) || defined(CONFIG_PM)
+static int us5182d_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct us5182d_data *data = iio_priv(indio_dev);
+
+	if (data->power_mode == US5182D_CONTINUOUS)
+		return us5182d_shutdown_en(data, US5182D_CFG0_SHUTDOWN_EN);
+
+	return 0;
+}
+
+static int us5182d_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct us5182d_data *data = iio_priv(indio_dev);
+
+	if (data->power_mode == US5182D_CONTINUOUS)
+		return us5182d_shutdown_en(data,
+					   ~US5182D_CFG0_SHUTDOWN_EN & 0xff);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops us5182d_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(us5182d_suspend, us5182d_resume)
+	SET_RUNTIME_PM_OPS(us5182d_suspend, us5182d_resume, NULL)
+};
+
 static const struct acpi_device_id us5182d_acpi_match[] = {
 	{ "USD5182", 0},
 	{}
@@ -615,6 +695,7 @@ MODULE_DEVICE_TABLE(i2c, us5182d_id);
 static struct i2c_driver us5182d_driver = {
 	.driver = {
 		.name = US5182D_DRV_NAME,
+		.pm = &us5182d_pm_ops,
 		.acpi_match_table = ACPI_PTR(us5182d_acpi_match),
 	},
 	.probe = us5182d_probe,
-- 
1.9.1
