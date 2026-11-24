Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526890;
	b=P68+qkeEFFM6/JQJxtCh9ZDqZ+LmSYbIhXKJTl29q5N6yJff1RLo8k79P5gdN/TVRKD7
	 byucrpoLEHvMhv6XXS8QQa7QCMx5tXCy3B6MTX5WseJykRh4+J+LhW8OzAFVoSOE+muEL
	 RquK8nEdscSFiA5NzDxSCG1TU14fVYXBolkKFc7xLRF/7+I9ydGnmdECt9WVkNJBj5Xk4
	 wm9BON3Se2bxMc9JTSNkOSKUA7OH9cHddaWOFOsE8j/XVKHlIOydKpcYLOyOzfU8x6O21
	 MeIQvr+HxWUhny5s3S3LBEMXzZ1E9M9RGXFq4DEFhL0R50opKPBm2R7jVODJjUqRaww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526890;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ETQq20MuksAGlwb3NO4DBAjWNREDGehauvLDnlkj6/s=;
	b=rnoDC7Ydsm76DbhJHIdlKhbDI8QYGF2/gDQ1H0BFFdYs3oLyfJwBEqZJxDlyPPi4F+Kj
	 WZgQXB6jmP2KKaiDhzCEAzKnwNSyxOUFYZ5j62I71mXw2aYnaGUI3/eO2Ss736Kw/vHSh
	 UOFE2amdUkgBgReSschyjAzXM0oAU8TTzPYgYSO+oaHYcQqqNa1EPmGp6OMYNGjyikR5L
	 6k95zInbrXoe+UN2+lEk51O94UP/r9EsEyWyptHRGAsfQv2H0MlgKLY5Xio0+Q+V4BbLr
	 wcJFIg14wd3hKuqr2WkbeOlM9G37bqDs6zgRInnxPnGMQC2HRA4r8KGUChYDG0pPN0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=exDRlvWF;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9C5606A31E;
	Tue, 24 Nov 2026 13:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F9C5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=exDRlvWF
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BEB1D339;
	Tue, 24 Nov 2026 05:28:05 -0800 (PST)
Received: from e127648.arm.com (unknown [10.57.71.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 37AE33F882;
	Tue, 24 Nov 2026 05:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795526888; bh=GVdatysqi0e4G0sd2VbmtUUpEO7i1Weoa/mvmiArCXg=;
	h=From:To:Cc:Subject:Date:From;
	b=exDRlvWFwL12WP1PWCwZb4SIgXR8PW54RjYkiT2ssv8RNvSJ5I/lPj+aOvJ4OtwFF
	 GsBx43FBNNCF1WAj3E++bM78yR8XjOoND1nSKuehWreq0DRpai3tXTslpv4Bdgn7D3
	 NvvHSNiGSSSHGLIrsqvQNr5f3DOUhv7jhedaHEfc=
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
Subject: [PATCHv2] thermal: samsung: acpm-tmu: Fix spurious CPU throttling
Date: Tue, 24 Nov 2026 13:27:56 +0000
Message-Id: <20261124132756.1306906-1-christian.loehle@arm.com>
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

Program slot 7 from the lowest active critical trip. Cache the low/high
window and update the critical limit from set_trip_temp(), because the
thermal core skips set_trips() when that window is unchanged.

Suggested-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Fixes: 50a2c5d4062a ("thermal/drivers/samsung: Add Exynos ACPM TMU driver GS101")
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
Since v1:
- Rebase onto linux-next, including Daniel’s queued ACPM TMU fixes.
- Cache only low/high and look up the lowest active critical trip when programming. (Tudor)
- Retain the requested window even if programming fails, matching the thermal core.
- Handle critical-trip deactivation and zones without an active critical trip.

 drivers/thermal/samsung/acpm-tmu.c | 76 +++++++++++++++++++++++++++---
 1 file changed, 70 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acpm-tmu.c
index 4799ef518a7a..6923256af1f2 100644
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
+struct acpm_tmu_critical_trip {
+	const struct thermal_trip *updated;
+	int temperature;
+};
+
+static int acpm_tmu_get_crit_temp(struct thermal_trip *trip, void *arg)
+{
+	struct acpm_tmu_critical_trip *critical = arg;
+
+	if (trip->type == THERMAL_TRIP_CRITICAL && trip != critical->updated &&
+	    trip->temperature != THERMAL_TEMP_INVALID)
+		critical->temperature = min(critical->temperature, trip->temperature);
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
+	struct acpm_tmu_critical_trip critical = { trip, INT_MAX };
+	u8 thresholds[ACPM_TMU_NUM_THRESHOLDS] = {};
+	int low = sensor->low, high = sensor->high;
 	u8 inten = 0;
 	int ret;
 
+	/* Exclude the trip being updated until the proposed value is considered. */
+	for_each_thermal_trip(tz, acpm_tmu_get_crit_temp, &critical);
+	if (temp != THERMAL_TEMP_INVALID)
+		critical.temperature = min(critical.temperature, temp);
+	thresholds[ACPM_TMU_HW_TRIP_THRESHOLD] =
+		clamp_val(critical.temperature / MILLIDEGREE_PER_DEGREE, 0, 255);
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
+	if (trip->type != THERMAL_TRIP_CRITICAL)
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

base-commit: e8017d29067fd1310a65c3494ce1a1b492adbac6
-- 
2.34.1

