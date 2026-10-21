Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580037;
	b=4Zu+qjncfIzLtmVDQF637EvI3sw/1chPt39BKHb99g7Zkc1Q1Esbf4X+4t+MRz0R+YjW
	 5oCMWy+NaDx3so+umeWkzUHJBzlWXgjw7x97Ns4gNuBv3s7JGX9Fh8h2GM4gaxmxl3DUR
	 9KZRONJy0f7QG+dpEs0LM/KwZBVEjhZs73/NMjlVGyQZqsSqqU/nnxM93ng3UdM4Rj2B4
	 RL3MyrcgTfJaTyi5JxcDdfcsXUeEP+gFboiTBf/CeUnH2aCnXJKymTLCpxsmlmJyryuEJ
	 BfcT25wbmOvINTSHRi9XB4qLoOyNuhKpIGs3gEU/n6GydxfGD8A6/RZEqaJRkcns6hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=b2cuoSSXuPlFWsURCaXb/TKI1SgcO0qXqGq45/zPoZc=;
	b=4L1NHnPuTi35bE7lFpEBn+ULknF/vZPyssk88Wqkhu7I1xbOXUgFwnBdNSh8yUHfkL25
	 Qnli6sAt2vtkTfd90/tXN3e1g/+PVsOt1XkQuM4I2Mcg+Oh7F7HLafByu6824Mtvx3jNZ
	 2s0fddFwEXHmYegpmeGU7BnYPPQMpTrcZl4mCC7lRX6syIyFgd9MkUh0WyOSgfucRy2uR
	 SMkUaB4c/NpNZ+ufxc8O6h6vS/VjHLAgPohlFtkZIjPFnoVlzzRYwieFZVvQWgVBzzT+c
	 728iFZqwA/g4NLvimfWx6rWRX2PJldLTIg1osO/H5xhGrx4IXgDNcxk8RzBkIfxXGKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q2rY8P8B;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECBE606A31F
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 10:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ECBE606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Q2rY8P8B
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1dede3c2cso7300655e9.2
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 03:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792580035; x=1793184835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b2cuoSSXuPlFWsURCaXb/TKI1SgcO0qXqGq45/zPoZc=;
        b=Q2rY8P8Bsl8yOeUp4qVBMjk7TbrmUu594XS7KqoA+bX9oGDtyYqBzATyJW9mYJkYfo
         Fhb+ycudX0fwmVYPhEGpavNN/3juPDghx9+GSlLCXwZGfBsHHS9snHSkYD+8BM8x1X/s
         9kuYqSSzvHv1rcRYJur1lvGRK1LytVLIGApPKAsMCOe+ZbsiJSzb4QjgSMWGtXnl7M18
         wOafauvI0BvGKNpmdHF9txt4J1z4N2IUcpa+1CI1qlXU39elJ2u7Fj4WjiMV5fNbNDXO
         YLl3B5/2clUQ5hF9QLcK4OXIbzbXqLqbG/jUuX5C3yKkE9+tEjM6tDuaaUkmEfkXdIQ+
         bmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792580035; x=1793184835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b2cuoSSXuPlFWsURCaXb/TKI1SgcO0qXqGq45/zPoZc=;
        b=RHJQuQlcNi9SERB32EQCWeyKMxmmFXKXzu+zPcgnb1zNto7/2/KhxvKKlBn+XmrJrw
         fkEPO6hTnDw+Est0xSE9QCe4cMqi2tEDbiCuIvMLEOphXFWfWK5tAihJCgFBFqM1iiz4
         zl5qCBcxKWAiqH0Og10h+i0td1n4Bk39gqNHI1qEEJmP/3IAeBqTjKfLjMuSCIiSSj4U
         e/KdRZip6z5TMjA/KSze+ZXIPg9s5/ttqT3nQxRE+gqm2AHeWQ3kLMrSXALgwfPKf/DU
         d+l4VOXNgt2Ru6hQ3BovEc/yoimwm678BIYZoXRLHhJ1zHlutDb7maRkBGTxXnvWCoXe
         T1QQ==
X-Forwarded-Encrypted: i=1; AKwUvBz8L+oDI5ZkfhNIlEmanWG0/ZyUehxIAY41y++KsOipnJJg5Hxt56FlKI3PfiKnXiKioMqu4DAbOw==@vger.kernel.org
X-Gm-Message-State: AFq9FYIULqpiKQO9Q5vaCJA1OZO9OjOLDHAMSJu44qIjii530cqR/0sx
	WatLErUZ1+hY5ik7j4gYLbMol5D80sL4KMEMwrGC+PpHo+jJ/gl916yW
X-Gm-Gg: AYBFou0OljH5Px7QYq+4ImzIupfoR0/Q1yxnGePK8QTpGofRV+JyA3bGNzOE69Mu2sQ
	HFCiAWWJW202VRrq9D/G4bgMYqldKblFdEfTQnyuv7qT0rH/l4drwGE2TpwBIZaminkR6weTXoi
	sW/+CgFJPfoith5e6M+tRySPc9uWNWYZvsrbCgwFwC+iFVJteibqcWbHNwE4HuQ4sbk2xeII58m
	Z8cbjyDIwaXrcrbplWtccySKUcS04dF8IlcSAI2b2mkgwG1n3Ihp0k0cwDHFg5/a74/ZsDN9WkL
	krdQCtMmRGH6f1P36fHvSrTSMm03Z/bnN03fZUoydFewxP/+pwW1sOlXfZ8mzTzRBndbINCxieE
	Id+KS3e/Snb70KJutMwQQJBLQprcBQBo9QJywEJji73IPcsyepb7I+hs5VGQHs7e15lDEHaG79T
	aZmvHB83GRDVRSvZ3zDqutEhoiEWfZlvexknf7QOO1r0MfbaC6M0Bw6WgHXqljLMQXoztMmtLz0
	XreQnaXebyBIBwPzPkqU+/hb49JVOSqml/zYlANN0t71SSJbyk=
X-Received: by 2002:a05:600c:4fd4:b0:4a1:7ba9:da2c with SMTP id 5b1f17b1804b1-4a1fdd4d220mr31805745e9.25.1792580035343;
        Wed, 21 Oct 2026 03:53:55 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d6e2dbsm153388305e9.13.2026.10.21.03.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:53:54 -0700 (PDT)
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
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Val Packett <val@packett.cool>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v11 7/9] pinctrl: mediatek: mt6397: Add MediaTek MT6392
Date: Wed, 21 Oct 2026 12:47:25 +0200
Message-ID: <20261021105109.199886-8-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021105109.199886-1-l.scorcia@gmail.com>
References: <20261021105109.199886-1-l.scorcia@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
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
index 13cee2a209c2..3944e39db7e6 100644
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
 MODULE_DEVICE_TABLE(of, mt6397_pctrl_match);
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

