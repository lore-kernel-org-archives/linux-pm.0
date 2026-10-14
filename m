Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AB34A2A6D
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009221; cv=none; b=aIoN1tDVFehRVXLeAu4ljRyMy6AJQX6Ofmea6rYTled8yE6U6s8J7sHOUFKQy7ZwhYWBY5PXyL4AoVlBkqakO7ptt7CL6v878oAgnp3JSsx4HGSI3g1Y0WpXe8PdnLhkoOxMdYshmUW7GmO88zJ8Sw8iWiS4BiUWcu3EVp0bmGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009221; c=relaxed/simple;
	bh=t+iB6nSaLLYc91ybuporeBtUy6FnNxhoISfbHB7Q5cQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=W915s7sSBtD//wUSowAMeBCcV1YTu+KZZcTvBmCOuA1yPPlwPmpT1//CV4XLlYIBCgqUO3Pjb4OuO2OiqvDoeDNUnwwZzkQfOize377njIHXXOpXjGb0IRg+oRgZ/iQmjdzLJ6fQEydbaBQTq3cSyXUHEQ0+WpiDBQARZeUCYYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c9voOaOH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XhrSBmEg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c9voOaOH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XhrSBmEg"
Date: Wed, 14 Oct 2026 20:20:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009217;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YTaEY/JoTjrLBJ9a6SrYM6tz+e9icZIqeSeqt0kPyHc=;
	b=c9voOaOHgdD6roNZGYn1AnDZ+Za7GOaCav0AWf1chTTjzUODA1tEx5UTtzv/WZTSP00PoZ
	G4SNajsbFMuaKCZ80b2z4axe3e71DAE7WnJyJleg7qhUc1QGV1KZzpIkAA4d786ZCJFaBf
	zdiB/V4AVmxdfIeDWbG+AuAwcNrtKcDYwWQ0w5kRkpgpKfWRo/suym/jz5H2+qNJPW9gUQ
	rL/lW1rI8OU4Z/Gw8y5uM/h1+BmpSZGQj7MevK5vYzxY0hNOuwzYNNyv3yKZkf5ElaqXzP
	rkB5STHGu1G7msWv6Vc0f/2r/vVvGCC30kSJaFQSEl7f1EctxRrJE7zto7zRYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009217;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YTaEY/JoTjrLBJ9a6SrYM6tz+e9icZIqeSeqt0kPyHc=;
	b=XhrSBmEgO8t29l22moAhDVe6OqhxNbXvRUJg78L44idrWlMvA0NIFxAU+pjFD8URLdGE1C
	hKAVUyiUqtklhJAQ==
From: "thermal-bot for Vitaliy Sochnev" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/airoha: Request the
 EN7581 IRQ after zone registration
Cc: Vitaliy Sochnev <sochnev.v.74@gmail.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, daniel.lezcano@oss.qualcomm.com
In-Reply-To: <20260915194128.42508-1-sochnev.v.74@gmail.com>
References: <20260915194128.42508-1-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200921604.2666337.2535785273741058305.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     7efceedd23678cd58e98b2c64d4b2b7be03f6cf9
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//7efceedd23678cd58e98b2c64d4b2b7be03f6cf9
Author:        Vitaliy Sochnev <sochnev.v.74@gmail.com>
AuthorDate:    Tue, 15 Sep 2026 20:41:28 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Fri, 18 Sep 2026 11:23:33 +02:00

thermal/drivers/airoha: Request the EN7581 IRQ after zone registration

The EN7581 IRQ is requested before the thermal zone is registered, and
the handler passes priv->tz to thermal_zone_device_update(). Unbind
leaves the monitor interrupt enabled, so an interrupt pending on the
next bind fires while priv->tz is NULL. On a Nokia XG-040G-MD this
oopses in thermal_zone_device_update(). On unbind, devres also frees the
zone before the IRQ.

Request the IRQ in post_probe, after zone registration.

Fixes: 42de37f40e1b ("thermal/drivers: Add support for Airoha EN7581 thermal =
sensor")
Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Link: https://patch.msgid.link/20260915194128.42508-1-sochnev.v.74@gmail.com
---
 drivers/thermal/airoha_thermal.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/thermal/airoha_thermal.c b/drivers/thermal/airoha_therma=
l.c
index 77b3a1a..ea3e264 100644
--- a/drivers/thermal/airoha_thermal.c
+++ b/drivers/thermal/airoha_thermal.c
@@ -528,7 +528,7 @@ static int en7581_thermal_probe(struct platform_device *p=
dev,
 	struct device_node *chip_scu_np;
 	struct device *dev =3D &pdev->dev;
 	void __iomem *base;
-	int i, irq, ret;
+	int i;
=20
 	base =3D devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -567,16 +567,6 @@ static int en7581_thermal_probe(struct platform_device *=
pdev,
 	of_address_to_resource(chip_scu_np, 0, &priv->scu_adc_res);
 	of_node_put(chip_scu_np);
=20
-	irq =3D platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return irq;
-
-	ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
-					en7581_thermal_irq, IRQF_ONESHOT,
-					pdev->name, priv);
-	if (ret)
-		return ret;
-
 	en7581_thermal_setup_monitor(priv);
 	en7581_thermal_setup_adc_val(dev, priv);
=20
@@ -586,6 +576,18 @@ static int en7581_thermal_probe(struct platform_device *=
pdev,
 static int en7581_thermal_post_probe(struct platform_device *pdev)
 {
 	struct airoha_thermal_priv *priv =3D platform_get_drvdata(pdev);
+	int irq, ret;
+
+	/* After zone registration: the handler uses priv->tz */
+	irq =3D platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
+					en7581_thermal_irq, IRQF_ONESHOT,
+					pdev->name, priv);
+	if (ret)
+		return ret;
=20
 	/* Enable LOW and HIGH interrupt (if supported) */
 	regmap_write(priv->map, EN7581_TEMPMONINT,
