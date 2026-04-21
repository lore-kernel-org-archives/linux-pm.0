Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F41739934A;
	Tue, 21 Apr 2026 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776772222; cv=none; b=ACFpFXe+FFt1m1Pz40GbswYQmvM5EKBqkNOjKwCVu6EPb2gSYT59gv4iWXWTHcUG1WCTHksDTZPDADjjg+6Bvn0jk1KW7CuXvEiJY2G6GvmCWuBD6YeFCCaERMsfm7Dn0GqhUbsFfMesJ3iGAkJAwnLjXGQYUAweb0P+fuS4vDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776772222; c=relaxed/simple;
	bh=Yr40ujZrqiWQlxRZ6ysM7KCEJl1lcxiTahjTdOp4wdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LubRzCdZwy4C2BKb0mKDIA8LzQ8rI9I8I1F/gGvG2acENtq0jYxo9tiNrp4SLuOQaFWINMK0wmogVvZ88LnGWlsLKpE9T6v4K+5eU+RNMz2ekR16wDn70veTRahACG5t88qTcL8UHeIt7G+nqroPXdn2wGhsUfuWVV6Ta0R7qg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pc+GwCWY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pc+GwCWY"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 396B2C2BCC9;
	Tue, 21 Apr 2026 11:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776772222;
	bh=Yr40ujZrqiWQlxRZ6ysM7KCEJl1lcxiTahjTdOp4wdo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pc+GwCWY4pLiilS8d2qBIfzejUwXTjbwEOnbIzrCiy9nmuNYRzZlLBmJsY/PIvpYW
	 uInqtslScwoxnVsAAo4/5CD/8QQu5StOVp4SFTew9Rv6dgTZvAULadCzEiS91Q6SeM
	 4fkKl1plOjd2J9ysKHBTViaunat1CB1kqJMfGbsx/f3t0sLCR++vDTVzZdO48IERhO
	 apewhNLceYT3/Lr6W8h0TTJcfds4/IaADcKcsxh5UPwVij4l8FB4Hoo3UNHMleZy2m
	 56jtTuJgg5c5OcoNKjZI5Ys8ukXiOC3gPXIjquf8YcKagRM35uRDadZpWJZywhJSTg
	 7vPt4UZQoea2g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C625F8FA64;
	Tue, 21 Apr 2026 11:50:22 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Tue, 21 Apr 2026 13:49:20 +0200
Subject: [PATCH v4 3/8] mfd: khadas-mcu: Add per-variant configuration
 infrastructure and VIM4 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260421-add-mcu-fan-khadas-vim4-v4-3-447114a28f2d@aliel.fr>
References: <20260421-add-mcu-fan-khadas-vim4-v4-0-447114a28f2d@aliel.fr>
In-Reply-To: <20260421-add-mcu-fan-khadas-vim4-v4-0-447114a28f2d@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2417;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=OW1b2Q/DJTEMxPikE6mdf/p+H5KyL7TPJwoR6k9njCc=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ+bzlBLf8xq9kzd6bI5sNs5Yb137qeDDFXvPNbrKq642S
 5j9u9XeUcrCIMbFICumyNI/1/LEu8tHz3zdo54CM4eVCWQIAxenAEzkmhsjw51DlrwHp5/grLJi
 v+YwQcCw6NLP9+GnVapOz70TkLppzl+GP1zF4Y9/zo5dePRV5fSbLavv2r0I1X3quSE4qXrxx0V
 8FzgB
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Introduce a per-variant configuration structure (khadas_mcu_data)
holding the regmap config and MFD cells,
selected at probe time via the of_device_id match data.
This makes adding other variants straightforward.

Also introduce khadas_mcu_fan_pdata to pass fan register address and
maximum level to the fan sub-driver, removing the hardcoded constants.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 include/linux/mfd/khadas-mcu.h | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/include/linux/mfd/khadas-mcu.h b/include/linux/mfd/khadas-mcu.h
index a99ba2ed0e4e0..75e275d3fa8d9 100644
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
@@ -82,10 +89,38 @@ enum {
  * struct khadas_mcu - Khadas MCU structure
  * @device:		device reference used for logs
  * @regmap:		register map
+ * @data:		pointer to variant-specific config
  */
 struct khadas_mcu {
-	struct device *dev;
-	struct regmap *regmap;
+	struct device			*dev;
+	struct regmap			*regmap;
+	const struct khadas_mcu_data	*data;
+};
+
+/**
+ * struct khadas_mcu_data - per-variant configuration
+ * @regmap_config:	regmap configuration
+ * @cells:		MFD sub-devices
+ * @ncells:		number of sub-devices
+ * @fan_cells:		MFD fan sub-devices
+ * @nfan_cells:		number of fan sub-devices
+ */
+struct khadas_mcu_data {
+	const struct regmap_config	*regmap_config;
+	const struct mfd_cell		*cells;
+	int				ncells;
+	const struct mfd_cell		*fan_cells;
+	int				nfan_cells;
+};
+
+/**
+ * struct khadas_mcu_fan_pdata - fan sub-driver configuration
+ * @fan_reg: register address to write the fan level
+ * @max_level: maximum fan level
+ */
+struct khadas_mcu_fan_pdata {
+	unsigned int fan_reg;
+	unsigned int max_level;
 };
 
 #endif /* MFD_KHADAS_MCU_H */

-- 
2.49.0


