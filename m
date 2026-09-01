Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA42843A807;
	Tue,  1 Sep 2026 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276467; cv=none; b=o5hl8ftU+xM3Zb4TbBQ7lMaDB9lkwtM/uEFDbAlO6AKdRAUCYqNWd5sFMkODkoaggO6mOpjNpStkmbI9RZRrK00PhvRfVh4rSXdLc0ZY0V0P/mWKMszN/qzQomHj/lfZ1sWXwm2UUboQD5HNwQh1qW2GqRluY/YHfqkxo+3N6i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276467; c=relaxed/simple;
	bh=O7eMDBHqcruD9r+Gj32/0LYLOb9udOfrNqBmq6ix7CA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jTDmNpN0JaS1SKcUq4Z5P7DsfO3/6Ulg2Pk7eCaVUgoikUzI4HxdOaNsyfrC2raLbXlCkIXflEMRFz45K07mj5GnPYvXXybA4rjAYWp+wQvC13wjFF1VR6AaY8g3aTCdQH3dSeMseWanU3uUB4cF8BsoDv4mnSIekdgkLsEWrMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+EB22dS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+EB22dS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F4DAC2BCFD;
	Tue,  1 Sep 2026 15:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788276466;
	bh=O7eMDBHqcruD9r+Gj32/0LYLOb9udOfrNqBmq6ix7CA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=r+EB22dSn+8a9Z21FaG9jc06hoqZZaO5NgmKGQzpsUrUeBRiL9+9hnZsRsYqIlI86
	 f2d2O5PKPFzoEJ8RABq5r+PDm7sUSeDgN9Sj+HAxA0yeuib4gcKZ2juebnlADoObVy
	 suAjVPPnunWxASfALZaOYRHT5x+eLWZV7mH5qvRurSrUn5e0rzlmtNlDrCRjTe9Ibh
	 c1OS+6eYuNp0UKBZ/P6nBRRyFlxDFUA7YMFpaesIO2HCPPv19n16cxRgIfDmjM35YB
	 /7vt3DWAYWDlcdg8RwHUkCAg08bIv/QRPobCsScGbZwzHBRnuhQz4fuSshL3M0Sg5O
	 TA8CQJn6Xxjpg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFB6C61DD3;
	Tue,  1 Sep 2026 15:27:46 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Tue, 01 Sep 2026 17:25:52 +0200
Subject: [PATCH v10 1/6] mfd: khadas-mcu: Add per-variant configuration
 infrastructure and VIM4 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-add-mcu-fan-khadas-vim4-v10-1-aecdb9955a30@aliel.fr>
References: <20260901-add-mcu-fan-khadas-vim4-v10-0-aecdb9955a30@aliel.fr>
In-Reply-To: <20260901-add-mcu-fan-khadas-vim4-v10-0-aecdb9955a30@aliel.fr>
To: Neil Armstrong <neil.armstrong@linaro.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Beniamino Galvani <b.galvani@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 mfd@lists.linux.dev, Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2035;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=41a1uCUdSjssDusDgka02m9AT4HiCk+OuG8CTPrx2oY=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9a0dy/rs7TzjeMnZDy9eyfhb8WWj2n8xVM2zrlxlf/X/
 thdRSbKHaUsDGJcDLJiiiz9cy1PvLt89MzXPeopMHNYmUCGMHBxCsBEvmozMmxd8mll5IslkfvO
 Tnz6TqC/08xhpqFxzqG1x30bdVvq4ksZ/squ//B53duUhW+1V6VOMfi1rjGMT/Pn5VTf3X38Vay
 vVzEAAA==
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Some values change per variant, add the structure to manage it.

Add VIM4 specific registers done for a subsequent patch, which will use a
new compatible especially to get the right regmap config.

Add an enum khadas_mcu_type used as value to match.

Also introduce khadas_mcu_fan_pdata to pass fan register address, a
table named levels to get fan-supported levels on the MCU, and the number
of levels to the fan sub-driver. Done in preparation for a subsequent
commit.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 include/linux/mfd/khadas-mcu.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/mfd/khadas-mcu.h b/include/linux/mfd/khadas-mcu.h
index a99ba2ed0e4e0..7a9980ea63e7e 100644
--- a/include/linux/mfd/khadas-mcu.h
+++ b/include/linux/mfd/khadas-mcu.h
@@ -70,6 +70,13 @@
 #define KHADAS_MCU_WOL_INIT_START_REG		0x87 /* WO */
 #define KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG	0x88 /* WO */
 
+/* VIM4 specific registers */
+#define KHADAS_MCU_VIM4_REST_CONF_REG		0x2c /* WO - reset EEPROM */
+#define KHADAS_MCU_VIM4_LED_ON_RAM_REG		0x89 /* WO - LED volatile */
+#define KHADAS_MCU_VIM4_FAN_CTRL_REG		0x8a /* WO */
+#define KHADAS_MCU_VIM4_WDT_EN_REG		0x8b /* WO */
+#define KHADAS_MCU_VIM4_SYS_RST_REG		0x91 /* WO */
+
 enum {
 	KHADAS_BOARD_VIM1 = 0x1,
 	KHADAS_BOARD_VIM2,
@@ -88,4 +95,21 @@ struct khadas_mcu {
 	struct regmap *regmap;
 };
 
+/**
+ * struct khadas_mcu_fan_pdata - fan sub-driver configuration
+ * @fan_reg: register address to write the fan level
+ * @levels: table mapping logical cooling-device states to raw fan levels
+ * @nlevels: number of entries in @levels
+ */
+struct khadas_mcu_fan_pdata {
+	unsigned int fan_reg;
+	const unsigned int *levels;
+	unsigned int nlevels;
+};
+
+enum khadas_mcu_type {
+	KHADAS_MCU_GENERIC = 1, /* VIM1/2/3, Edge, Edge-V */
+	KHADAS_MCU_VIM4,
+};
+
 #endif /* MFD_KHADAS_MCU_H */

-- 
2.49.0


