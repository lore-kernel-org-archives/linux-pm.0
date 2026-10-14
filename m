Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFD041440A
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009182; cv=none; b=gp1NXhcfx9aPkgSQvLsezIGWwbAvktaCLyjUvjV5Bypk8uoEyA1GelRImFpqbI0M9vtEz42hYZh5eLx5p4F1AvcUnnAIXos2Km0k3ytTtJexshIEY29/lE+W0Xrg+iCKuTn7J9/cI1PEdY/Wvly051SzW8w1NsRMOx0eYenD9so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009182; c=relaxed/simple;
	bh=VhPekkJ1ospJsBTWZ6PPvXwhu4fRS9FbS2TvJRmjkwE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XYCBm/waZs6kzZ9ktS/1drj+dWmFf4REk3VHwRbXbMAYAVYUmhN07K50iez5tbBoflD4Nkqv67bmZeVquW31jIWmfpyKltYECFCIz218XlaqFKyNM3qEbzX5fvaZYniyaOXKCF07fwndDpN+bz5qILWPDp2BN9ty62OfpPyLZrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jQV5sXgq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r8upO0Un; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jQV5sXgq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r8upO0Un"
Date: Wed, 14 Oct 2026 20:19:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009178;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nTjlx1T+3GtqdkJowgBMJ0uZa0ksMkxlJHqS22TBTuQ=;
	b=jQV5sXgqbJ427RoddWn3MpMZLtU48FQRUNdeE1he7t1LRr5j3ceoIdOFYrOy040vMTR8hE
	k6VMGoF0xWAc48tJSdq3Wst+b/U6TFs5R+OsFoBpRgD9i1yN3eTaIc0s8i+UUDtuJEmHJ0
	tVqMDp+u68ox9UzXDnfLfOL+ydo0TRj5GD9W7oYIdlLHupyLrbs1t0cjB32MWfQm9pFH9U
	2af7wqzdAEeR4BZMEgpQHjfFu/gyk7+rABx8AU6jwymZTFpZeR/XDMayEnnu6x+zvOYjFi
	sYj9XShU6Kyz9NHFj65iqIKc/FCezTUn90LrlQUVKI+KrfzPeAb+xZN2ecJB7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009178;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nTjlx1T+3GtqdkJowgBMJ0uZa0ksMkxlJHqS22TBTuQ=;
	b=r8upO0UnijnOmco+hPBMRH+gVEaVokBBo2cb+G5kd4Lijw0D1RUgJBnNVqDeiCu/SF1n5q
	JyMx900plGFy7RAg==
From: "thermal-bot for Vitaliy Sochnev" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/airoha: Register a
 thermal zone per AN7583 sensor
Cc: Vitaliy Sochnev <sochnev.v.74@gmail.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260929165209.69669-5-sochnev.v.74@gmail.com>
References: <20260929165209.69669-5-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200917675.2666337.17327784204961776155.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     06a169d840a0d6ce03c230b115cef7d7cebcc2d4
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//06a169d840a0d6ce03c230b115cef7d7cebcc2d4
Author:        Vitaliy Sochnev <sochnev.v.74@gmail.com>
AuthorDate:    Tue, 29 Sep 2026 19:52:09 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 14 Oct 2026 09:45:40 +02:00

thermal/drivers/airoha: Register a thermal zone per AN7583 sensor

AN7583 has three temperature sensors and the driver has constants for
all of them, but it registers one zone and reads only the bandgap sensor.

Register a zone per sensor; the thermal sensor cell selects it. A device
tree may describe fewer zones than sensors. EN7581 still registers one
zone.

Idle and with both cores loaded on a Nokia XG-040G-MF:

  bandgap  56.9 C -> 59.3 C
  GbE      58.7 C -> 61.5 C
  CPU      57.0 C -> 61.1 C

Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20260929165209.69669-5-sochnev.v.74@gmail.com
---
 drivers/thermal/airoha_thermal.c | 64 ++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 13 deletions(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_therma=
l.c
index 0f0e6f3..7c63a1b 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -245,6 +245,11 @@ enum airoha_thermal_chip_scu_field {
 	AIROHA_THERMAL_FIELD_MAX,
 };
=20
+struct airoha_thermal_zone {
+	struct airoha_thermal_priv *priv;
+	int sensor;
+};
+
 struct airoha_thermal_priv {
 	struct regmap *map;
 	struct regmap *chip_scu;
@@ -263,6 +268,9 @@ struct airoha_thermal_priv {
=20
 struct airoha_thermal_soc_data {
 	u32 pllrg_protect;
+	/* Sensor mux value per zone, NULL without a sensor mux */
+	const int *sensors;
+	int num_sensors;
=20
 	const struct thermal_zone_device_ops *thdev_ops;
 	int (*probe)(struct platform_device *pdev,
@@ -348,7 +356,8 @@ static void airoha_set_thermal_mux(struct airoha_thermal_=
priv *priv,
=20
 static int en7581_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct airoha_thermal_priv *priv =3D thermal_zone_device_priv(tz);
+	struct airoha_thermal_zone *zone =3D thermal_zone_device_priv(tz);
+	struct airoha_thermal_priv *priv =3D zone->priv;
 	int min_value, max_value, avg_value, value;
 	int i;
=20
@@ -374,7 +383,8 @@ static int en7581_thermal_get_temp(struct thermal_zone_de=
vice *tz, int *temp)
 static int en7581_thermal_set_trips(struct thermal_zone_device *tz, int low,
 				    int high)
 {
-	struct airoha_thermal_priv *priv =3D thermal_zone_device_priv(tz);
+	struct airoha_thermal_zone *zone =3D thermal_zone_device_priv(tz);
+	struct airoha_thermal_priv *priv =3D zone->priv;
 	bool enable_monitor =3D false;
=20
 	if (high !=3D INT_MAX) {
@@ -642,8 +652,9 @@ static int an7583_thermal_read_diodes(struct airoha_therm=
al_priv *priv,
=20
 static int an7583_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	struct airoha_thermal_priv *priv =3D thermal_zone_device_priv(tz);
-	int sensor_idx;
+	struct airoha_thermal_zone *zone =3D thermal_zone_device_priv(tz);
+	struct airoha_thermal_priv *priv =3D zone->priv;
+	int sensor_idx =3D zone->sensor;
 	int delta_diode, delta_gain;
 	int coeff, slope, offset;
 	int tries =3D AIROHA_THERMAL_MUX_TRIES;
@@ -651,9 +662,6 @@ static int an7583_thermal_get_temp(struct thermal_zone_de=
vice *tz, int *temp)
=20
 	int diode_zero, diode_d0, diode_d1;
=20
-	/* Always read sensor AN7583_BGP_TEMP_SENSOR */
-	sensor_idx =3D AN7583_BGP_TEMP_SENSOR;
-
 	coeff =3D an7583_thermal_coeff[sensor_idx];
 	slope =3D an7583_thermal_slope[sensor_idx];
 	offset =3D an7583_thermal_offset[sensor_idx];
@@ -717,7 +725,7 @@ static int airoha_thermal_probe(struct platform_device *p=
dev)
 	const struct airoha_thermal_soc_data *soc_data;
 	struct airoha_thermal_priv *priv;
 	struct device *dev =3D &pdev->dev;
-	int ret;
+	int ret, i;
=20
 	soc_data =3D device_get_match_data(dev);
=20
@@ -739,11 +747,31 @@ static int airoha_thermal_probe(struct platform_device =
*pdev)
 		return ret;
=20
 	/* register of thermal sensor and get info from DT */
-	priv->tz =3D devm_thermal_of_zone_register(dev, 0, priv,
-						 soc_data->thdev_ops);
-	if (IS_ERR(priv->tz)) {
-		dev_err(dev, "register thermal zone sensor failed\n");
-		return PTR_ERR(priv->tz);
+	for (i =3D 0; i < soc_data->num_sensors; i++) {
+		struct airoha_thermal_zone *zone;
+		struct thermal_zone_device *tz;
+
+		zone =3D devm_kzalloc(dev, sizeof(*zone), GFP_KERNEL);
+		if (!zone)
+			return -ENOMEM;
+
+		zone->priv =3D priv;
+		zone->sensor =3D soc_data->sensors ? soc_data->sensors[i] :
+						   AIROHA_THERMAL_NO_MUX_SENSOR;
+
+		tz =3D devm_thermal_of_zone_register(dev, i, zone,
+						   soc_data->thdev_ops);
+		if (IS_ERR(tz)) {
+			/* A DT may describe fewer zones than sensors */
+			if (i && PTR_ERR(tz) =3D=3D -ENODEV)
+				continue;
+
+			dev_err(dev, "register thermal zone %d failed\n", i);
+			return PTR_ERR(tz);
+		}
+
+		if (!i)
+			priv->tz =3D tz;
 	}
=20
 	platform_set_drvdata(pdev, priv);
@@ -751,7 +779,15 @@ static int airoha_thermal_probe(struct platform_device *=
pdev)
 	return soc_data->post_probe ? soc_data->post_probe(pdev) : 0;
 }
=20
+/* The bandgap sensor stays zone 0 */
+static const int an7583_zone_sensors[AN7583_NUM_SENSOR] =3D {
+	AN7583_BGP_TEMP_SENSOR,
+	AN7583_GBE_TEMP_SENSOR,
+	AN7583_CPU_TEMP_SENSOR,
+};
+
 static const struct airoha_thermal_soc_data en7581_data =3D {
+	.num_sensors =3D 1,
 	.pllrg_protect =3D EN7581_SCU_THERMAL_PROTECT_KEY,
 	.thdev_ops =3D &en7581_thdev_ops,
 	.probe =3D &en7581_thermal_probe,
@@ -759,6 +795,8 @@ static const struct airoha_thermal_soc_data en7581_data =
=3D {
 };
=20
 static const struct airoha_thermal_soc_data an7583_data =3D {
+	.sensors =3D an7583_zone_sensors,
+	.num_sensors =3D AN7583_NUM_SENSOR,
 	.pllrg_protect =3D AN7583_SCU_THERMAL_PROTECT_KEY,
 	.thdev_ops =3D &an7583_tz_ops,
 	.probe =3D &an7583_thermal_probe,
