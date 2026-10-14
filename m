Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC85485929
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009185; cv=none; b=VUh8pd+/KIfU5K26X3v4F0lnzpDUmgu5nrR14vM6ZSlWtohkqPEGtkXBYB8DjE1IN9gW8Dp3bkC1wnDbYJ7NKbAH3BdUCsed3qvnrboPq7I+rMLxPRAvOviIrcArdm8lnJI7xVLojP5lgfhX/k0zoDWV0rfleuZhGgST/+ePlJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009185; c=relaxed/simple;
	bh=B+RdroiS0h4HmQ5I2KUQ74sslP857yN+Smcu+OuZHi4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A5ttXLtxXikjjZ+LV9xOl1g8yJovPxnBTTwKQhvQtz62dyJ6j80cvZptNUxYhNGivh/qWDv+e5n3ORLyU50HeTQOYVEtZ1niASR0YfG0Uxnkp4UELN29hmv9pVrOg9nQcqTU7ekBjOiIWpnFAX2msWKHBb5Ae2OI2hhmM3gdg9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i+Fno6YJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=suMYUiAn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i+Fno6YJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="suMYUiAn"
Date: Wed, 14 Oct 2026 20:19:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009181;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulcKsdpiUJhjU1rb5rSJxDbevh3dl5n0bh86TpSfALk=;
	b=i+Fno6YJTPLLljoU9YUkxIgCHaG3feF9K7WE/fF0y4PKcI/rY+I+2fPbvtUe2ntm544cJN
	j1Qyv31Os1mIPV5gqJ41h3bVMNUGlHhNBcMWTAC6LUQA8zDmCLvbyE/p8Nk0d4I9BK1ZGW
	IM/2wo4bvH5oec/l9mKkl3ww5impFnwG/zOWCXDdQwFl5XgWlKtCZigjMUB454SOsd8cHG
	K7l7e6gkmEqrwdYl7J+anYSQoN5h0YHMlZqyJ1r0ZWWnYhdnrPTJhuQpR/8gzp5QJgIABC
	d0iAR7KdCsIeNGiaenE9rQPYb9pd/Vx3S8SVef3kLeXGvA/GiaDOzmYUFfzXPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009181;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ulcKsdpiUJhjU1rb5rSJxDbevh3dl5n0bh86TpSfALk=;
	b=suMYUiAnDm2Zzn/tY+XYooZWgx4qxjT93xFWuYDvYZ3MQMpqS1X8HWesUwxNzpbPM/YE0E
	miHLvN+fEjMz/EBA==
From: "thermal-bot for Vitaliy Sochnev" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/airoha: Serialise
 access to the shared ADC
Cc: Vitaliy Sochnev <sochnev.v.74@gmail.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260929165209.69669-3-sochnev.v.74@gmail.com>
References: <20260929165209.69669-3-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200918002.2666337.11523530805865659801.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     b1bf55053abed0d72738bcc12297bfa09f45eeb4
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//b1bf55053abed0d72738bcc12297bfa09f45eeb4
Author:        Vitaliy Sochnev <sochnev.v.74@gmail.com>
AuthorDate:    Tue, 29 Sep 2026 19:52:07 +03:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Wed, 14 Oct 2026 09:45:40 +02:00

thermal/drivers/airoha: Serialise access to the shared ADC

A read selects the sensor and walks three diodes with a 10 ms settle on
each. The zone lock serialises reads of one zone. With a zone per AN7583
sensor, added later in this series, reads of different zones interleave
and convert samples taken at another mux position.

Mux writes are dropped silently unless PLLRG_PROTECT is lifted, and its
save and restore do not nest. The cached TADC value also skips a write
after another reader has moved the mux.

With the AN7583 sensors read as parallel zones during CPU frequency
changes, a zone crossed its critical trip on a chip at 55 C and the
board shut down.

Serialise the sequence, drop the cache, check the selection after
writing and after sampling, and return -EAGAIN if it does not hold.

Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20260929165209.69669-3-sochnev.v.74@gmail.com
---
 drivers/thermal/airoha_thermal.c | 85 ++++++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_therma=
l.c
index 1b187c4..0f0e6f3 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -5,6 +5,7 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/syscon.h>
+#include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
@@ -191,6 +192,7 @@
 #define AN7583_NUM_SENSOR			3
=20
 #define AIROHA_THERMAL_NO_MUX_SENSOR		-1
+#define AIROHA_THERMAL_MUX_TRIES		3
=20
 /* Convert temp to raw value as read from ADC	((((temp / 100) - init) * slop=
e) / 1000) + offset */
 #define TEMP_TO_RAW(priv, temp)			((((((temp) / 100) - (priv)->init_temp) * \
@@ -250,7 +252,8 @@ struct airoha_thermal_priv {
 	struct resource scu_adc_res;
=20
 	u32 pllrg_protect;
-	int current_adc;
+	/* Serialises mux selection and ADC sampling */
+	struct mutex lock;
=20
 	struct thermal_zone_device *tz;
 	int init_temp;
@@ -294,9 +297,26 @@ static int airoha_get_thermal_ADC(struct airoha_thermal_=
priv *priv)
 	return val;
 }
=20
+static bool airoha_thermal_mux_holds(struct airoha_thermal_priv *priv,
+				     int tdac_idx, int sensor_idx)
+{
+	unsigned int val;
+
+	if (regmap_field_read(priv->chip_scu_fields[AIROHA_THERMAL_MUX_TADC], &val)=
 ||
+	    val !=3D tdac_idx)
+		return false;
+
+	if (sensor_idx =3D=3D AIROHA_THERMAL_NO_MUX_SENSOR)
+		return true;
+
+	return !regmap_field_read(priv->chip_scu_fields[AIROHA_THERMAL_MUX_SENSOR],=
 &val) &&
+	       val =3D=3D sensor_idx;
+}
+
 static void airoha_set_thermal_mux(struct airoha_thermal_priv *priv,
 				   int tdac_idx, int sensor_idx)
 {
+	int tries =3D AIROHA_THERMAL_MUX_TRIES;
 	u32 pllrg;
=20
 	/* Save PLLRG current value */
@@ -307,19 +327,17 @@ static void airoha_set_thermal_mux(struct airoha_therma=
l_priv *priv,
 		     priv->pllrg_protect);
=20
 	/*
-	 * Configure Thermal Sensor mux to sensor_idx.
+	 * Configure Thermal Sensor mux to sensor_idx and Thermal ADC mux to
+	 * tdac_idx. Writes can be dropped silently, so read them back.
 	 * (if not supported, sensor_idx is AIROHA_THERMAL_NO_MUX_SENSOR)
 	 */
-	if (sensor_idx !=3D AIROHA_THERMAL_NO_MUX_SENSOR)
-		regmap_field_write(priv->chip_scu_fields[AIROHA_THERMAL_MUX_SENSOR],
-				   sensor_idx);
-
-	/* Configure Thermal ADC mux to tdac_idx */
-	if (priv->current_adc !=3D tdac_idx) {
+	do {
+		if (sensor_idx !=3D AIROHA_THERMAL_NO_MUX_SENSOR)
+			regmap_field_write(priv->chip_scu_fields[AIROHA_THERMAL_MUX_SENSOR],
+					   sensor_idx);
 		regmap_field_write(priv->chip_scu_fields[AIROHA_THERMAL_MUX_TADC],
 				   tdac_idx);
-		priv->current_adc =3D tdac_idx;
-	}
+	} while (!airoha_thermal_mux_holds(priv, tdac_idx, sensor_idx) && --tries);
=20
 	/* Restore PLLRG value on exit */
 	regmap_write(priv->chip_scu, EN7581_PLLRG_PROTECT, pllrg);
@@ -596,12 +614,40 @@ static int en7581_thermal_post_probe(struct platform_de=
vice *pdev)
 	return 0;
 }
=20
+static int an7583_thermal_read_diode(struct airoha_thermal_priv *priv,
+				     int diode, int sensor_idx, int *val)
+{
+	airoha_set_thermal_mux(priv, diode, sensor_idx);
+	*val =3D airoha_get_thermal_ADC(priv);
+
+	return airoha_thermal_mux_holds(priv, diode, sensor_idx) ? 0 : -EAGAIN;
+}
+
+static int an7583_thermal_read_diodes(struct airoha_thermal_priv *priv,
+				      int sensor_idx, int *zero, int *d0,
+				      int *d1)
+{
+	int ret;
+
+	ret =3D an7583_thermal_read_diode(priv, AN7583_ZERO_TADC, sensor_idx, zero);
+	if (ret)
+		return ret;
+
+	ret =3D an7583_thermal_read_diode(priv, AN7583_D0_TADC, sensor_idx, d0);
+	if (ret)
+		return ret;
+
+	return an7583_thermal_read_diode(priv, AN7583_D1_TADC, sensor_idx, d1);
+}
+
 static int an7583_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct airoha_thermal_priv *priv =3D thermal_zone_device_priv(tz);
 	int sensor_idx;
 	int delta_diode, delta_gain;
 	int coeff, slope, offset;
+	int tries =3D AIROHA_THERMAL_MUX_TRIES;
+	int ret;
=20
 	int diode_zero, diode_d0, diode_d1;
=20
@@ -612,12 +658,14 @@ static int an7583_thermal_get_temp(struct thermal_zone_=
device *tz, int *temp)
 	slope =3D an7583_thermal_slope[sensor_idx];
 	offset =3D an7583_thermal_offset[sensor_idx];
=20
-	airoha_set_thermal_mux(priv, AN7583_ZERO_TADC, sensor_idx);
-	diode_zero =3D airoha_get_thermal_ADC(priv);
-	airoha_set_thermal_mux(priv, AN7583_D0_TADC, sensor_idx);
-	diode_d0 =3D airoha_get_thermal_ADC(priv);
-	airoha_set_thermal_mux(priv, AN7583_D1_TADC, sensor_idx);
-	diode_d1 =3D airoha_get_thermal_ADC(priv);
+	mutex_lock(&priv->lock);
+	do {
+		ret =3D an7583_thermal_read_diodes(priv, sensor_idx, &diode_zero,
+						 &diode_d0, &diode_d1);
+	} while (ret =3D=3D -EAGAIN && --tries);
+	mutex_unlock(&priv->lock);
+	if (ret)
+		return ret;
=20
 	delta_diode =3D diode_d1 - diode_d0;
 	delta_gain =3D (delta_diode * coeff) / 100 + (diode_zero - diode_d1);
@@ -678,7 +726,10 @@ static int airoha_thermal_probe(struct platform_device *=
pdev)
 		return -ENOMEM;
=20
 	priv->pllrg_protect =3D soc_data->pllrg_protect;
-	priv->current_adc =3D -1;
+
+	ret =3D devm_mutex_init(dev, &priv->lock);
+	if (ret)
+		return ret;
=20
 	if (!soc_data->probe)
 		return -EINVAL;
