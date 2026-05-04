Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303443E714A;
	Mon,  4 May 2026 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919099; cv=none; b=n2+8YMT97FRKcMiTewwOY9vP5od2KAmoMy2GrxEDQtZQ3LaFxWv7VXDZXUopLlUO8jgodOhCy9CJ9tgFfJO7ryTkrLqWXb7UhfTbWfwz57bcAVys4IJNinF8G0QN5s6cnyZl7xcRPe5yGvhVLVbgAEujYkaThlZL2wngbltOVms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919099; c=relaxed/simple;
	bh=SFyDTRyWZjDxmsFtAqwCPfeazjDIIWp9P+6ztku6jaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M2vo431KEZHPwijiGwT9e0lFyShE2JDNMm/UQVkCLvstU4HpiizqkOJY+lvYEkhh75+1ss/oMtqfoOsW4d0m4cy6IP3Xk5W+kEo9R1n6NqiuFAABi/rl6/ZdeRtLu4Ka60RyU9WGxaITarr+xSG+K1JM4sf2OEETtEVyfrYI90k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2UAt5ov; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2UAt5ov"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D0621C2BCFF;
	Mon,  4 May 2026 18:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777919098;
	bh=SFyDTRyWZjDxmsFtAqwCPfeazjDIIWp9P+6ztku6jaM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=s2UAt5ovqGlDNFbvBTOq9Ul3dNhnc8+V4nJQ46Am+zdgmiXhdKT+g0jZ0Q8ix3IZj
	 O2/VeKbMqjR3qc7N/pLMAiC2vLZfx7v8A1TDWEPO7mzEnMe6iuLR7Z4bt08xQVfoqx
	 +g47+4YP6+SaIvYJik8QeCbV86R+KhJVsfZ3acj9IqauGEuo4Cay6pSTSurvHmG4B9
	 QQeAEpk0E8PmMKb919W7ExNurr5gq0+GVF3tu4NTCGHVbztRVypUfhSjcX5p9Ep2rv
	 HV/8B4b4aqHbekZ7A70x8he6Tad6ccU5VeYc2vGLY+ywBYgrIP3JgX8TRtqqoz+iFt
	 l14GrneLJz23A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DBDCD3427;
	Mon,  4 May 2026 18:24:58 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Mon, 04 May 2026 21:24:57 +0300
Subject: [PATCH 05/13] nvmem: add mt6323 PMIC EFUSE driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-mt6323-v1-5-799b58b355ff@protonmail.com>
References: <20260504-mt6323-v1-0-799b58b355ff@protonmail.com>
In-Reply-To: <20260504-mt6323-v1-0-799b58b355ff@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
 Ben Grisdale <bengris32@protonmail.ch>, 
 Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777919095; l=4311;
 i=rva333@protonmail.com; s=20260325; h=from:subject:message-id;
 bh=1nnD8x2/YfoddlKavtCr39AhwjwKkPATibCGf0JcRFk=;
 b=CI5X+E7LWYk0XH+OzSwni+MoWgPTu5HtndpDXnOqF9faEAkuaULlKcmd0lygCathpvFdBASrg
 4bDRnzyx1tNB1bkDi+UHEUCBKymKHiNPndUPXJqGBcyuGzcbcrQiVoC
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=euuVBZGtA2Cqb8Dju84qpQPhvwxyUirJlXpqEPQWKBM=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260325 with
 auth_id=695
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

Add support for the EFUSE controller found in the Mediatek MT6323 PMIC.
The MT6323 EFUSE stores 24 bytes of hardware-related data, such as
thermal sensor calibration values.

Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 drivers/nvmem/Kconfig        | 11 ++++++
 drivers/nvmem/Makefile       |  2 ++
 drivers/nvmem/mt6323-efuse.c | 86 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index 74ddbd0f79b0..db248a3c4e87 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -227,6 +227,17 @@ config NVMEM_MTK_EFUSE
 	  This driver can also be built as a module. If so, the module
 	  will be called efuse-mtk.
 
+config NVMEM_MT6323_EFUSE
+	tristate "Mediatek MT6323 PMIC EFUSE support"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on MFD_MT6397
+	help
+	  This is a driver to access hardware related data like sensor
+	  calibration, etc.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called efuse-mt6323.
+
 config NVMEM_MXS_OCOTP
 	tristate "Freescale MXS On-Chip OTP Memory Support"
 	depends on ARCH_MXS || COMPILE_TEST
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index 7252b8ec88d4..0e2b73f42b25 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -48,6 +48,8 @@ obj-$(CONFIG_NVMEM_MICROCHIP_OTPC)	+= nvmem-microchip-otpc.o
 nvmem-microchip-otpc-y			:= microchip-otpc.o
 obj-$(CONFIG_NVMEM_MTK_EFUSE)		+= nvmem_mtk-efuse.o
 nvmem_mtk-efuse-y			:= mtk-efuse.o
+obj-$(CONFIG_NVMEM_MT6323_EFUSE)		+= nvmem_mt6323-efuse.o
+nvmem_mt6323-efuse-y			:= mt6323-efuse.o
 obj-$(CONFIG_NVMEM_MXS_OCOTP)		+= nvmem-mxs-ocotp.o
 nvmem-mxs-ocotp-y			:= mxs-ocotp.o
 obj-$(CONFIG_NVMEM_NINTENDO_OTP)	+= nvmem-nintendo-otp.o
diff --git a/drivers/nvmem/mt6323-efuse.c b/drivers/nvmem/mt6323-efuse.c
new file mode 100644
index 000000000000..0c1b405fbc89
--- /dev/null
+++ b/drivers/nvmem/mt6323-efuse.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2026 Roman Vivchar <rva333@protonmail.com>
+ */
+
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/mfd/mt6323/registers.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+#define MT6323_EFUSE_DOUT_BASE MT6323_EFUSE_DOUT_0_15
+#define MT6323_EFUSE_SIZE 24
+
+struct mt6323_efuse {
+	struct regmap *regmap;
+};
+
+static int mt6323_efuse_read(void *context, unsigned int offset, void *val,
+			     size_t bytes)
+{
+	struct mt6323_efuse *efuse = context;
+	u32 tmp;
+	u16 *buf = val;
+	int i, ret;
+
+	for (i = 0; i < bytes; i += 2) {
+		ret = regmap_read(efuse->regmap,
+				  MT6323_EFUSE_DOUT_BASE + offset + i, &tmp);
+		if (ret)
+			return ret;
+		buf[i / 2] = tmp;
+	}
+	return 0;
+}
+
+static int mt6323_efuse_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct mt6323_efuse *priv;
+	struct nvmem_config config = {
+		.name = "mt6323-efuse",
+		.stride = 2,
+		.word_size = 2,
+		.size = MT6323_EFUSE_SIZE,
+		.reg_read = mt6323_efuse_read,
+	};
+	struct nvmem_device *nvmem;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	/* efuse -> mfd -> pwrap */
+	priv->regmap = dev_get_regmap(dev->parent->parent, NULL);
+	if (!priv->regmap)
+		return -ENODEV;
+
+	config.dev = dev;
+	config.priv = priv;
+
+	nvmem = devm_nvmem_register(dev, &config);
+	return PTR_ERR_OR_ZERO(nvmem);
+}
+
+static const struct of_device_id mt6323_efuse_of_match[] = {
+	{ .compatible = "mediatek,mt6323-efuse" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, mt6323_efuse_of_match);
+
+static struct platform_driver mt6323_efuse_driver = {
+	.probe = mt6323_efuse_probe,
+	.driver = {
+		.name = "mt6323-efuse",
+		.of_match_table = mt6323_efuse_of_match,
+	},
+};
+module_platform_driver(mt6323_efuse_driver);
+
+MODULE_DESCRIPTION("Mediatek MT6323 PMIC EFUSE driver");
+MODULE_LICENSE("GPL");

-- 
2.53.0


