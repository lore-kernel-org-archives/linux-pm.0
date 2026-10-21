Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627287;
	b=UQ7r3D6wwFu8KYyFiO2qHfUqKU6mjCdHpeVzy2ryPep1a8jQv8l/VzsUZ6Zdg2kH76f0
	 rRsdToeWP0vvrY2SAsib9fcox77ra4V1mTll1CTz3j76yFWEEon0d9HRVBG5X6juw3xr0
	 /FkNp/TbQ6y3rcBT4IC4NWAulNfnfIUaIMYDJOiXd8u1/q7tI065tvXEbcghw05uN9vF0
	 WSzy1aDyoZ/zAq9b0PWoCJWaLdD95ZJudjxHTWC0JEexwkiwHB7dk5kSUbRDwSbIwm9tC
	 vWvvQY1hI2IAklu3WSIH9wc0+adXlK1mHlzAC4jiMpJLxRKWp85qQt6vY1ntzK1vB8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627287;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1uqPCq3qxm+fw1hPGBE2UXSjTZOflrZR/TS0Ft0vAgA=;
	b=QVDE+IZgqqbnnXyQC5v2cpO0PmnGTjbAVa5xwAcJwQSNEmhmXhKQ0I0SaGRPdnw6vL8X
	 x5mR+ZsVzeh3Ca89YtlFnXB/kPlKfBEHjk9wH+RLmkKfOytjzsmNj12TxTxTCVR5atG2B
	 JEV53cIcXSoJwaRD81+VDAZzkzAjFmyeSNdIXc4pndYjX0kkuYRlqki/HCwLLl9U0viXN
	 eE4RsOUfSnjbbDSlWFC9xu1APLCCmk+Hj1K4nS1CBEYxeHQ4KOId3fDvYYl487mxOFzrr
	 ouBsDtYsmi1g1SU+OSM/LNbCgIzluCfg3WK136CYUwlbxi3ERBsjjk5ovYMlfEpug/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="buQiQ/D3";
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054C0606A32F
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 00:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 054C0606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=buQiQ/D3
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-35c76e9614aso2320829eec.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 17:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627286; x=1793232086; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1uqPCq3qxm+fw1hPGBE2UXSjTZOflrZR/TS0Ft0vAgA=;
        b=buQiQ/D3DAXlEypzLtAc/t9usf8mNTUED8VNz4jhlaYhRYbrcB8G2APPcGr7JXYBdV
         z6cysmNgjTPY/AjuXOHTwA+xfg/2i/tYOGz4RyyEXjexC2X6BmAYFze6sZ2cYSaX9Xq9
         q7Yo4+2gAFIsEEy6rcf9nfXlWOKkDSqe4UmqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627286; x=1793232086;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1uqPCq3qxm+fw1hPGBE2UXSjTZOflrZR/TS0Ft0vAgA=;
        b=WSN7EoWdyY1qF2R2BA3Q2FxgMkHFepwdzqcxvaaySobzKS9Z0X4Jybsm8q9in9zLA1
         1/MUSzIFMpRctt482BWgBig4RimoHH+OlM3G9/yfuxluVs3TIGaH3oOB6P3TSwmqJaoG
         Hnt/e6eFTpKzsf1MFa6y1AN5u0O3Fj0Swyptar95fZZISH+fYDF3+rNgFJZC6jz1GuGU
         oBi1fVIGBLVGlNAJkoiFxvRlhdvvQFKHiSKEaS2hZMG2p3luDFr5WVoDiFenC/kkqW1H
         J9uYANEBzI+OyDicIP3I23w5BJValzBuqB/YeL5Z292uMe6tCIxYOzj6/thPQHQbBljR
         ANjA==
X-Forwarded-Encrypted: i=1; AKwUvByZ8glOe7IQMke96SwU3V8zvDKUzo9+tRV5NkF4uST1Zp3NKhlGtwt0tmnyhAjoQIAczxvIO00iXg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIZXPZb97lR0b/2MHc20dkq5hT27n2qp0t1JObzJ0vAq1EC0+KH
	cNFfuiVsuh0VfzXd4p5paLbfxNPawKPX+5G/+cfwowUXSRUT0JfmFIZCTUuh7vWQIw==
X-Gm-Gg: AYBFou2IdvQb/XMMudEvLA9eE1VJpoIMdRDCpwVHfrpZFkeAzkiYEIvDoUnMcGnzzub
	Vp1WH3pYxJgnQfs4k/2hugkJ2ihkCvhh8/Yr6v4G5wSc53EvS2IPSx5kDXAdSbHQhhzDmkChs+k
	bOQjXEzxbnvE9umaWAvIDdjkmdiwche5kT5fz6MUrZPPN5tQMjasEcZOxNf5xVaiMNtK0pvFJxF
	6pCTh+1870bYu6csfrUspKEFIcFfXS2J2JbF3bsc3JUpgq+RHncAA5cPA/OmbMfA9Azvkdsr+ao
	xAOb50Am7amvYUWP+YJffDJXigrvOntXQFAGMgkTgrm/PjoRyW6h8ke2j4QMhzGwOyGh+h83+7n
	HddR8WQaSAy6ImVoRTjjIW9GoNHa2lJwSbstesgztT6yKAho9hP5e56BUQ+QNPg7Ku5SJyeVyBa
	OjbH2yWlDnTHP5h5BlHo9y4fVBMd8WjG4TLZqNH0SYm5oTwdyPkbWs6BPBKi8Qi/oIwJBHBdMjb
	529Rsn9023j1bD+HvYcEcXwXio5KJHn407aG+DymtASwdJ3GUrC0bxibkgcqXuFs7KuaMx8hQx+
	xQBfq217YV6pesHzc9JwXoEqTqCl0+5EjhaA2vBT
X-Received: by 2002:a05:693c:41c2:20b0:366:2893:7429 with SMTP id 5a478bee46e88-3674e0501e2mr4574299eec.24.1792627285985;
        Wed, 21 Oct 2026 17:01:25 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-3674198f1d8sm15879892eec.24.2026.10.21.17.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:25 -0700 (PDT)
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
Subject: [PATCH v2 07/17] iio: adc: ti-ads1015: Discard pm_runtime_put_autosuspend() return values
Date: Wed, 21 Oct 2026 16:57:08 -0700
Message-ID: <20261021165858.v2.7.Ib4e8fc11192ec5721b98bd85fa9a68d3349ba9e8@changeid>
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
pm_runtime_put_autosuspend() return value. Inline
ads1015_set_power_state() while we're at it, since its behavior is now
the same with and without CONFIG_PM, and it is otherwise trivial.

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Split iio patch into per-driver patches
 * Inlining

 drivers/iio/adc/ti-ads1015.c | 50 +++++++++++++-----------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 0f9244107c6d..a677ec7abda2 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -367,30 +367,6 @@ static const struct iio_chan_spec tla2024_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(ADS1015_TIMESTAMP),
 };
 
-
-#ifdef CONFIG_PM
-static int ads1015_set_power_state(struct ads1015_data *data, bool on)
-{
-	int ret;
-	struct device *dev = regmap_get_device(data->regmap);
-
-	if (on)
-		ret = pm_runtime_resume_and_get(dev);
-	else
-		ret = pm_runtime_put_autosuspend(dev);
-
-	return ret < 0 ? ret : 0;
-}
-
-#else /* !CONFIG_PM */
-
-static int ads1015_set_power_state(struct ads1015_data *data, bool on)
-{
-	return 0;
-}
-
-#endif /* !CONFIG_PM */
-
 static
 int ads1015_get_adc_result(struct ads1015_data *data, int chan, int *val)
 {
@@ -533,26 +509,29 @@ static int ads1015_read_avail(struct iio_dev *indio_dev,
 static int __ads1015_read_info_raw(struct ads1015_data *data,
 				   struct iio_chan_spec const *chan, int *val)
 {
+	struct device *dev = regmap_get_device(data->regmap);
 	int ret;
 
 	if (ads1015_event_channel_enabled(data) &&
 	    data->event_channel != chan->address)
 		return -EBUSY;
 
-	ret = ads1015_set_power_state(data, true);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
 		return ret;
 
 	ret = ads1015_get_adc_result(data, chan->address, val);
 	if (ret < 0) {
-		ads1015_set_power_state(data, false);
+		pm_runtime_put_autosuspend(dev);
 		return ret;
 	}
 
 	*val = sign_extend32(*val >> chan->scan_type.shift,
 			     chan->scan_type.realbits - 1);
 
-	return ads1015_set_power_state(data, false);
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
 }
 
 static int ads1015_read_raw(struct iio_dev *indio_dev,
@@ -708,6 +687,7 @@ static int ads1015_read_event_config(struct iio_dev *indio_dev,
 static int ads1015_enable_event_config(struct ads1015_data *data,
 	const struct iio_chan_spec *chan, int comp_mode)
 {
+	struct device *dev = regmap_get_device(data->regmap);
 	int low_thresh = data->thresh_data[chan->address].low_thresh;
 	int high_thresh = data->thresh_data[chan->address].high_thresh;
 	int ret;
@@ -736,7 +716,7 @@ static int ads1015_enable_event_config(struct ads1015_data *data,
 	if (ret)
 		return ret;
 
-	ret = ads1015_set_power_state(data, true);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
 		return ret;
 
@@ -745,7 +725,7 @@ static int ads1015_enable_event_config(struct ads1015_data *data,
 	ret = ads1015_get_adc_result(data, chan->address, &val);
 	if (ret) {
 		ads1015_event_channel_disable(data, chan->address);
-		ads1015_set_power_state(data, false);
+		pm_runtime_put_autosuspend(dev);
 	}
 
 	return ret;
@@ -775,7 +755,9 @@ static int ads1015_disable_event_config(struct ads1015_data *data,
 
 	ads1015_event_channel_disable(data, chan->address);
 
-	return ads1015_set_power_state(data, false);
+	pm_runtime_put_autosuspend(regmap_get_device(data->regmap));
+
+	return 0;
 }
 
 static int ads1015_write_event_config(struct iio_dev *indio_dev,
@@ -836,12 +818,16 @@ static int ads1015_buffer_preenable(struct iio_dev *indio_dev)
 	if (ads1015_event_channel_enabled(data))
 		return -EBUSY;
 
-	return ads1015_set_power_state(iio_priv(indio_dev), true);
+	return pm_runtime_resume_and_get(regmap_get_device(data->regmap));
 }
 
 static int ads1015_buffer_postdisable(struct iio_dev *indio_dev)
 {
-	return ads1015_set_power_state(iio_priv(indio_dev), false);
+	struct ads1015_data *data = iio_priv(indio_dev);
+
+	pm_runtime_put_autosuspend(regmap_get_device(data->regmap));
+
+	return 0;
 }
 
 static const struct iio_buffer_setup_ops ads1015_buffer_setup_ops = {
-- 
2.56.0.218.g1ec904b173-goog

