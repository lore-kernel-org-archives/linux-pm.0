Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794904520;
	b=UqLUleYN0Xwuwq97agFwpmFBOd9Uil6fn47ZTh4HvPML/7CjLARvHBfp0McgauuYnaX0
	 m9zzJJiji3fCaX8tHjisyFJzxISAWNsnbwGeJtgnEUNYwSXpPNd4lX0yRkXAJNEf36wJe
	 FTIJSyEzzur/jXY+ndrqfm2F9gPMzeE0FVRYmzT+aV7IO35FERE6RLOcP2vawZLqSjiUT
	 c1qqRo9UmTLQLaGKmAsDR7GX7JYyIGzVnE6LINHWBCHrQVg65HmEsE3Sdex8cAiPJdVeH
	 zGrJ9e4TuVYAmSi+KQaUK+b136ZuJy4EmBlrk5WHrjIQhcHJwFP0lUeFqm5hLpSME4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904520;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=agk/A3LWw5a2lEDhtnhF8EnN5eBx0hVoD8HiwFb2c/c=;
	b=HWjwFtxboXPBSYF6Rt2Tk8EiYwV/INAewqXh1SyuXk+r7IEi7pwUPIDjDAY5eZOm32fm
	 0F+NVEjh6BrvafeNejJOiH4EQlPAJs7Pzf9uaQxyrTdpRyoivyy7yDd6DPVWjjw2myYA3
	 JjZiq4QhZt5+2ZcBJx4eyKb+bWlhzJxQ8PbPSm7ZtG8a1+2XQgfwDpLskkKrOWawCfUyU
	 yX4f5iJqyT5n0thggM5/1Y2x6ECXPFn5RI6K1EaPQQUW/Wku7xzxMXJ+8AJZ0x/vTJzWu
	 3Py7nae9j3UiaSZYhRU84aWqky/hpI6mK2MxZsLvyxLuf1Cj2EIJP+j6O9GfLUueamg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=TWY4x2Uj;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5DA606A898;
	Tue, 17 Nov 2026 08:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE5DA606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=TWY4x2Uj
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E64191476;
	Tue, 17 Nov 2026 00:35:14 -0800 (PST)
Received: from e127648.cambridge.arm.com (e127648.arm.com [10.0.130.226])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2B6593F673;
	Tue, 17 Nov 2026 00:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794904517; bh=JugGxAZr1qpyxmpUOLtk7kz41B+FkAk/NDLgG3gX4GY=;
	h=From:To:Cc:Subject:Date:From;
	b=TWY4x2Ujr70vxmXCSeeYqW263KE53eJqHCQr8Bi7oedmwg1fDNAB7JeCs2XOIGrFH
	 6JOV+LOTtntyqbcNENoOyV05gskpKksGW414A0eTLg6SIR022ndmhHjTPC1EJe3O6k
	 Cp9UqLu9pLmmw/MgqpOeGdYUcdgUaHAUN82VyDsI=
From: Christian Loehle <christian.loehle@arm.com>
To: tudor.ambarus@linaro.org,
	bzolnier@gmail.com
Cc: krzk@kernel.org,
	rafael@kernel.org,
	daniel.lezcano@kernel.org,
	lukasz.luba@arm.com,
	linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] thermal: samsung: acpm-tmu: Fix spurious CPU throttling
Date: Tue, 17 Nov 2026 08:34:42 +0000
Message-Id: <20261117083442.830549-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
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

acpm_tmu_set_trips() supplies two thresholds, but the ACPM command
writes all eight slots, zero-filling the rest. On GS101, slot 7
controls autonomous CPU throttling even when its interrupt is masked.
Programming it to 0 C limits all three CPU clusters to about 200 MHz
on Pixel 6, while cpufreq continues to report the requested
frequencies.

Program slot 7 from the zone's critical trip before enabling the
sensor and preserve it when updating the low/high interrupt window.
Cache the three temperatures so a writable critical trip can update
the hardware without changing that window.
Reject critical temperatures that cannot be represented by the
firmware's unsigned degree-Celsius byte.

Fixes: 50a2c5d4062a ("thermal/drivers/samsung: Add Exynos ACPM TMU driver GS101")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/thermal/samsung/acpm-tmu.c | 62 ++++++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acpm-tmu.c
index b86dfa3c3ddb..1d8076f91fe7 100644
--- a/drivers/thermal/samsung/acpm-tmu.c
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -37,6 +37,8 @@
 				  EXYNOS_TMU_SENSOR(2))
 
 #define GS101_REG_INTPEND(i)		((i) * 0x50 + 0xf8)
+#define GS101_TMU_THRESHOLD_COUNT	8
+#define GS101_TMU_CRITICAL_THRESHOLD	7
 
 enum {
 	P0_INTPEND,
@@ -68,6 +70,9 @@ struct acpm_tmu_sensor {
 	struct thermal_zone_device *tzd;
 	struct acpm_tmu_priv *priv;
 	struct mutex lock; /* protects sensor state */
+	int low;
+	int high;
+	int critical;
 	bool enabled;
 };
 
@@ -250,7 +255,7 @@ static int acpm_tmu_get_temp(struct thermal_zone_device *tz, int *temp)
 }
 
 static int acpm_tmu_update_thresholds(struct acpm_tmu_sensor *sensor,
-				      u8 thresholds[2], u8 inten)
+				      u8 thresholds[GS101_TMU_THRESHOLD_COUNT], u8 inten)
 {
 	struct acpm_tmu_priv *priv = sensor->priv;
 	struct acpm_handle *handle = priv->handle;
@@ -260,7 +265,7 @@ static int acpm_tmu_update_thresholds(struct acpm_tmu_sensor *sensor,
 	bool was_enabled;
 	int ret, restore_ret;
 
-	guard(mutex)(&sensor->lock);
+	lockdep_assert_held(&sensor->lock);
 
 	was_enabled = sensor->enabled;
 
@@ -271,7 +276,7 @@ static int acpm_tmu_update_thresholds(struct acpm_tmu_sensor *sensor,
 	}
 
 	ret = ops->set_threshold(handle, mbox_chan_id, acpm_sensor_id,
-				 thresholds, 2);
+				 thresholds, GS101_TMU_THRESHOLD_COUNT);
 	if (!ret) {
 		ret = ops->set_interrupt_enable(handle, mbox_chan_id,
 						acpm_sensor_id, inten);
@@ -289,15 +294,21 @@ static int acpm_tmu_update_thresholds(struct acpm_tmu_sensor *sensor,
 	return ret;
 }
 
-static int acpm_tmu_set_trips(struct thermal_zone_device *tz, int low, int high)
+static int acpm_tmu_set_thresholds(struct acpm_tmu_sensor *sensor,
+				   int low, int high, int critical)
 {
-	struct acpm_tmu_sensor *sensor = thermal_zone_device_priv(tz);
 	struct acpm_tmu_priv *priv = sensor->priv;
 	struct device *dev = priv->dev;
-	u8 thresholds[2] = {};
+	u8 thresholds[GS101_TMU_THRESHOLD_COUNT] = {};
 	u8 inten = 0;
 	int ret;
 
+	if (critical < 0 || critical > 255 * MILLIDEGREE_PER_DEGREE)
+		return -EINVAL;
+
+	/* Slot 7 throttles CPU clocks independently of the interrupt mask. */
+	thresholds[GS101_TMU_CRITICAL_THRESHOLD] = critical / MILLIDEGREE_PER_DEGREE;
+
 	/* If a valid lower bound exists, set the threshold and enable its interrupt */
 	if (low > -INT_MAX) {
 		thresholds[0] = clamp_val(low / MILLIDEGREE_PER_DEGREE, 0, 255);
@@ -315,15 +326,43 @@ static int acpm_tmu_set_trips(struct thermal_zone_device *tz, int low, int high)
 		return ret;
 
 	ret = acpm_tmu_update_thresholds(sensor, thresholds, inten);
+	if (!ret) {
+		sensor->low = low;
+		sensor->high = high;
+		sensor->critical = critical;
+	}
 
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
 }
 
+static int acpm_tmu_set_trips(struct thermal_zone_device *tz, int low, int high)
+{
+	struct acpm_tmu_sensor *sensor = thermal_zone_device_priv(tz);
+
+	guard(mutex)(&sensor->lock);
+
+	return acpm_tmu_set_thresholds(sensor, low, high, sensor->critical);
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
+	guard(mutex)(&sensor->lock);
+
+	return acpm_tmu_set_thresholds(sensor, sensor->low, sensor->high, temp);
+}
+
 static const struct thermal_zone_device_ops acpm_tmu_sensor_ops = {
 	.get_temp = acpm_tmu_get_temp,
 	.set_trips = acpm_tmu_set_trips,
+	.set_trip_temp = acpm_tmu_set_trip_temp,
 };
 
 static int acpm_tmu_has_pending_irq(struct acpm_tmu_sensor *sensor,
@@ -469,6 +508,7 @@ static int acpm_tmu_probe(struct platform_device *pdev)
 
 	for (i = 0; i < priv->num_sensors; i++) {
 		struct acpm_tmu_sensor *sensor = &priv->sensors[i];
+		int critical;
 
 		mutex_init(&sensor->lock);
 		sensor->group = &data->sensor_groups[i];
@@ -488,8 +528,16 @@ static int acpm_tmu_probe(struct platform_device *pdev)
 			goto err_rollback;
 		}
 
+		ret = thermal_zone_get_crit_temp(sensor->tzd, &critical);
+		if (ret) {
+			ret = dev_err_probe(dev, ret, "Sensor %d has no critical trip\n", i);
+			goto err_rollback;
+		}
+
 		mutex_lock(&sensor->lock);
-		ret = acpm_tmu_op_tz_control(sensor, true);
+		ret = acpm_tmu_set_thresholds(sensor, -INT_MAX, INT_MAX, critical);
+		if (!ret)
+			ret = acpm_tmu_op_tz_control(sensor, true);
 		mutex_unlock(&sensor->lock);
 		if (ret) {
 			ret = dev_err_probe(dev, ret, "Failed to enable sensor %d\n", i);
-- 
2.34.1

