Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627309;
	b=nGfczZ3xRfRpW5HqEPjX3ZHG/g06apMHRoDIP4jJvZ6JIbIHzGooQyeM9wH/1m8gIIKh
	 zV/XMmgW4q0Uqi/Hz/PlUou/GYvc926zZmHlExB0kGZDkVcfY3Ze6FKl8disV8b8kaoi9
	 Yrr3mII6LFyYAMuIE7KJXoZN+hDUGPwM30zhdpYBYSKXU9RJIRgzJ6b6pr4t4+VCeLgGC
	 XQ//v12kZBtP5GAX8VahFd63gtOIwNaSNsWdKlQgLbeikg6AL45NeYWZB5PhN+ktxvvAk
	 6T6ENOjCVyrMfvbZYND47mhPIZlwNPPDErexNqGv78PKvPinTfR7C0NfzyrJkyH2qhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627309;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=blXYgQJJBizz/bz/KIQMetOyL/YCHKq3pY30hwAK25M=;
	b=S5lsHP8itFgSwcDOlkaq+PUwjS83fdME8RdPWlZFCcNIkzGLIHANtTvQ4zJxPJJ95X9O
	 NklMu4Ax5F3rMIHsDVpwcl/MGkywGDFa3jFVtJ14PfSI6/8yrT10YesNaz3bK/N7eU7Dc
	 ZpRaMaz2C5RlNOkM5iHl7LeKAY7CTfFifPaDH7ttsaGyf+h1bQCDvm7+tWmaRfsU4xlz3
	 7/Qg8swmgdIUqSoKGf+ml0QISyFgmQ8PW/FBb1tini/xR2KYnGVhzLt/arM8DtAJSJ9pO
	 Ae9iN5wfa0UqY1ZTm0joOWRC83+hXHV24GLARVcaFHTItrugLBqFU1yUzojxs02Y6WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=NelsS96C;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5739860A2619
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 00:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5739860A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=NelsS96C
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso2235582eec.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 17:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627307; x=1793232107; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=blXYgQJJBizz/bz/KIQMetOyL/YCHKq3pY30hwAK25M=;
        b=NelsS96C6bj2mZywfkxDxSnUjkXtFur6XMZuZtSmnKGE9qGz208ajyJZwN/WEP8Obs
         anrHJKyf7UmvRRRzyIo46WLiZPaea20IsdzILDfOpEAFyprvGcC7Yyr7ub5QupGdFQN/
         Yrzx/SaJtWDcDapVW1fZIa+/KRsnLYGwgvRj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627307; x=1793232107;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=blXYgQJJBizz/bz/KIQMetOyL/YCHKq3pY30hwAK25M=;
        b=1OdkoHpNfDBZH6RJWouC8nXejabSVLPMOitFy/eedEHoR55oHVWI9ZKK91d0WLeakw
         3pEktwyqOv79wfC7uUApJBAG4+fGUoFWPWUlwHhUOTY7yM9HgC6Wh42sjxw/HGbnYIn0
         W1RtLFuLmkJ5nB83wa4B0bFyOW9ZIE89GOaHS/JiIDqV/4rnYn58Eo31+ykkUPdRU0Un
         ZfXnFfiTmoLOW9RT3vnIXNy885U/YvldfJvAFGVkBSWlJsFIadLhblfymHdTv4CJRdSP
         IgxblnIxeHCFrZfAypFRMn6PRMalpWlxFoQGioz23Sjj4N9h1tm9nh8YLr/4FpclYi8a
         BPIg==
X-Forwarded-Encrypted: i=1; AKwUvBymCi6iavRqEZAEzhPMGAWUM4tbpwqkQawPpcC6ZYQCxXsW+bdZK/mYzNGp53jAmseXDRd4ZEkg2A==@vger.kernel.org
X-Gm-Message-State: AFq9FYLDf2l0U5Q2nDrUyOyjQJN3fcFfj/canVHeBcpkhPM3YELZB7qg
	X5q5B/BcMtkBtJyNJH+EilMkgVoSJKL/sxZoOP6pKlzbZTNj2ptf1j12ikOh9BLUFQ==
X-Gm-Gg: AYBFou2W5ZUQA0EJ1OB+HlvqKH+0/xcxrES9pH2jwy/tuYKziAx4SWdnGONWZQ/kWIN
	fbUk/oaK3P9LAXkuISDEx4Z3IuPBuUezgZB0vy9p+G7KJzsSKMvhlcCmIhgr/nA0Eep0fVVNJT9
	zBYUgXHoLmFroxZbnC+Aa/0MEGcf0wP9VU80ezVcjfx+4/X981xlP9VgZf9w/HAlL4MOgYaYke/
	+qVVVR1qXb3L+I75EblkAHY3LQBkmeVVEAi/8OO0yoTGOcuf7p2ZavuDD+v+T++aldStEz3Dj5g
	lJ4nmFs2QrPHHBQg6HQpmpfUqgGImyXwpvfu/c0K6HQ94ZY3eTEAJ+M8ROo7Axwev+AUEwh/ydk
	/pN0Nn7eOkt1Y6lgJbx8g7je96/EySGiZqM9ougxLce1iacBMU15ezcoUi13F/xqNo6JjAh5bzi
	73n8gjdlbinyxgtqCZXEr07fO7FqmbofJQgdgDD9tVTSCBb6gEHFL5SYu4jWa3fPCozR3qo52Yy
	EjEr4/NAr2Sgkrn0JoHihD3nhFqAPKnpM/BsvswRpMn2N4E0ujuf1GrpLH9bAfZSP99dOc2sF5n
	SIVar25yiNX4fS1RDfc=
X-Received: by 2002:a05:7301:e2e:b0:368:8d1d:2a81 with SMTP id 5a478bee46e88-3688d1d2d90mr1563701eec.24.1792627307305;
        Wed, 21 Oct 2026 17:01:47 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-36740cc848fsm10851892eec.13.2026.10.21.17.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:46 -0700 (PDT)
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
Subject: [PATCH v2 15/17] iio: light: rpr0521: Discard pm_runtime_put_autosuspend() return values
Date: Wed, 21 Oct 2026 16:57:16 -0700
Message-ID: <20261021165858.v2.15.I31ffc98637199185bab952631d880c1d38d64b7c@changeid>
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
pm_runtime_put_autosuspend() return value.

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Split iio patch into per-driver patches
 * Simplify some conditional logic

 drivers/iio/light/rpr0521.c | 57 ++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 7d82efc31f3a..6305d7a9c282 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -357,32 +357,31 @@ static int rpr0521_set_power_state(struct rpr0521_data *data, bool on,
 	 * Note: If either measurement is re-enabled before _suspend(),
 	 * both stay enabled until _suspend().
 	 */
-	if (on)
-		ret = pm_runtime_resume_and_get(&data->client->dev);
-	else
-		ret = pm_runtime_put_autosuspend(&data->client->dev);
+	if (!on) {
+		pm_runtime_put_autosuspend(&data->client->dev);
+
+		return 0;
+	}
+
+	ret = pm_runtime_resume_and_get(&data->client->dev);
 	if (ret < 0) {
-		dev_err(&data->client->dev,
-			"Failed: rpr0521_set_power_state for %d, ret %d\n",
-			on, ret);
+		dev_err(&data->client->dev, "Failed to resume: %d\n", ret);
 		return ret;
 	}
 
-	if (on) {
-		/* If _resume() was not called, enable measurement now. */
-		if (data->als_ps_need_en) {
-			ret = rpr0521_als_enable(data, RPR0521_MODE_ALS_ENABLE);
-			if (ret)
-				return ret;
-			data->als_ps_need_en = false;
-		}
+	/* If _resume() was not called, enable measurement now. */
+	if (data->als_ps_need_en) {
+		ret = rpr0521_als_enable(data, RPR0521_MODE_ALS_ENABLE);
+		if (ret)
+			return ret;
+		data->als_ps_need_en = false;
+	}
 
-		if (data->pxs_ps_need_en) {
-			ret = rpr0521_pxs_enable(data, RPR0521_MODE_PXS_ENABLE);
-			if (ret)
-				return ret;
-			data->pxs_ps_need_en = false;
-		}
+	if (data->pxs_ps_need_en) {
+		ret = rpr0521_pxs_enable(data, RPR0521_MODE_PXS_ENABLE);
+		if (ret)
+			return ret;
+		data->pxs_ps_need_en = false;
 	}
 #endif
 	return 0;
@@ -545,17 +544,14 @@ static int rpr0521_buffer_preenable(struct iio_dev *indio_dev)
 
 static int rpr0521_buffer_postdisable(struct iio_dev *indio_dev)
 {
-	int err;
 	struct rpr0521_data *data = iio_priv(indio_dev);
 
 	mutex_lock(&data->lock);
-	err = rpr0521_set_power_state(data, false,
-		(RPR0521_MODE_PXS_MASK | RPR0521_MODE_ALS_MASK));
+	rpr0521_set_power_state(data, false,
+				RPR0521_MODE_PXS_MASK | RPR0521_MODE_ALS_MASK);
 	mutex_unlock(&data->lock);
-	if (err)
-		dev_err(&data->client->dev, "_buffer_postdisable fail\n");
 
-	return err;
+	return 0;
 }
 
 static const struct iio_buffer_setup_ops rpr0521_buffer_setup_ops = {
@@ -718,12 +714,7 @@ static int rpr0521_read_info_raw(struct rpr0521_data *data,
 	ret = regmap_bulk_read(data->regmap,
 			       rpr0521_data_reg[chan->address].address,
 			       &raw_data, sizeof(raw_data));
-	if (ret < 0) {
-		rpr0521_set_power_state(data, false, device_mask);
-		return ret;
-	}
-
-	ret = rpr0521_set_power_state(data, false, device_mask);
+	rpr0521_set_power_state(data, false, device_mask);
 	if (ret < 0)
 		return ret;
 
-- 
2.56.0.218.g1ec904b173-goog

