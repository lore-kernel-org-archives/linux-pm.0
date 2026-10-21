Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627303;
	b=QvC29vHuSzzFkDCMQEPc0rdTJ+k+3bTOUZTFtkbj8jyNuDZOyYEs7neCAl90JjUlxB1q
	 dupe2P7LGzQhwFnuKupxJ9UwmJNHBdYaAcwOsBWhbnbcXeZiqMc2dhSz1KRRa1JO3ZGRk
	 oGp8Ryc5kt6ysYbXD90f38U2vYlNNxlRqIKJ0zqJR3LJIA7E4YjA5GgM+NcrdGngMRSzz
	 hTJdqEJEI2xOKog27Y63ctLEmYkkyHvf9YEwQEEqFrQhretLjwPDnWni9iacBbzMXl7k3
	 a6Nk87ubLpG8AclQwRbnuVHzg/Ic8vFsZQ30j/c3df7MAEFZ7rnoXu0lHd9KaHccDsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xzFwmGHdlHCFeH91f0yXYoPTiWjKtDmQ9whoEi6CYmo=;
	b=mTy/naGFMuRy+ypW2Vy3ApsTBSxVSqAEt4GH7zq+vDM3p908+D76CxRTOswDqrqYhRi/
	 GAJ4QQ+tPcn4ocMuMWEklDtcumdzXgDCWFIfapjHHvl0s/xIQLibHXLynFHLUzIOu5HJJ
	 Zvu+pZTCOFWUPMyonYJyP7dDUe9zWjDFYgbcEDVrqW5paHoQcRVabd7jY/bf0DAyPUWFB
	 dE1PzJFCJppFpNWv4FOTa7AmiLxGXG3oaAJEByPO12IvEe16jC27lOWhpa8KGugkcNWoh
	 6lFfNJitVj6oSFPjAi0fWseXJ0Z3pHtq8hozFjpv5bHl6DQPT9hk6TpnAaUE3JvNTuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mfooWoBL;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853C560A4ACF
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 00:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 853C560A4ACF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=mfooWoBL
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35f036b17easo1570280eec.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 17:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627302; x=1793232102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xzFwmGHdlHCFeH91f0yXYoPTiWjKtDmQ9whoEi6CYmo=;
        b=mfooWoBLQ49R4W96lPj6ek9zouBwjFgjcwiTmjoQxjajp8opGZln+hCXXpdBbY31dH
         +W4/G9hlzQePAV0I9WZLPiq5sBTvZQ/eaOtSYfFa4jnH9Cb3/JLrJJPGb+7Jnb+ZI68/
         Ryj/1pPSfTyOoJcWR8luaUtueRELcPvDfUgqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627302; x=1793232102;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xzFwmGHdlHCFeH91f0yXYoPTiWjKtDmQ9whoEi6CYmo=;
        b=plEFiud/IW2ftL8jTj2UBRbjflrrsmzQqG2OfI9BVqkfkAinLK1d/8eDM4Sj4z65Jm
         7Gt2CW0k07VLBJx8HErMh7HoE7TpRhtGxV+UAgHy/1qtSMyDYARxah72rvZlUhXyKdVV
         FDa9Kg6jAcdBX4WmaQj9mzE1tH+9e7nZsJB4SaVTZMgJrWlUInmGYmXRv/uX12PgbT80
         Yd+IDav/J5Xhnt8eqXB9hDnjXkpG9QtYduZh7mMkTAHArFbTnXBBaJispZ1cvRzIOTP4
         9pLJ9P2wBoRWFuOhlbYKLg1CAk/W8rTfrrbzEYfl7uBA1oupFEQLUVzhBgZfqZtzstz0
         aaTg==
X-Forwarded-Encrypted: i=1; AKwUvBxQ/JvZMP3rU6+jxyO1kSPSh8Zp+kk1Dfigkt22vwkoYl2o8/QGq5wLFPeS2zMxSniAHIWxBEkIZw==@vger.kernel.org
X-Gm-Message-State: AFq9FYL6mximm6cKi8jNiC84tPkgUrRBOkzsCWLjh9a/thnzqVOtKwke
	qawOOVwvtZPzWCxHQqb1FAzF29lRwUXGL4uSg3b6IwW97osJypkgixLHZZdf8EJs3w==
X-Gm-Gg: AYBFou3hibx/AZIruhw9vinIDhnXy+JmHELQ+/j/8Qp/Ur33ln+LSPPkWm/9AtLLHuC
	G1X6Rk3qeI3WwbX6II9z8C8GhiMGi6fAZaqWXb61OSJ1F2UGDp4zlh301b/t9WRG0tYy3p3QNxX
	GYxhefV1v0aTj+mkdA1qmmsbJ6iVJqDRlKpp2mX4fSqrobK+56Pet/sUDleOc3THuVZl63NSPRj
	+t0kzb3/bO1326lxY/7kHj3BMJb3fNmfpkuGnznylAnWZHUS8Z/MSUZyXAOrBBpiQhEPIawVQt+
	d3ClVrpRdM5Xp5CEdlGnfzEtkFSKSIFFtnwZAtZ/Zju3uvqJESxX8XAHZeSVjRq3Xzsl4fTIyVr
	TuiFqo1l1s/Y+I2gAUn7lpd5tNGcJ+Pfmt7x6po9TjZkQVhieAdoqHFEYgMO70yO0gPoDQoYPQg
	A9LMHwUU0wtCan9uoPjCSKafvKSE1gkhSpDOMAlik4XwrPrBKdO1dZ1YVQ5BTe/yu8/KVziszVq
	URgDfdIyFWO0Ny/Xn+YLBKHJ9WPirQUwftNyw5Iea0ud6eEWfNMEwlqhvHOqL+CtpeMW/WUtk33
	5pkY2OyZmnIvOm1oc0k=
X-Received: by 2002:a05:693c:864e:10b0:351:7444:8bfd with SMTP id 5a478bee46e88-367508e2cfemr5263895eec.39.1792627301575;
        Wed, 21 Oct 2026 17:01:41 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-36741e71eaesm22647177eec.26.2026.10.21.17.01.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:40 -0700 (PDT)
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
Subject: [PATCH v2 13/17] iio: light: apds9960: Discard pm_runtime_put_autosuspend() return values
Date: Wed, 21 Oct 2026 16:57:14 -0700
Message-ID: <20261021165858.v2.13.Ic0c3be7c36a602e32c04628d5ae5692556742fa8@changeid>
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
pm_runtime_put_autosuspend() return value. Inline the "off" helper, as
it's trivial now, and rename to apds9960_power_on().

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
I'm not sure if apds9960_write_event_config()'s existing logic is
correct, but I don't want to mess with it.

Changes in v2:
 * Split iio patch into per-driver patches
 * Inline the put() helper

 drivers/iio/light/apds9960.c | 48 ++++++++++++++----------------------
 1 file changed, 18 insertions(+), 30 deletions(-)

diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index afe520de60e2..0e084ffba1a6 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -476,38 +476,23 @@ static int apds9960_set_als_gain(struct apds9960_data *data, int val)
 	return ret;
 }
 
-#ifdef CONFIG_PM
-static int apds9960_set_power_state(struct apds9960_data *data, bool on)
+static void apds9960_power_on(struct apds9960_data *data)
 {
 	struct device *dev = &data->client->dev;
-	int ret = 0;
+	int suspended;
 
 	mutex_lock(&data->lock);
 
-	if (on) {
-		int suspended;
-
-		suspended = pm_runtime_suspended(dev);
-		ret = pm_runtime_get_sync(dev);
+	suspended = pm_runtime_suspended(dev);
+	pm_runtime_get_sync(dev);
 
-		/* Allow one integration cycle before allowing a reading */
-		if (suspended)
-			usleep_range(data->als_adc_int_us,
-				     APDS9960_MAX_INT_TIME_IN_US);
-	} else {
-		ret = pm_runtime_put_autosuspend(dev);
-	}
+	/* Allow one integration cycle before allowing a reading */
+	if (suspended)
+		usleep_range(data->als_adc_int_us,
+			     APDS9960_MAX_INT_TIME_IN_US);
 
 	mutex_unlock(&data->lock);
-
-	return ret;
 }
-#else
-static int apds9960_set_power_state(struct apds9960_data *data, bool on)
-{
-	return 0;
-}
-#endif
 
 static int apds9960_read_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
@@ -522,7 +507,7 @@ static int apds9960_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		apds9960_set_power_state(data, true);
+		apds9960_power_on(data);
 		switch (chan->type) {
 		case IIO_PROXIMITY:
 			ret = regmap_read(data->regmap, chan->address, val);
@@ -540,7 +525,7 @@ static int apds9960_read_raw(struct iio_dev *indio_dev,
 		default:
 			ret = -EINVAL;
 		}
-		apds9960_set_power_state(data, false);
+		pm_runtime_put_autosuspend(&data->client->dev);
 		break;
 	case IIO_CHAN_INFO_INT_TIME:
 		/* RGB + ALS sensors only have integration time */
@@ -767,7 +752,6 @@ static int apds9960_write_event_config(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 		data->pxs_int = state;
-		apds9960_set_power_state(data, state);
 		break;
 	case IIO_INTENSITY:
 		if (data->als_int == state)
@@ -777,12 +761,16 @@ static int apds9960_write_event_config(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 		data->als_int = state;
-		apds9960_set_power_state(data, state);
 		break;
 	default:
 		return -EINVAL;
 	}
 
+	if (state)
+		apds9960_power_on(data);
+	else
+		pm_runtime_put_autosuspend(&data->client->dev);
+
 	return 0;
 }
 
@@ -1078,7 +1066,7 @@ static int apds9960_probe(struct i2c_client *client)
 	pm_runtime_set_autosuspend_delay(&client->dev, 5000);
 	pm_runtime_use_autosuspend(&client->dev);
 
-	apds9960_set_power_state(data, true);
+	apds9960_power_on(data);
 
 	ret = apds9960_regfield_init(data);
 	if (ret)
@@ -1105,12 +1093,12 @@ static int apds9960_probe(struct i2c_client *client)
 	if (ret)
 		goto error_power_down;
 
-	apds9960_set_power_state(data, false);
+	pm_runtime_put_autosuspend(&client->dev);
 
 	return 0;
 
 error_power_down:
-	apds9960_set_power_state(data, false);
+	pm_runtime_put_autosuspend(&client->dev);
 
 	return ret;
 }
-- 
2.56.0.218.g1ec904b173-goog

