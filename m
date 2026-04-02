Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401ED3ED5DF;
	Thu,  2 Apr 2026 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140065; cv=none; b=mQ4ZayD3C2IwnDaMRVwelN4HA9FM54ToJZbYPii0uWv7RlAVTpuleyISWQpwSYizx1c6fvMDgxGa2qRmw63Lvqd2/cNLjx7+wKF36ywKDpcrT7eQHRS4SHh07t+m5tcnqf4bVhk5j9X8XfYVlk6aNCGmVZJe2rF6GRCChhLpD00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140065; c=relaxed/simple;
	bh=OW1b2Q/DJTEMxPikE6mdf/p+H5KyL7TPJwoR6k9njCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DJK9hMP5jE/9nYGuys9doAZvcxsA0edR81FdTdtlltq4L5friVeljWN/d7k3Ti4YCsw3eIUo+vO5Dif8R6FB1/coU1yI3b9FDLs5VaYu4MkDyxeBHHgGtMYT1lQJ98VA4G4Vrc/DiFOz+wsxEnaAek4cqtJMgF7iT78GzS1plcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=O/gJyXCY; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="O/gJyXCY"
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1775140055;
	bh=OW1b2Q/DJTEMxPikE6mdf/p+H5KyL7TPJwoR6k9njCc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=O/gJyXCYxOWLH/pg4WHZtU9ZZOo9D2u8nXxetVV1/Uc2nWifKNMPH0SGM5SVp79p0
	 XoguOXigMUSqM317nbmu+rmOwATmDNZIzd8HZakkF+/2283gg9XCU5mwAYJeAb355o
	 KsiL6I7GmbXPIVUB+jA4DCNl5C7+Hgqx3ByPZAXs=
Date: Thu, 02 Apr 2026 16:27:03 +0200
Subject: [PATCH 3/8] mfd: khadas-mcu: Add per-variant configuration
 infrastructure and VIM4 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-add-mcu-fan-khadas-vim4-v1-3-2b12eb4ac7b0@aliel.fr>
References: <20260402-add-mcu-fan-khadas-vim4-v1-0-2b12eb4ac7b0@aliel.fr>
In-Reply-To: <20260402-add-mcu-fan-khadas-vim4-v1-0-2b12eb4ac7b0@aliel.fr>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1775140049; l=2417;
 i=linux-kernel-dev@aliel.fr; s=id_ed25519; h=from:subject:message-id;
 bh=OW1b2Q/DJTEMxPikE6mdf/p+H5KyL7TPJwoR6k9njCc=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgMGec55oxeeisqykQiUedekMYyOnR9
 BG9E/7rDWyqdNoAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJQD1RXiwqGSCudz2T2NToVaIjfpOkyZvtViVyFleYf7mppZRAVvUZsWNfO6IPLktG6IXr04m4f
 g7YhTf1y+pwo=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openssh;
 fpr=SHA256:kch4osYZ6A1BrPps5AUs6KnfdE2wm4ocMtyTc8TmZMs

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

