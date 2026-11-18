Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795008530;
	b=ThLk2RJqAxzqWMDwtxrr8v473gsMll+U/BkqkPwpFsnGVpzm8leEmb/Fg875TWEpv+Q3
	 sB1Yvr8H5KuK/S2IGgos3jBt2seV7KDIQHG8P81W8IToCoT4Lz8CwkDZbFHf1q0NHIjKR
	 1W+o7PdnOkfPYLqYKdDtiRpBADmZTYg53mWVlVCSNT4zPh9B/OUvYKXEC3N2OokxgP9qg
	 N3+A507WPFSPX7LEvUPZDghj+5AM3uPEvTdDaqrfsoM/Th31CeeYxeKs3MIjtGFsjN8m9
	 qf/85KsjR8JwQqpYPk5Bbgb0c+T2JdZmoll6mfnn76wTqrIV8ZC8o9wsjUvuFLoeMEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795008530;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=/bUX1o10AeaLg2EvHKlQx3MEISY3ApyjT1Rh2bWzuqk=;
	b=iQDTFhcA4y9WSbBo2/vNDo4873umvzKBbiXiintjjhycYJuyIZTdMc2tRyWqHI++XQzw
	 wjw28TxZq+VFKvQ/ajzxQeXaV4niJ5MMW3H+q7nauWa7oM809yJrI+Nn7ulvr7AQTgKk5
	 BrZO4TBxDl26OSfepZPLKSbK79okWJC8fM9l4rFre6h4hLpRmTtdXOo4RTp7Ed2/DYfS5
	 w9FkN7rkDXxP1Igy9cYIKWqt0+uz4bjDdizTJaCrR+2kQALKVDokFKbtTkWXkmTIUPsye
	 QpQqV62Q9zDSP3kJi/StuoZJrMWVNojvxg3j00LTaLY0yd3fKpvZXnzQ6hYaUYmLrpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qScRVsHn;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533F0606A33B
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 13:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 533F0606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=qScRVsHn
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so10040895e9.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 05:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795008527; x=1795613327; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/bUX1o10AeaLg2EvHKlQx3MEISY3ApyjT1Rh2bWzuqk=;
        b=qScRVsHn8cSlX/3DL2rr9yiE2sN5/ZgLpiSyjB6ojZVGViN3m68W4dUYp9qrPLtEAp
         Tmpmkfs205keydruSvyAJWphhGwh45T+tPQzJRsdFgfvjeED5u8e5SmEpmsqOvjI2OTF
         6YbXMAT/9WhAQHpt9fzS3NjGfqiwSQMceXebHzPvliCmNvc9Dc+lG1foOSRz0jSL0Vu0
         l5DbgrFdGkuokXt26LCuajKNpZzm8ssPt4d9M7q0XqLaYLDWHcsa9j1jD1DP2EyPCRlT
         6AgUUia1VRqFQ8NUCPk6rkUUuHsVYuJc3BHL9NXpkqJLfCScTQ/piwJt4MGPgvI5quw7
         /AVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795008527; x=1795613327;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/bUX1o10AeaLg2EvHKlQx3MEISY3ApyjT1Rh2bWzuqk=;
        b=ulZCdwdKk1tvB4eFvw5bys7JWUC9x9IUW9cpVbju1v/XXjjf4A/QfpCOpm/QkZgB1k
         OqNZFthyWvJiVZHLUSLt4p+uhbP6Yk4dTo0WIf/X1mv8WBIHxDekkrMRXh972d2YgCJf
         BFMRzAoxSYvhZuFHjuC4YiVVGDWYNfywqy/kTBFx3OxAkyaV7XBF3f0GyA8fDVZ5y/J2
         VT39p3pJNuCSca55cNlKxAMvwTNknSayhWxdJvPpW+LJpJbaLGQC4ZF6pyLQZ1oKqP61
         940HV+XBLi4K4ErWRvZJ17Euhxew/Asq8xkBz2mkW3KJCivI3LePgjBwzPsb1GG9m5Jd
         u2Ag==
X-Forwarded-Encrypted: i=1; AL+hErH83CORYM41XApz8m/Yf8VEu1zy9qJEtGWKbWSzEvnakhC1nVRDQzI5DISldlZrBWfxOdOcHcJpGQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9DGlkiFYSIeiv7VGfQskwYeP+IlKEj+MQkcU3CstB2gRGiHbku
	XzR3QxEUI3HRe6XI5TkP107y3pwoodIR/oRUsneC24wR7VaJZjrTihkqsLGRsWqxkS0=
X-Gm-Gg: AYBFou2mY65z/DSmlBPPbUKB4RqrySGG2fyo6q8tAFmrQUuZOMrx1g/Vyc+32AJCuv8
	Cw6NtqZLhoAko78y/mKeht3g4zMO44TBTk3P1fJ/VZvD7QRgp1cj32QWtEmkqjW3HZmIiuPDwfH
	qVnTxpJ2fDDQkn/y+Wwn5lOTuxGtmfzJjbsb4PNPV3hXQbbxvNFDW6fwyJiZW74l/uPHtofr8J6
	KN77mytmkEPibuttYU+MlYg8JGAI4xcFa0MNH/wvpC9Uf6L31GEsBpxJJJ6C4id3Z/aGCJndF4G
	0UUFiQFAl0mtqZEhi+WBVVUoaKHp8HPuVJ0rTVaTaEWbeyJZBzA2xGtyIdkjJWLieC9gVcshk0n
	FQuE3/IwxsnBhpsHyW9KUOAzCrYI+C2AQVUAOzKgiIgqOsSuxbWNZRM4i9xLPVdlpEsp9RdgYLy
	269IqpyW9mvHDv/gTIiLHkKrhVrcsAcXhXRuawF4BHFFsAoGO58eJNa3DDWqFccNbuSsFhz7fYz
	3y7h9Q6aKuT1K9KDlfca/2kNQtIOvs+5FDyTt3CIKevtxiEUUVT8lGKYNRkgzr6wr01bH5TCuUT
	piCfG977Q6369M5OQN8qoJWlFOs1rhsA1o7EQXpLCpvGS1aINAHNAkcjMtkJ
X-Received: by 2002:a05:600c:4e44:b0:4a1:fba8:b13d with SMTP id 5b1f17b1804b1-4bb7da12957mr47322395e9.9.1795008527371;
        Wed, 18 Nov 2026 05:28:47 -0800 (PST)
Received: from [192.168.0.252] ([82.76.204.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7df07ff6sm38205175e9.4.2026.11.18.05.28.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 05:28:46 -0800 (PST)
Message-ID: <4d51fe5f-d233-44d4-a50e-ef168b6f0402@linaro.org>
Date: Wed, 18 Nov 2026 15:28:45 +0200
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
To: Christian Loehle <christian.loehle@arm.com>, bzolnier@gmail.com,
 Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: krzk@kernel.org, rafael@kernel.org, lukasz.luba@arm.com,
 linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-pm@vger.kernel.org, Juan Yescas <jyescas@google.com>
References: <20261117083442.830549-1-christian.loehle@arm.com>
 <3ea5d94b-6913-4534-816a-3935c689225b@linaro.org>
 <56a7a762-7667-4186-973c-ca0fcb399ecc@arm.com>
 <b2b0ddc6-964f-4d8d-86d4-a0bc24d9022e@arm.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <b2b0ddc6-964f-4d8d-86d4-a0bc24d9022e@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/26 2:06 PM, Christian Loehle wrote:
> On 11/17/26 16:41, Christian Loehle wrote:
>> On 11/17/26 15:37, Tudor Ambarus wrote:
>>> Hi, Christian,
>>>
>>> Thanks for the patch!
>>>
>>> On 11/17/26 10:34 AM, Christian Loehle wrote:
>>>> acpm_tmu_set_trips() supplies two thresholds, but the ACPM command
>>>> writes all eight slots, zero-filling the rest. On GS101, slot 7
>>>> controls autonomous CPU throttling even when its interrupt is masked.
>>>> Programming it to 0 C limits all three CPU clusters to about 200 MHz
>>>> on Pixel 6, while cpufreq continues to report the requested
>>>> frequencies.
>>>
>>> Could you share how you discovered this? I don't have access to the
>>> ACPM firmware sources, and the downstream driver doesn't state it
>>> either.
>>
>> Neither do I, I discovered this randomly through running regression tests
>> on Energy-Aware Scheduling on the Pixel6 and acpm-tmu (7.4-rc1) causes a
>> massive energy regression (+~1000%) for the same workloads.
>> The reason is this DVFS throttling.
>>
>>>
>>> How did you measure the actual CPU frequency, given that cpufreq
>>> keeps reporting the requested one?
>>
>> PMU counters CPU_CYCLES
>>
>>>
>>> Do you know whether slots 2-6 have any side effects as well?
>>
>> I hadn't discovered any.
>>
>>>
>>> Also note that Daniel has already queued a set of acpm-tmu fixes in
>>> thermal/linux-next, so this patch will need to be reworked on top of
>>> them.
>>
>> will rebase then!
>>
>>>
>>>>
>>>> Program slot 7 from the zone's critical trip before enabling the
>>>> sensor and preserve it when updating the low/high interrupt window.
>>>> Cache the three temperatures so a writable critical trip can update
>>>> the hardware without changing that window.
>>>
>>> I think this can be handled with a smaller change: look up the
>>> critical trip in .set_trips() itself. The zone lock is held there, so
>>> for_each_thermal_trip() can be used. That avoids caching
>>> low/high/critical, the .set_trip_temp() callback and the probe changes.
>>
>> Ah yep you're right, will fix and resend.
>> Thanks!
> 
> Okay, maybe I'm missing something but AFAICS we have to do the set_trip_temp
> because thermal core looks only at min/max and may skip set_trips() in case

ah, you're right!

> these are unchanged, missing a critical update.
> So the minimal I see working is making 'critical' (again, this is my
> interpretation of the value, if you want it named anything else, just shoot)
> non-writable by failing it's set_trip_temp()?
> Or is there another way?

While I like it, the problem is that the trip is writable in sysfs but
always failing.

An alternative is to touch the core and let OF drivers mark trips
read-only but maybe this is not suitable for a quick fix. We need to
involve Daniel.

So I think your v1 approach of caching and updating the hardware from
.set_trip_temp() is the right one after all. I'd just look up the
critical trip in .set_trips() instead of caching it from probe, and
cache the last programmed thresholds and interrupt mask.

Would something along the lines work?

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acpm-tmu.c
index 7c30401f8fc7..b2e5b1f6641a 100644
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
+	/* Last programmed thresholds, protected by the thermal zone lock */
+	u8 thresholds[ACPM_TMU_NUM_THRESHOLDS];
+	u8 inten;
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
@@ -267,14 +275,56 @@ static int acpm_tmu_update_thresholds(struct acpm_tmu_sensor *sensor,
 	return ret;
 }
 
+static int acpm_tmu_get_crit_temp(struct thermal_trip *trip, void *arg)
+{
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
+				       u8 thresholds[ACPM_TMU_NUM_THRESHOLDS],
+				       u8 inten)
+{
+	struct device *dev = sensor->priv->dev;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	ret = acpm_tmu_update_thresholds(sensor, thresholds, inten);
+	if (!ret) {
+		memcpy(sensor->thresholds, thresholds, sizeof(sensor->thresholds));
+		sensor->inten = inten;
+	}
+
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
 static int acpm_tmu_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
 	struct acpm_tmu_sensor *sensor = thermal_zone_device_priv(tz);
-	struct acpm_tmu_priv *priv = sensor->priv;
-	struct device *dev = priv->dev;
-	u8 thresholds[2] = {};
+	u8 thresholds[ACPM_TMU_NUM_THRESHOLDS] = {};
+	int crit = INT_MAX;
 	u8 inten = 0;
-	int ret;
+
+	/*
+	 * The firmware programs all thresholds at once. Set the hardware trip
+	 * to the lowest critical trip temperature, so that it never fires
+	 * below the point where the thermal core shuts the system down. If
+	 * the zone has no critical trip, crit stays INT_MAX and is clamped to
+	 * the highest threshold value.
+	 */
+	for_each_thermal_trip(tz, acpm_tmu_get_crit_temp, &crit);
+	thresholds[ACPM_TMU_HW_TRIP_THRESHOLD] =
+		clamp_val(crit / MILLIDEGREE_PER_DEGREE, 0, 255);
 
 	/* If a valid lower bound exists, set the threshold and enable its interrupt */
 	if (low > -INT_MAX) {
@@ -288,15 +338,28 @@ static int acpm_tmu_set_trips(struct thermal_zone_device *tz, int low, int high)
 		inten |= BIT(1);
 	}
 
-	ret = pm_runtime_resume_and_get(dev);
-	if (ret)
-		return ret;
+	return acpm_tmu_program_thresholds(sensor, thresholds, inten);
+}
 
-	ret = acpm_tmu_update_thresholds(sensor, thresholds, inten);
+static int acpm_tmu_set_trip_temp(struct thermal_zone_device *tz,
+				  const struct thermal_trip *trip, int temp)
+{
+	struct acpm_tmu_sensor *sensor = thermal_zone_device_priv(tz);
+	u8 thresholds[ACPM_TMU_NUM_THRESHOLDS];
 
-	pm_runtime_put_autosuspend(dev);
+	if (trip->type != THERMAL_TRIP_CRITICAL)
+		return 0;
 
-	return ret;
+	/*
+	 * The thermal core skips .set_trips() when the low/high window does
+	 * not change, so update the hardware trip threshold here, keeping the
+	 * last programmed window.
+	 */
+	memcpy(thresholds, sensor->thresholds, sizeof(thresholds));
+	thresholds[ACPM_TMU_HW_TRIP_THRESHOLD] =
+		clamp_val(temp / MILLIDEGREE_PER_DEGREE, 0, 255);
+
+	return acpm_tmu_program_thresholds(sensor, thresholds, sensor->inten);
 }
 
 static int acpm_tmu_change_mode(struct thermal_zone_device *tz,
@@ -329,6 +392,7 @@ static const struct thermal_zone_device_ops acpm_tmu_sensor_ops = {
 	.change_mode = acpm_tmu_change_mode,
 	.get_temp = acpm_tmu_get_temp,
 	.set_trips = acpm_tmu_set_trips,
+	.set_trip_temp = acpm_tmu_set_trip_temp,
 };
 
 static bool acpm_tmu_clear_pending_irq(struct acpm_tmu_sensor *sensor)


