From: Adriana Reus <adriana.reus@intel.com>
Subject: [PATCH 5/5] iio: light: us5182d: Add interrupt support and events
Date: Tue, 24 Nov 2015 12:59:52 +0200
Message-ID: <1448362792-5181-6-git-send-email-adriana.reus@intel.com>
References: <1448362792-5181-1-git-send-email-adriana.reus@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448362792-5181-1-git-send-email-adriana.reus@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, robh+dt@kernel.org, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, pawel.moll@arm.com, pmeerw@pmeerw.net, lars@metafoo.de, Adriana Reus <adriana.reus@intel.com>
List-Id: linux-pm@vger.kernel.org

Add interrupt support and events for proximity.
Add two threshold events to signal rising and falling directions.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
---
 drivers/iio/light/us5182d.c | 272 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 271 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index 60cab4a..4d1f80d 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -20,7 +20,10 @@
 #include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/iio/sysfs.h>
 #include <linux/mutex.h>
 #include <linux/pm.h>
@@ -30,6 +33,8 @@
 #define US5182D_CFG0_ONESHOT_EN				BIT(6)
 #define US5182D_CFG0_SHUTDOWN_EN			BIT(7)
 #define US5182D_CFG0_WORD_ENABLE			BIT(0)
+#define US5182D_CFG0_PROX				BIT(3)
+#define US5182D_CFG0_PX_IRQ				BIT(2)
 
 #define US5182D_REG_CFG1				0x01
 #define US5182D_CFG1_ALS_RES16				BIT(4)
@@ -41,6 +46,7 @@
 
 #define US5182D_REG_CFG3				0x03
 #define US5182D_CFG3_LED_CURRENT100			(BIT(4) | BIT(5))
+#define US5182D_CFG3_INT_SOURCE_PX			BIT(3)
 
 #define US5182D_REG_CFG4				0x10
 
@@ -55,6 +61,13 @@
 #define US5182D_REG_AUTO_LDARK_GAIN		0x29
 #define US5182D_REG_AUTO_HDARK_GAIN		0x2a
 
+/* Thresholds for events: px low (0x08-l, 0x09-h), px high (0x0a-l 0x0b-h) */
+#define US5182D_REG_PXL_TH			0x08
+#define US5182D_REG_PXH_TH			0x0a
+
+#define US5182D_REG_PXL_TH_DEFAULT		1000
+#define US5182D_REG_PXH_TH_DEFAULT		30000
+
 #define US5182D_OPMODE_ALS			0x01
 #define US5182D_OPMODE_PX			0x02
 #define US5182D_OPMODE_SHIFT			4
@@ -84,6 +97,8 @@
 #define US5182D_READ_WORD			2
 #define US5182D_OPSTORE_SLEEP_TIME		20 /* ms */
 #define US5182D_SLEEP_MS			3000 /* ms */
+#define US5182D_PXH_TH_DISABLE			0xffff
+#define US5182D_PXL_TH_DISABLE			0x0000
 
 /* Available ranges: [12354, 7065, 3998, 2202, 1285, 498, 256, 138] lux */
 static const int us5182d_scales[] = {188500, 107800, 61000, 33600, 19600, 7600,
@@ -119,6 +134,12 @@ struct us5182d_data {
 	u8 upper_dark_gain;
 	u16 *us5182d_dark_ths;
 
+	u16 px_low_th;
+	u16 px_high_th;
+
+	int rising_en;
+	int falling_en;
+
 	u8 opmode;
 	u8 power_mode;
 
@@ -148,10 +169,26 @@ static const struct {
 	{US5182D_REG_CFG1, US5182D_CFG1_ALS_RES16},
 	{US5182D_REG_CFG2, (US5182D_CFG2_PX_RES16 |
 			    US5182D_CFG2_PXGAIN_DEFAULT)},
-	{US5182D_REG_CFG3, US5182D_CFG3_LED_CURRENT100},
+	{US5182D_REG_CFG3, US5182D_CFG3_LED_CURRENT100 |
+			   US5182D_CFG3_INT_SOURCE_PX},
 	{US5182D_REG_CFG4, 0x00},
 };
 
+static const struct iio_event_spec us5182d_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+				BIT(IIO_EV_INFO_ENABLE),
+	},
+};
+
 static const struct iio_chan_spec us5182d_channels[] = {
 	{
 		.type = IIO_LIGHT,
@@ -161,6 +198,8 @@ static const struct iio_chan_spec us5182d_channels[] = {
 	{
 		.type = IIO_PROXIMITY,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.event_spec = us5182d_events,
+		.num_event_specs = ARRAY_SIZE(us5182d_events),
 	}
 };
 
@@ -477,11 +516,199 @@ static int us5182d_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static int us5182d_setup_prox(struct iio_dev *indio_dev,
+			      enum iio_event_direction dir, u16 val)
+{
+	struct us5182d_data *data = iio_priv(indio_dev);
+	int ret = 0;
+
+	if (dir == IIO_EV_DIR_FALLING)
+		ret = i2c_smbus_write_word_data(data->client,
+						US5182D_REG_PXL_TH, val);
+
+	if (dir == IIO_EV_DIR_RISING)
+		ret = i2c_smbus_write_word_data(data->client,
+						US5182D_REG_PXH_TH, val);
+
+	return ret;
+}
+
+static int us5182d_read_thresh(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, enum iio_event_info info, int *val,
+	int *val2)
+{
+	struct us5182d_data *data = iio_priv(indio_dev);
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		mutex_lock(&data->lock);
+		*val = data->px_high_th;
+		mutex_unlock(&data->lock);
+		break;
+	case IIO_EV_DIR_FALLING:
+		mutex_lock(&data->lock);
+		*val = data->px_low_th;
+		mutex_unlock(&data->lock);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return IIO_VAL_INT;
+}
+
+static int us5182d_write_thresh(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, enum iio_event_info info, int val,
+	int val2)
+{
+	struct us5182d_data *data = iio_priv(indio_dev);
+	int ret = 0;
+
+	if (val < 0 || val > USHRT_MAX || val2 != 0)
+		return -EINVAL;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		mutex_lock(&data->lock);
+		if (data->rising_en) {
+			ret = us5182d_setup_prox(indio_dev, dir, val);
+			if (ret < 0)
+				goto err;
+		}
+		data->px_high_th = val;
+		mutex_unlock(&data->lock);
+		break;
+	case IIO_EV_DIR_FALLING:
+		mutex_lock(&data->lock);
+		if (data->falling_en) {
+			ret = us5182d_setup_prox(indio_dev, dir, val);
+			if (ret < 0)
+				goto err;
+		}
+		data->px_low_th = val;
+		mutex_unlock(&data->lock);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+err:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
+static int us5182d_read_event_config(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir)
+{
+	struct us5182d_data *data = iio_priv(indio_dev);
+	int ret;
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		mutex_lock(&data->lock);
+		ret = data->rising_en;
+		mutex_unlock(&data->lock);
+		break;
+	case IIO_EV_DIR_FALLING:
+		mutex_lock(&data->lock);
+		ret = data->falling_en;
+		mutex_unlock(&data->lock);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	return ret;
+}
+
+static int us5182d_write_event_config(struct iio_dev *indio_dev,
+	const struct iio_chan_spec *chan, enum iio_event_type type,
+	enum iio_event_direction dir, int state)
+{
+	struct us5182d_data *data = iio_priv(indio_dev);
+	int ret;
+	u16 new_th;
+
+	mutex_lock(&data->lock);
+
+	switch (dir) {
+	case IIO_EV_DIR_RISING:
+		if (data->rising_en == state)
+			goto out;
+		new_th = US5182D_PXH_TH_DISABLE;
+		if (state) {
+			data->power_mode = US5182D_CONTINUOUS;
+			ret = us5182d_set_power_state(data, true);
+			if (ret < 0)
+				goto err;
+			ret = us5182d_px_enable(data);
+			if (ret < 0)
+				goto err_poweroff;
+			new_th = data->px_high_th;
+		}
+		ret = us5182d_setup_prox(indio_dev, dir, new_th);
+		if (ret < 0)
+			goto err_poweroff;
+		data->rising_en = state;
+		break;
+	case IIO_EV_DIR_FALLING:
+		if (data->falling_en == state)
+			goto out;
+		new_th =  US5182D_PXL_TH_DISABLE;
+		if (state) {
+			data->power_mode = US5182D_CONTINUOUS;
+			ret = us5182d_set_power_state(data, true);
+			if (ret < 0)
+				goto err;
+			ret = us5182d_px_enable(data);
+			if (ret < 0)
+				goto err_poweroff;
+			new_th = data->px_low_th;
+		}
+		ret = us5182d_setup_prox(indio_dev, dir, new_th);
+		if (ret < 0)
+			goto err_poweroff;
+		data->falling_en = state;
+		break;
+	default:
+		ret = -EINVAL;
+		goto err;
+	}
+
+	if (!state) {
+		ret = us5182d_set_power_state(data, false);
+		if (ret < 0)
+			goto err;
+	}
+
+	if (!data->falling_en && !data->rising_en && !data->default_continuous)
+		data->power_mode = US5182D_ONESHOT;
+
+out:
+	mutex_unlock(&data->lock);
+	return 0;
+err_poweroff:
+	if (state)
+		us5182d_set_power_state(data, false);
+err:
+	mutex_unlock(&data->lock);
+	return ret;
+}
+
 static const struct iio_info us5182d_info = {
 	.driver_module	= THIS_MODULE,
 	.read_raw = us5182d_read_raw,
 	.write_raw = us5182d_write_raw,
 	.attrs = &us5182d_attr_group,
+	.read_event_value = &us5182d_read_thresh,
+	.write_event_value = &us5182d_write_thresh,
+	.read_event_config = &us5182d_read_event_config,
+	.write_event_config = &us5182d_write_event_config,
 };
 
 static int us5182d_reset(struct iio_dev *indio_dev)
@@ -503,6 +730,9 @@ static int us5182d_init(struct iio_dev *indio_dev)
 
 	data->opmode = 0;
 	data->power_mode = US5182D_CONTINUOUS;
+	data->px_low_th = US5182D_REG_PXL_TH_DEFAULT;
+	data->px_high_th = US5182D_REG_PXH_TH_DEFAULT;
+
 	for (i = 0; i < ARRAY_SIZE(us5182d_regvals); i++) {
 		ret = i2c_smbus_write_byte_data(data->client,
 						us5182d_regvals[i].reg,
@@ -573,6 +803,36 @@ static int  us5182d_dark_gain_config(struct iio_dev *indio_dev)
 					 US5182D_REG_DARK_AUTO_EN_DEFAULT);
 }
 
+static irqreturn_t us5182d_irq_thread_handler(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct us5182d_data *data = iio_priv(indio_dev);
+	enum iio_event_direction dir;
+	int ret;
+	int approach;
+	u64 ev;
+
+	ret = i2c_smbus_read_byte_data(data->client, US5182D_REG_CFG0);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "i2c transfer error in irq\n");
+		return IRQ_HANDLED;
+	}
+
+	approach = ret & US5182D_CFG0_PROX;
+	dir = approach ? IIO_EV_DIR_RISING : IIO_EV_DIR_FALLING;
+	ev = IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 1, IIO_EV_TYPE_THRESH, dir);
+
+	iio_push_event(indio_dev, ev, iio_get_time_ns());
+
+	ret = ret & ~US5182D_CFG0_PX_IRQ;
+
+	ret = i2c_smbus_write_byte_data(data->client, US5182D_REG_CFG0, ret);
+	if (ret < 0)
+		dev_err(&data->client->dev, "i2c transfer error in irq\n");
+
+	return IRQ_HANDLED;
+}
+
 static int us5182d_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -604,6 +864,16 @@ static int us5182d_probe(struct i2c_client *client,
 		return (ret < 0) ? ret : -ENODEV;
 	}
 
+	if (client->irq > 0) {
+		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
+						us5182d_irq_thread_handler,
+						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+						"us5182d-irq", indio_dev);
+		if (ret < 0)
+			return ret;
+	} else
+		dev_warn(&client->dev, "no valid irq found\n");
+
 	us5182d_get_platform_data(indio_dev);
 	ret = us5182d_init(indio_dev);
 	if (ret < 0)
-- 
1.9.1
