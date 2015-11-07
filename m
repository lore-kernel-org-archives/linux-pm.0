From: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] iio: pulsedlight-lidar-lite: add runtime PM
Date: Fri,  6 Nov 2015 21:37:23 -0800
Message-ID: <1446874643-28020-1-git-send-email-mranostay@gmail.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Add runtime PM support for the lidar-lite module to enable low power
mode when last device requested reading is over a second ago.

Signed-off-by: Matt Ranostay <mranostay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 54 ++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index e544fcf..e015a89 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -13,7 +13,7 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  * GNU General Public License for more details.
  *
- * TODO: runtime pm, interrupt mode, and signal strength reporting
+ * TODO: interrupt mode, and signal strength reporting
  */
 
 #include <linux/err.h>
@@ -21,6 +21,7 @@
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/buffer.h>
@@ -37,6 +38,7 @@
 
 #define LIDAR_REG_DATA_HBYTE	0x0f
 #define LIDAR_REG_DATA_LBYTE	0x10
+#define LIDAR_REG_PWR_CONTROL	0x65
 
 #define LIDAR_DRV_NAME "lidar"
 
@@ -90,6 +92,12 @@ static inline int lidar_write_control(struct lidar_data *data, int val)
 	return i2c_smbus_write_byte_data(data->client, LIDAR_REG_CONTROL, val);
 }
 
+static inline int lidar_write_power(struct lidar_data *data, int val)
+{
+	return i2c_smbus_write_byte_data(data->client,
+					 LIDAR_REG_PWR_CONTROL, val);
+}
+
 static int lidar_read_measurement(struct lidar_data *data, u16 *reg)
 {
 	int ret;
@@ -114,8 +122,15 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
 {
 	struct i2c_client *client = data->client;
 	int tries = 10;
+	int suspended = pm_runtime_suspended(&client->dev);
 	int ret;
 
+	pm_runtime_get(&client->dev);
+
+	/* regulator and FPGA needs settling time */
+	if (suspended)
+		usleep_range(15000, 20000);
+
 	/* start sample */
 	ret = lidar_write_control(data, LIDAR_REG_CONTROL_ACQUIRE);
 	if (ret < 0) {
@@ -144,6 +159,7 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
 		}
 		ret = -EIO;
 	}
+	pm_runtime_put_autosuspend(&client->dev);
 
 	return ret;
 }
@@ -243,6 +259,15 @@ static int lidar_probe(struct i2c_client *client,
 	if (ret)
 		goto error_unreg_buffer;
 
+	pm_runtime_set_autosuspend_delay(&client->dev, 1000);
+	pm_runtime_use_autosuspend(&client->dev);
+
+	pm_runtime_set_active(&client->dev);
+	pm_runtime_enable(&client->dev);
+
+	pm_runtime_mark_last_busy(&client->dev);
+	pm_runtime_idle(&client->dev);
+
 	return 0;
 
 error_unreg_buffer:
@@ -258,6 +283,9 @@ static int lidar_remove(struct i2c_client *client)
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
 
+	pm_runtime_disable(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
+
 	return 0;
 }
 
@@ -273,10 +301,34 @@ static const struct of_device_id lidar_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, lidar_dt_ids);
 
+#ifdef CONFIG_PM
+static int lidar_pm_runtime_suspend(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct lidar_data *data = iio_priv(indio_dev);
+
+	return lidar_write_power(data, 0x0f);
+}
+
+static int lidar_pm_runtime_resume(struct device *dev)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
+	struct lidar_data *data = iio_priv(indio_dev);
+
+	return lidar_write_power(data, 0);
+}
+#endif
+
+static const struct dev_pm_ops lidar_pm_ops = {
+	SET_RUNTIME_PM_OPS(lidar_pm_runtime_suspend,
+			   lidar_pm_runtime_resume, NULL)
+};
+
 static struct i2c_driver lidar_driver = {
 	.driver = {
 		.name	= LIDAR_DRV_NAME,
 		.of_match_table	= of_match_ptr(lidar_dt_ids),
+		.pm	= &lidar_pm_ops,
 	},
 	.probe		= lidar_probe,
 	.remove		= lidar_remove,
-- 
1.9.1
