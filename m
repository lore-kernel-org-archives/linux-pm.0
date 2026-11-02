Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638232;
	b=2BtFPQy8GWaKeDkZrMy1G1Bi3GtTY/i4awUFElxFF2SRTu5VfqHl/spMYqf6TMH1LRhE
	 gWINqhKe8N2zRxUTCcgf8kLraALDFQdleO0hiv2Z4yrqwduJIp3XV+huMwHnVdnB3ah2z
	 ERVfeJPTE6KNp0md6W+RS3BOJb7YBFJrB0y/HI72cfQ97QSIkHsChpMt5pOvXRdJ1IO1i
	 DP5UgiMi6CmmEceW4JX3rEvOibzGySfL+cCX/1ze/IAVi4p9ZZOLoPAe9OMSpMKbFMxQA
	 nYNak8Va1OiUmR6tAOKYOdxs/jMmFYBQ5K6xwp0dkRPyqp6O9+xVrYteh1sSa8v9SMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638232;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=K8BYvSAD0vaRsrXFQzKVgQ9ORTXgw762XXjLlecX85Y=;
	b=ZLE4nHNWviJsDHy2NTaCOGNvVvmS1BdGNkX7dUAqfO9gFzssPRXPtGnM8gwxCDEBuaRC
	 zFFbzX3O6X6f+G+HJvU47NO1cVmaWq/+lPQUhkRzCYFkRpXk+CogvG6gRpJTHHi/yU6b3
	 cALUNF3j8k3m/+dfjq9NQChG5zsycDyVD35MqpbL/Y9CI/0WuaxbECz+bjs7UhL6vR6Yr
	 scQpn/u84onpfTUOclmygYn241jt4PEkuNIXFNFveKDSBdUPxYz4e9tyYVIwWL5Euul8Z
	 UudHMzI+gzw5BpeNeZ4aGQP56K9wicw+/SQFaRAbOZDFxhGF+k6rRbSs7dgZcF/2Eyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rHfQ1jyI;
	arc=none smtp.remote-ip=74.125.231.137
Received: from mail-oo2-f9.google.com (mail-oo2-f9.google.com [74.125.231.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ECD607466D
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 16:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1ECD607466D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rHfQ1jyI
Received: by mail-oo2-f9.google.com with SMTP id 46e09a7af769-821a4a69647so258983a34.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 08:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793638231; x=1794243031; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K8BYvSAD0vaRsrXFQzKVgQ9ORTXgw762XXjLlecX85Y=;
        b=rHfQ1jyI8vgeZsIJ8/crxP6sQGfOrqxThPsEAA/+kbRZwUIEBpVbtv0fgCcZRIF23D
         jawXtmxCraOCtUMOjgKF2+S9Ww0FRiTIgABHxilJk8/hfn/bzcoHiYI0KZHSPccxiW1I
         1/agQFhLFa1IMgaD9Szej8Q3tnpjCpN8FCN8tOVSKSnxBziMSactzZwu7lizWLGztw7C
         DLip1LNDcM8jd8J2A0nS64qm7jIGRLOTEvSlRagL8a/hh/ywh/oAVXto359VwJJBwv5y
         Ik9/Ifb/YIaU/OECBjMSkLi69Zsj7Tf81u12NAT+xnj0Y+qS/2TsgMNydiWc0Ps5ACLr
         V1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793638231; x=1794243031;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K8BYvSAD0vaRsrXFQzKVgQ9ORTXgw762XXjLlecX85Y=;
        b=2hLlNQ0yK0MuP6gNGsSqyuSosozKfBljuGbk0dhQr9PJMt/wBjzcI1Jz8L8xOXFgge
         w8KMLrB6xaDDQbY5YpRtm/k6PtdKq9Mp9O6NZt0arY2VaRlWKznCrRx2D2nxRKWYhiK2
         HXfB5TC6Ck3Rd1AAttOQu0LjYgV0ytv5Cz7+WEZkQfQApFHV/chGRFLxVFCN0c+lqJqL
         etwgfIJKSIEosz9fq9XCxCMbiBfPuZos7JuhHQHv3i0mm5/tk3mGJ+z/ysgLhTOgc8bt
         gXnkCzYRxovhxiiB8ei+Teeku72EYrtTc96khk8cjCrfERhNmeWHEgkZvW7o/gFzCenF
         FbCA==
X-Gm-Message-State: AFq9FYKcWXQRxn3A2brp3DrX3vAGAUOpdNegVEdM7FlCqQ/N3S2tAa2K
	2yBClYYUTFTNEByvWsWuPSmmUgRY2y7nfwKLqlJjtgjcusejGI+BmZNO
X-Gm-Gg: AYBFou0H51Xuh6bILjscTjkVjJdFG4zwWWN51/CoaJyVQ0xeZagLajtGKKMD637SgZO
	9iGxiGYtpIYuqUkxyinsr26AhLkIFt6C4nKlk/kwbebwui6BXMRGEqeheo7zuYgm29J4pIf5XWF
	xbv2wAQ9+JvqIv2poNM+hJY8AlqujA1A5NEjLTtf8FtkAFUATIzditht3v+dOqUI7ykBQrGXn3B
	L1hUvo7SlETWGhoVgL06fJK3vzWHssvpSB+nGTIGfCzNeL8vpZdiQLyoYUmeEIeJaSIUrYubo+7
	qL78SPQKRQgb/tLkHqyUGR+9ENFqNCVCix1KLZ3kKnAo0czvvaY0ju+Z7SwQ8ezyLESq1ovT0Et
	gYgMeU2UuF+INBe/zFsZoLZRa0rk2ceAy2NepwVq3tVICHqoQFV68JZILw2owQT5f12G+6scM0i
	iI6viqcCoRAzUqrqaS16cefBmQpXqTUj1F4+ziD/XWKD5F21fyFXWy1c039npXdWPyPc4hczJLz
	I1fKqIzrLtThv5CjEryXv6P/aVe4DeYwLLg001KZHfimw+Q0amNafMf4YckUe6HmJgjd+pIc2IA
	voZuOImKm1lPyhzD3wYBLzVheXRQ0aKTgXRcrZC8dX+No3pjS99+i5Mms5eXebhkTMlPDE4XTzA
	Zd2YU1vsrix54Dssc54Y=
X-Received: by 2002:a05:6830:3481:b0:844:a8bf:7dc7 with SMTP id 46e09a7af769-85d363fc570mr7336192a34.17.1793638230796;
        Mon, 02 Nov 2026 08:50:30 -0800 (PST)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85d354985cdsm9936779a34.10.2026.11.02.08.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:50:30 -0800 (PST)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Mon, 02 Nov 2026 10:50:22 -0600
Subject: [PATCH v2 2/2] rtc: mt6397: provide the 32 kHz output as a clock
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
Message-Id: <20261102-rbrue-suez-upstreaming-mt6397-rtc-32k-v2-2-19ca72815374@gmail.com>
References: <20261102-rbrue-suez-upstreaming-mt6397-rtc-32k-v2-0-19ca72815374@gmail.com>
In-Reply-To: <20261102-rbrue-suez-upstreaming-mt6397-rtc-32k-v2-0-19ca72815374@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793638226; l=4890;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=amIz4+OO8bg9BY0ErwfxlJTjkYD75qjrKdIIoLGCs4c=;
 b=SddfdcmGKWyuqGOE2/GxaWQqOQ1TXoTGs5VUhTToGfp3bnPWl7+Zrz5vLWEeXxPdlsr4dE61r
 fAJ9r7/SePRCBSg2vB3thim3kLRhLfoupjQ/1z8Xsr6XCNPG6w8yuKc
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
index d6e156516aa6..2849beddc79d 100644
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
+	if (!of_property_present(dev->of_node, "#clock-cells") || !rtc->data->con)
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

