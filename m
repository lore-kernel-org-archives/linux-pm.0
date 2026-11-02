Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793584119;
	b=pOM4P14u3jiqankSJp5esnJVR6inF7aRMXGjyt0dr1jEh1Sqgwa/JTa32RUnzTWnbtwc
	 gf2Y+Pm+h8diJ0g+ORUuEU4j9ZEsWOsPKGepInX3eFxXYeNPLrI7A7bIZH4WzZI5JptI+
	 GNbL1/7VND87zOc0Qp2AMmB2ObSEo1G7Cdf9c6kc07juZQ0RmcOuxQaUqD1snROaUpQlx
	 WHOeH3pARYU9oaEBhL8pY1BgiCLpa9G+wuyXruXlPZ1ZHAH3J4TPTBHx9xQ4VDYyTzpAs
	 eumPhE5F7npQ+/0TpMhPm+CmXJSzCSIzxyzjxxOQSgxhLbhLULGsXje82/YXVvg6NYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793584119;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zkt3u9XM5bx1kx/K20XdgNWCJGbPOFWn8mW0vOVqS+4=;
	b=fEpY6TjdtBC5IrQ37exjmj0SlINuSjjcBB1zV+oWTBgtrt2nTrait1SnBKRF+q+XrU/b
	 HDUxUQyLB6Z7U5jYB5C9HSEJC1RZbuNIj4h8rm6M6jSpei9eJ//xC2dfabCb0mQSViCHN
	 uR36UGZtmwxsi4Q5nJ/KypYYOhzk1m2Ku7wH4kIHpq6i8j1Wwnym9M8mULjc33/aEXYJv
	 JHKX5pg22wCiN0P2Y39+jXTLohccq9EW8ypILH7L+K+usDg/W4+qMN7USlYB0QZ3YFgws
	 obmRNRVEoseXBZRIhFQzkgoPPyOSI86p/bDeFZykiJs+1+8heXpMYEBmR8vpJALu1Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oWHzzEDj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B6C606A324;
	Mon,  2 Nov 2026 01:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oWHzzEDj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0541F000C1;
	Mon,  2 Nov 2026 01:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793584118;
	bh=zkt3u9XM5bx1kx/K20XdgNWCJGbPOFWn8mW0vOVqS+4=;
	h=From:To:Cc:Subject:Date;
	b=oWHzzEDjOOf+g+Xhoym0/jpyuOWwQg2e+O1rX74sdU2sJCFQq/YQGMWagJG9/bHCi
	 7+OyugophQ7WJv4zMgequgTiUEP8PcMvnmKPiNwE1aTVnlMDkG9HFoHNdxv33sLk+T
	 mbJCQHLs303F8kyBl/jDvpf0fqy0mvFzNVwuerZhVRIf8bVRkNng9QNnsTmAWH+NrT
	 LP5+HnAYmpaWXDrE+kWVdNRZvQQZk4ZxcBdPunXyesTvRnJTvRIXDDyQmM7yJbCO7u
	 AEJ8Adp2GV173eVHF5EXvv0OcFoiDWn76ObZm70DvnYOGU4icrXAEn6WZAr5Z+Dyvp
	 6c/X13hZrGSDQ==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-pm@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>
Cc: linux-kernel@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v3] iio: gyro: bmg160: Discard pm_runtime_put_autosuspend() return values
Date: Mon,  2 Nov 2026 01:48:30 +0000
Message-ID: <20261102014830.679216-1-jic23@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brian Norris <briannorris@chromium.org>

This driver propagates the return value of pm_runtime_put_autosuspend(),
which is not particularly useful.

Returning an error code from pm_runtime_put_autosuspend() merely means
that it has not queued up a timer or work item to check whether or not
the device can be suspended and there are many perfectly valid
situations in which that can happen, like after writing "on" to the
device's runtime PM "control" attribute in sysfs for one example.

For this reason, modify this driver to simply discard the
pm_runtime_put_autosuspend() return value, and inline
bmg160_set_power_state() now that it behaves the same with and without
CONFIG_PM and is otherwise trivial.

Now the return value of the cleanup is ignored, also switch various
paths to use PM_RUNTIEM_ACQUIRE_AUTOSUSPEND() in conjunction
with guard(mutex)() futher simplifying the code.

While at it, I notice that bmg160_write_event_config() and
bmg160_data_rdy_trigger_set_state() mismanage the runtime PM reference
count intentionally, relying on racy autosuspend behavior for
correctness. I refactor this to manage refcounts properly instead.
I use guard() for the mutex, to make this less error prone.

Additionally, bmg160_write_raw() had one error path where a
pm_runtime_resume_and_get() failure would also drop a runtime PM
refcount (pm_runtime_put_autosuspend()), which potentially leads to
underflow. I fix that.

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
I'm continuing to nibble away at Brian's series applying some of the
additional changes Andy asked for (that Brian quite reasonably stated
were beyond what he was going to take on!)  Just this one today.

v3: Make use of ACQUIRE magic in various paths as enabled
by dropping the return value.

With this posted, I'll mark it changes requested in patchwork.

https://patchwork.kernel.org/project/linux-iio/patch/20261021165858.v2.10.I5918e916cbe48281c13e5734733a3281e7be8841@changeid/

---
 drivers/iio/gyro/bmg160_core.c | 237 +++++++++++++--------------------
 1 file changed, 94 insertions(+), 143 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index b007f46d3fd6..a48e01ecc367 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -8,6 +8,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/cleanup.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/iio/iio.h>
@@ -313,30 +314,6 @@ static int bmg160_chip_init(struct bmg160_data *data)
 	return 0;
 }
 
-static int bmg160_set_power_state(struct bmg160_data *data, bool on)
-{
-#ifdef CONFIG_PM
-	struct device *dev = regmap_get_device(data->regmap);
-	int ret;
-
-	if (on)
-		ret = pm_runtime_get_sync(dev);
-	else
-		ret = pm_runtime_put_autosuspend(dev);
-
-	if (ret < 0) {
-		dev_err(dev, "Failed: bmg160_set_power_state for %d\n", on);
-
-		if (on)
-			pm_runtime_put_noidle(dev);
-
-		return ret;
-	}
-#endif
-
-	return 0;
-}
-
 static int bmg160_setup_any_motion_interrupt(struct bmg160_data *data,
 					     bool status)
 {
@@ -502,26 +479,20 @@ static int bmg160_get_temp(struct bmg160_data *data, int *val)
 	int ret;
 	unsigned int raw_val;
 
-	mutex_lock(&data->mutex);
-	ret = bmg160_set_power_state(data, true);
-	if (ret < 0) {
-		mutex_unlock(&data->mutex);
-		return ret;
+	guard(mutex)(&data->mutex);
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm)) {
+		dev_err(dev, "failed to resume\n");
+		return -ENXIO;
 	}
 
 	ret = regmap_read(data->regmap, BMG160_REG_TEMP, &raw_val);
 	if (ret < 0) {
 		dev_err(dev, "Error reading reg_temp\n");
-		bmg160_set_power_state(data, false);
-		mutex_unlock(&data->mutex);
 		return ret;
 	}
 
 	*val = sign_extend32(raw_val, 7);
-	ret = bmg160_set_power_state(data, false);
-	mutex_unlock(&data->mutex);
-	if (ret < 0)
-		return ret;
 
 	return IIO_VAL_INT;
 }
@@ -532,27 +503,21 @@ static int bmg160_get_axis(struct bmg160_data *data, int axis, int *val)
 	int ret;
 	__le16 raw_val;
 
-	mutex_lock(&data->mutex);
-	ret = bmg160_set_power_state(data, true);
-	if (ret < 0) {
-		mutex_unlock(&data->mutex);
-		return ret;
+	guard(mutex)(&data->mutex);
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm)) {
+		dev_err(dev, "failed to resume\n");
+		return -ENXIO;
 	}
 
 	ret = regmap_bulk_read(data->regmap, BMG160_AXIS_TO_REG(axis), &raw_val,
 			       sizeof(raw_val));
 	if (ret < 0) {
 		dev_err(dev, "Error reading axis %d\n", axis);
-		bmg160_set_power_state(data, false);
-		mutex_unlock(&data->mutex);
 		return ret;
 	}
 
 	*val = sign_extend32(le16_to_cpu(raw_val), 15);
-	ret = bmg160_set_power_state(data, false);
-	mutex_unlock(&data->mutex);
-	if (ret < 0)
-		return ret;
 
 	return IIO_VAL_INT;
 }
@@ -624,11 +589,11 @@ static int bmg160_write_raw(struct iio_dev *indio_dev,
 			    int val, int val2, long mask)
 {
 	struct bmg160_data *data = iio_priv(indio_dev);
-	int ret;
+	struct device *dev = regmap_get_device(data->regmap);
 
 	switch (mask) {
-	case IIO_CHAN_INFO_SAMP_FREQ:
-		mutex_lock(&data->mutex);
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		guard(mutex)(&data->mutex);
 		/*
 		 * Section 4.2 of spec
 		 * In suspend mode, the only supported operations are reading
@@ -636,65 +601,41 @@ static int bmg160_write_raw(struct iio_dev *indio_dev,
 		 * register. Since we will be in suspend mode by default, change
 		 * mode to power on for other writes.
 		 */
-		ret = bmg160_set_power_state(data, true);
-		if (ret < 0) {
-			mutex_unlock(&data->mutex);
-			return ret;
-		}
-		ret = bmg160_set_bw(data, val);
-		if (ret < 0) {
-			bmg160_set_power_state(data, false);
-			mutex_unlock(&data->mutex);
-			return ret;
+		PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+		if (PM_RUNTIME_ACQUIRE_ERR(&pm)) {
+			dev_err(dev, "failed to resume\n");
+			return -ENXIO;
 		}
-		ret = bmg160_set_power_state(data, false);
-		mutex_unlock(&data->mutex);
-		return ret;
-	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
+
+		return bmg160_set_bw(data, val);
+	}
+	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: {
 		if (val2)
 			return -EINVAL;
 
-		mutex_lock(&data->mutex);
-		ret = bmg160_set_power_state(data, true);
-		if (ret < 0) {
-			bmg160_set_power_state(data, false);
-			mutex_unlock(&data->mutex);
-			return ret;
-		}
-		ret = bmg160_set_filter(data, val);
-		if (ret < 0) {
-			bmg160_set_power_state(data, false);
-			mutex_unlock(&data->mutex);
-			return ret;
+		guard(mutex)(&data->mutex);
+		PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+		if (PM_RUNTIME_ACQUIRE_ERR(&pm)) {
+			dev_err(dev, "failed to resume\n");
+			return -ENXIO;
 		}
-		ret = bmg160_set_power_state(data, false);
-		mutex_unlock(&data->mutex);
-		return ret;
-	case IIO_CHAN_INFO_SCALE:
+		return bmg160_set_filter(data, val);
+	}
+	case IIO_CHAN_INFO_SCALE: {
 		if (val)
 			return -EINVAL;
 
-		mutex_lock(&data->mutex);
-		/* Refer to comments above for the suspend mode ops */
-		ret = bmg160_set_power_state(data, true);
-		if (ret < 0) {
-			mutex_unlock(&data->mutex);
-			return ret;
+		guard(mutex)(&data->mutex);
+		PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+		if (PM_RUNTIME_ACQUIRE_ERR(&pm)) {
+			dev_err(dev, "failed to resume\n");
+			return -ENXIO;
 		}
-		ret = bmg160_set_scale(data, val2);
-		if (ret < 0) {
-			bmg160_set_power_state(data, false);
-			mutex_unlock(&data->mutex);
-			return ret;
-		}
-		ret = bmg160_set_power_state(data, false);
-		mutex_unlock(&data->mutex);
-		return ret;
+		return bmg160_set_scale(data, val2);
+	}
 	default:
 		return -EINVAL;
 	}
-
-	return -EINVAL;
 }
 
 static int bmg160_read_event(struct iio_dev *indio_dev,
@@ -759,42 +700,37 @@ static int bmg160_write_event_config(struct iio_dev *indio_dev,
 				     bool state)
 {
 	struct bmg160_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
 	if (state && data->ev_enable_state)
 		return 0;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	if (!state && data->motion_trigger_on) {
 		data->ev_enable_state = 0;
-		mutex_unlock(&data->mutex);
 		return 0;
 	}
-	/*
-	 * We will expect the enable and disable to do operation
-	 * in reverse order. This will happen here anyway as our
-	 * resume operation uses sync mode runtime pm calls, the
-	 * suspend operation will be delayed by autosuspend delay
-	 * So the disable operation will still happen in reverse of
-	 * enable operation. When runtime pm is disabled the mode
-	 * is always on so sequence doesn't matter
-	 */
-	ret = bmg160_set_power_state(data, state);
-	if (ret < 0) {
-		mutex_unlock(&data->mutex);
-		return ret;
-	}
+	if (state) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret < 0) {
+			dev_err(dev, "failed to resume: %d\n", ret);
+			return ret;
+		}
 
-	ret =  bmg160_setup_any_motion_interrupt(data, state);
-	if (ret < 0) {
-		bmg160_set_power_state(data, false);
-		mutex_unlock(&data->mutex);
-		return ret;
-	}
+		ret = bmg160_setup_any_motion_interrupt(data, true);
+		if (ret < 0) {
+			pm_runtime_put_autosuspend(dev);
+			return ret;
+		}
+	} else {
+		ret = bmg160_setup_any_motion_interrupt(data, false);
+		if (ret < 0)
+			return ret;
 
-	data->ev_enable_state = state;
-	mutex_unlock(&data->mutex);
+		pm_runtime_put_autosuspend(dev);
+	}
 
 	return 0;
 }
@@ -929,41 +865,47 @@ static int bmg160_data_rdy_trigger_set_state(struct iio_trigger *trig,
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct bmg160_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	if (!state && data->ev_enable_state && data->motion_trigger_on) {
 		data->motion_trigger_on = false;
-		mutex_unlock(&data->mutex);
 		return 0;
 	}
 
-	/*
-	 * Refer to comment in bmg160_write_event_config for
-	 * enable/disable operation order
-	 */
-	ret = bmg160_set_power_state(data, state);
-	if (ret < 0) {
-		mutex_unlock(&data->mutex);
-		return ret;
-	}
-	if (data->motion_trig == trig)
-		ret =  bmg160_setup_any_motion_interrupt(data, state);
-	else
-		ret = bmg160_setup_new_data_interrupt(data, state);
-	if (ret < 0) {
-		bmg160_set_power_state(data, false);
-		mutex_unlock(&data->mutex);
-		return ret;
+	if (state) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret < 0) {
+			dev_err(dev, "failed to resume: %d\n", ret);
+			return ret;
+		}
+
+		if (data->motion_trig == trig)
+			ret = bmg160_setup_any_motion_interrupt(data, true);
+		else
+			ret = bmg160_setup_new_data_interrupt(data, true);
+		if (ret < 0) {
+			pm_runtime_put_autosuspend(dev);
+			return ret;
+		}
+	} else {
+		if (data->motion_trig == trig)
+			ret = bmg160_setup_any_motion_interrupt(data, false);
+		else
+			ret = bmg160_setup_new_data_interrupt(data, false);
+		if (ret < 0)
+			return ret;
+
+		pm_runtime_put_autosuspend(dev);
 	}
+
 	if (data->motion_trig == trig)
 		data->motion_trigger_on = state;
 	else
 		data->dready_trigger_on = state;
 
-	mutex_unlock(&data->mutex);
-
 	return 0;
 }
 
@@ -1046,15 +988,24 @@ static irqreturn_t bmg160_data_rdy_trig_poll(int irq, void *private)
 static int bmg160_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct bmg160_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		dev_err(dev, "failed to resume: %d\n", ret);
 
-	return bmg160_set_power_state(data, true);
+	return ret;
 }
 
 static int bmg160_buffer_postdisable(struct iio_dev *indio_dev)
 {
 	struct bmg160_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
 
-	return bmg160_set_power_state(data, false);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
 }
 
 static const struct iio_buffer_setup_ops bmg160_buffer_setup_ops = {
-- 
2.56.0

