Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6776939E6C9
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 20:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781296042; cv=none; b=hmRWm7qufHAsZ7DAHnGcHmmf1lZqrtMAvRGXFgAVFCR2Z/BZeEOfmbpFvH+Mk2GqMtRSEfjZvVrkD80mk8dqtLMni9yEnnuI/A++27A5u+oDj+Bcawh2cwa9JMcjwJeMZXD7JlK8x6f3UMdUMUFPMMPFzkEGYtpQbNzC2JgFM60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781296042; c=relaxed/simple;
	bh=qTaF7TRiZkTD1hP7KOH8ckvyLCF0n7wFHby0gHb6G+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FbQo3oMZY/W6Cg55BAEW487wFZ9AZ/krv/ZlZ56I0q8Xm1cpYNdwbLAN+oFpY5vkDGbriWQ45L3CD+vM2DxII7R8Uq/EXY8Z5zPjpJklVs84N2yvMCltiGGN6D3ECoIVqO+E+J3jc10OwGSG5/8B3uUda3gcvNmJFAFMWZb+V1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCt5R/4H; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCt5R/4H"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490ac357c55so12750415e9.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 13:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781296040; x=1781900840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nG1MlD4PN9leIlB74vSBgHn1juhdOfLFrGDifVzjZsw=;
        b=QCt5R/4HKFIj5n1EYOFOU6x5/0SLtKaA0TDzE+kuX/T5E2gIxCWWOh3AiTCFdyuued
         6m2YugoE0Dj0OBbG576MshB88mpfDs8C/O/LOFcWp0pNg89X8w46IJVKC+TsP9S2jBtj
         uGAR1bmFhWN/Rp1kyHXqDUEZnG1ToF+jdq4UvnvIWFnbhSdGFcI3UlJYFbHSStKNAhqM
         +cnDOxhpsoi0mkvMafT1EhKyoSUdMYaCW84eAIqjT2ZEwXzemQGzNPbfwgsAXK+PuYBl
         BbZls9JTfl+gZoa0TVkVHOVgfS1KU4FcLxx1rS/SXf0A0qVrPB+GG3hI8ZWaZSpB4ukW
         Xn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781296040; x=1781900840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nG1MlD4PN9leIlB74vSBgHn1juhdOfLFrGDifVzjZsw=;
        b=cv9pWgSjx5jONRzZohRksZ9wa75Lte6r4E28Vlm+J7P1EZoDhh3tjy3lsU5ShwL2RF
         mvqhoNtt/G9YRWuWVuXK2SNv8ZsY6VSzThHuyn9vd/gpTtjP+knxTlkPC89n5oFc6jKv
         Bp1sIY5YYkqCg38e+WzG3dCxDX6jQ8o9JgFR/1eZ2EYFlNONQn0lEcfnINCp2yrCjwAS
         oVqqiTOTwydFqy8Qf0A93J9gMNs3k4ErBvypWHS0Y46L3y80Fde1Ihrfhr+e47aUNvvv
         nkqMgmxkKLhm3t4AhMBBX3XKVPcvxO9zQyOyrhreciJBKoYuCXgZz0j49KBfX73yt4uA
         C4Sw==
X-Forwarded-Encrypted: i=1; AFNElJ9lqT7FeUUQRL9a4Vv3iJbCsKSJYFkYFDxKrphAaBIexXkYS/JYhhi/Grw3ej+caCLBmSVNmT26BQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg+PK4+7OXQdevt5dp7TEMTHk49XoV5j3bRVviQcH68uPRN2Et
	7OuSk95ksl9OFfypX+6Ht2NPMuvDrXvFteUxJvHw+NQYAgEbiEfGBZZi
X-Gm-Gg: Acq92OFNMgLR+9ayeYLWu64UNknnkDgT+5xJzmrWy0cGbNlss3N2DjX83dhcDNnGMD8
	q4nctL3lSImeaQFfJ7/vQxXX7Gn10tT6cmMKfWpe2aMJNkoTMcG54jSjOrYHEHE1wvXMzgYTSyO
	9mesZXLUE3/2hYaC4Abeh52F4RB0FDQwFhw4j+edkfJe2ltrVo1nI/jdaiIC1tGRc+H4K/GCRcW
	ZTFH780FI4G3hoMIQh4ZNgEhjpElp79OrfYWzYC08L1EJsyOYbfZxHpmw8581Pvsa0OmqT/v1Sy
	mSjS0ywwoKq5iKzTT2F4nR2qy2iTS5aXVnnHXJ5G3e9/Lv6fSXjF3QlWkJ23hKxzFKiiSibcFaQ
	N0NzYZWQgP3a77vLUBYcLiBpsAixilA8IFVbXqaCuAp3DQO9MBf10CdXra4F1IvypJR/bEa3pA7
	Aegklquj69RJ4fPr34
X-Received: by 2002:a05:600c:820c:b0:490:958f:2a5e with SMTP id 5b1f17b1804b1-490ec4cf45amr55021715e9.13.1781296039766;
        Fri, 12 Jun 2026 13:27:19 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26434dsm9173261f8f.1.2026.06.12.13.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 13:27:19 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Julien Massot <julien.massot@collabora.com>,
	Val Packett <val@packett.cool>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v6 6/7] pinctrl: mediatek: mt6397: Add MediaTek MT6392
Date: Fri, 12 Jun 2026 22:04:11 +0200
Message-ID: <20260612200717.361018-7-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612200717.361018-1-l.scorcia@gmail.com>
References: <20260612200717.361018-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the MT6392 pinctrl device, which is very similar to
MT6397 with a handful of different property values and its own pins
definition.

Update the MT6397 driver to retrieve device data from the match table and
use it for driver init.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt6397.c     | 37 ++++++++++-
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h | 64 +++++++++++++++++++
 2 files changed, 99 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt6397.c b/drivers/pinctrl/mediatek/pinctrl-mt6397.c
index 03d0f65d7bcc..8ba02e70595c 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt6397.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt6397.c
@@ -12,10 +12,32 @@
 #include <linux/mfd/mt6397/core.h>
 
 #include "pinctrl-mtk-common.h"
+#include "pinctrl-mtk-mt6392.h"
 #include "pinctrl-mtk-mt6397.h"
 
 #define MT6397_PIN_REG_BASE  0xc000
 
+static const struct mtk_pinctrl_devdata mt6392_pinctrl_data = {
+	.pins = mtk_pins_mt6392,
+	.npins = ARRAY_SIZE(mtk_pins_mt6392),
+	.dir_offset = (MT6397_PIN_REG_BASE + 0x000),
+	.ies_offset = MTK_PINCTRL_NOT_SUPPORT,
+	.smt_offset = MTK_PINCTRL_NOT_SUPPORT,
+	.pullen_offset = (MT6397_PIN_REG_BASE + 0x020),
+	.pullsel_offset = (MT6397_PIN_REG_BASE + 0x040),
+	.dout_offset = (MT6397_PIN_REG_BASE + 0x080),
+	.din_offset = (MT6397_PIN_REG_BASE + 0x0a0),
+	.pinmux_offset = (MT6397_PIN_REG_BASE + 0x0c0),
+	.type1_start = 7,
+	.type1_end = 7,
+	.port_shf = 3,
+	.port_mask = 0x3,
+	.port_align = 2,
+	.mode_mask = 0xf,
+	.mode_per_reg = 5,
+	.mode_shf = 4,
+};
+
 static const struct mtk_pinctrl_devdata mt6397_pinctrl_data = {
 	.pins = mtk_pins_mt6397,
 	.npins = ARRAY_SIZE(mtk_pins_mt6397),
@@ -40,13 +62,24 @@ static const struct mtk_pinctrl_devdata mt6397_pinctrl_data = {
 static int mt6397_pinctrl_probe(struct platform_device *pdev)
 {
 	struct mt6397_chip *mt6397;
+	const struct mtk_pinctrl_devdata *data;
+
+	data = device_get_match_data(&pdev->dev);
+	if (!data)
+		return -ENOENT;
 
 	mt6397 = dev_get_drvdata(pdev->dev.parent);
-	return mtk_pctrl_init(pdev, &mt6397_pinctrl_data, mt6397->regmap);
+	return mtk_pctrl_init(pdev, data, mt6397->regmap);
 }
 
 static const struct of_device_id mt6397_pctrl_match[] = {
-	{ .compatible = "mediatek,mt6397-pinctrl", },
+	{
+		.compatible = "mediatek,mt6392-pinctrl",
+		.data = &mt6392_pinctrl_data
+	}, {
+		.compatible = "mediatek,mt6397-pinctrl",
+		.data = &mt6397_pinctrl_data
+	},
 	{ }
 };
 
diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h b/drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h
new file mode 100644
index 000000000000..e7241af28fdb
--- /dev/null
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-mt6392.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PINCTRL_MTK_MT6392_H
+#define __PINCTRL_MTK_MT6392_H
+
+#include <linux/pinctrl/pinctrl.h>
+#include "pinctrl-mtk-common.h"
+
+static const struct mtk_desc_pin mtk_pins_mt6392[] = {
+	MTK_PIN(PINCTRL_PIN(0, "INT"),
+		NULL, "mt6392",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO0"),
+		MTK_FUNCTION(1, "INT"),
+		MTK_FUNCTION(5, "TEST_CK2"),
+		MTK_FUNCTION(6, "TEST_IN1"),
+		MTK_FUNCTION(7, "TEST_OUT1")
+	),
+	MTK_PIN(PINCTRL_PIN(1, "SRCLKEN"),
+		NULL, "mt6392",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO1"),
+		MTK_FUNCTION(1, "SRCLKEN"),
+		MTK_FUNCTION(5, "TEST_CK0"),
+		MTK_FUNCTION(6, "TEST_IN2"),
+		MTK_FUNCTION(7, "TEST_OUT2")
+	),
+	MTK_PIN(PINCTRL_PIN(2, "RTC_32K1V8"),
+		NULL, "mt6392",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO2"),
+		MTK_FUNCTION(1, "RTC_32K1V8"),
+		MTK_FUNCTION(5, "TEST_CK1"),
+		MTK_FUNCTION(6, "TEST_IN3"),
+		MTK_FUNCTION(7, "TEST_OUT3")
+	),
+	MTK_PIN(PINCTRL_PIN(3, "SPI_CLK"),
+		NULL, "mt6392",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO3"),
+		MTK_FUNCTION(1, "SPI_CLK")
+	),
+	MTK_PIN(PINCTRL_PIN(4, "SPI_CSN"),
+		NULL, "mt6392",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO4"),
+		MTK_FUNCTION(1, "SPI_CSN")
+	),
+	MTK_PIN(PINCTRL_PIN(5, "SPI_MOSI"),
+		NULL, "mt6392",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO5"),
+		MTK_FUNCTION(1, "SPI_MOSI")
+	),
+	MTK_PIN(PINCTRL_PIN(6, "SPI_MISO"),
+		NULL, "mt6392",
+		MTK_EINT_FUNCTION(NO_EINT_SUPPORT, NO_EINT_SUPPORT),
+		MTK_FUNCTION(0, "GPIO6"),
+		MTK_FUNCTION(1, "SPI_MISO"),
+		MTK_FUNCTION(6, "TEST_IN4"),
+		MTK_FUNCTION(7, "TEST_OUT4")
+	),
+};
+
+#endif /* __PINCTRL_MTK_MT6392_H */
-- 
2.43.0

