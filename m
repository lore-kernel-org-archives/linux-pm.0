Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792627305;
	b=XBhRrGIIQFsy6fkn9UJtJ7tsRW8sSl+eQGOdQc6Gz+HvZhhX6QBNjturJ+g8p2FIhX33
	 Pf8XBNgY4e6WR28I+A0IJl4paS4y1h0FoH3LLuJndm/KtpNsV1LJ5T/nAI8Z7Bnp37B4A
	 ilShqR8CSiWrj2C8w3s3b8My//1m0OSO38tv3bzqgx3a6i/jjbB7zuW0NUSNICjAU5/dW
	 SaC5exVYie1i1zjJIGaU6le/E3g9OBdEA7NMupF6Z05DR9Ke3HuFmwh+9rgZWgRXoQyCL
	 la4PVqk7psDWpDbzsu/MJFvb9O0cqkcFPZpvzThCQ9wYGkhlsTXjQwdY7mMab5fBH+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792627305;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hvZJAGJoNW9px1hCT4jyVbr/7Ym3LMfNBDMY5M42JDI=;
	b=Ypo/w5v2Kp1fwQBTBVW4dnmXdvEB5tUaVRK/cuPRHLwrPdlfES5MDVjiDQFcygBQJcDw
	 1huviIkuWKOXDxKufGQmZFUGfxuDOup7xHFrPjNn2sp3PO9Udlv8KBPjxxAQsGCoNm7qI
	 1T0DbmpM4IRtkzxuIFBmB27TvQCrJEYcCXupNv8mmrYVRvKrl86vQ4vKNt9lbfEztXnT2
	 2muzX2473NZWxDQN5l1bemdSJqW/hOv5J1yRNg7YPu42kGzkxIv+wNCjH107ql4Se9x4Y
	 HUiEFT053vX9mhZw/OHXEGcOzHXNwjR1C7nGyaFohACNyXsa7lLdK4C4bd8rjM0iTTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ECWbVKoP;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5767C60A2619
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 00:01:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5767C60A2619
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ECWbVKoP
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3550c917fd3so1717876eec.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 17:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792627304; x=1793232104; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hvZJAGJoNW9px1hCT4jyVbr/7Ym3LMfNBDMY5M42JDI=;
        b=ECWbVKoPH/fjp+0fMIXh0XR4F4wF3kd+jhtIeTuoZf3HhCNT5XUBYhAz3nr1EjyK4P
         ycZeszuRSrqXsWhj/ZpWVdMiaFnyaHdQp3HLSMDs2YHhmDjNztwp52dZN4+GUgaXefGP
         ZcPEa6jJ22sfzGvp/iIGEwx5EqtFHq8f7SI4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792627304; x=1793232104;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hvZJAGJoNW9px1hCT4jyVbr/7Ym3LMfNBDMY5M42JDI=;
        b=zvx1jZB9mPcxiNk4UvAtQE5zpmof/GrYfNSeZpCzHSLFUow8A0wZyx+UZImMPg6tCI
         +IFo/P/xhNXsehDyACnvSAfS6VXC3SWSHRH8wMOSEjVvk18welsEJYWVQd/w21RFxs/1
         4bRmZvCK49n4ekOKJrqXIeCBJ8iSHFypylBU+iARwlizwIFb0OJ5tImGN7bo2W76WXkS
         Nbb0cDBnmrpxFnNHiSeoXyohxU1UXejOwvuazFCVPbxjmcCwWHQtxsYePJTnh4B4Dm0F
         3bR0ZgYSVTNEzKq7Wd8h6q+QbdmKwj23NzUr3U+Sfh/a7MCjtVq36DqmLYnFQS9bYQlL
         pn8g==
X-Forwarded-Encrypted: i=1; AKwUvBw8e7SLVIOMewCp3Zav4ykO2riAQTcWBmDVZj1/zUAu8pMZX1hDrINDSwCHILNYg4c/DFlpBKEYHQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKQBaFch3fGCXsoYNAjUurWEbhmjftS6hS8jLKyeUVgAdXKzRjT
	/Hx+RPCAk29tL7KmmbSFQgxChoseJSdE0VkL+oNVmmWMnBNtfbrt6phQGisnNIEJ7Q==
X-Gm-Gg: AYBFou2NAXJy2NJ7WJ0AiUp5NHWCjQiHUdkT8JFqoqa0+nKjHGOP7Ybq1W9S1j0TAhh
	T4vYTMrOoLm65oCKHpFCLIlPmYTxhBk+BonW7/9tM2PlUgBVkXKCRXthJobEYFVQD5QPIJQhMbH
	bvHIo0KVExqrBF70pMmpR5pCb+tbadCtr+Qc5C2rZedq5/ULXRJeHJN4njIk0Fsym8dB+hNUf1z
	ZPhGaI4AX9qOLkFNAL7UEFU+o4b+0WpPlSuF70+RrGgo+q5bSLS8AlEpiTaPfDTLkCjjWglr6Oc
	gyOO970CauowwcNUFIZZkoyChSaHFsF2un+2YdudlHbkGlNPHd0Tyd0yve7UrHHfrZLdhxotqj8
	NQfg5PV+9uXPwA5KhhKPlEO4lMaBnYQWLF7n8btQrylpZW+fWPJiMF3MMcvkJ92kVmYuL4LQCXK
	oI6c03PcGbqIIfQDbtuKMFgTyexE0gBtN4jG/n8QCj6ApsYQPpfWTlV8MBUNpXWCu+BU7MaPMXM
	fr9x5vjUlQfRrzTekQKF7VEhzvCNQfZl2P1SzH62fpd14voHaifCZdXqUTwFFeJXwoCJuXaz5KB
	ph8CHH/NWzK+OMJfU8F8liZ1Kn415HIEaok9AUmw
X-Received: by 2002:a05:7300:3398:b0:35e:a225:3ba6 with SMTP id 5a478bee46e88-3674c531737mr4703094eec.13.1792627304253;
        Wed, 21 Oct 2026 17:01:44 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:14ab:bfeb:ac88:458f])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-36741e71eaesm22647943eec.26.2026.10.21.17.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 17:01:43 -0700 (PDT)
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
Subject: [PATCH v2 14/17] iio: light: pa12203001: Discard pm_runtime_put_autosuspend() return values
Date: Wed, 21 Oct 2026 16:57:15 -0700
Message-ID: <20261021165858.v2.14.I501510b542691f595de1e110cfe35632a5fa7768@changeid>
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
pm_runtime_put_autosuspend() return value, and inline some of the
runtime PM helper function, now that it behaves the same with and
without CONFIG_PM.

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Split iio patch into per-driver patches
 * Inlining

 drivers/iio/light/pa12203001.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/light/pa12203001.c b/drivers/iio/light/pa12203001.c
index c0f4db8d95f7..0a0502a60a06 100644
--- a/drivers/iio/light/pa12203001.c
+++ b/drivers/iio/light/pa12203001.c
@@ -154,13 +154,12 @@ static inline int pa12203001_px_enable(struct pa12203001_data *data, u8 enable)
 	return 0;
 }
 
-static int pa12203001_set_power_state(struct pa12203001_data *data, bool on,
-				      u8 mask)
+static int pa12203001_runtime_resume_and_get(struct pa12203001_data *data, u8 mask)
 {
 #ifdef CONFIG_PM
 	int ret;
 
-	if (on && (mask & PA12203001_ALS_EN_MASK)) {
+	if (mask & PA12203001_ALS_EN_MASK) {
 		mutex_lock(&data->lock);
 		if (data->px_enabled) {
 			ret = pa12203001_als_enable(data,
@@ -173,7 +172,7 @@ static int pa12203001_set_power_state(struct pa12203001_data *data, bool on,
 		mutex_unlock(&data->lock);
 	}
 
-	if (on && (mask & PA12203001_PX_EN_MASK)) {
+	if (mask & PA12203001_PX_EN_MASK) {
 		mutex_lock(&data->lock);
 		if (data->als_enabled) {
 			ret = pa12203001_px_enable(data, PA12203001_PX_EN_MASK);
@@ -185,10 +184,7 @@ static int pa12203001_set_power_state(struct pa12203001_data *data, bool on,
 		mutex_unlock(&data->lock);
 	}
 
-	if (on)
-		return pm_runtime_resume_and_get(&data->client->dev);
-
-	return pm_runtime_put_autosuspend(&data->client->dev);
+	return pm_runtime_resume_and_get(&data->client->dev);
 
 err:
 	mutex_unlock(&data->lock);
@@ -213,7 +209,7 @@ static int pa12203001_read_raw(struct iio_dev *indio_dev,
 		switch (chan->type) {
 		case IIO_LIGHT:
 			dev_mask = PA12203001_ALS_EN_MASK;
-			ret = pa12203001_set_power_state(data, true, dev_mask);
+			ret = pa12203001_runtime_resume_and_get(data, dev_mask);
 			if (ret < 0)
 				return ret;
 			/*
@@ -226,13 +222,11 @@ static int pa12203001_read_raw(struct iio_dev *indio_dev,
 				goto reg_err;
 
 			*val = le16_to_cpu(reg_word);
-			ret = pa12203001_set_power_state(data, false, dev_mask);
-			if (ret < 0)
-				return ret;
+			pm_runtime_put_autosuspend(&data->client->dev);
 			break;
 		case IIO_PROXIMITY:
 			dev_mask = PA12203001_PX_EN_MASK;
-			ret = pa12203001_set_power_state(data, true, dev_mask);
+			ret = pa12203001_runtime_resume_and_get(data, dev_mask);
 			if (ret < 0)
 				return ret;
 			ret = regmap_read(data->map, PA12203001_REG_PDH,
@@ -241,9 +235,7 @@ static int pa12203001_read_raw(struct iio_dev *indio_dev,
 				goto reg_err;
 
 			*val = reg_byte;
-			ret = pa12203001_set_power_state(data, false, dev_mask);
-			if (ret < 0)
-				return ret;
+			pm_runtime_put_autosuspend(&data->client->dev);
 			break;
 		default:
 			return -EINVAL;
@@ -262,7 +254,7 @@ static int pa12203001_read_raw(struct iio_dev *indio_dev,
 	}
 
 reg_err:
-	pa12203001_set_power_state(data, false, dev_mask);
+	pm_runtime_put_autosuspend(&data->client->dev);
 	return ret;
 }
 
-- 
2.56.0.218.g1ec904b173-goog

