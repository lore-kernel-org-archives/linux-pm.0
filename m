Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EE33793CB;
	Wed,  3 Jun 2026 18:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780509967; cv=none; b=NuGFq/l0BpCPzbHgxiqN1aQ4DZdR9iHAdFpTZ78FyF0fGvjTLrvNCNTpVo0iZbeqf5c7kGXwcosDqMihYj6JXOfeA5oZ/DpDQ3UpDaNhEx9rGpsxTy4CrUXvvGGbNNEdVFIfIhGzKhD8mKb1X6akzgUvLQI/wYuDj7EZ+aI75B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780509967; c=relaxed/simple;
	bh=s+oHyWDZzLbBnj8OuFd9lF7Ytt8JqU1hi9/yv03fVKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SLMnbPmlRWvgu9YsssuxVxcNdLH+TAE6hWlVMV03PisN1TYq/Lq+Q7YslnYuXqp5A9HFYj8SLRpKsTNpPTUvSdIqFc4duipq+YlhKJQEk9tGvIwbPVCdj6E/gQHk79v9l2VJd3loaxCRPoY+hstOKg0/+uP4fwJyOlv9hVVd5X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGlow3I5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGlow3I5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 346AEC2BCC6;
	Wed,  3 Jun 2026 18:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780509967;
	bh=s+oHyWDZzLbBnj8OuFd9lF7Ytt8JqU1hi9/yv03fVKE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QGlow3I5jbY1g938+oluN3CxmulaGm3ArFTNGzD4J/CVPoPnzBxxl6GR+nACqsKlQ
	 FxnnjbhaRVq4H47WDzkLIb8z1tS3zv/gW7YFZ7p/cMQnCSGJnZn830Uifyv4PAGoPV
	 bi9Tr07bM3oMeu0igWvQN1sB0q4Yf6cNQVqV+AGbuGswyOornIX/BGnh6w8/FfLuo6
	 tH4U+E/nm2I28+E8W1r0Vb+KZZoKXC4NTxtzwpYKudZHAdeihCoV+A+pX0MZ2VnNa3
	 wO3cx4/rlEJ05M8khn6LwcpuwOREhkvi+s6ehmXSnJhUkwNUGo3S/WxhzeXj54He/Z
	 cn2lpnSXf3heg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 282E0CD6E6D;
	Wed,  3 Jun 2026 18:06:07 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Wed, 03 Jun 2026 20:05:25 +0200
Subject: [PATCH v7 3/8] mfd: khadas-mcu: Add per-variant configuration
 infrastructure and VIM4 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-add-mcu-fan-khadas-vim4-v7-3-594ba8a965d8@aliel.fr>
References: <20260603-add-mcu-fan-khadas-vim4-v7-0-594ba8a965d8@aliel.fr>
In-Reply-To: <20260603-add-mcu-fan-khadas-vim4-v7-0-594ba8a965d8@aliel.fr>
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
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ5ZCLuvPh7m2MVvS5usndXemTXmlVK7BMyXg2qzHLUf/l
 1e8aDjaUcrCIMbFICumyNI/1/LEu8tHz3zdo54CM4eVCWQIAxenAEwkiJeRYV2NzsLn5iJhW/ku
 xh9qZv32OuHy4oMHjz1/9tGpRs0wcS3DL6YizbCoN/aH8zbfqKu7ETlNYKdyYyA355QA8/+rp8n
 /ZgQA
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


