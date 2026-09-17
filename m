Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC833DDDD7;
	Thu, 17 Sep 2026 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789632045; cv=none; b=qt9sfgjkH2932WwHbKHFm0EHRlw8FJscz/wDik5PWfB9VfiLfu6w/KjBENTnpf4sPVAQZzt50t7+8Z1181WTKxtQApUlyvg/oLa5L4opEhdlb91aNEvHxc13cNKql5ftsX7FIRNn7OTYXjTJR1K02HSoI7ztU/xOGoBT/2+Wr90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789632045; c=relaxed/simple;
	bh=fpSccCQTtocdNkkOJ7qtK8D7ka1uiiSK6AMKGUYwGwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fMmKf5NwB8/tckgwGTz5h0M/Iwipi8u4oU/xk5JPzED+SN1Hj8uODEVtCU4QQjIkJzt0BPVu83GrYGCaFcFeq04tiz8M2czOCIvr99sI2+yAbXpw5SvvqdpU7OYM1Jjhd7QotEdPiSHKAkUL7y2WiT0AATvxt4yPehb4WuqaSDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltfFARBn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltfFARBn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1C55C4AF09;
	Thu, 17 Sep 2026 08:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789632045;
	bh=fpSccCQTtocdNkkOJ7qtK8D7ka1uiiSK6AMKGUYwGwQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ltfFARBn2kLxaJP4576aO5fKsWFweBm4ob0uhQo360ecbAYkXLwRIKXiSfZd6XBkN
	 FiInId7w9Stc41FMj0ChuQEMB4wo2DSHo5Eb0Qx074mLo6rIbG0+AVpQHVRz+qkhb+
	 NJVjTAOarzLJzB76O834lgPeAuY3gPdeUqRPUiKTDq0vYR9sI/zAxJw+8+VAj8bzUq
	 Unl2iRhV4fVm+y8mqv8Nfw9N8AlLzcLtNtCSARtZaprE6a4cVxEzeMAuGRATG3ym7Q
	 Qipz51aPdR0+sqCC76B/q+Oj9prvfGMPQLukcScVM6ravs5xlx3/+NxfZIVr+iVRJF
	 ROhHoPGCl4Ejw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B5CC88E72;
	Thu, 17 Sep 2026 08:00:44 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Thu, 17 Sep 2026 09:59:00 +0200
Subject: [PATCH v12 1/6] mfd: khadas-mcu: Add per-variant configuration
 infrastructure and VIM4 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-add-mcu-fan-khadas-vim4-v12-1-497cd543a148@aliel.fr>
References: <20260917-add-mcu-fan-khadas-vim4-v12-0-497cd543a148@aliel.fr>
In-Reply-To: <20260917-add-mcu-fan-khadas-vim4-v12-0-497cd543a148@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1930;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=BJRhwKhcdjrF5epARgcxNmy3jED4cBzG1XxROeciDJk=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9bqeVLWEctSXnAY1q9nWdy0Muhnc9WiVtHLglO2nDH43
 Xhtn+2DjlIWBjEuBlkxRZb+uZYn3l0+eubrHvUUmDmsTCBDGLg4BWAiu3gY/vCdeSbLuyCiZ8Np
 LfHQOWtF/jExpDhNedZ9bLPGoZ0rHFsYGb5OU9ds5dmX4JAsJqm2IlTSlfGXw5wN2mZbOTgqpoW
 u5QcA
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

Also fix a kernel-doc warning for the khadas_mcu struct.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 include/linux/mfd/khadas-mcu.h | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/mfd/khadas-mcu.h b/include/linux/mfd/khadas-mcu.h
index a99ba2ed0e4e0..acd3291061b40 100644
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
@@ -80,7 +87,7 @@ enum {
 
 /**
  * struct khadas_mcu - Khadas MCU structure
- * @device:		device reference used for logs
+ * @dev:		device reference used for logs
  * @regmap:		register map
  */
 struct khadas_mcu {
@@ -88,4 +95,14 @@ struct khadas_mcu {
 	struct regmap *regmap;
 };
 
+/**
+ * enum khadas_mcu_type - Khadas MCU hardware variant
+ * @KHADAS_MCU_GENERIC: VIM1, VIM2, VIM3, Edge, Edge-V (shared register map)
+ * @KHADAS_MCU_VIM4: VIM4 (extended register map, distinct fan/LED/WDT regs)
+ */
+enum khadas_mcu_type {
+	KHADAS_MCU_GENERIC = 1,
+	KHADAS_MCU_VIM4,
+};
+
 #endif /* MFD_KHADAS_MCU_H */

-- 
2.49.0


