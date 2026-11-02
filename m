Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793597640;
	b=D0ZrclBjUXuXpEQ7AWkWPuXa8rxNusdEGTIPGEVgp1p2gGhUdC6KMJ+ww2pI6Vo73g0T
	 A1RMLgiE3LLI8JelURJMAu0Ha1GHCYFL3RZghRX1AfDkOA3BgC5KZQUWHTinlPh+2f3Y8
	 RlFS2Uz8YIynMzp8qQjiW3bsJ0TB1rNE/U3YpaMpbW7OuQ/xkzRL0KGljNH7L77sIc66A
	 WrcsFDEn0sFcIuVaKmY7ULJ1h8hMb/SXusprZmKf943mZ4zSQvLVTPobwNAvAuM25zS+r
	 OJnek1PpnVyfZ9dpvXgkIJ5Wdlj1vbWavyPyeyFynn6Irt2vPQKDzcrO9Oh7NM32nSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793597640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=j/iKDdwYCnsubloLpqDmZlwHL6ERoLEJpqDNEy1hOkk=;
	b=g4+iDB1djhMDHDFZztQjp2UYFmPBi+LSA025LSyPZRKCsoQMHh9Qjj5LeupaxhtpZou3
	 4zArAZQfBxR9Ok0hWwzAHo7ashNIOx51q9gUeoAvM2Hi2T6N6q0czMLgyNHKKNqEPMl3h
	 eDoxgOdhdMzW1wPTM6MSbIh5K0Dkk1pDp+hQT5jHcm1m68+mjm0X7vP1YNKzxzw9iHj9y
	 G6EoD2YJMQdTLL1sLGQn0zFvjML/baxdEZGDXWascWp+7lgGxJyR4J7Oo4UFJOjaGLeG9
	 0GhnD93JcH2auzT7SkGeo3Lrm4kA8lVDZvYfbc4IVr5tOGFryptv58S9A9uFYjryQ4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="U/9AMy9R";
	arc=none smtp.remote-ip=74.125.231.130
Received: from mail-oo2-f2.google.com (mail-oo2-f2.google.com [74.125.231.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064DA606A335
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 05:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 064DA606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U/9AMy9R
Received: by mail-oo2-f2.google.com with SMTP id 46e09a7af769-824f3901d55so3181796a34.1
        for <linux-pm@vger.kernel.org>; Sun, 01 Nov 2026 21:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793597639; x=1794202439; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j/iKDdwYCnsubloLpqDmZlwHL6ERoLEJpqDNEy1hOkk=;
        b=U/9AMy9R3HO9CMqxdw8ILkrqQN9WdKD8V4l+rW1MDOuT0q5IRvrMc7EDMvi5OkZ4Cb
         u+od2i2X+TCWB4D1bfUNUgeOJBp+qGOzCdE3IX4sQ8amKTaqL1poBlxapkklf7vaFzID
         p+PtgaHZRGqlNyOP94i1yg/pJIc4WVDNwJYBwcSpp+aXKS0mA5NQmw2mmfoBVIz+uJuN
         X2+9Ou5QJfgDIrL0upNFq4zz/eizYAmzUMqsNL4A2piO8+SWndRcdvDiNzn46cD2ldWN
         ZSiGtqtxHKZrROrXcE6GKK90c1+RYbkGT6zdde4Z7PkwFwQvIsbO8Rgy4r7eaVcLKQe/
         BIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793597639; x=1794202439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j/iKDdwYCnsubloLpqDmZlwHL6ERoLEJpqDNEy1hOkk=;
        b=XEuleDcPE/wQ0v8ZFlRIrnOjJptKwg0o44U+f5f2PtXq5L2Rfdgug8142iHjyowByu
         Bse5BPJvXwsbv55IFY6M+YPeDvgHaG8tD8RpGYHZpBgRKprropNrq8ouknwI7bW2QZRC
         bEwDS601su7dgYgS7gzeoCkRvRxeo7sFIRdOZAanDJ3yhmmorTG8eETHO/VHS2T/1WGe
         goXGirqdiYTq8a0F3Y1LWMEiFIbcsHUzYGPcoT+GX8wWCNvT7nwFbAqrHIzH6H8VLgIL
         zaw984tHqFdc8rIcYgxxccEvflTKD6H3HX3s5xLEufLiD7QOHPtiS3lDyTQArcvlN+pL
         RS/w==
X-Gm-Message-State: AFq9FYJ+JTcRCowyX/SIq5aX2OUZqWJKRYHeqydS4DnMHbAz73FmEizN
	eijZPzbZXFrSwO/GHHcjeW3wLTDz63R2Ds8ui9jRsdE/Y8lLr869YY3Q
X-Gm-Gg: AYBFou0rMJ5NomJXAfQ/ULj1s+RUFu7VcOYhjJLNgwlrVRYIyePcxLugYVP4UPwLy8f
	yXJeuGXSd+VlZ+mKQXZxjw7HY7wrwpY4FsI+AGMD9qX9ezrAA3ATsPWxa/eGqVce2WgpWMAoCW2
	sL9MqBHA3EZqudT7tiwdP5JHMMsF8kIriLru9ygmQLTQC5J5atB4l3hK8Hpm1qMTu8tIVFgOIOf
	l0f8/GrC0OhnOYypZcZvrBKQdzILpjFM/Od/qJATxu8T5cwitBhmoTl909+jClVI1BsAQuYUejm
	ZR8LpHJkvrXgB56KyLfBBFOpbjzAdP9xjJu5tZR9uH+mktZBXsV+chSg27sE9EeBidClscn7mBi
	XMA+iNkYdDM8loiruFpnWo2QRWJim7apBSOoYqAzH/lYshkneRFWQ3ycIfVyr8DKRUmh1t6S5jm
	NjwthuDO/mJ2und3GGQInW6BbiqIVZqsDilG+XYE9FwUBBwpWiD6YK8Bw+pztH2nGzeeAG/Gr1W
	muVCtMoroN8dc9RxmfC8K9U4uov6q46n2Ub93yBc8nP6fqpg8cpd7AtlEqcht3cQV95uVikbwek
	h8QDEZ2ByWm0gMdIO2ZXwFvj
X-Received: by 2002:a05:6820:81e:b0:70a:4053:52dd with SMTP id 006d021491bc7-714f24f9791mr5803420eaf.12.1793597638909;
        Sun, 01 Nov 2026 21:33:58 -0800 (PST)
Received: from [192.168.18.164] ([2600:8804:5716:d800::f01a])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2a818b9sm8321164eaf.1.2026.11.01.21.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 21:33:57 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Sun, 01 Nov 2026 23:33:47 -0600
Subject: [PATCH 2/2] rtc: mt6397: provide the 32 kHz output as a clock
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-2-9758f38d7053@gmail.com>
References: <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-0-9758f38d7053@gmail.com>
In-Reply-To: <20261101-rbrue-suez-upstreaming-mt6397-rtc-32k-v1-0-9758f38d7053@gmail.com>
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Eddie Huang <eddie.huang@mediatek.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-pm@vger.kernel.org, mfd@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-rtc@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793597629; l=4890;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=eS8wwphnLf29L4d5m076ho5/o3jTqtIytR9mtme4zMw=;
 b=V5rSbVxU0IF5N7h6PPPyOJQV/wX0G6LmMZa8wVDZQxfdGcr4TIErn1bIGZZU6u4TjA94W77+a
 3p2deiTL6UBBKiXt28snx/azYaVv8C5+hP8+TMfIhI6rsZeP2q+Xt+p
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

The RTC's 32 kHz output is gated by RTC_CON.F32KOB, which the vendor
kernel clears before it powers the Wi-Fi/Bluetooth combo chip. Mainline
never touches it, so on a board whose bootloader leaves it set, such a
chip has no sleep clock and does not come up.

Register the output as a clock when the RTC node has #clock-cells, so
the chip's power sequence can enable it.

Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 drivers/rtc/rtc-mt6397.c       | 85 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/mt6397/rtc.h |  6 +++
 2 files changed, 91 insertions(+)

diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
index d6e156516aa6..5130fecffa7b 100644
--- a/drivers/rtc/rtc-mt6397.c
+++ b/drivers/rtc/rtc-mt6397.c
@@ -6,6 +6,7 @@
 
 #include <linux/array_size.h>
 #include <linux/bitfield.h>
+#include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/mt6397/core.h>
@@ -317,6 +318,84 @@ static int mtk_rtc_nvram_write(void *priv, unsigned int offset, void *val,
 	return ret;
 }
 
+#ifdef CONFIG_COMMON_CLK
+static int mtk_rtc_clkout_set(struct clk_hw *hw, bool on)
+{
+	struct mt6397_rtc *rtc = container_of(hw, struct mt6397_rtc, clkout);
+	int ret;
+
+	mutex_lock(&rtc->lock);
+	ret = regmap_update_bits(rtc->regmap, rtc->addr_base + rtc->data->con,
+				 RTC_CON_F32KOB, on ? 0 : RTC_CON_F32KOB);
+	if (!ret)
+		ret = mtk_rtc_write_trigger(rtc);
+	mutex_unlock(&rtc->lock);
+
+	return ret;
+}
+
+static int mtk_rtc_clkout_prepare(struct clk_hw *hw)
+{
+	return mtk_rtc_clkout_set(hw, true);
+}
+
+static void mtk_rtc_clkout_unprepare(struct clk_hw *hw)
+{
+	mtk_rtc_clkout_set(hw, false);
+}
+
+static int mtk_rtc_clkout_is_prepared(struct clk_hw *hw)
+{
+	struct mt6397_rtc *rtc = container_of(hw, struct mt6397_rtc, clkout);
+	u32 con;
+
+	if (regmap_read(rtc->regmap, rtc->addr_base + rtc->data->con, &con))
+		return 0;
+
+	return !(con & RTC_CON_F32KOB);
+}
+
+static unsigned long mtk_rtc_clkout_recalc_rate(struct clk_hw *hw,
+						unsigned long parent_rate)
+{
+	return 32768;
+}
+
+static const struct clk_ops mtk_rtc_clkout_ops = {
+	.prepare = mtk_rtc_clkout_prepare,
+	.unprepare = mtk_rtc_clkout_unprepare,
+	.is_prepared = mtk_rtc_clkout_is_prepared,
+	.recalc_rate = mtk_rtc_clkout_recalc_rate,
+};
+
+/* The 32 kHz output the PMIC drives to other chips, such as a combo chip */
+static int mtk_rtc_register_clkout(struct device *dev, struct mt6397_rtc *rtc)
+{
+	struct clk_init_data init = {
+		.name = "mt6397-rtc-32k",
+		.ops = &mtk_rtc_clkout_ops,
+	};
+	int ret;
+
+	if (!rtc->data->con || !of_property_present(dev->of_node, "#clock-cells"))
+		return 0;
+
+	rtc->clkout.init = &init;
+
+	ret = devm_clk_hw_register(dev, &rtc->clkout);
+	if (ret)
+		return ret;
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get,
+					   &rtc->clkout);
+}
+#else
+static int mtk_rtc_register_clkout(struct device *dev, struct mt6397_rtc *rtc)
+{
+	return 0;
+}
+#endif
+
 static int mtk_rtc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
@@ -380,6 +459,11 @@ static int mtk_rtc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = mtk_rtc_register_clkout(&pdev->dev, rtc);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to register the 32k clock\n");
+
 	nvmem_cfg.priv = rtc;
 
 	return devm_rtc_nvmem_register(rtc->rtc_dev, &nvmem_cfg);
@@ -416,6 +500,7 @@ static const struct mtk_rtc_data mt6358_rtc_data = {
 
 static const struct mtk_rtc_data mt6397_rtc_data = {
 	.wrtgr = RTC_WRTGR_MT6397,
+	.con = RTC_CON_MT6397,
 };
 
 static const struct of_device_id mt6397_rtc_of_match[] = {
diff --git a/include/linux/mfd/mt6397/rtc.h b/include/linux/mfd/mt6397/rtc.h
index f4da579ec638..a8130d726c59 100644
--- a/include/linux/mfd/mt6397/rtc.h
+++ b/include/linux/mfd/mt6397/rtc.h
@@ -9,6 +9,7 @@
 #ifndef _LINUX_MFD_MT6397_RTC_H_
 #define _LINUX_MFD_MT6397_RTC_H_
 
+#include <linux/clk-provider.h>
 #include <linux/jiffies.h>
 #include <linux/mutex.h>
 #include <linux/regmap.h>
@@ -22,6 +23,9 @@
 #define RTC_WRTGR_MT6397       0x003c
 #define RTC_WRTGR_MT6323       RTC_WRTGR_MT6397
 
+#define RTC_CON_MT6397         0x003e
+#define RTC_CON_F32KOB         BIT(5)
+
 #define RTC_IRQ_STA            0x0002
 #define RTC_IRQ_STA_AL         BIT(0)
 #define RTC_IRQ_STA_LP         BIT(3)
@@ -72,6 +76,7 @@
 
 struct mtk_rtc_data {
 	u32                     wrtgr;
+	u32                     con;
 };
 
 struct mt6397_rtc {
@@ -83,6 +88,7 @@ struct mt6397_rtc {
 	int                     irq;
 	u32                     addr_base;
 	const struct mtk_rtc_data *data;
+	struct clk_hw           clkout;
 };
 
 #endif /* _LINUX_MFD_MT6397_RTC_H_ */

-- 
2.55.0

