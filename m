Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58264E8E1B
	for <linux-pm@vger.kernel.org>; Tue,  6 Oct 2026 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791328814; cv=none; b=ZiPNp61tUtphVVw7MGAdNCqMe+ZptrnkmS59sNNbt30jQgz1Agav0SDYMzK/2mvj4qOaejKKS92v3oy9Zd/yCsuZaEUEF6y1WfTzdF5yUnXwRYn5UiqYoLCQzRKQQoIH4w4pUvi6aEK8Owt2YTOsQkfu94luwV104jaCZXESEBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791328814; c=relaxed/simple;
	bh=wK2aCxJ9U+ub/DEV7X7hyoaxaqGtj9ujkt+2WBRc93E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uh9kmd6lFI+N2AhSxOLZiw6vnN8OIA2et79CyxO9uj6oeva7fU4QOX450YkiXBPQuI3UfY+gfNEJpX/28yUoNUZJf/HTrwnbakcVNOCL/5CqObOIS1tO6H3HY2JecIUJENZ8sAD6fgNJVwPgMTG7D0q55F7txRknE9Uv1TK/9w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V8Hk/RP+; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V8Hk/RP+"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3282db206d3so9901411eec.0
        for <linux-pm@vger.kernel.org>; Tue, 06 Oct 2026 16:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1791328792; x=1791933592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SeuThS77cf851FYkL3wNU27hfqCIdrf/bvhf8WRGatA=;
        b=V8Hk/RP+kuvRSmUDjqqQ/YnCUKREu5ecv+q0RYafOkmX5TtOSMUGD7nJkTH5csG7a0
         SE/K+oZQYMvrADbcqSMW+rC3333+fD91KMMYYsYPjobYsUBN0SPJZW3bpBm87OTNtVk6
         QkJR/l1yRgQBUy1iU4SWIR2p93DdMn6QJSXzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791328792; x=1791933592;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SeuThS77cf851FYkL3wNU27hfqCIdrf/bvhf8WRGatA=;
        b=T8tf8AZTjv+/t8P3osD9oO/Hdq51EWt/DGc9vNV7m9pFpGCY4lVxScSJkfR4Su1cQX
         DKnmlgjMj3UhCk7KB7Hw5TeUmxa86AiLMoc1MkJpZ8QKOEC9tBul44/eQDml9aATCauo
         iCq+Fhp18ciotA1k6Rhl8x6+m3BdGQUzf2/3bBPHV/+PoPn15EEBId9X/U06jHxr1fq9
         ZXycGdBuNafwSL1JRNuWuZvdgUJZTG9BZFjAEFBD0/QEfoRVjmn+Wy0dFisDCNwsZoLt
         pIhcGEIJ8/gv9mEtPs5zbvPTrBfYpaDt/9W75hNduGyJMXTNyn1U3arWqmJLwYmmEhcm
         MPOA==
X-Gm-Message-State: AFuF++nMzFZl3auWDPy9bMq0OiUmmhaU7q2ENsn59QWhx01FEL/xsBZl
	DsYEjAzk/MIc4SoZv3+n4E5HHO5GVkajR0UB/9RxQZ2/ga6jFJ9CNSumC7QIxSKzdw==
X-Gm-Gg: AYBFou2LzwP0aJqo8jh5JZypMtv1OlkOUrUFaSPyNeuDk9bt96DkzEaIigxJ2vARNFC
	1QJs4QIkqEBttOUoysLxXrWkWj1K6A7FwjaS0dxWdhXqKqdl0AlHxH/iFzdjnQ8UcEOJH9fpCf8
	2hLGFEluDRqfuwrXSFh+2he3327LPtVIYYeNzu6Qv7U9xw6bps6EGa0DYUGkyRx6i2jH07wVWsc
	q4mTWunqdjvOyd4jWAPLAsU35xUgvm8+2kCsA/4JLZymaZj7gUhe+siifaS30CTS1WmBEv4wCFN
	uDYty0mLgkzVbbqzoXVZLNZ5zPCpCX+I4GCH4IdIQ2iEbhY+aHeE2xKG9Knopf/7K0MUbKxKhV9
	Bnv1ke6IqmrUzsZqhysmGAyGGgH2FDB8xTz0MPKdWKfh/bnfWk3uvBYq+kPBz62exjwYHiwb1fV
	WpdCUoYsYhk8JUi5c8DUifpQKdE8kjh4H90SgdzswvRdttsDs6l3rGY3IQzmFTT8bRCi+CcYede
	zDzdJibdVFTJiuDP1ZUZtJXwHk7meqY3iqgFA==
X-Received: by 2002:a05:7300:3a97:b0:343:f1fc:9006 with SMTP id 5a478bee46e88-3515de7effbmr291244eec.30.1791328792383;
        Tue, 06 Oct 2026 16:19:52 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:63eb:e7f9:1d47:7d47])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3515b01ea9csm1659478eec.27.2026.10.06.16.19.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Oct 2026 16:19:51 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Jonathan Cameron <jic23@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH 03/13] iio: Discard pm_runtime_put_autosuspend() return values
Date: Tue,  6 Oct 2026 16:13:31 -0700
Message-ID: <20261006161337.3.If2263e6ae9eaa4493881b72922dcde031ce9d81d@changeid>
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
In-Reply-To: <20261006231900.3230373-1-briannorris@chromium.org>
References: <20261006231900.3230373-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Multiple IIO drivers inspect or propagate the return value of
pm_runtime_put_autosuspend(), which is not particularly useful.

Returning an error code from pm_runtime_put_autosuspend() merely means
that it has not queued up a timer or work item to check whether or not
the device can be suspended and there are many perfectly valid
situations in which that can happen, like after writing "on" to the
device's runtime PM "control" attribute in sysfs for one example.

For this reason, modify these drivers to simply discard the
pm_runtime_put_autosuspend() return value, and change the return types
of fxls8962af_power_off() and fxas21002c_pm_put() to void.

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
This patch is independent of the rest of the series, except for the end
(changing the return type). I expect it can be applied by individual
maintainers, and we pick up the end once the dust is settled.

I couldn't decide if I should split this up by individual driver, or
just 1 for the whole drivers/iio/ subsystem. Many of these drivers have
borrowed the same patterns, so I chose to just send 1. Let me know if I
should split it up.

 drivers/iio/accel/bmc150-accel-core.c         | 14 +++++-----
 drivers/iio/accel/fxls8962af-core.c           | 11 +++-----
 drivers/iio/accel/kxcjk-1013.c                | 15 ++++++-----
 drivers/iio/accel/mma8452.c                   | 15 +++++------
 drivers/iio/accel/mma9551_core.c              | 15 +++++------
 drivers/iio/adc/rcar-gyroadc.c                |  4 +--
 drivers/iio/adc/ti-ads1015.c                  |  8 +++---
 drivers/iio/chemical/atlas-sensor.c           |  4 +--
 .../common/hid-sensors/hid-sensor-trigger.c   | 14 ++++------
 drivers/iio/gyro/bmg160_core.c                | 17 +++++-------
 drivers/iio/gyro/fxas21002c_core.c            | 12 +++------
 drivers/iio/imu/kmx61.c                       | 17 ++++++------
 drivers/iio/light/apds9960.c                  |  2 +-
 drivers/iio/light/isl29028.c                  | 15 +++--------
 drivers/iio/light/pa12203001.c                |  3 ++-
 drivers/iio/light/rpr0521.c                   | 15 +++++------
 drivers/iio/light/tsl2583.c                   | 27 +++----------------
 drivers/iio/light/us5182d.c                   |  3 ++-
 18 files changed, 80 insertions(+), 131 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 46bb36d9366e..2f7fe28e3e0b 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -332,14 +332,14 @@ static int bmc150_accel_set_power_state(struct bmc150_accel_data *data, bool on)
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
-	if (on)
+	if (on) {
 		ret = pm_runtime_resume_and_get(dev);
-	else
-		ret = pm_runtime_put_autosuspend(dev);
-	if (ret < 0) {
-		dev_err(dev,
-			"Failed: %s for %d\n", __func__, on);
-		return ret;
+		if (ret < 0) {
+			dev_err(dev, "%s: failed to resume: %d\n", __func__, ret);
+			return ret;
+		}
+	} else {
+		pm_runtime_put_autosuspend(dev);
 	}
 
 	return 0;
diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 18d7b09bddd2..3a2c4ce0557c 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -216,16 +216,11 @@ static int fxls8962af_power_on(struct fxls8962af_data *data)
 	return ret;
 }
 
-static int fxls8962af_power_off(struct fxls8962af_data *data)
+static void fxls8962af_power_off(struct fxls8962af_data *data)
 {
 	struct device *dev = regmap_get_device(data->regmap);
-	int ret;
-
-	ret = pm_runtime_put_autosuspend(dev);
-	if (ret)
-		dev_err(dev, "failed to power off\n");
 
-	return ret;
+	pm_runtime_put_autosuspend(dev);
 }
 
 static int fxls8962af_standby(struct fxls8962af_data *data)
@@ -692,7 +687,7 @@ fxls8962af_write_event_config(struct iio_dev *indio_dev,
 			return -EBUSY;
 
 		/* Not in buffered mode so disable power */
-		ret = fxls8962af_power_off(data);
+		fxls8962af_power_off(data);
 
 		iio_device_release_direct(indio_dev);
 	}
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 166fb786425f..f068753469a8 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -633,14 +633,15 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
 #ifdef CONFIG_PM
 	int ret;
 
-	if (on)
+	if (on) {
 		ret = pm_runtime_resume_and_get(&data->client->dev);
-	else
-		ret = pm_runtime_put_autosuspend(&data->client->dev);
-	if (ret < 0) {
-		dev_err(&data->client->dev,
-			"Failed: %s for %d\n", __func__, on);
-		return ret;
+		if (ret < 0) {
+			dev_err(&data->client->dev,
+				"%s: failed to resume: %d\n", __func__, ret);
+			return ret;
+		}
+	} else {
+		pm_runtime_put_autosuspend(&data->client->dev);
 	}
 #endif
 
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 7d683686dd9d..711689db8694 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -224,15 +224,14 @@ static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
 #ifdef CONFIG_PM
 	int ret;
 
-	if (on)
+	if (on) {
 		ret = pm_runtime_resume_and_get(&client->dev);
-	else
-		ret = pm_runtime_put_autosuspend(&client->dev);
-	if (ret < 0) {
-		dev_err(&client->dev,
-			"failed to change power state to %d\n", on);
-
-		return ret;
+		if (ret < 0) {
+			dev_err(&client->dev, "failed to resume: %d\n", ret);
+			return ret;
+		}
+	} else {
+		pm_runtime_put_autosuspend(&client->dev);
 	}
 #endif
 
diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
index 2ccb1fb19b96..d8aa0a062779 100644
--- a/drivers/iio/accel/mma9551_core.c
+++ b/drivers/iio/accel/mma9551_core.c
@@ -669,15 +669,14 @@ int mma9551_set_power_state(struct i2c_client *client, bool on)
 #ifdef CONFIG_PM
 	int ret;
 
-	if (on)
+	if (on) {
 		ret = pm_runtime_resume_and_get(&client->dev);
-	else
-		ret = pm_runtime_put_autosuspend(&client->dev);
-	if (ret < 0) {
-		dev_err(&client->dev,
-			"failed to change power state to %d\n", on);
-
-		return ret;
+		if (ret < 0) {
+			dev_err(&client->dev, "failed to resume: %d\n", ret);
+			return ret;
+		}
+	} else {
+		pm_runtime_put_autosuspend(&client->dev);
 	}
 #endif
 
diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
index d38cf3caeae0..0d3b061d6ec2 100644
--- a/drivers/iio/adc/rcar-gyroadc.c
+++ b/drivers/iio/adc/rcar-gyroadc.c
@@ -199,10 +199,8 @@ static int rcar_gyroadc_read_raw(struct iio_dev *indio_dev,
 		*val = readl(priv->regs + datareg);
 		*val &= BIT(priv->sample_width) - 1;
 
-		ret = pm_runtime_put_autosuspend(priv->dev);
+		pm_runtime_put_autosuspend(priv->dev);
 		iio_device_release_direct(indio_dev);
-		if (ret < 0)
-			return ret;
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 0fbfa4e499aa..817ec1c73df4 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -370,15 +370,13 @@ static const struct iio_chan_spec tla2024_channels[] = {
 #ifdef CONFIG_PM
 static int ads1015_set_power_state(struct ads1015_data *data, bool on)
 {
-	int ret;
 	struct device *dev = regmap_get_device(data->regmap);
 
 	if (on)
-		ret = pm_runtime_resume_and_get(dev);
-	else
-		ret = pm_runtime_put_autosuspend(dev);
+		return pm_runtime_resume_and_get(dev);
 
-	return ret < 0 ? ret : 0;
+	pm_runtime_put_autosuspend(dev);
+	return 0;
 }
 
 #else /* !CONFIG_PM */
diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
index 1d4a9919df1a..48598475512f 100644
--- a/drivers/iio/chemical/atlas-sensor.c
+++ b/drivers/iio/chemical/atlas-sensor.c
@@ -426,9 +426,7 @@ static int atlas_buffer_predisable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	ret = pm_runtime_put_autosuspend(&data->client->dev);
-	if (ret)
-		return ret;
+	pm_runtime_put_autosuspend(&data->client->dev);
 
 	return 0;
 }
diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
index 60808e2430ca..d76a6d9f04f6 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
@@ -154,21 +154,17 @@ int hid_sensor_power_state(struct hid_sensor_common *st, bool state)
 {
 
 #ifdef CONFIG_PM
-	int ret;
-
 	if (atomic_add_unless(&st->runtime_pm_enable, 1, 1))
 		pm_runtime_enable(&st->pdev->dev);
 
 	if (state) {
 		atomic_inc(&st->user_requested_state);
-		ret = pm_runtime_resume_and_get(&st->pdev->dev);
-	} else {
-		atomic_dec(&st->user_requested_state);
-		pm_runtime_use_autosuspend(&st->pdev->dev);
-		ret = pm_runtime_put_autosuspend(&st->pdev->dev);
+		return pm_runtime_resume_and_get(&st->pdev->dev);
 	}
-	if (ret < 0)
-		return ret;
+
+	atomic_dec(&st->user_requested_state);
+	pm_runtime_use_autosuspend(&st->pdev->dev);
+	pm_runtime_put_autosuspend(&st->pdev->dev);
 
 	return 0;
 #else
diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index d611341a0e2a..e8e511daa7c4 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -319,18 +319,15 @@ static int bmg160_set_power_state(struct bmg160_data *data, bool on)
 	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
-	if (on)
+	if (on) {
 		ret = pm_runtime_get_sync(dev);
-	else
-		ret = pm_runtime_put_autosuspend(dev);
-
-	if (ret < 0) {
-		dev_err(dev, "Failed: bmg160_set_power_state for %d\n", on);
-
-		if (on)
+		if (ret < 0) {
+			dev_err(dev, "%s: failed to resume: %d\n", __func__, ret);
 			pm_runtime_put_noidle(dev);
-
-		return ret;
+			return ret;
+		}
+	} else {
+		pm_runtime_put_autosuspend(dev);
 	}
 #endif
 
diff --git a/drivers/iio/gyro/fxas21002c_core.c b/drivers/iio/gyro/fxas21002c_core.c
index a88670207cec..408f88f12fe7 100644
--- a/drivers/iio/gyro/fxas21002c_core.c
+++ b/drivers/iio/gyro/fxas21002c_core.c
@@ -369,11 +369,11 @@ static int  fxas21002c_pm_get(struct fxas21002c_data *data)
 	return pm_runtime_resume_and_get(regmap_get_device(data->regmap));
 }
 
-static int  fxas21002c_pm_put(struct fxas21002c_data *data)
+static void fxas21002c_pm_put(struct fxas21002c_data *data)
 {
 	struct device *dev = regmap_get_device(data->regmap);
 
-	return pm_runtime_put_autosuspend(dev);
+	pm_runtime_put_autosuspend(dev);
 }
 
 static int fxas21002c_temp_get(struct fxas21002c_data *data, int *val)
@@ -396,9 +396,7 @@ static int fxas21002c_temp_get(struct fxas21002c_data *data, int *val)
 
 	*val = sign_extend32(temp, 7);
 
-	ret = fxas21002c_pm_put(data);
-	if (ret < 0)
-		goto data_unlock;
+	fxas21002c_pm_put(data);
 
 	ret = IIO_VAL_INT;
 
@@ -430,9 +428,7 @@ static int fxas21002c_axis_get(struct fxas21002c_data *data,
 
 	*val = sign_extend32(be16_to_cpu(axis_be), 15);
 
-	ret = fxas21002c_pm_put(data);
-	if (ret < 0)
-		goto data_unlock;
+	fxas21002c_pm_put(data);
 
 	ret = IIO_VAL_INT;
 
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index c288437d53ea..a8d37aa549ae 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -747,16 +747,15 @@ static int kmx61_set_power_state(struct kmx61_data *data, bool on, u8 device)
 		data->mag_ps = on;
 	}
 
-	if (on)
+	if (on) {
 		ret = pm_runtime_resume_and_get(&data->client->dev);
-	else
-		ret = pm_runtime_put_autosuspend(&data->client->dev);
-	if (ret < 0) {
-		dev_err(&data->client->dev,
-			"Failed: kmx61_set_power_state for %d, ret %d\n",
-			on, ret);
-
-		return ret;
+		if (ret < 0) {
+			dev_err(&data->client->dev,
+				"%s: failed to resume: %d\n", __func__, ret);
+			return ret;
+		}
+	} else {
+		pm_runtime_put_autosuspend(&data->client->dev);
 	}
 #endif
 	return 0;
diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index afe520de60e2..611e59d6b027 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -495,7 +495,7 @@ static int apds9960_set_power_state(struct apds9960_data *data, bool on)
 			usleep_range(data->als_adc_int_us,
 				     APDS9960_MAX_INT_TIME_IN_US);
 	} else {
-		ret = pm_runtime_put_autosuspend(dev);
+		pm_runtime_put_autosuspend(dev);
 	}
 
 	mutex_unlock(&data->lock);
diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index 33deb1726689..190ce67d2efe 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -395,9 +395,7 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
 	if (ret < 0)
 		return ret;
 
-	ret = pm_runtime_put_autosuspend(dev);
-	if (ret < 0)
-		return ret;
+	pm_runtime_put_autosuspend(dev);
 
 	return 0;
 }
@@ -408,7 +406,7 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
 {
 	struct isl29028_chip *chip = iio_priv(indio_dev);
 	struct device *dev = regmap_get_device(chip->regmap);
-	int ret, pm_ret;
+	int ret;
 
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
@@ -464,14 +462,7 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
 	if (ret < 0)
 		return ret;
 
-	/**
-	 * Preserve the ret variable if the call to
-	 * pm_runtime_put_autosuspend() is successful so the reading
-	 * (if applicable) is returned to user space.
-	 */
-	pm_ret = pm_runtime_put_autosuspend(dev);
-	if (pm_ret < 0)
-		return pm_ret;
+	pm_runtime_put_autosuspend(dev);
 
 	return ret;
 }
diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
index c0f4db8d95f7..d4e197e05d26 100644
--- a/drivers/iio/light/pa12203001.c
+++ b/drivers/iio/light/pa12203001.c
@@ -188,7 +188,8 @@ static int pa12203001_set_power_state(struct pa12203001_data *data, bool on,
 	if (on)
 		return pm_runtime_resume_and_get(&data->client->dev);
 
-	return pm_runtime_put_autosuspend(&data->client->dev);
+	pm_runtime_put_autosuspend(&data->client->dev);
+	return 0;
 
 err:
 	mutex_unlock(&data->lock);
diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 7d82efc31f3a..60c5e85bac2c 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -357,15 +357,14 @@ static int rpr0521_set_power_state(struct rpr0521_data *data, bool on,
 	 * Note: If either measurement is re-enabled before _suspend(),
 	 * both stay enabled until _suspend().
 	 */
-	if (on)
+	if (on) {
 		ret = pm_runtime_resume_and_get(&data->client->dev);
-	else
-		ret = pm_runtime_put_autosuspend(&data->client->dev);
-	if (ret < 0) {
-		dev_err(&data->client->dev,
-			"Failed: rpr0521_set_power_state for %d, ret %d\n",
-			on, ret);
-		return ret;
+		if (ret < 0) {
+			dev_err(&data->client->dev, "Failed to resume: %d\n", ret);
+			return ret;
+		}
+	} else {
+		pm_runtime_put_autosuspend(&data->client->dev);
 	}
 
 	if (on) {
diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index 53fd423aa7ae..deaa71485468 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -640,7 +640,7 @@ static int tsl2583_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct tsl2583_chip *chip = iio_priv(indio_dev);
-	int ret, pm_ret;
+	int ret;
 
 	ret = pm_runtime_resume_and_get(&chip->client->dev);
 	if (ret < 0)
@@ -709,19 +709,7 @@ static int tsl2583_read_raw(struct iio_dev *indio_dev,
 read_done:
 	mutex_unlock(&chip->als_mutex);
 
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(&chip->client->dev);
-		return ret;
-	}
-
-	/*
-	 * Preserve the ret variable if the call to
-	 * pm_runtime_put_autosuspend() is successful so the reading
-	 * (if applicable) is returned to user space.
-	 */
-	pm_ret = pm_runtime_put_autosuspend(&chip->client->dev);
-	if (pm_ret < 0)
-		return pm_ret;
+	pm_runtime_put_autosuspend(&chip->client->dev);
 
 	return ret;
 }
@@ -773,16 +761,9 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
 
 	mutex_unlock(&chip->als_mutex);
 
-	if (ret < 0) {
-		pm_runtime_put_autosuspend(&chip->client->dev);
-		return ret;
-	}
+	pm_runtime_put_autosuspend(&chip->client->dev);
 
-	ret = pm_runtime_put_autosuspend(&chip->client->dev);
-	if (ret < 0)
-		return ret;
-
-	return 0;
+	return ret;
 }
 
 static const struct iio_info tsl2583_info = {
diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index ab518311fd79..e76c40b422f4 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -366,7 +366,8 @@ static int us5182d_set_power_state(struct us5182d_data *data, bool on)
 	if (on)
 		return pm_runtime_resume_and_get(&data->client->dev);
 
-	return pm_runtime_put_autosuspend(&data->client->dev);
+	pm_runtime_put_autosuspend(&data->client->dev);
+	return 0;
 }
 
 static int us5182d_read_value(struct us5182d_data *data,
-- 
2.56.0.360.g66cac248cb-goog

