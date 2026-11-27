Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795793323;
	b=VdvQV4APXY8zeTECZBTTk+8c1L5iJRABcoeI7NEypOY+LugQYHP+H7PRq9IJ6rZPzs5I
	 kZ3FHthHpV4nAENsiEUWUIjGxYpiKuiG/Jpafy8eCcqZfrROaZMHUx3qsBQ7vqj/1fKWU
	 kn8mFJQs/BBVh5FkM47BTRnJNxMOpn1bxraLSS+5kXN88EcnCJzk+5kIChvTLHubf2qXy
	 RhCX4RTIHQLPZM7E9EsVeKW8u8T4Uz7Rzjsf8Efxl5B/e3aJgqBO/7tZ33IMJsPl+oZ0Z
	 DI6EjL3NQt7swbbYzQ3c7Bi6OTVWQ8LYQFPD+jLP3i2MqZBLCDTTTqjQiuhcC1prD7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793323;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=R1lgErtkHGkez/v6nABySb2ir4YTlwoSE0mnN6tPgq4=;
	b=455FSwDguf0mSX7LC91JQWlulmOWOGI2FycihbIIkegNvpFq2zwr/kzDfqAUCXiRlGF0
	 fKT39688q+1YIaThEegNCud2nplEcnMhEKbauDekMVxQhw1mUnuGeWHtQN6TG4wIdOriK
	 Cyl2NJGg5aoFzrpYTe2wWwPgLq/lPisUsyMG7oM+8NZ9Lnsg9nETUnV1BoNI42VoSVNMt
	 JDYB0wanxv7H8lM8vDVExrwdphKoKCRLbI9x3GQpXD0XBYY3F648gSOjheyGiXOjkgA/y
	 KIb9azmDrqf9/oMBzYxTEww3hnFw7FOCOuU7fGOvxyZwS+WPua31Me+LdC2tQBEszVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FLE4iApO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B082606A6B1;
	Fri, 27 Nov 2026 15:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FLE4iApO
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795793323;
	b=WdC6IXHk6trPlkrAR2QsR9lj5usy6j2F89t1ZLE3CCKrcK8dgC9ctYZoYWMk6SctCJGF
	 doq5+xb7mnjnxCfWYtXXCb9fmTBR+SGuPJEO9gGREvtz7nMERKydJ+Q85K9Sn51rQnK/0
	 nzfrsXNZNgv/q1UyxVY5MKcWKWZ6mextmgmnld4A2tx/UEbcNDC0p5VKROsfM6Na002tZ
	 8FlzDK0qwppOrFKveoGTgdVkg/ETSVf9wNurU1p47QEtCZCzPPZubYnMuEqBuztpqK4Td
	 AFR+xjRi9HrKhwYgYsKK6T2FOO+z5LBekZD7F0byIbXjb3y7J4DQ9qLc7jxuKhBldvA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795793323;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=R1lgErtkHGkez/v6nABySb2ir4YTlwoSE0mnN6tPgq4=;
	b=IjEv4HDzRWKhXpxasx9MMBmZ7QCl8fCq6Bry2HU7J9qjXe3tkbl66hOHgX3J4Zh3oMjc
	 wsCsLHbY61b7qHlptr+5s1keYiHmOluwfyxmbJeLxhqpkbTLt91nfSwH3V/2NVIdabED/
	 uetWDrDh/iEih0Cx0m7+Q1DuWpK+4rL0dhJ6wDZ5NRFDzxAcEWA1C6/1zfFMcae28B54S
	 JRBze7yVQE+1/l7dMplWSv6By2nNDqP0owBHScFORXgUeZ61y5IYtLX2n/SpZFk/pVkxr
	 mqnrPrlR/Hwkrsxiq9SLJQcXVYBxxGQnwhJSa3lZ70zDq/8hK34T3sobdTZOkZZkTxQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CCC661F00930;
	Fri, 27 Nov 2026 15:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795793323;
	bh=R1lgErtkHGkez/v6nABySb2ir4YTlwoSE0mnN6tPgq4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=FLE4iApO5VS4qhNp1J7g7eBku6/UwX3SpdqmIsb0go8XYgyvLxCrHwKWIt3V9PhXk
	 PLyBWQN6FiOg25JOWthQX00xE6fq21oS4Fp/01VsnUhmTzRKkJMtDDGotXiitci9Hd
	 /lIqaWdSRfqhJoy1x5D8Imd3UKUv1WX1EuOMVeerxFNIkdegq/DGrmdOUyT0tLM/0i
	 7JmEf+15qs1WYOWUm/2SNHdiEuFDaFjXsGY39uH3gp3eS/D+w9Y87MG0vh77deNrCJ
	 5X6jKAC6CIAJ2wP630NSimxF96Cb3kp8sz3+E2t8ZCREf1XUVS46p2OHbd9dlS+IOh
	 tiD0ghLGs07IA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 556534DC7C;
	Fri, 27 Nov 2026 15:28:29 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 27 Nov 2026 16:27:05 +0100
Subject: [PATCH v5 04/12] phy: amlogic: rename Meson8 HDMI TX PHY driver to
 be SoC-generic
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261127-meson-drm-create-hdmitx-phy-v5-4-88c43eb95468@aliel.fr>
References: <20261127-meson-drm-create-hdmitx-phy-v5-0-88c43eb95468@aliel.fr>
In-Reply-To: <20261127-meson-drm-create-hdmitx-phy-v5-0-88c43eb95468@aliel.fr>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ulf Hansson <ulfh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>, linux-pm@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7248;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=+Sa3VAnyG7mxwHscfV5CH9pZg3lPumtOGpHuVXBmS/s=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbnwt5Xj6Wd3k9onfpsRdnRCCPpnnW/HmjKPD90eolYd
 5uxzR+VjlIWBjEuBlkxRZb+uZYn3l0+eubrHvUUmDmsTCBDGLg4BWAiTv8Z/odJNgW9vOv6aJ3G
 83mrjEsrFwq/6Jkd/vbhwVn7E4+sqlrPyPBk65wnz87aNnB23V2+7uAkueadGtN3qiZ8sEjdmrl
 v9jNWAA==
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr
Content-Transfer-Encoding: 7bit

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

The HDMI TX PHY driver is currently named after the Meson8 family
(Meson8, Meson8b and Meson8m2), but the same IP block is found, with
SoC-specific register programming, on the newer GXBB, GXL, GXM and
G12A SoCs.

In preparation for adding support for these SoCs, make the driver
generic:

 - rename phy-meson8-hdmi-tx.c to phy-meson-hdmi-tx.c
 - rename the Kconfig symbol PHY_MESON8_HDMI_TX to PHY_MESON_HDMI_TX
   and update the Makefile accordingly
 - drop the "(ARCH_MESON && ARM)" dependency in favour of
   "ARCH_MESON", since the driver is no longer ARM32-only, and
   select GENERIC_PHY
 - rename the phy_meson8_hdmi_tx_* symbols to meson_hdmi_phy_*
 - update the platform driver name, the Kconfig help text and the
   module description
 - drop the unused <linux/property.h> include

No functional change intended: the only supported compatible remains
"amlogic,meson8-hdmi-tx-phy".

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 drivers/phy/amlogic/Kconfig                        |  9 ++--
 drivers/phy/amlogic/Makefile                       |  2 +-
 .../{phy-meson8-hdmi-tx.c => phy-meson-hdmi-tx.c}  | 54 +++++++++++-----------
 3 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
index ce7ba3eb2a8e..294996869e83 100644
--- a/drivers/phy/amlogic/Kconfig
+++ b/drivers/phy/amlogic/Kconfig
@@ -2,14 +2,15 @@
 #
 # Phy drivers for Amlogic platforms
 #
-config PHY_MESON8_HDMI_TX
-	tristate "Meson8, Meson8b and Meson8m2 HDMI TX PHY driver"
-	depends on (ARCH_MESON && ARM) || COMPILE_TEST
+config PHY_MESON_HDMI_TX
+	tristate "Meson HDMI TX PHY driver"
+	depends on ARCH_MESON || COMPILE_TEST
 	depends on OF
+	select GENERIC_PHY
 	select MFD_SYSCON
 	help
 	  Enable this to support the HDMI TX PHYs found in Meson8,
-	  Meson8b and Meson8m2 SoCs.
+	  Meson8b, Meson8m2, GXBB, GXL, GXM and G12A SoCs.
 	  If unsure, say N.
 
 config PHY_MESON8B_USB2
diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
index 91e3b9790c03..2611ec8a056d 100644
--- a/drivers/phy/amlogic/Makefile
+++ b/drivers/phy/amlogic/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_PHY_MESON8_HDMI_TX)		+= phy-meson8-hdmi-tx.o
+obj-$(CONFIG_PHY_MESON_HDMI_TX)			+= phy-meson-hdmi-tx.o
 obj-$(CONFIG_PHY_MESON8B_USB2)			+= phy-meson8b-usb2.o
 obj-$(CONFIG_PHY_MESON_GXL_USB2)		+= phy-meson-gxl-usb2.o
 obj-$(CONFIG_PHY_MESON_G12A_USB2)		+= phy-meson-g12a-usb2.o
diff --git a/drivers/phy/amlogic/phy-meson8-hdmi-tx.c b/drivers/phy/amlogic/phy-meson-hdmi-tx.c
similarity index 68%
rename from drivers/phy/amlogic/phy-meson8-hdmi-tx.c
rename to drivers/phy/amlogic/phy-meson-hdmi-tx.c
index f6b5df74a58f..e4e606ab4eef 100644
--- a/drivers/phy/amlogic/phy-meson8-hdmi-tx.c
+++ b/drivers/phy/amlogic/phy-meson-hdmi-tx.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Meson8, Meson8b and Meson8m2 HDMI TX PHY.
+ * Amlogic Meson HDMI TX PHY driver
+ * (Meson8/8b/8m2)
  *
  * Copyright (C) 2021 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
  */
@@ -13,7 +14,6 @@
 #include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
-#include <linux/property.h>
 #include <linux/regmap.h>
 
 /*
@@ -32,30 +32,30 @@
 
 #define HHI_HDMI_PHY_CNTL2				0x3a8
 
-struct phy_meson8_hdmi_tx_priv {
+struct meson_hdmi_phy {
 	struct regmap		*hhi;
 	struct clk		*tmds_clk;
 };
 
-static int phy_meson8_hdmi_tx_init(struct phy *phy)
+static int meson_hdmi_phy_init(struct phy *phy)
 {
-	struct phy_meson8_hdmi_tx_priv *priv = phy_get_drvdata(phy);
+	struct meson_hdmi_phy *priv = phy_get_drvdata(phy);
 
 	return clk_prepare_enable(priv->tmds_clk);
 }
 
-static int phy_meson8_hdmi_tx_exit(struct phy *phy)
+static int meson_hdmi_phy_exit(struct phy *phy)
 {
-	struct phy_meson8_hdmi_tx_priv *priv = phy_get_drvdata(phy);
+	struct meson_hdmi_phy *priv = phy_get_drvdata(phy);
 
 	clk_disable_unprepare(priv->tmds_clk);
 
 	return 0;
 }
 
-static int phy_meson8_hdmi_tx_power_on(struct phy *phy)
+static int meson_hdmi_phy_power_on(struct phy *phy)
 {
-	struct phy_meson8_hdmi_tx_priv *priv = phy_get_drvdata(phy);
+	struct meson_hdmi_phy *priv = phy_get_drvdata(phy);
 	unsigned int i;
 	u16 hdmi_ctl0;
 
@@ -85,9 +85,9 @@ static int phy_meson8_hdmi_tx_power_on(struct phy *phy)
 	return 0;
 }
 
-static int phy_meson8_hdmi_tx_power_off(struct phy *phy)
+static int meson_hdmi_phy_power_off(struct phy *phy)
 {
-	struct phy_meson8_hdmi_tx_priv *priv = phy_get_drvdata(phy);
+	struct meson_hdmi_phy *priv = phy_get_drvdata(phy);
 
 	regmap_write(priv->hhi, HHI_HDMI_PHY_CNTL0,
 		     FIELD_PREP(HHI_HDMI_PHY_CNTL0_HDMI_CTL1, 0x0841) |
@@ -96,18 +96,18 @@ static int phy_meson8_hdmi_tx_power_off(struct phy *phy)
 	return 0;
 }
 
-static const struct phy_ops phy_meson8_hdmi_tx_ops = {
-	.init		= phy_meson8_hdmi_tx_init,
-	.exit		= phy_meson8_hdmi_tx_exit,
-	.power_on	= phy_meson8_hdmi_tx_power_on,
-	.power_off	= phy_meson8_hdmi_tx_power_off,
+static const struct phy_ops meson_hdmi_phy_ops = {
+	.init		= meson_hdmi_phy_init,
+	.exit		= meson_hdmi_phy_exit,
+	.power_on	= meson_hdmi_phy_power_on,
+	.power_off	= meson_hdmi_phy_power_off,
 	.owner		= THIS_MODULE,
 };
 
-static int phy_meson8_hdmi_tx_probe(struct platform_device *pdev)
+static int meson_hdmi_phy_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct phy_meson8_hdmi_tx_priv *priv;
+	struct meson_hdmi_phy *priv;
 	struct phy_provider *phy_provider;
 	struct resource *res;
 	struct phy *phy;
@@ -128,7 +128,7 @@ static int phy_meson8_hdmi_tx_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->tmds_clk))
 		return PTR_ERR(priv->tmds_clk);
 
-	phy = devm_phy_create(&pdev->dev, np, &phy_meson8_hdmi_tx_ops);
+	phy = devm_phy_create(&pdev->dev, np, &meson_hdmi_phy_ops);
 	if (IS_ERR(phy))
 		return PTR_ERR(phy);
 
@@ -140,21 +140,21 @@ static int phy_meson8_hdmi_tx_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
-static const struct of_device_id phy_meson8_hdmi_tx_of_match[] = {
+static const struct of_device_id meson_hdmi_phy_of_match[] = {
 	{ .compatible = "amlogic,meson8-hdmi-tx-phy" },
 	{ /* sentinel */ }
 };
-MODULE_DEVICE_TABLE(of, phy_meson8_hdmi_tx_of_match);
+MODULE_DEVICE_TABLE(of, meson_hdmi_phy_of_match);
 
-static struct platform_driver phy_meson8_hdmi_tx_driver = {
-	.probe	= phy_meson8_hdmi_tx_probe,
+static struct platform_driver meson_hdmi_phy_driver = {
+	.probe	= meson_hdmi_phy_probe,
 	.driver	= {
-		.name		= "phy-meson8-hdmi-tx",
-		.of_match_table	= phy_meson8_hdmi_tx_of_match,
+		.name		= "meson-hdmi-tx-phy",
+		.of_match_table	= meson_hdmi_phy_of_match,
 	},
 };
-module_platform_driver(phy_meson8_hdmi_tx_driver);
+module_platform_driver(meson_hdmi_phy_driver);
 
 MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
-MODULE_DESCRIPTION("Meson8, Meson8b and Meson8m2 HDMI TX PHY driver");
+MODULE_DESCRIPTION("Amlogic Meson HDMI TX PHY driver");
 MODULE_LICENSE("GPL v2");

-- 
2.56.1


