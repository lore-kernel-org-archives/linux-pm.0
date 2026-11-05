Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893772;
	b=zCVjqjRkztpiUBR9J9Lc42y+HOjbhQOMtKTJrJYgWNe8M8dsYLmKzeGglRvSPY3Silw2
	 mEHwHU1oyYJYsXiebJ2onkDmNYIU/XZ4HFHwS0tlFcbvClvS1OrHmUNmvEu9g1W+L0x26
	 HMKFF/gwcGWiyQkkjrQp+hN3LGiKv09Nq1RGuF3Pmb4gv/DZFVVIoGaEc53EbvIqeE9aG
	 EvKyVynHL8xmhXxUvb5N6dv2JvrPyV/lHSTTMktVKiYFnk1FuDy5fCIU0E04sxZku6x+O
	 ULZrwcYzPI4D9hQ4hN9f+kPEbrqKvZT7WaeoMPtE78Fx4mDFWMUUDMDcA+mQzuuWYuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893772;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=UwbaSl6CWOKQJqF9u3nY9lqR11TliAYhsL7rNvoMn1w=;
	b=M8OqVRmoe5HLaWWZ4nBbshXnYisJNppeShfFgSjQKrzZyrV3boXxpJtKop9s5wT2HynD
	 SHFvO1gf+cOPWRd6fXVbYvQcJ/yuxM8lakVlA9L5JhhsdIFKBFH+YbYApueVFq7Gv5C9S
	 NLJfQY1ctv+6DYkQHmZQUNg/Gbdlinch4FMc9r9zzTY/bJtBj8CWOFDLnioOx3VQ1LyjZ
	 yPc6FHWm7+DYfTsy3N8V/3FknawzOshTjRLHjhuvZ2+VPBh8G9Sv+vYUaL93K6Juzd30W
	 Mot1r+bUNHn9ABJct9abzp3KFZclqtsXk48C4ejmLg2rdsOPYRJ+9tfXdjmv1WFI6Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Ppe3q1UF;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=vkK1Vs82;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B943760A5BC0
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 15:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B943760A5BC0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Ppe3q1UF;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=vkK1Vs82
Date: Thu, 05 Nov 2026 15:49:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1793893770;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UwbaSl6CWOKQJqF9u3nY9lqR11TliAYhsL7rNvoMn1w=;
	b=Ppe3q1UFIzIlKK11+BFaMVKP1XAuqGn7slf4T18EbWEI0KBL5l01rfdSrbGm1f2/hhHd+4
	+l1XFeO17n5mKn5XueP3BLKNnauT8Drp81XY+j3Cp112noO38CZaSqSPKco0NS+m7K2Cd1
	hLjif6gszEucYu2k5WbZ415JxHe7y27P0vPt872fF+qQacHUcR9c1yuM0H0KsYQzucG6Qz
	h0saSYQLOfkCCy4irSxtLujS0AwriMAtQMEUIbm4BoSoQS589xMGhHYPZk0LkMLkupR1Iw
	D0n/FNDCVjqrYt8UKdEWQtycdU7tZEOqfh1S45yYFbCNB0ec9iqhzZQGYR7SUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1793893770;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UwbaSl6CWOKQJqF9u3nY9lqR11TliAYhsL7rNvoMn1w=;
	b=vkK1Vs82Ac2hvUGdyXjTWdBBtK9TUIMv1r8MPh5IG+E44ZQMkMKrNq377DgpdvaS81LgfI
	PN/qipH13JaMZ4Cw==
From: "thermal-bot for Tudor Ambarus" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/samsung: acpm-tmu:
 Implement .change_mode() callback
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>
In-Reply-To: <20261026-acpm-tmu-fixes-v1-5-0637431b7268@linaro.org>
References: <20261026-acpm-tmu-fixes-v1-5-0637431b7268@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179389376818.1009794.7017463131205959666.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     09e928b13aaddbefc08aeca13b1a78bd8b0feb14
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//09e928b13aaddbefc08aeca13b1a78bd8b0feb14
Author:        Tudor Ambarus <tudor.ambarus@linaro.org>
AuthorDate:    Mon, 26 Oct 2026 16:01:22=20
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Tue, 03 Nov 2026 19:51:50 +01:00

thermal/drivers/samsung: acpm-tmu: Implement .change_mode() callback

Because acpm-tmu did not implement the .change_mode() callback and
instead enabled the hardware sensor manually after registration, the
hardware sensor state was out of sync with the thermal core:

1. Disabling a thermal zone (e.g. via /sys/class/thermal/thermal_zone*/mode
   or thermal_of_zone_unregister()) only set tz->mode to
   THERMAL_DEVICE_DISABLED and stopped software polling, while leaving
   sensor->enabled true and the ACPM TMU sensor active in hardware.
   Consequently, crossing a trip threshold still fired the hardware IRQ
   and ran acpm_tmu_thread_fn(), where thermal_zone_device_update()
   returned early without updating the trip window. Direct sysfs and
   hwmon temperature reads via thermal_zone_get_temp() also continued to
   resume the device and query ACPM over IPC on a disabled zone.
2. System suspend/resume paths in acpm_tmu_control() unconditionally
   toggled all registered sensors without checking the thermal zone mode
   or current hardware state. As a result, acpm_tmu_suspend() issued
   redundant disable IPC calls for already-disabled zones,
   acpm_tmu_resume() unconditionally re-enabled zones that had been
   disabled via sysfs prior to suspend, and suspend error recovery sent
   redundant enable IPC calls to sensors that had not yet been disabled.
3. devm_thermal_of_zone_register() enables the zone and triggers an
   initial thermal_zone_device_update() before returning. Because
   sensor->enabled was still false during registration, the initial
   acpm_tmu_get_temp() call failed with -EAGAIN and scheduled a retry,
   requiring a manual sensor enable and a second
   thermal_zone_device_update() call in acpm_tmu_probe().

Implement the .change_mode() callback to manage sensor hardware state
transitions directly through the thermal core and record the requested
zone mode in sensor->mode. Update acpm_tmu_control() to only toggle
sensors whose zone mode is THERMAL_DEVICE_ENABLED and whose
sensor->enabled state differs from the target state. Drop the redundant
manual sensor enablement and thermal_zone_device_update() call from
acpm_tmu_probe().

Fixes: 50a2c5d4062a ("thermal/drivers/samsung: Add Exynos ACPM TMU driver GS1=
01")
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20261026-acpm-tmu-fixes-v1-5-0637431b7268@lina=
ro.org
---
 drivers/thermal/samsung/acpm-tmu.c | 59 +++++++++++++++++++----------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/drivers/thermal/samsung/acpm-tmu.c b/drivers/thermal/samsung/acp=
m-tmu.c
index 55ee972..69793fc 100644
--- a/drivers/thermal/samsung/acpm-tmu.c
+++ b/drivers/thermal/samsung/acpm-tmu.c
@@ -68,6 +68,7 @@ struct acpm_tmu_sensor {
 	struct thermal_zone_device *tzd;
 	struct acpm_tmu_priv *priv;
 	struct mutex lock; /* protects sensor state */
+	enum thermal_device_mode mode;
 	bool enabled;
 };
=20
@@ -188,9 +189,12 @@ static int acpm_tmu_control(struct acpm_tmu_priv *priv, =
bool on)
 		if (!sensor->tzd)
 			continue;
=20
-		mutex_lock(&sensor->lock);
-		ret =3D acpm_tmu_op_tz_control(sensor, on);
-		mutex_unlock(&sensor->lock);
+		scoped_guard(mutex, &sensor->lock) {
+			ret =3D 0;
+			if (sensor->mode =3D=3D THERMAL_DEVICE_ENABLED &&
+			    sensor->enabled !=3D on)
+				ret =3D acpm_tmu_op_tz_control(sensor, on);
+		}
 		if (ret && !err)
 			err =3D ret;
 	}
@@ -313,7 +317,34 @@ static int acpm_tmu_set_trips(struct thermal_zone_device=
 *tz, int low, int high)
 	return ret;
 }
=20
+static int acpm_tmu_change_mode(struct thermal_zone_device *tz,
+				enum thermal_device_mode mode)
+{
+	struct acpm_tmu_sensor *sensor =3D thermal_zone_device_priv(tz);
+	struct acpm_tmu_priv *priv =3D sensor->priv;
+	struct device *dev =3D priv->dev;
+	bool enable =3D (mode =3D=3D THERMAL_DEVICE_ENABLED);
+	int ret;
+
+	ret =3D pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	scoped_guard(mutex, &sensor->lock) {
+		ret =3D 0;
+		if (sensor->enabled !=3D enable)
+			ret =3D acpm_tmu_op_tz_control(sensor, enable);
+		if (!ret)
+			sensor->mode =3D mode;
+	}
+
+	pm_runtime_put_autosuspend(dev);
+
+	return ret;
+}
+
 static const struct thermal_zone_device_ops acpm_tmu_sensor_ops =3D {
+	.change_mode =3D acpm_tmu_change_mode,
 	.get_temp =3D acpm_tmu_get_temp,
 	.set_trips =3D acpm_tmu_set_trips,
 };
@@ -463,17 +494,17 @@ static int acpm_tmu_probe(struct platform_device *pdev)
=20
 	for (i =3D 0; i < priv->num_sensors; i++) {
 		struct acpm_tmu_sensor *sensor =3D &priv->sensors[i];
+		struct thermal_zone_device *tzd;
=20
 		mutex_init(&sensor->lock);
 		sensor->group =3D &data->sensor_groups[i];
 		sensor->priv =3D priv;
=20
-		sensor->tzd =3D devm_thermal_of_zone_register(dev, i, sensor,
-							    &acpm_tmu_sensor_ops);
-		if (IS_ERR(sensor->tzd)) {
-			ret =3D PTR_ERR(sensor->tzd);
+		tzd =3D devm_thermal_of_zone_register(dev, i, sensor,
+						    &acpm_tmu_sensor_ops);
+		if (IS_ERR(tzd)) {
+			ret =3D PTR_ERR(tzd);
 			if (ret =3D=3D -ENODEV) {
-				sensor->tzd =3D NULL;
 				dev_dbg(dev, "Sensor %d not used in DT, skipping\n", i);
 				continue;
 			}
@@ -481,17 +512,7 @@ static int acpm_tmu_probe(struct platform_device *pdev)
 			ret =3D dev_err_probe(dev, ret, "Failed to register sensor %d\n", i);
 			goto err_rollback;
 		}
-
-		mutex_lock(&sensor->lock);
-		ret =3D acpm_tmu_op_tz_control(sensor, true);
-		mutex_unlock(&sensor->lock);
-		if (ret) {
-			ret =3D dev_err_probe(dev, ret, "Failed to enable sensor %d\n", i);
-			goto err_rollback;
-		}
-
-		thermal_zone_device_update(sensor->tzd,
-					   THERMAL_EVENT_UNSPECIFIED);
+		sensor->tzd =3D tzd;
=20
 		ret =3D devm_thermal_add_hwmon_sysfs(dev, sensor->tzd);
 		if (ret)
