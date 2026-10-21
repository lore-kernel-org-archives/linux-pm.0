Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627280;
	b=SS6qL3tE5gYJMekjWZ/Dq2HtsAsUwPOsdwmEkMf4WxdH3ZdJKcJWoSCe7phb0zDlvE/Y
	 0+2QKCPLrD//6e9OH49ZroTHpwjjifX9/wdXXRM9xFtQdIJJBhmEHMYZ4zmIC0XLwa3wl
	 oY17OlbJR8s1B1yRDRuLmoXmYaMtCUzz2qf1o4cOH0LcVWZk2EhPE6cOoJfU1k9sH00hZ
	 mjH17DIxqlYdrRFxSBCyR9u8vgFRatI6p2+7Rg1kIYlmh2+Wq5AcBEdEXOCdMah/8fXN6
	 6iluLlbfI88mv2g5NmlaFeGBg644zvNtDXE0r3Q6vuI+1SYfpqEOcWXW5tKUe+KZvjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DrhBXqhw+pc4M/hvpW+mvyywy5l2oUqCGne7U8TDFRk=;
	b=BiYv30JvzEOS7DgHgEc5QnMvAHTKDka73HX7xtpIKnazoZoB83neChuBNr2peDPI+znc
	 ZyHuDeoqBYUx8rrF/0cfqeY2QAxqgO1zMMpY/2joeJJM12FEniPo6fEKdhDuRqEuTVxYB
	 E4yXab/4XDVSlmcQX8IZzcrJTBU8aV687lkuFmloXar+epcm2rL0ce1vU5CCV4CUquoAD
	 08FCjKxvS9tCCRVDvTlycPRfKc/Y20ysXZvpYH3bYXdC2H04DwmKt+aLRVchqhfK6YNaK
	 t8ShXdE0EzV9BwzKsy7fHcfvuT3EUIbeMYRSJBco5pjxrVl2g1TIDUSMylXUQkZ+j6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=HrJTejEB;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B04606A33C
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 00:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9B04606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=HrJTejEB
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-353804b591eso2388568eec.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 17:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627279; x=1793232079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DrhBXqhw+pc4M/hvpW+mvyywy5l2oUqCGne7U8TDFRk=;
        b=HrJTejEB7BtLE0g6YVZzJ+mXw/FqC4qs+QE3ZEylrm506D3bPr/XnbN7CQaB1kxGgG
         POwNaazpcRqDRqmS6PBilW20w11LSMVcXHTYIwZh9MAXzgRDhdANFYKJ8p+i5GEF7jNZ
         ndsHL84Hh8PeeeGrLlhciPOC2ADIkgI0bAiiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627279; x=1793232079;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DrhBXqhw+pc4M/hvpW+mvyywy5l2oUqCGne7U8TDFRk=;
        b=MLbZUi9zwgfmS1n2s1M8Anno2qU0v3NHWWXvPp21h93LksBAJaZ9Uz2lq02l76glb+
         sC9WiQRMk0uXYHOrYE9NEqX4U/lZnmQukuQrZEqlToV+cOClMdCN4TROfuN5nR8Or/Mh
         4JJ4pERzmPX9RaPeVY1HZ/V6x4zwJlnOI467TebSb+bHoQrsavQtjGl2nWW3dqKREeG3
         /x/90BvPJBtWuAegRV+AT9lns3kpgFqWoIg+qBOLkZhjPnCfYXWZEq8bL4be8T6+s2dy
         WzCa7BTFfc+xufnXPEoKyXrwzMAnzgAMYknIeRBS49EdLWX7f8TXZbfiFf5/zGJX16kL
         BfzA==
X-Forwarded-Encrypted: i=1; AKwUvByfnFr4HzuCpx1jHlbr7RpN37D3EtVfSd2bBLEauBrI/GXQgB0IQyUAQd4wFTm8emruLzEQQ/YCKA==@vger.kernel.org
X-Gm-Message-State: AFq9FYIq4jzOJPHbi+BQjgW55fOB2blODq/mj44nJsmKQ98o10r6aDV1
	eGOYaMjqs0FvthwcBO3QFEvrqP3f0BV+jEEgu7HOl1BVXxkdvKbY58Fi0iWU1rOC7KoqV/hS2Sr
	n8FQ=
X-Gm-Gg: AYBFou0Qtf8Y3gijHUkzvK/qASI7MGlPE7/nZ2bWiqm6L0SDVjtZFzROF0Dqr5NOLi7
	fV440T6e+Go8ElvL3mpb0XFWygzzVyoKmdxN2awYAeWAO3smjPHWEci1iDLOhkZLpKd3hAzhv5Z
	gTPjB412OwhwXMjtJln17fVVbqCjeEDJG3LhrwpW7KFhdS7zfoBxpmXX9tWAjO/gjW/XbHrMGfS
	zoLteG8oVDtH/ME1ENtQc5U/6sZoNMErV4absEReggzA3BMaNcwSFP/G1fSNhSRiBXslC6+gJBM
	xqBavotTfSEPUdfZAYYTbiyVRSf7pyUGwYdcgufv2N9gBD0/uOA7rDuwNEzd2zfmiN1wwTNZ5S6
	VWLXkP6fB2fHyKTAKOJtbuU7BpJra4deHQELEQbneRqwkN64ovXQY31ymZuQU4Cpw9mhhmh3K8W
	K+4vLZP4yPwP5ocWZ9Sfjj/5J2Q19ziSQo9n1L/1tzhuSEyO43Hi5euJDsWSFj/Rn/fOUn6fsaC
	RIWYx5fM7exr46Iat5z26KN45RX4PI6DnW6yc2PsDF05BSxxUVzEGUeeW9zxSjMWjhpNUy94fVf
	8scSH2Q94USVSOeA24I=
X-Received: by 2002:a05:7301:618e:10b0:35f:8c5d:5927 with SMTP id 5a478bee46e88-3674cf3715emr5200368eec.14.1792627278783;
        Wed, 21 Oct 2026 17:01:18 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-36741e71eaesm22639722eec.26.2026.10.21.17.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:18 -0700 (PDT)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/17] iio: accel: mma955x: Discard pm_runtime_put_autosuspend() return values
Date: Wed, 21 Oct 2026 16:57:05 -0700
Message-ID: <20261021165858.v2.4.Ie9a9de6adbe98d063c6c45b2f59e143303586067@changeid>
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

These drivers propagate the return value of
pm_runtime_put_autosuspend(), which is not particularly useful.

Returning an error code from pm_runtime_put_autosuspend() merely means
that it has not queued up a timer or work item to check whether or not
the device can be suspended and there are many perfectly valid
situations in which that can happen, like after writing "on" to the
device's runtime PM "control" attribute in sysfs for one example.

For this reason, modify these drivers to simply discard the
pm_runtime_put_autosuspend() return value, and inline the pm_runtime
helpers now that they behave the same with and without CONFIG_PM.

While at it, I see that mma9553_write_event_config() mismanages the
runtime PM reference count. It should only put() a reference after it's
done touching the hardware, not before. Resolve this ordering issue.

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Split iio patch into per-driver patches
 * Inlining
 * Refcount ordering

 drivers/iio/accel/mma9551.c      | 21 +++++++++--------
 drivers/iio/accel/mma9551_core.c | 39 ++++----------------------------
 drivers/iio/accel/mma9551_core.h |  1 -
 drivers/iio/accel/mma9553.c      | 36 ++++++++++++++++++++---------
 4 files changed, 42 insertions(+), 55 deletions(-)

diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
index 182f488edab1..4c549fb106bc 100644
--- a/drivers/iio/accel/mma9551.c
+++ b/drivers/iio/accel/mma9551.c
@@ -71,9 +71,11 @@ static int mma9551_read_incli_chan(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	ret = mma9551_set_power_state(client, true);
-	if (ret < 0)
+	ret = pm_runtime_resume_and_get(&client->dev);
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to resume: %d\n", ret);
 		return ret;
+	}
 
 	ret = mma9551_read_status_byte(client, MMA9551_APPID_TILT,
 				       reg_addr, &angle);
@@ -96,7 +98,7 @@ static int mma9551_read_incli_chan(struct i2c_client *client,
 	ret = IIO_VAL_INT;
 
 out_poweroff:
-	mma9551_set_power_state(client, false);
+	pm_runtime_put_autosuspend(&client->dev);
 	return ret;
 }
 
@@ -178,9 +180,7 @@ static int mma9551_config_incli_event(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		ret = mma9551_set_power_state(data->client, false);
-		if (ret < 0)
-			return ret;
+		pm_runtime_put_autosuspend(&data->client->dev);
 	} else {
 		int bitnum;
 
@@ -200,15 +200,18 @@ static int mma9551_config_incli_event(struct iio_dev *indio_dev,
 		}
 
 
-		ret = mma9551_set_power_state(data->client, true);
-		if (ret < 0)
+		ret = pm_runtime_resume_and_get(&data->client->dev);
+		if (ret < 0) {
+			dev_err(&data->client->dev, "failed to resume: %d\n",
+				ret);
 			return ret;
+		}
 
 		ret = mma9551_gpio_config(data->client,
 					  (enum mma9551_gpio_pin)mma_axis,
 					  MMA9551_APPID_TILT, bitnum, 0);
 		if (ret < 0) {
-			mma9551_set_power_state(data->client, false);
+			pm_runtime_put_autosuspend(&data->client->dev);
 			return ret;
 		}
 	}
diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
index 2ccb1fb19b96..68df195d5b24 100644
--- a/drivers/iio/accel/mma9551_core.c
+++ b/drivers/iio/accel/mma9551_core.c
@@ -654,37 +654,6 @@ int mma9551_set_device_state(struct i2c_client *client, bool enable)
 }
 EXPORT_SYMBOL_NS(mma9551_set_device_state, "IIO_MMA9551");
 
-/**
- * mma9551_set_power_state() - sets runtime PM state
- * @client:	I2C client
- * @on:		Use true to power on device, false to power off
- *
- * Resume or suspend the device using Runtime PM.
- * The device will suspend after the autosuspend delay.
- *
- * Returns: 0 on success, negative value on failure.
- */
-int mma9551_set_power_state(struct i2c_client *client, bool on)
-{
-#ifdef CONFIG_PM
-	int ret;
-
-	if (on)
-		ret = pm_runtime_resume_and_get(&client->dev);
-	else
-		ret = pm_runtime_put_autosuspend(&client->dev);
-	if (ret < 0) {
-		dev_err(&client->dev,
-			"failed to change power state to %d\n", on);
-
-		return ret;
-	}
-#endif
-
-	return 0;
-}
-EXPORT_SYMBOL_NS(mma9551_set_power_state, "IIO_MMA9551");
-
 /**
  * mma9551_sleep() - sleep
  * @freq:	Application frequency
@@ -741,9 +710,11 @@ int mma9551_read_accel_chan(struct i2c_client *client,
 		return -EINVAL;
 	}
 
-	ret = mma9551_set_power_state(client, true);
-	if (ret < 0)
+	ret = pm_runtime_resume_and_get(&client->dev);
+	if (ret < 0) {
+		dev_err(&client->dev, "failed to resume: %d\n", ret);
 		return ret;
+	}
 
 	ret = mma9551_read_status_word(client, MMA9551_APPID_AFE,
 				       reg_addr, &raw_accel);
@@ -755,7 +726,7 @@ int mma9551_read_accel_chan(struct i2c_client *client,
 	ret = IIO_VAL_INT;
 
 out_poweroff:
-	mma9551_set_power_state(client, false);
+	pm_runtime_put_autosuspend(&client->dev);
 	return ret;
 }
 EXPORT_SYMBOL_NS(mma9551_read_accel_chan, "IIO_MMA9551");
diff --git a/drivers/iio/accel/mma9551_core.h b/drivers/iio/accel/mma9551_core.h
index 543454a31dc0..1d55fdfd0a92 100644
--- a/drivers/iio/accel/mma9551_core.h
+++ b/drivers/iio/accel/mma9551_core.h
@@ -62,7 +62,6 @@ int mma9551_gpio_config(struct i2c_client *client, enum mma9551_gpio_pin pin,
 			u8 app_id, u8 bitnum, int polarity);
 int mma9551_read_version(struct i2c_client *client);
 int mma9551_set_device_state(struct i2c_client *client, bool enable);
-int mma9551_set_power_state(struct i2c_client *client, bool on);
 void mma9551_sleep(int freq);
 int mma9551_read_accel_chan(struct i2c_client *client,
 			    const struct iio_chan_spec *chan,
diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 5a36d415a837..2ccb68dfbcd4 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -610,10 +610,16 @@ static int mma9553_write_raw(struct iio_dev *indio_dev,
 		if (data->stepcnt_enabled == !!val)
 			return 0;
 		mutex_lock(&data->mutex);
-		ret = mma9551_set_power_state(data->client, val);
-		if (ret < 0) {
-			mutex_unlock(&data->mutex);
-			return ret;
+		if (val) {
+			ret = pm_runtime_resume_and_get(&data->client->dev);
+			if (ret < 0) {
+				dev_err(&data->client->dev,
+					"failed to resume: %d\n", ret);
+				mutex_unlock(&data->mutex);
+				return ret;
+			}
+		} else {
+			pm_runtime_put_autosuspend(&data->client->dev);
 		}
 		data->stepcnt_enabled = val;
 		mutex_unlock(&data->mutex);
@@ -737,24 +743,32 @@ static int mma9553_write_event_config(struct iio_dev *indio_dev,
 
 	mutex_lock(&data->mutex);
 
-	ret = mma9551_set_power_state(data->client, state);
-	if (ret < 0)
-		goto err_out;
+	if (state) {
+		ret = pm_runtime_resume_and_get(&data->client->dev);
+		if (ret < 0) {
+			dev_err(&data->client->dev, "failed to resume: %d\n",
+				ret);
+			goto err_out;
+		}
+	}
+
 	event->enabled = state;
 
 	ret = mma9553_conf_gpio(data);
 	if (ret < 0)
 		goto err_conf_gpio;
 
+	if (!state)
+		pm_runtime_put_autosuspend(&data->client->dev);
+
 	mutex_unlock(&data->mutex);
 
 	return 0;
 
 err_conf_gpio:
-	if (state) {
-		event->enabled = false;
-		mma9551_set_power_state(data->client, false);
-	}
+	if (state)
+		pm_runtime_put_autosuspend(&data->client->dev);
+	event->enabled = !state;
 err_out:
 	mutex_unlock(&data->mutex);
 	return ret;
-- 
2.56.0.218.g1ec904b173-goog

