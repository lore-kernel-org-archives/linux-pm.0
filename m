Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC7F3E5EF3;
	Wed,  5 Aug 2026 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785917295; cv=none; b=dwAsmK90umE0Qwkp9FxkYL509wzLtkJSM7BJbZLsbnSccpuiYT2J6xT/5sOvgdvq4QZHwCljD76AsM7nRtHlg67JosEz8Cv1BsCxTiYaowYOFJ95pCP9cNyylA/ZAe9PGZZ3lboBgiEOQUMKbwoA8DHFRqTsZV51uVBqeoB2LGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785917295; c=relaxed/simple;
	bh=hpWnV5LS0GblNz9y/FlvFSDIRyY1+QAth4KLt9LSkxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pVXmc7uKK/tNyywuQU2hcAXVOZgDtteqBqwjXAycM91+yjVAS6BZ3BW+AnrYbjqEOwixXMyRB4Qs6jI3PLWhaLozrEQ8Ud3YIAc6eKnZn3ghTL21q30Mev15S6zBtK+eHyIpnefCGiXp7ZtjqGfni6h9Jl84vW40uwBfntBfcdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMhsEdTl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMhsEdTl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99F7EC19425;
	Wed,  5 Aug 2026 08:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785917294;
	bh=hpWnV5LS0GblNz9y/FlvFSDIRyY1+QAth4KLt9LSkxg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PMhsEdTlGclZENFHxJlxo5CMm+SwPMSZmOggq17f39z97QCSdkheGuSa+aFQDQ8tB
	 ZIg4AxiTYEuYDw3IAcWMNDpJapPfoQaxXeMsVVxAe3oNj5ACwf+5pLjHrddDGJ4Pcn
	 VbZMLc1DyKWFxgzVarh6xOfmGNXKoz9F0f6DEdoH0omlUu0pLE94E1Lzk5PiqnuUxn
	 5BDy39WTOiEmhRfkApwkLcLjH0mGwqab5xFQP4ukdWxs5nrBNo11iX9g6sFo7Ds5jx
	 y7Z9OBfQjr8RO/PTTLd9/mHViDOcqiUZXqqCs5HitA88lmki3Utk0j4r2t5J3lXqgI
	 eCn5a6illaf1g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73970C55822;
	Wed,  5 Aug 2026 08:08:14 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Wed, 05 Aug 2026 10:06:02 +0200
Subject: [PATCH v9 1/6] mfd: khadas-mcu: Add per-variant configuration
 infrastructure and VIM4 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-add-mcu-fan-khadas-vim4-v9-1-75df78710b9e@aliel.fr>
References: <20260805-add-mcu-fan-khadas-vim4-v9-0-75df78710b9e@aliel.fr>
In-Reply-To: <20260805-add-mcu-fan-khadas-vim4-v9-0-75df78710b9e@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1883;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=l0O0cD0fiAJBO81t4csvMi2nHXVHt2flC0X0yXFYJns=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ1bR+7TlSTH9bA6391scvfY9sPj+ZvY9kdq+Uhds605FR
 CfOXfm5o5SFQYyLQVZMkaV/ruWJd5ePnvm6Rz0FZg4rE8gQBi5OAZiIz0lGhhlSAYsrLkzS3X6y
 OsCsfU22wO947eligi/VU77/mLKBVYeRYerdpsq1a5xWL/CKXOvgJbxZL96NI6lpkXlcYe2aS4/
 juAA=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Some values change per variant, add the structure to manage it.

Add an enum khadas_mcu_type used as value to match.

Also introduce khadas_mcu_fan_pdata to pass fan register address, a
table named levels to get fan-supported levels on the MCU, and the number
of levels to the fan sub-driver, removing the hardcoded constants.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 include/linux/mfd/khadas-mcu.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/mfd/khadas-mcu.h b/include/linux/mfd/khadas-mcu.h
index a99ba2ed0e4e0..e4044c251b97e 100644
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
+	KHADAS_MCU_GENERIC, /* VIM1/2/3, Edge, Edge-V */
+	KHADAS_MCU_VIM4,
+};
+
 #endif /* MFD_KHADAS_MCU_H */

-- 
2.49.0


