Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FFE3C553B;
	Wed, 15 Jul 2026 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103957; cv=none; b=nPsaI9igtMwBfGdKBsi/yWxengb2b57g/iW00tPpegTimZ6RyBC8+5pNJ2OAK7f+RX5TmazkpIE1DyID9abduEUY4hA4IH5p+JRuOyY8994gYQcVp2RI2nPERq26Gduo560EsDL4zbhbiNyBe/0z75R3l6sZt5kWIbZXAxRPLWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103957; c=relaxed/simple;
	bh=DUMpCtmzqNZECMm9DCH89x+Qh2EGRoVif4z9CSmaRlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Uc6h5Ni9xRc/8bGtSxQow0eZe8/mAhn3npL3tlG4bty7KXl0x09fzzN+mj/ihVTW1KUx3BnXtFyvTwvUcGUOpRr0+Kx5JTtCVHMgu2OSETtzFpkx/OPew/QisQZiy6vGIWiNfJbFiobtB7JvfkbfFH4A3sx2u0HTbCpLNOb0UgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S+VeRqtG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K6wu4rnQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S+VeRqtG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K6wu4rnQ"
From: Gregor Herburger <gregor.herburger@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784103357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=069svORtyCtYRHYaLHWNs2IVK4x94dg6+FEW0jE90ig=;
	b=S+VeRqtG5jBbEUtIk/aobk8kRiO5gVxLPO/2xwGMHffxZuw5FuTltyoWFzKrfQFVpAdE34
	Jl+ibliUh8TXAW5Z70ThtVx9Y0keOLIU0SLSYQUspaLTZ0F/6+UxmLOm+lluMBRrQyqbCO
	U1Ki6umQVT7far+z4iefIieKFcuKA1F25gFcJmLlOzjHRewh4htFoZGAZRRwvpEkEZfNJm
	cI0kYA5UninTshHJkq/n/mKqIdP93kLZFD9uuQmZeClT05gfQ9Tj7/wPhhjy2m4Ut8thF2
	0OWlSBi85yIbG+QpCj6UToX/sMKdCr1F0lJ29u6Dmd8dq/9NpQuIXvGkkd7WLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784103357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=069svORtyCtYRHYaLHWNs2IVK4x94dg6+FEW0jE90ig=;
	b=K6wu4rnQ1ce5y0zo5F93CG2EgbmU5dIuXh+ePpbjHxEarAL7PgnebMyiR7S7jNOOVRV51C
	hBe1VfXQcMPq/4BA==
Date: Wed, 15 Jul 2026 10:15:49 +0200
Subject: [PATCH] pmdomain: raspberrypi-power: add remove function
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-rpi-pm-remove-v1-1-e4eed226e08a@linutronix.de>
X-B4-Tracking: v=1; b=H4sIALRBV2oC/yXMQQqDMBBG4avIrDsQgxroVUoXGv/oCGqYVBHEu
 5u2y2/x3kkJKkj0LE5S7JJkXTLKR0F+bJcBLH02WWMb48qaNQrHmRXzuoMrDxus62qElnITFUG
 O3+/1/jtt3QT/+U7oum7kWY3dcQAAAA==
X-Change-ID: 20260715-rpi-pm-remove-4ce2f27b5efa
To: Ulf Hansson <ulfh@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Gregor Herburger <gregor.herburger@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784103357; l=1632;
 i=gregor.herburger@linutronix.de; s=20260226; h=from:subject:message-id;
 bh=DUMpCtmzqNZECMm9DCH89x+Qh2EGRoVif4z9CSmaRlw=;
 b=7Vqo1EJ6O4wEXv/6vBSIwOV9PCjZmGsxxCW8jc9inW5fLCsIxVbw9OHMBL3g6IXpq2oJ2uBlZ
 MrCfMdowNI7ABWa2RpIn81fuXOVMxbK81Cb5R4fqV2XmCVwRwhqYDj8
X-Developer-Key: i=gregor.herburger@linutronix.de; a=ed25519;
 pk=u72Lv7+/lS5CC1hmSrb17lv/6CK7HBh4Lvz77PHA5LM=

The raspberrypi-power driver registers resources with
of_genpd_add_provider_onecell and pm_genpd_init but never removes them.
When the driver gets unbound and bound again this causes error. Add a
remove function to cleanup all registered resources.

Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
---
 drivers/pmdomain/bcm/raspberrypi-power.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pmdomain/bcm/raspberrypi-power.c b/drivers/pmdomain/bcm/raspberrypi-power.c
index b87ea7adb7bea..2c2135c17afb0 100644
--- a/drivers/pmdomain/bcm/raspberrypi-power.c
+++ b/drivers/pmdomain/bcm/raspberrypi-power.c
@@ -232,6 +232,17 @@ static int rpi_power_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static void rpi_power_remove(struct platform_device *pdev)
+{
+	struct rpi_power_domains *rpi_domains = platform_get_drvdata(pdev);
+	int nr_domains = RPI_POWER_DOMAIN_COUNT - 1;
+
+	of_genpd_del_provider(pdev->dev.of_node);
+
+	for (int i = nr_domains; i >= 0; i--)
+		pm_genpd_remove(&rpi_domains->domains[i].base);
+}
+
 static const struct of_device_id rpi_power_of_match[] = {
 	{ .compatible = "raspberrypi,bcm2835-power", },
 	{},
@@ -244,6 +255,7 @@ static struct platform_driver rpi_power_driver = {
 		.of_match_table = rpi_power_of_match,
 	},
 	.probe		= rpi_power_probe,
+	.remove		= rpi_power_remove,
 };
 builtin_platform_driver(rpi_power_driver);
 

---
base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
change-id: 20260715-rpi-pm-remove-4ce2f27b5efa

Best regards,
--  
Gregor Herburger <gregor.herburger@linutronix.de>

