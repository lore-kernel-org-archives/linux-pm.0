Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628410;
	b=Fw2aKuEacLULsggRHJQ+vGB8VD2+Rb+LECwECJdK5nRchTJd8KfvbLVvdKR8AkMmaP6Z
	 0WvvfrimG6ygpziAkXv+nQdB4AKv67B0f7L/DIzFdiQPgQb0xtFJ7davVDtu2HvP/pRgg
	 CnIYXfK0HQuzxSKVFE/Y0XTiX2fwoedlxJBACcELTarwra0j/hyozchQFi1D5HWfid5ae
	 j5vKNCYhn5FUo1vMslWEt23K6iaoC0X5NgepGS+7Ol4BlLzGNQ7Rq8pHmhzxrSGHsDazj
	 dmeYcVfOdR+aAjDAGp0W95kEGOpdNBdEDzXKG+nleD2LS23liEZsFMBr8W7v0KdTR3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628410;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Kv2CBvjOfycHlmjB6SC5hIbRJOSjsO3gZFs9cUX9YCg=;
	b=xFvc+t0j8kMUz6YPlgZMdcK8RRkA8MVZHy1tboVjB4a6vlw8qkTXDASRsdqgDQEY1p3W
	 AMXbd91JccPgBvsyn1scp5eN8Sb6dSneIvAKT8mWCHueFas+b1toiwuoO9YWaTi6v+5SL
	 tXMVvtIQ7pS3HEh1tyHL96jUhGTPZ3Cq2j1dZIDOhXaw8ItzUrFfdyx4HFOTNdpcZSxUC
	 QSDsV+0hoAvdOsUU+HQxkEUQ1R//ywhe3H8jiC+n1Mr8afSdF1I0CY0cJsYvvjPcoNw+U
	 WZrnjYy4u4Lcxj0DW3wHR2E3jSUovqkHV+7Qa9HGgF8jngQB/T6rtncOCdMAE2mgppQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=gs2zOBOl;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5511C606A31E;
	Wed, 25 Nov 2026 17:40:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5511C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=gs2zOBOl
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E2E1339;
	Wed, 25 Nov 2026 09:40:06 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.72.178])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2807B3F86F;
	Wed, 25 Nov 2026 09:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795628409; bh=lnCsqy1vLk+wb0zjY+zvfVbFIS3udMzWV8kdwdEBezs=;
	h=From:To:Cc:Subject:Date:From;
	b=gs2zOBOlP2a7W7F3z6Txi0AVjIhtMECOWJP6Li483S4GOLUmvr3Cpa3jKzoPnuM8h
	 FgGZGUeSIlvdeDGQ83SK+Zai8stpEbzin6kzjnmtW+ujiIC90O3sVKi+zpcQCpg3Du
	 L4lZiDot6Q4/+1NSRQcx8hiSKoGd2pU1WEHvC7cA=
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
Subject: [PATCHv3] thermal/drivers/samsung/acpm-tmu: Fix spurious CPU throttling
Date: Wed, 25 Nov 2026 17:39:59 +0000
Message-Id: <20261125173959.2198116-1-christian.loehle@arm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

acpm_tmu_set_trips() supplies two thresholds, but the ACPM command writes
all eight slots, zero-filling the rest. On GS101, slot 7 limits CPU clocks
independently of its interrupt mask. Setting it to 0 C limits all three
clusters to about 200 MHz while cpufreq reports the requested frequencies.
This was found through trial and error while tracking EAS regressions.

Program slot 7 from the lowest active hot trip so hardware throttling can
precede the critical trip's system shutdown. Cache the low/high window and
update the hot limit from set_trip_temp(), because the thermal core skips
set_trips() when that window is unchanged.

Fixes: 50a2c5d4062a ("thermal/drivers/samsung: Add Exynos ACPM TMU driver GS101")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
Since v2:
- Use hot instead of critical s.t. it precedes shutdown. (Tudor)
Since v1:
- Rebase onto linux-next, including Daniel’s queued ACPM TMU fixes.
- Cache only low/high and look up the lowest active critical trip when programming. (Tudor)
- Retain the requested window even if programming fails, matching the thermal core.
- Handle critical-trip deactivation and zones without an active critical trip.


 drivers/thermal/samsung/acpm-tmu.c | 76 +++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acpm-tmu.c
index 4799ef518a7a..08856d713d5d 100644
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
+	/* Last requested window, protected by the thermal zone lock */
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
@@ -267,15 +275,40 @@ static int acpm_tmu_update_thresholds(struct acpm_tmu_sensor *sensor,
 	return ret;
 }
 
-static int acpm_tmu_set_trips(struct thermal_zone_device *tz, int low, int high)
+struct acpm_tmu_hot_trip {
+	const struct thermal_trip *updated;
+	int temperature;
+};
+
+static int acpm_tmu_get_hot_temp(struct thermal_trip *trip, void *arg)
+{
+	struct acpm_tmu_hot_trip *hot = arg;
+
+	if (trip->type == THERMAL_TRIP_HOT && trip != hot->updated &&
+	    trip->temperature != THERMAL_TEMP_INVALID)
+		hot->temperature = min(hot->temperature, trip->temperature);
+
+	return 0;
+}
+
+static int acpm_tmu_program_thresholds(struct thermal_zone_device *tz,
+				       const struct thermal_trip *trip, int temp)
 {
 	struct acpm_tmu_sensor *sensor = thermal_zone_device_priv(tz);
-	struct acpm_tmu_priv *priv = sensor->priv;
-	struct device *dev = priv->dev;
-	u8 thresholds[2] = {};
+	struct device *dev = sensor->priv->dev;
+	struct acpm_tmu_hot_trip hot = { trip, INT_MAX };
+	u8 thresholds[ACPM_TMU_NUM_THRESHOLDS] = {};
+	int low = sensor->low, high = sensor->high;
 	u8 inten = 0;
 	int ret;
 
+	/* Exclude the trip being updated until the proposed value is considered. */
+	for_each_thermal_trip(tz, acpm_tmu_get_hot_temp, &hot);
+	if (temp != THERMAL_TEMP_INVALID)
+		hot.temperature = min(hot.temperature, temp);
+	thresholds[ACPM_TMU_HW_TRIP_THRESHOLD] =
+		clamp_val(hot.temperature / MILLIDEGREE_PER_DEGREE, 0, 255);
+
 	/* If a valid lower bound exists, set the threshold and enable its interrupt */
 	if (low > -INT_MAX) {
 		thresholds[0] = clamp_val(low / MILLIDEGREE_PER_DEGREE, 0, 255);
@@ -299,6 +332,34 @@ static int acpm_tmu_set_trips(struct thermal_zone_device *tz, int low, int high)
 	return ret;
 }
 
+static int acpm_tmu_set_trips(struct thermal_zone_device *tz, int low, int high)
+{
+	struct acpm_tmu_sensor *sensor = thermal_zone_device_priv(tz);
+
+	/* The core remembers this window even if programming fails. */
+	sensor->low = low;
+	sensor->high = high;
+
+	return acpm_tmu_program_thresholds(tz, NULL, INT_MAX);
+}
+
+static int acpm_tmu_set_trip_temp(struct thermal_zone_device *tz,
+				  const struct thermal_trip *trip, int temp)
+{
+	if (trip->type != THERMAL_TRIP_HOT)
+		return 0;
+
+	if (temp != THERMAL_TEMP_INVALID &&
+	    (temp < 0 || temp > 255 * MILLIDEGREE_PER_DEGREE))
+		return -EINVAL;
+
+	/*
+	 * The core can skip .set_trips() when the window is unchanged and has
+	 * not committed trip->temperature yet. Substitute the proposed value.
+	 */
+	return acpm_tmu_program_thresholds(tz, trip, temp);
+}
+
 static int acpm_tmu_change_mode(struct thermal_zone_device *tz,
 				enum thermal_device_mode mode)
 {
@@ -329,6 +390,7 @@ static const struct thermal_zone_device_ops acpm_tmu_sensor_ops = {
 	.change_mode = acpm_tmu_change_mode,
 	.get_temp = acpm_tmu_get_temp,
 	.set_trips = acpm_tmu_set_trips,
+	.set_trip_temp = acpm_tmu_set_trip_temp,
 };
 
 static bool acpm_tmu_clear_pending_irq(struct acpm_tmu_sensor *sensor)
@@ -477,6 +539,8 @@ static int acpm_tmu_probe(struct platform_device *pdev)
 		mutex_init(&sensor->lock);
 		sensor->group = &data->sensor_groups[i];
 		sensor->priv = priv;
+		sensor->low = -INT_MAX;
+		sensor->high = INT_MAX;
 
 		tzd = devm_thermal_of_zone_register(dev, i, sensor,
 						    &acpm_tmu_sensor_ops);
-- 
2.34.1

