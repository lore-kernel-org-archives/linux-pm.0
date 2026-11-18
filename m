Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795010480;
	b=GsxOALkJ0qdpOA0QApVJRPvMM+ZqYz98bv5fo1BF2Kd3DLa+82iJi7C6EeWc2ChFQrp7
	 oaZX9X+szIvr1B/uX4zR7K7XiGbCEe4dnNy8IESKz1VH4/qW2AHBwSpQ7DyxNsl0q7AZR
	 C32U143S2KJJuRvlLQSJBI7cawXLEvsA8B0KsbOaQyDGCgTHpGSsQ/12yDQTMCL2ol95F
	 eraeooj1yrG0AWkWFvYqjmdb4p2CIxb8Z2UHPwwwCX8D5JbRJ2xDXcbHPnDJp38XpKLJ2
	 vixfSNcm6gE21BfkIJymGBgdClTqW1yAE6zNRLKmWGeEPlGD7nIAKGQxau6wAhejT+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795010480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=SQBL/pm8ssQ4h2Vnf/mf2PH79AlhPBjy2NJAi+slih8=;
	b=WjfPELeECEEH4bXgqDRH/qUHBlQYcde3bynNzKxI3MlHFasqG5b6AL1Ronv7/8qUR2AR
	 IrNW1F8dEUYtfjUgpm4IEOIV7BuexQuPS8E8s4QEOBvP4pj64jk5JMAu9rNlS3FyPOEUy
	 2B2/U+TklIGsEX75TpUVjx6t3Vt6OYcnygst2l32/fMHFSW3TpiG2aL4VpBDB7BebYEIB
	 EY83WuYJfBil3NDVX3u1f5a+KbOqtjNB1qfS944MEMyJuM1mNstc8I2fOg0wR2vdXAKUD
	 O+R4xmwTlVA2kWSil3HqrUcVtsIwGVQSRV//hcQJtRLmhPgG3+lZT/d5nb4coezFI6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jS4aIIkB;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D602260A260B
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 14:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D602260A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jS4aIIkB
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so5693685e9.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 06:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795010478; x=1795615278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SQBL/pm8ssQ4h2Vnf/mf2PH79AlhPBjy2NJAi+slih8=;
        b=jS4aIIkBn1GkKpz/AmCsxNZ8+ib0VEwLgKDAaLBW+jQXaz+OFbxh0AwL5jZSuzrnQA
         6aYFUIXGUAbzIvTFy75MfykZeitXKFTE7m9ztElrn85/vV1Erx21+RSswv8q5dcXcynp
         rLk+AZ4z9EUjWwtwyRDJNrU/qSpXgWn06BvctbmrolhMMz1SuhSM+C2QJe0cAAzWv4w3
         gZqIa4dE2FfkcDAORc/hsit1wKMxpTzz+8OEA8oNNJr7dQwdP3PtyDmOtw1mIOshHSy6
         D5scBVdjX7uXxl1+DRW8CkNvToZ4NnaVwTCKUMJE/r/vVpwIAfnK5c6SUj3/aYPdy7BR
         1WUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795010478; x=1795615278;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SQBL/pm8ssQ4h2Vnf/mf2PH79AlhPBjy2NJAi+slih8=;
        b=rk8PjG5B5Xg0HNQ1ciIi55XiDNtiuJomsVPL1IfM8hJbGBacz8y63i5swMzydNUXZN
         U93GABJxNhuSZm2H9+yF6FOTAnZoU7aWUGGdUvVa/WdqCUzbw+d2LROaWSlm1Mzz+flC
         E4gOh+AxTtObe8t9Ch3O9YFkOgRP4eG5vt55pg7OfEe27iojjmbdRmn1j1AotVJ4/677
         ukxCP+EpODTq/s9Jovzv2O4ZwRQcAxbzR8XxXslRdlGRAEX0DhngjFIAtb2lnKNLlVCW
         1mbTTIrx8i/HNe0sjLdAt4rQnQApu1YK5sUeK8GrudodJ+Vw1DMvuUlGmyf2/619nMYo
         OT8A==
X-Forwarded-Encrypted: i=1; AL+hErHWDRwu1mCyh4B5JhUT24g5NSFhS06uNJw8C4dVMCCItrBDAtmZ2LNgjp3nbUngf/PgKzblyybNOg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/e+Tie+Gm7yroGBI+rPEadoZhgRrNUwiQ2WLYzBBFDxgnS9oY3
	VS8WejY4n9VCY8ZKg8isuR5oEdF/0toHpWVmt+kI0IFM51Yf83W8pICsgiSHeWz+y4DfolwadjD
	4kGzz
X-Gm-Gg: AYBFou3T5WsLiIaDPZ/Iu1XlV6X0TmhKONXoBy+8XrTDxpy0oNmV4gNmZ3a7QerCMKA
	Lpe+b8sa4H5Rbc5PqXztccad0vrWun74AdN3GfO0Gf/K0xa16J2Vu+RmMnuEcfY8O8UPsc/BOoZ
	jsS8nNyBRVLvvdsu1lbtHwb2HX7GFaU/o8/0MxIIWJFHtFy5Jx/QeX5z7gSMrVJMoR9AH+jbybq
	Ti4EJf1BmXN3BXPBEQTv0D4ADvXuljgSV/W1Ahn2HDaWooD/iru+yhSv+JWzi2j8xwqgVk0ipwc
	DUjRS0LS5fr4ktXWJ55vioAOAdprBDT+AIK06n8pG07IeXl+pU4evDJuLamoor9Zick1SBOHIia
	njadBysE3wZQEe5z1vRFr5B39RSkJ4LhXgLBi2RD6LKiQTx5uHDEm0bH2DhJiB13WYyAJEjKSg/
	Dv1DvCuGRMGDM0uXgLlNW1f8iycmWMPIV/ghPry1UYkqKR9kIQ17/at0ZAUs8ex37At7lY21j23
	GZKgOBIl5pO7BQZFM3rTXbvd/74S/jsKp2NGsPdDMxcDSQB1I9izRCwhZ6mEBzDtM3K+feptPfV
	2yKf3XIwGEvPB6zYzfnyIc+5xe2kHnFu6YO+tEc=
X-Received: by 2002:a05:600c:6746:b0:4a5:87b3:ddc1 with SMTP id 5b1f17b1804b1-4bb7da19d44mr49686225e9.13.1795010477916;
        Wed, 18 Nov 2026 06:01:17 -0800 (PST)
Received: from [192.168.0.252] ([82.76.204.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a656095f21sm4649341f8f.38.2026.11.18.06.01.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 06:01:17 -0800 (PST)
Message-ID: <2cc6efc8-db35-4b40-ab71-815f08ed9dc9@linaro.org>
Date: Wed, 18 Nov 2026 16:01:16 +0200
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal: samsung: acpm-tmu: Fix spurious CPU throttling
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: Christian Loehle <christian.loehle@arm.com>, bzolnier@gmail.com,
 Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: krzk@kernel.org, rafael@kernel.org, lukasz.luba@arm.com,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-pm@vger.kernel.org, Juan Yescas <jyescas@google.com>
References: <20261117083442.830549-1-christian.loehle@arm.com>
 <3ea5d94b-6913-4534-816a-3935c689225b@linaro.org>
 <56a7a762-7667-4186-973c-ca0fcb399ecc@arm.com>
 <b2b0ddc6-964f-4d8d-86d4-a0bc24d9022e@arm.com>
 <4d51fe5f-d233-44d4-a50e-ef168b6f0402@linaro.org>
Content-Language: en-US
In-Reply-To: <4d51fe5f-d233-44d4-a50e-ef168b6f0402@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/26 3:28 PM, Tudor Ambarus wrote:
> Would something along the lines work?

Thinking more about it, caching the window instead of the raw
thresholds is simpler and closer to your v1, as inten derives from
low/high anyway. Maybe this:

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acpm-tmu.c
index 7c30401f8fc7..8422a7c970e7 100644
--- a/drivers/thermal/samsung/acpm-tmu.c
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -39,6 +39,10 @@
 
 #define GS101_REG_INTPEND(i)		((i) * 0x50 + 0xf8)
 
+#define ACPM_TMU_NUM_THRESHOLDS		8
+/* Threshold 7 throttles the CPUs in hardware, regardless of the INTEN mask. */
+#define ACPM_TMU_HW_TRIP_THRESHOLD	7
+
 enum {
 	P0_INTPEND,
 	P1_INTPEND,
@@ -70,6 +74,9 @@ struct acpm_tmu_sensor {
 	struct acpm_tmu_priv *priv;
 	struct mutex lock; /* protects sensor state */
 	enum thermal_device_mode mode;
+	/* Last programmed window, protected by the thermal zone lock */
+	int low;
+	int high;
 	bool enabled;
 };
 
@@ -228,7 +235,8 @@ static int acpm_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 }
 
 static int acpm_tmu_update_thresholds(struct acpm_tmu_sensor *sensor,
-				      u8 thresholds[2], u8 inten)
+				      u8 thresholds[ACPM_TMU_NUM_THRESHOLDS],
+				      u8 inten)
 {
 	struct acpm_tmu_priv *priv = sensor->priv;
 	struct acpm_handle *handle = priv->handle;
@@ -249,7 +257,7 @@ static int acpm_tmu_update_thresholds(struct acpm_tmu_sensor *sensor,
 	}
 
 	ret = ops->set_threshold(handle, mbox_chan_id, acpm_sensor_id,
-				 thresholds, 2);
+				 thresholds, ACPM_TMU_NUM_THRESHOLDS);
 	if (!ret) {
 		ret = ops->set_interrupt_enable(handle, mbox_chan_id,
 						acpm_sensor_id, inten);
@@ -267,12 +275,22 @@ static int acpm_tmu_update_thresholds(struct acpm_tmu_sensor *sensor,
 	return ret;
 }
 
-static int acpm_tmu_set_trips(struct thermal_zone_device *tz, int low, int high)
+static int acpm_tmu_get_crit_temp(struct thermal_trip *trip, void *arg)
 {
-	struct acpm_tmu_sensor *sensor = thermal_zone_device_priv(tz);
-	struct acpm_tmu_priv *priv = sensor->priv;
-	struct device *dev = priv->dev;
-	u8 thresholds[2] = {};
+	int *temp = arg;
+
+	if (trip->type == THERMAL_TRIP_CRITICAL &&
+	    trip->temperature != THERMAL_TEMP_INVALID)
+		*temp = min(*temp, trip->temperature);
+
+	return 0;
+}
+
+static int acpm_tmu_program_thresholds(struct acpm_tmu_sensor *sensor,
+				       int low, int high, int crit)
+{
+	struct device *dev = sensor->priv->dev;
+	u8 thresholds[ACPM_TMU_NUM_THRESHOLDS] = {};
 	u8 inten = 0;
 	int ret;
 
@@ -288,17 +306,61 @@ static int acpm_tmu_set_trips(struct thermal_zone_device *tz, int low, int high)
 		inten |= BIT(1);
 	}
 
+	/*
+	 * The firmware programs all thresholds at once. Set the hardware trip
+	 * to the critical trip temperature, so that it never fires below the
+	 * point where the thermal core shuts the system down.
+	 */
+	thresholds[ACPM_TMU_HW_TRIP_THRESHOLD] =
+		clamp_val(crit / MILLIDEGREE_PER_DEGREE, 0, 255);
+
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret)
 		return ret;
 
 	ret = acpm_tmu_update_thresholds(sensor, thresholds, inten);
+	if (!ret) {
+		sensor->low = low;
+		sensor->high = high;
+	}
 
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
 }
 
+static int acpm_tmu_set_trips(struct thermal_zone_device *tz, int low, int high)
+{
+	struct acpm_tmu_sensor *sensor = thermal_zone_device_priv(tz);
+	int crit = INT_MAX;
+
+	/*
+	 * Use the lowest critical trip temperature. If the zone has no
+	 * critical trip, crit stays INT_MAX and is clamped to the highest
+	 * threshold value.
+	 */
+	for_each_thermal_trip(tz, acpm_tmu_get_crit_temp, &crit);
+
+	return acpm_tmu_program_thresholds(sensor, low, high, crit);
+}
+
+static int acpm_tmu_set_trip_temp(struct thermal_zone_device *tz,
+				  const struct thermal_trip *trip, int temp)
+{
+	struct acpm_tmu_sensor *sensor = thermal_zone_device_priv(tz);
+
+	if (trip->type != THERMAL_TRIP_CRITICAL)
+		return 0;
+
+	/*
+	 * The thermal core skips .set_trips() when the low/high window does
+	 * not change, so update the hardware trip threshold here, keeping the
+	 * last programmed window.
+	 */
+	return acpm_tmu_program_thresholds(sensor, sensor->low, sensor->high,
+					   temp);
+}
+
 static int acpm_tmu_change_mode(struct thermal_zone_device *tz,
 				enum thermal_device_mode mode)
 {
@@ -329,6 +391,7 @@ static const struct thermal_zone_device_ops acpm_tmu_sensor_ops = {
 	.change_mode = acpm_tmu_change_mode,
 	.get_temp = acpm_tmu_get_temp,
 	.set_trips = acpm_tmu_set_trips,
+	.set_trip_temp = acpm_tmu_set_trip_temp,
 };
 
 static bool acpm_tmu_clear_pending_irq(struct acpm_tmu_sensor *sensor)
@@ -479,6 +542,8 @@ static int acpm_tmu_probe(struct platform_device *pdev)
 		mutex_init(&sensor->lock);
 		sensor->group = &data->sensor_groups[i];
 		sensor->priv = priv;
+		sensor->low = -INT_MAX;
+		sensor->high = INT_MAX;
 
 		tzd = devm_thermal_of_zone_register(dev, i, sensor,
 						    &acpm_tmu_sensor_ops);

