Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5439D495523;
	Thu,  2 Jul 2026 09:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782986243; cv=none; b=WL1RX2i12tW9bgghkqboYu+jxuf1SURQbC/nRi+XUoCMZaEdTaUVXUXaxkymBdaZNAUGCbeHjyYKxWVQXXNreOfcl9lEWk4hHSEpDY4RbmEsQiV9bgMIbj/WNjqYhnydNUju3GqtKFrbk9nXDCeb054ajqVMpJ08KkHFYr5j64Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782986243; c=relaxed/simple;
	bh=s+oHyWDZzLbBnj8OuFd9lF7Ytt8JqU1hi9/yv03fVKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aBsfTPl8WRVCjHDD8jNmGDDEBiFbU7lT0Dh4KBBA4mKQzaLZeb2hNFI8jkvUAC72PH1Da+nKBc+96uBQETWnNBV/IeiuLFSTzzPe4nvsk8OcwgIuzfrEJKy21Tx3fj+WG2rN/EivaThUPSwMHq8AgAefBdp56b3V5kpjHYftZcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COVKx5wQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COVKx5wQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0310DC2BCF5;
	Thu,  2 Jul 2026 09:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782986243;
	bh=s+oHyWDZzLbBnj8OuFd9lF7Ytt8JqU1hi9/yv03fVKE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=COVKx5wQb+StEj7TqgSz07EXj45F5fLixil3TinXrdKnVGnqz/TR7QEYBeGIcKtPN
	 a31SzvNXyE9cTBU08cBVrioTLHqEl5/rvooq5KTHTFn28nDVII/yXIt1ZfMcDxf30F
	 Pjc1Yd1HP0diT7eZ472YvkAfz/HRbnFfs0OInw0csOsLwH0GtgrUP0nfzUYJLd3ZZ2
	 H1WLIB4721iGDy+2fUZx4zVhkppM+aDmzDXocjeFyU7QOq2xr3I/EBFTR3mqiVNR2l
	 Vvc7fCPVedYlmsdD//z0btoXGcyGLN40RHKLiCkvmFGH2tYH573Eda3/Tu6RfPSUY1
	 P/nWbaZbEn+qw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68DFC43327;
	Thu,  2 Jul 2026 09:57:22 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Thu, 02 Jul 2026 11:55:56 +0200
Subject: [PATCH v8 3/8] mfd: khadas-mcu: Add per-variant configuration
 infrastructure and VIM4 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-add-mcu-fan-khadas-vim4-v8-3-244feee91a36@aliel.fr>
References: <20260702-add-mcu-fan-khadas-vim4-v8-0-244feee91a36@aliel.fr>
In-Reply-To: <20260702-add-mcu-fan-khadas-vim4-v8-0-244feee91a36@aliel.fr>
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
 Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1697;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=V4o6dWy7ikMDkJA0YYsEmYbq9MismeNwAHAJSdqrVEU=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ5ab6U93xrQtwUeUtfLfR/vP3KWmNLk/OzfnDLvgHclzl
 Vz285d1lLIwiHExyIopsvTPtTzx7vLRM1/3qKfAzGFlAhnCwMUpABMpUGRkuMvt1bm4QpHl2Zx6
 16aaU3J9WYuWtCdfNdn3yTP2xM9gT4b/YbyW+dVq1p1604PNdVNO/XwcmjxN8404R9mqpgyVtYq
 cAA==
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Some values change per variant, add the structure to manage it.

Add an enum khadas_mcu_type used as value to match.

Also introduce khadas_mcu_fan_pdata to pass fan register address and
maximum level to the fan sub-driver, removing the hardcoded constants.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 include/linux/mfd/khadas-mcu.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/mfd/khadas-mcu.h b/include/linux/mfd/khadas-mcu.h
index a99ba2ed0e4e0..471a31787cce2 100644
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
@@ -88,4 +95,19 @@ struct khadas_mcu {
 	struct regmap *regmap;
 };
 
+/**
+ * struct khadas_mcu_fan_pdata - fan sub-driver configuration
+ * @fan_reg: register address to write the fan level
+ * @max_level: maximum fan level
+ */
+struct khadas_mcu_fan_pdata {
+	unsigned int fan_reg;
+	unsigned int max_level;
+};
+
+enum khadas_mcu_type {
+	KHADAS_MCU_GENERIC, /* VIM1/2/3, Edge, Edge-V */
+	KHADAS_MCU_VIM4,
+};
+
 #endif /* MFD_KHADAS_MCU_H */

-- 
2.49.0


