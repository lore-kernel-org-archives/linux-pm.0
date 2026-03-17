Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C6B379966
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773217; cv=none; b=iVwRCUpX9RE+eA3qgc9IwP6/Wv1WBm1Mekvbt/t1d0Km50SXN1sIgChqHciwiG5kxwvxGU9yZsJZ2H/wAv9lVMXkFUsCVkoji+dByuQx7OY2DppRmNmVgDuYHNVJdWvEjsgvsn6gbaXG5DIu7begs+8TxQzFobk/Dg8T6E2FZzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773217; c=relaxed/simple;
	bh=afZ1HjrfXvsRlWddGdki+RptwDdRc2stJrbXSWL55Cw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gn2O1DUW8I+3Axgl4b7DHvmvFykYPrmkgusCF976BKG4cmBu8GFtkDOuvJfCr8eWuo8GOs3O1+3JEbsclJNLT/21KODGbWdMtlL0RerMJpsKQ/2nDs1O5LOpiaE9I5EgDdaPvhdrZQUjY2pXNNG9J00feCb4XXZ2431lApIFUbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCTmha8R; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCTmha8R"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso54727775e9.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 11:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773773213; x=1774378013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jITvgy6W9V0ZjL2HN2g4X8oAqibIQBDVRpwgqXTuyEY=;
        b=UCTmha8RXT+l/dq+2HQIDKZ8f81z6gBmvnnHsa27pyv380ihntJPtShtwKOO0910sg
         4DTj4yK8VEC+mNOsnaY++bCQFA+ISkbkRjj8P8SFSZCHI8kw8N2PziTHA7BUhFvnrFnm
         XJr60wWWuTZfAZW6Ik5wttXh75beqwZ9pj6DTZkvqY+895UBZWuy35cJjwFb+cbZjNeP
         hf1Fhgonj3K4SnBlJpNev8Y5uSbDDRByv73rvkVaj0I02TNRm8g21+LXZNE6Kf3K3blE
         e1i26Em4CvG4dMq3e32BB2Rz3newWMEU2dmD9o9Y16IvPtX1vqa7HOANpNH4uuJq+c3Q
         AslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773773213; x=1774378013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jITvgy6W9V0ZjL2HN2g4X8oAqibIQBDVRpwgqXTuyEY=;
        b=b+5m3dNiwUYhPBd92ToBSzMbV25lwlC6xiPZsS9Dh9p4t6gbZN1IoSqDa0XH2fqHAG
         wO0M7W7nvrBPRjtCjS+ZPNcVg5c00e2Qu22ZFlrTQ6C4a0b/P9cvfp0zLPtBxKzPFUxs
         lzEosyFX5e8+2tMyxDZWBUMvIAVbfIfh7yDefCGqwIcJxXfU0ZnpCJZXeAMGiMI115T0
         3qxQsXmADoTLAzVWNN5rSRgMqHJHGI4EW6RaSkBrGSaE6tiCKh0ABJ9WEvBbbOwWoOjp
         ihCimdltjP44gOwmQO68dT6Gjc4LSff3TkShPwiQqnZO08uhuzwkctTTjoMhbo45yxBe
         QzLQ==
X-Forwarded-Encrypted: i=1; AJvYcCX31FCtcTly2vvirkKUkpSUibTNhc/UHpzGVTwaAomdG7G6RbHA4rTP35NXF5rZVzcT+gEbknldDw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcczdknPWDx1k8O0JGsqvZPwaIlIU8QpBdwRF0SoLgdki0+WWC
	ribsx07boJdEJ++EmfmQk+az775uRdCWcpCudZ2NaBCHCyMrMvs8wMSn
X-Gm-Gg: ATEYQzyIh37l6ydrvRo/v2XCbyCT0qpnSwH7iOtuxGS/vc0H3RrU3Hee7uICkb1BLuq
	oTHxbIJ2OxPF1oRZsrTrUHCKE1ZSsLHWOoDnDSFqImiKsOJk5wYp2UK7lHNZBXtPtQ20uf/Fx42
	SaG8tPoE5cBgFOBulzBugRqwrR2H9SbrAIxHN7Aqn/K3l7MqeNtS47NJi4Bpl2/xt9D1YCb2rC3
	hUXFgjTtFtL8OMRJ/ZG/St2oUqh7waSQuAToxlwR+fskICSrPeXqL2DQLbYJngXwhdtuER5LGop
	IxIQLp26av3d3fq0u9LYtD3cR7doJdDjH3jA9P1a4OA6xmQi84M5PbXefHbdHhlCVuctLyYPL49
	pSqvNA0Wxo7La6j1fUr++/uLHP+GdysjRgK53Vh7rUMMIyhpQXookTNDca00uHmxOtvSKGMJLw/
	Irfx5CJu4ZFtwDyuEe2EqDqWJg8lu7+A==
X-Received: by 2002:a05:600c:198c:b0:483:7980:4687 with SMTP id 5b1f17b1804b1-486f457232dmr11127115e9.17.1773773212953;
        Tue, 17 Mar 2026 11:46:52 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4ba760esm102725e9.24.2026.03.17.11.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 11:46:52 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Gary Bisson <bisson.gary@gmail.com>,
	Julien Massot <julien.massot@collabora.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Val Packett <val@packett.cool>,
	Fabien Parent <parent.f@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v3 8/9] pinctrl: mediatek: mt6397: Add support for MT6392 variant
Date: Tue, 17 Mar 2026 18:43:11 +0000
Message-ID: <20260317184507.523060-9-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317184507.523060-1-l.scorcia@gmail.com>
References: <20260317184507.523060-1-l.scorcia@gmail.com>
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

