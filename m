Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627295;
	b=yUmoR0h+7AkOdecz0nyuUN8joRJyJl+k+pJcopzL9WeDxoUoL978js8pqOloiOfQ7x1J
	 io+mXo1L1BBlNYUa2B4sWvp98aClAUGc0iORcuNT0Rr0yKN6MT4+mmQczkBtRdI3NRqnR
	 5Bu9F4L2seXRNMZNLiTXJPFlTcirxkVbBsp9ELHop9845OKlidqFKuioUZj36hhyPfeYq
	 BTlNhfDdzuolX6S08n7Asn98Fnsr3q2PJ2lC/nq+02AJ3s6O7nivmEzFR6A/CC3oHZQzE
	 saLzD/2JaCUc3+6R0JC7l6OmzOTCML2AMN4j3kGQgjt+iY4bF+rxzXdWNNPBeNlQF0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627295;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Gsd6bRhlTh/YOIZGX8jXAT4MMsBhNz0V/WWByQICZzw=;
	b=cioFNshlWmGuYc2E9jPiytRibUJf0MkyIWU3CacYbNNAVXzT0JEZLyqhQMCGS1/mwBnz
	 RjEL0qaBoKK53gHxhAeOBEsDex/gBBgz0mHsdS9DtqBrDtvXfrqVjj8Rc5XhtuTrRJklH
	 seQOBHSj/R8mOVxcwSGUXZZ3wCGPtKwZ/l2ixRdOgk387NN2b9Pkqc3EHomke2ck7G37W
	 YbVF6bStskgNdi/0d1yBQAbgs9pNWdiuFr1lrVN+lO5n3INdcmstR5bWYcGeGBBzgUBxe
	 JShXRqYVnIlx180hCTgCLdDouyXlGDgDxBXJqv4NtH+TSi0OqtEGUaloHWd6YKUjvgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=cd4A51uY;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18BF60A381B
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 00:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E18BF60A381B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=cd4A51uY
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3514b90bb89so3491629eec.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 17:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627294; x=1793232094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Gsd6bRhlTh/YOIZGX8jXAT4MMsBhNz0V/WWByQICZzw=;
        b=cd4A51uYQQAHx6tTp0GxCUUwPl6yFZwUM7LL8Vt2gNarBStsEYQ2Ts+sZDxxNH3jwD
         xs3SSz7Ztc8vtsIr/f/Bq7aeiDNLJeaKj0lxVHMUOTIiIRFVPwqDLqlIv5g1bj97Bfrl
         Apx2eb05eKs7GXxkiDh10+tMASq1hcHbutALQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627294; x=1793232094;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gsd6bRhlTh/YOIZGX8jXAT4MMsBhNz0V/WWByQICZzw=;
        b=GENxpw4iuyWmLfwS8mFFZ8UU1xAWkki2zUBMhYpsOewneB0Ibdk0El5eINGLwacyam
         konwZKsdOPRbIBZyanQyIt1XVKpwxN8ROioPVgqyE8ZI83z3BB09DvgKWSyijpiw6zbF
         F16hj4U/tqFr3Sdb3fgsEKonw6Ogb70+ceaG36hW0seUB03ELZL+tIVIFPWSPooIlmCQ
         orNQjb3fKvf2bFsT5mNa8hcpc7G/uOxIbgiTvSr2kEHM60Xow5VTZPBujgHeeyWMplb9
         8oMXenfsNULTSdLjErSdk1ffF/Kl1mIMxIWbfIEtEDQqXrNsaS5w91NU1hBHLhHg+L3K
         OvzA==
X-Forwarded-Encrypted: i=1; AKwUvBwhjYtMzVpqCwkG4lFZ6t7DAKon+uEzCxxvqSoQdkITC8jDezAM0BZcC98RhLs9mZiBBumAbBFPUg==@vger.kernel.org
X-Gm-Message-State: AFq9FYL39O83FT+EpWMVdFG8+ehWLT+dv5vbCQlfGCF011r+/l5iJoPQ
	/kQ/jn4Nvpcf7XRk/RhDziCkRACAd8z5R64v9kbj52CJb1QhkShS6B5//3N9s6i2lA==
X-Gm-Gg: AYBFou1YM+lDwyBvrE4hUTjMwCOngfgERAGcCjme0t6WhbBgqCmfNqFyxMSvvrDxdB2
	P0rN3V255SDP7z9jJD/5RvTh/UlALcKdCYCzhmWcqFsT3qrh0zQvSinKQ0OAcAi7+hWh4rKbSGd
	xHJRKpzxcF0qlZHfKM8900Mf1+Sxy+L/sdFF8KqfE4lG8usuMnQKNRL8Ns01ee4CmH81Hne+JJA
	VpYHSRuEREZUydWoftShrwcrDRVaY+Oy3Ds8n5vmo7SfZL22N6oJffT1MesBc+rRoUG3lsErCu+
	NkThxVispnt3qAaGSizo0ezLX1d7Kkab7p9b26BwAThkbVSVE6eKnN81F6YKwpcYBtt+vuOWN1j
	w1rhdhtaUcEPCg2URM+z4eMcrrxCwcaMYGYJV7Dv6VRY3VkMMh1RSVtJ6T7U/b1MAEmmAKBwOTT
	1wvjs0j8diPl4wuC+NMo3UJMFmSreBatbtxaS1jsZ72ml42ZwF2UiOq4klSftUxJ7GvaSyL1vEV
	oUXQqkVauGPuu6JcHOaFefsui7+ctDy5LSSJMfOYvk26M57Oq5hYTCtQDww+pnnkOAjy1D2FW/a
	W+jCxMpiPpyp9QYk6bmt
X-Received: by 2002:a05:7023:904:b0:14a:d8fe:33b3 with SMTP id a92af1059eb24-190a6dbd933mr4831229c88.40.1792627293578;
        Wed, 21 Oct 2026 17:01:33 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1903a180b9esm14472813c88.4.2026.10.21.17.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:32 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-pm@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/17] iio: gyro: bmg160: Discard pm_runtime_put_autosuspend() return values
Date: Wed, 21 Oct 2026 16:57:11 -0700
Message-ID: <20261021165858.v2.10.I5918e916cbe48281c13e5734733a3281e7be8841@changeid>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021235818.3059519-1-briannorris@chromium.org>
References: <20261021235818.3059519-1-briannorris@chromium.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
---

Changes in v2:
 * Split iio patch into per-driver patches
 * Inlining
 * guard()

 drivers/iio/gyro/bmg160_core.c | 178 ++++++++++++++-------------------
 1 file changed, 77 insertions(+), 101 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 0958b7d31a92..0281a3a52105 100644
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
@@ -503,8 +480,9 @@ static int bmg160_get_temp(struct bmg160_data *data, int *val)
 	unsigned int raw_val;
 
 	mutex_lock(&data->mutex);
-	ret = bmg160_set_power_state(data, true);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
+		dev_err(dev, "failed to resume: %d\n", ret);
 		mutex_unlock(&data->mutex);
 		return ret;
 	}
@@ -512,16 +490,14 @@ static int bmg160_get_temp(struct bmg160_data *data, int *val)
 	ret = regmap_read(data->regmap, BMG160_REG_TEMP, &raw_val);
 	if (ret < 0) {
 		dev_err(dev, "Error reading reg_temp\n");
-		bmg160_set_power_state(data, false);
+		pm_runtime_put_autosuspend(dev);
 		mutex_unlock(&data->mutex);
 		return ret;
 	}
 
 	*val = sign_extend32(raw_val, 7);
-	ret = bmg160_set_power_state(data, false);
+	pm_runtime_put_autosuspend(dev);
 	mutex_unlock(&data->mutex);
-	if (ret < 0)
-		return ret;
 
 	return IIO_VAL_INT;
 }
@@ -533,8 +509,9 @@ static int bmg160_get_axis(struct bmg160_data *data, int axis, int *val)
 	__le16 raw_val;
 
 	mutex_lock(&data->mutex);
-	ret = bmg160_set_power_state(data, true);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
+		dev_err(dev, "failed to resume: %d\n", ret);
 		mutex_unlock(&data->mutex);
 		return ret;
 	}
@@ -543,16 +520,14 @@ static int bmg160_get_axis(struct bmg160_data *data, int axis, int *val)
 			       sizeof(raw_val));
 	if (ret < 0) {
 		dev_err(dev, "Error reading axis %d\n", axis);
-		bmg160_set_power_state(data, false);
+		pm_runtime_put_autosuspend(dev);
 		mutex_unlock(&data->mutex);
 		return ret;
 	}
 
 	*val = sign_extend32(le16_to_cpu(raw_val), 15);
-	ret = bmg160_set_power_state(data, false);
+	pm_runtime_put_autosuspend(dev);
 	mutex_unlock(&data->mutex);
-	if (ret < 0)
-		return ret;
 
 	return IIO_VAL_INT;
 }
@@ -624,6 +599,7 @@ static int bmg160_write_raw(struct iio_dev *indio_dev,
 			    int val, int val2, long mask)
 {
 	struct bmg160_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
 	switch (mask) {
@@ -636,18 +612,14 @@ static int bmg160_write_raw(struct iio_dev *indio_dev,
 		 * register. Since we will be in suspend mode by default, change
 		 * mode to power on for other writes.
 		 */
-		ret = bmg160_set_power_state(data, true);
+		ret = pm_runtime_resume_and_get(dev);
 		if (ret < 0) {
+			dev_err(dev, "failed to resume: %d\n", ret);
 			mutex_unlock(&data->mutex);
 			return ret;
 		}
 		ret = bmg160_set_bw(data, val);
-		if (ret < 0) {
-			bmg160_set_power_state(data, false);
-			mutex_unlock(&data->mutex);
-			return ret;
-		}
-		ret = bmg160_set_power_state(data, false);
+		pm_runtime_put_autosuspend(dev);
 		mutex_unlock(&data->mutex);
 		return ret;
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
@@ -655,19 +627,14 @@ static int bmg160_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 
 		mutex_lock(&data->mutex);
-		ret = bmg160_set_power_state(data, true);
+		ret = pm_runtime_resume_and_get(dev);
 		if (ret < 0) {
-			bmg160_set_power_state(data, false);
+			dev_err(dev, "failed to resume: %d\n", ret);
 			mutex_unlock(&data->mutex);
 			return ret;
 		}
 		ret = bmg160_set_filter(data, val);
-		if (ret < 0) {
-			bmg160_set_power_state(data, false);
-			mutex_unlock(&data->mutex);
-			return ret;
-		}
-		ret = bmg160_set_power_state(data, false);
+		pm_runtime_put_autosuspend(dev);
 		mutex_unlock(&data->mutex);
 		return ret;
 	case IIO_CHAN_INFO_SCALE:
@@ -676,18 +643,14 @@ static int bmg160_write_raw(struct iio_dev *indio_dev,
 
 		mutex_lock(&data->mutex);
 		/* Refer to comments above for the suspend mode ops */
-		ret = bmg160_set_power_state(data, true);
+		ret = pm_runtime_resume_and_get(dev);
 		if (ret < 0) {
+			dev_err(dev, "failed to resume: %d\n", ret);
 			mutex_unlock(&data->mutex);
 			return ret;
 		}
 		ret = bmg160_set_scale(data, val2);
-		if (ret < 0) {
-			bmg160_set_power_state(data, false);
-			mutex_unlock(&data->mutex);
-			return ret;
-		}
-		ret = bmg160_set_power_state(data, false);
+		pm_runtime_put_autosuspend(dev);
 		mutex_unlock(&data->mutex);
 		return ret;
 	default:
@@ -759,42 +722,40 @@ static int bmg160_write_event_config(struct iio_dev *indio_dev,
 				     bool state)
 {
 	struct bmg160_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
 	if (state == data->ev_enable_state)
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
 
-	ret =  bmg160_setup_any_motion_interrupt(data, state);
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
+		ret = bmg160_setup_any_motion_interrupt(data, true);
+		if (ret < 0) {
+			pm_runtime_put_autosuspend(dev);
+			return ret;
+		}
+	} else {
+		ret = bmg160_setup_any_motion_interrupt(data, false);
+		if (ret < 0)
+			return ret;
+
+		pm_runtime_put_autosuspend(dev);
 	}
 
 	data->ev_enable_state = state;
-	mutex_unlock(&data->mutex);
 
 	return 0;
 }
@@ -929,41 +890,47 @@ static int bmg160_data_rdy_trigger_set_state(struct iio_trigger *trig,
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
 
@@ -1046,15 +1013,24 @@ static irqreturn_t bmg160_data_rdy_trig_poll(int irq, void *private)
 static int bmg160_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct bmg160_data *data = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(data->regmap);
+	int ret;
 
-	return bmg160_set_power_state(data, true);
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret < 0)
+		dev_err(dev, "failed to resume: %d\n", ret);
+
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
2.56.0.218.g1ec904b173-goog

