Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F01C4A2A6D
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009204; cv=none; b=ZWkzD5lgwG0Of3L1inhuBiUFproEOmDfSfz8DKphf5nT2Nd8VuIpA44EZI7aOCqmykwQmH7V4xJIOuAznxvNFTaNTQvBRxZ8QVlaAZGQRGQQAj5aBuMgFwPnQE4fIViAi7KZTtdtE8rtYbxJE2OIw0DvnNk4jtDuhEX6AHJPDXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009204; c=relaxed/simple;
	bh=MCE8G308Jo24LvinYDfuBHlX3N4KgKU+YxbLWyXKtMs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MjbqAP85LpxhpIj/gb32W6JeX9luDEsBbh2bEbuF0uODp8T7fjdTQVITBrQLWdYepThYQYU9lHR5cGJBux3d+XS+VrSb+xKp+UmdWDDjjsKwOQPnryFEMSMDZ9O6G6SnSd7OvxsOhw7blbpqo+ls/U4xYIzMBAlWRlyrzh0FcwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lwNcpzAB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WuWh/ojp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lwNcpzAB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WuWh/ojp"
Date: Wed, 14 Oct 2026 20:19:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009201;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dg8Y+RvlHSvzp89ROgooCx+1TMkZnMu+R3UKOboTA9Q=;
	b=lwNcpzABD8n/arNcOnmqoNKr3C1hklmxIJDUJOYku8f78LQgwOrr5PmpY3AAFVnCINGTEJ
	CUq52tE1lUkfO/aG4d1HKZ8rjPe9meaN9jJ0Qf6KHY3N2SGt0oe8sNRc4SsWn1X0JYqCWP
	qGaE8W/79kbq9YwCBvh1yy7gXSr0Fac8v5nxp0zz1bKuyUcS0M7n/TYQyKts3yLrKU1iL5
	p4UNAltM6OCP8s1MSjZp7OsaJ2dHdA11EH3DAReEpjDiOpFchEBcj1NWGKS0RXhZVxPm/5
	rUB/vfzDrs/JoErfMmCfE01PAkCH0q3FyhxXp6S64dvHuFSKfwnFx8s2SjbBZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009201;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dg8Y+RvlHSvzp89ROgooCx+1TMkZnMu+R3UKOboTA9Q=;
	b=WuWh/ojpTiFedYXGW1IXT+QuZ5tPL2N2ZW5woSQgqgLlEz1HVH9ltaDqXhfmYTwCCrUgvG
	SZDpqYKBE5DOkFDQ==
From: "thermal-bot for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/renesas/rzg3s: Convert
 calibration defaults to per-SoC match data
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260925061617.127349-3-biju.das.jz@bp.renesas.com>
References: <20260925061617.127349-3-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200919949.2666337.16841963928682139963.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     91e5a33675e56dbc982703655cdf4637f5e76f23
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//91e5a33675e56dbc982703655cdf4637f5e76f23
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Fri, 25 Sep 2026 07:16:00 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Sun, 27 Sep 2026 23:01:10 +02:00

thermal/drivers/renesas/rzg3s: Convert calibration defaults to per-SoC match =
data

Move the default (software) calibration values SW_CALIB0_VAL and
SW_CALIB1_VAL, used when FUSE values are missing, into a new
struct rzg3s_thermal_info retrieved via of_device_get_match_data().

This allows different SoCs sharing this driver to provide their own
default calibration constants, which is needed as RZ/G3L uses
different values than RZ/G3S.

No functional change intended for RZ/G3S.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260925061617.127349-3-biju.das.jz@bp.renesas=
.com
---
 drivers/thermal/renesas/rzg3s_thermal.c | 32 +++++++++++++++++-------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/renesas/rzg3s_thermal.c b/drivers/thermal/renesa=
s/rzg3s_thermal.c
index 7ced8f7..146b73a 100644
--- a/drivers/thermal/renesas/rzg3s_thermal.c
+++ b/drivers/thermal/renesas/rzg3s_thermal.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/reset.h>
 #include <linux/thermal.h>
 #include <linux/units.h>
@@ -27,10 +28,6 @@
=20
 #define TSU_READ_STEPS		8
=20
-/* Default calibration values, if FUSE values are missing. */
-#define SW_CALIB0_VAL		1297
-#define SW_CALIB1_VAL		751
-
 #define MCELSIUS(temp)		((temp) * MILLIDEGREE_PER_DEGREE)
=20
 /**
@@ -55,6 +52,16 @@ struct rzg3s_thermal_priv {
 	u16 calib1;
 };
=20
+/**
+ * struct rzg3s_thermal_info - RZ/G3S thermal information
+ * @calib0: calibration value if FUSE value is missing
+ * @calib1: calibration value if FUSE value is missing
+ */
+struct rzg3s_thermal_info {
+	u16 calib0;
+	u16 calib1;
+};
+
 static int rzg3s_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	struct rzg3s_thermal_priv *priv =3D thermal_zone_device_priv(tz);
@@ -149,7 +156,8 @@ static const struct thermal_zone_device_ops rzg3s_tz_of_o=
ps =3D {
 	.change_mode =3D rzg3s_thermal_change_mode,
 };
=20
-static int rzg3s_thermal_read_calib(struct rzg3s_thermal_priv *priv)
+static int rzg3s_thermal_read_calib(struct rzg3s_thermal_priv *priv,
+				    const struct rzg3s_thermal_info *info)
 {
 	struct device *dev =3D priv->dev;
 	u32 val;
@@ -163,13 +171,13 @@ static int rzg3s_thermal_read_calib(struct rzg3s_therma=
l_priv *priv)
 	if (val & OTPTSUTRIM_EN_MASK)
 		priv->calib0 =3D FIELD_GET(OTPTSUTRIM_MASK, val);
 	else
-		priv->calib0 =3D SW_CALIB0_VAL;
+		priv->calib0 =3D info->calib0;
=20
 	val =3D readl(priv->base + OTPTSUTRIM_REG(1));
 	if (val & OTPTSUTRIM_EN_MASK)
 		priv->calib1 =3D FIELD_GET(OTPTSUTRIM_MASK, val);
 	else
-		priv->calib1 =3D SW_CALIB1_VAL;
+		priv->calib1 =3D info->calib1;
=20
 	pm_runtime_put_autosuspend(dev);
=20
@@ -178,6 +186,7 @@ static int rzg3s_thermal_read_calib(struct rzg3s_thermal_=
priv *priv)
=20
 static int rzg3s_thermal_probe(struct platform_device *pdev)
 {
+	const struct rzg3s_thermal_info *info =3D device_get_match_data(&pdev->dev);
 	struct rzg3s_thermal_priv *priv;
 	struct device *dev =3D &pdev->dev;
 	int ret;
@@ -208,7 +217,7 @@ static int rzg3s_thermal_probe(struct platform_device *pd=
ev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to enable runtime PM!\n");
=20
-	ret =3D rzg3s_thermal_read_calib(priv);
+	ret =3D rzg3s_thermal_read_calib(priv, info);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to read calibration data!\n");
=20
@@ -251,8 +260,13 @@ static const struct dev_pm_ops rzg3s_thermal_pm_ops =3D {
 	SYSTEM_SLEEP_PM_OPS(rzg3s_thermal_suspend, rzg3s_thermal_resume)
 };
=20
+static const struct rzg3s_thermal_info rzg3s_info =3D {
+	.calib0 =3D 1297,
+	.calib1 =3D 751,
+};
+
 static const struct of_device_id rzg3s_thermal_dt_ids[] =3D {
-	{ .compatible =3D "renesas,r9a08g045-tsu" },
+	{ .compatible =3D "renesas,r9a08g045-tsu", .data =3D &rzg3s_info },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzg3s_thermal_dt_ids);
