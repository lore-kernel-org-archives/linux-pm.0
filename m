Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093413;
	b=29GXcOd3sy2xBWvOpyAPF2hWceqQ7OiQh1Zm/WIJItxzoM09WkSiw3TpRxMVlsOJvCgm
	 DTwbEgjRyfEJJpjgFPBimchLpadLtVtkulJrL3xYXuVCKDBfM6RI0pSSjQpAKC7Ypm/9/
	 yQdkMhXkHKE5UOS0HHZ7q28diEf7yQqsx1LFEkvN5WeczsGgmpxAAhXxRdzXvdwDyIg3L
	 burLZ3KwEsYqwK05DEYrzULlq3e3OOlC/Hs/Q4aa+PhQ1w6zBJ3MtgeGZhTM4QTxjvXSh
	 aWFPjtvE8WAB1yfGwRFKrSVqX6GVr2rE6lU2REzeMcPoFVtnXgVeoZE0TMBT3ZLcMtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093413;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=YYEucHbOJr7sHI1QK+4+U5IS8+cvqTd4o5ImRK6/ELo=;
	b=qHrhlE8F05hzVNI1GpPAuc9rer7T0AYp39jeJ4WKsVBI67YiQshQxYOxK3YGpePUvZiG
	 J5lO/NW0CMEtXgLBX+hMXHNnfwhey/w0fAk5eQ6YtKpiHbQIr2iXFRs1oOUXoj3Z5Umxy
	 dKbo2N6p1VvECMi793oJ9JJCrVQ6UMLoFzLik+yypWHgTGu4+89dpUfHMU5TZ50LF/VSY
	 j02L87mqMqiduAHsWhv1Y8yGqG+K07wngVrLpjxy84uJpTvUBqMnvWpq2i6lLx9ZK7GiB
	 znKyhun1CBaG57FGOg/tbaLLoB0vaErEABjnOe+Uxb1JOKGTcFFttA9SSjHTfXkRoww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=fVZYMZTs;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A7760A380B;
	Thu, 19 Nov 2026 13:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9A7760A380B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=fVZYMZTs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795093403;
	bh=QIs20cC4oV6a0WIA8EHzSU6K8z7ePAnHakWYlW5RbNU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fVZYMZTsHzD49niEKWO1Gh7JCiMtGqa8fghI9qviitjmPNmM+b0do3DEL/CvBAllM
	 AEUWfPJERnF8oWoKpt5VSx6F1Y2fcEiw4SOsC19iSehjWQ5vOgZ3eDXtKynQIA1l0m
	 CTLu9cElgytSLKHZJAUbFk5ew1t+70rod/gpx7OKtfirkkqIVZdrAgqOWuUvNWeO2J
	 SoD6WCV6L5ORZ66y6H2+cogEE4iloQZEBu7kQHLFvFKXq8f3mVHZetxEMeSH7qNQnm
	 QWVBejc8LS144CJa8ZB8ND/JLZ8h6Pbu67hJvHJUoM/MfutxDuRV5a59Ixjguq4IoZ
	 RnPMi5qFem7qQ==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 49FC117E0E61;
	Thu, 19 Nov 2026 14:03:23 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 9F63E480048; Thu, 19 Nov 2026 14:03:22 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 19 Nov 2026 14:02:00 +0100
Subject: [PATCH v4 10/11] PM / devfreq: rockchip-dfi: prepare support for
 v4 DDRMON
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
Message-Id: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-10-517a68c008fe@collabora.com>
References: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-0-517a68c008fe@collabora.com>
In-Reply-To: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-0-517a68c008fe@collabora.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5043;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=QIs20cC4oV6a0WIA8EHzSU6K8z7ePAnHakWYlW5RbNU=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr+85puBsvVa6IHnz8wWUoFSjRclITcOaqY0
 JDJ7sBs06M40okCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq/vOaAAoJENju1/PI
 O/qaBy0P/jOXCtAFv43kMKBG32DJcaPuUeFWCuiEpVyGIrRqyGd7CtqhxUqXJQRXoI73R3dtzGw
 sSBFFreH50k+B7yhKstOuhQdH+TKPnjVC6nxRySIIQaoTdgsPrkFaXIq7UN7wfI8ByJRLBrmhgF
 mc3m5SFpR2w9Pv6CVD47JpsGgWE3taF1Yi5UP21dw0Ohh2c7WcXbt5vHS2gHWWHqt5K2NoVmccU
 XXeWc8VV36aJ17NI2a2GabC8kDK1d6W2DuIhvXktww/II6N1C7+CUBVYCnRvMcy2nZ1tE75yXJE
 Z5ZRL2JDoFZVp3WuTN1vZrmYoOvYBaUxhCtKX+A2ZEXCPDbpJGwoiqm7Ue3cEBC25jwM4BgEp8M
 JMZrjMNQ2WFKlAXGmOlkR8gSLhwCn78bmsIhaEPPy36UxwAdUJtJj/EJQzX86xWVSugWJGOp3oE
 L0QvJsQhFETWh0N+vgHofgSvUK7L63xggSqIuJiLiUtkqXmt4bLbAuOCBBDTpKjK67qB+AF5nDx
 6fJS3LaJClcFmW3wIVIPCjQnPqmJcSMSo/tJgPhDKw1tUi98RTYTdB/Qq+HnxGZhjnsoRWb77ut
 nJpMcilFXZLZ+So5OdT78lpnrtI8/l8d+W2RDRyNxKYk4uVAl5pUnz/6zinj1KhwZ4sCiMrH2wu
 6UJWFyNpkaoeA8g0mSoAtSQ==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Add support for the new control register layout found for DDRMON
controllers having version 0x40. This prepares the driver for
adding RK3576 support.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/devfreq/event/rockchip-dfi.c | 84 ++++++++++++++++++++++++++----------
 1 file changed, 61 insertions(+), 23 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index a8329af90709..db2c77fc5907 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -42,6 +42,19 @@
 #define DDRMON_CTRL_TIMER_CNT_EN	BIT(0)
 #define DDRMON_CTRL_LP5_BANK_MODE_MASK	GENMASK(8, 7)
 
+#define DDRMON_CTRL0	0x04
+#define DDRMON_CTRL0_EXT_TRIGGER_EN		BIT(6)
+#define DDRMON_CTRL0_DDR4			BIT(5)
+#define DDRMON_CTRL0_LPDDR4			BIT(4)
+#define DDRMON_CTRL0_HARDWARE_EN		BIT(3)
+#define DDRMON_CTRL0_LPDDR23			BIT(2)
+#define DDRMON_CTRL0_SOFTWARE_EN		BIT(1)
+#define DDRMON_CTRL0_TIMER_CNT_EN		BIT(0)
+#define DDRMON_CTRL0_HOT_RANK			GENMASK(8, 7)
+
+#define DDRMON_CTRL1	0x08
+#define DDRMON_CTRL1_LPDDR5			BIT(0)
+#define DDRMON_CTRL1_LP5_BANK_MODE_MASK		GENMASK(2, 1)
 
 #define PERF_EVENT_CYCLES		0x0
 #define PERF_EVENT_READ_BYTES		0x1
@@ -143,8 +156,6 @@ struct rockchip_dfi_variant {
 
 static int rockchip_dfi_ddrtype_to_ctrl(struct rockchip_dfi *dfi, u32 *ctrl)
 {
-	u32 ddrmon_ver;
-
 	switch (dfi->ddr_type) {
 	case ROCKCHIP_DDRTYPE_LPDDR2:
 	case ROCKCHIP_DDRTYPE_LPDDR3:
@@ -159,26 +170,43 @@ static int rockchip_dfi_ddrtype_to_ctrl(struct rockchip_dfi *dfi, u32 *ctrl)
 			FIELD_PREP_WM16(DDRMON_CTRL_LPDDR5, 0);
 		break;
 	case ROCKCHIP_DDRTYPE_LPDDR5:
-		ddrmon_ver = readl_relaxed(dfi->regs);
-		if (ddrmon_ver < 0x40) {
-			*ctrl = FIELD_PREP_WM16(DDRMON_CTRL_LPDDR23, 0) |
-				FIELD_PREP_WM16(DDRMON_CTRL_LPDDR4, 0) |
-				FIELD_PREP_WM16(DDRMON_CTRL_LPDDR5, 1) |
-				FIELD_PREP_WM16(DDRMON_CTRL_LP5_BANK_MODE_MASK,
-						dfi->lp5_bank_mode);
-			break;
-		}
-
-		/*
-		 * As it is unknown whether the unpleasant special case
-		 * behaviour used by the vendor kernel is needed for any
-		 * shipping hardware, ask users to report if they have
-		 * some of that hardware.
-		 */
-		dev_err(&dfi->edev->dev,
-			"unsupported DDRMON version 0x%04X, please let linux-rockchip know!\n",
-			ddrmon_ver);
+		*ctrl = FIELD_PREP_WM16(DDRMON_CTRL_LPDDR23, 0) |
+			FIELD_PREP_WM16(DDRMON_CTRL_LPDDR4, 0) |
+			FIELD_PREP_WM16(DDRMON_CTRL_LPDDR5, 1) |
+			FIELD_PREP_WM16(DDRMON_CTRL_LP5_BANK_MODE_MASK,
+					dfi->lp5_bank_mode);
+		break;
+	default:
+		dev_err(&dfi->edev->dev, "unsupported memory type 0x%X\n",
+			dfi->ddr_type);
 		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int rockchip_dfi_v4_ddrtype_to_ctrl(struct rockchip_dfi *dfi, u32 *ctrl0, u32 *ctrl1)
+{
+	switch (dfi->ddr_type) {
+	case ROCKCHIP_DDRTYPE_LPDDR2:
+	case ROCKCHIP_DDRTYPE_LPDDR3:
+		*ctrl0 = FIELD_PREP_WM16(DDRMON_CTRL0_LPDDR23, 1) |
+			 FIELD_PREP_WM16(DDRMON_CTRL0_LPDDR4, 0);
+		*ctrl1 = FIELD_PREP_WM16(DDRMON_CTRL1_LPDDR5, 0);
+		break;
+	case ROCKCHIP_DDRTYPE_LPDDR4:
+	case ROCKCHIP_DDRTYPE_LPDDR4X:
+		*ctrl0 = FIELD_PREP_WM16(DDRMON_CTRL0_LPDDR23, 0) |
+			 FIELD_PREP_WM16(DDRMON_CTRL0_LPDDR4, 1);
+		*ctrl1 = FIELD_PREP_WM16(DDRMON_CTRL1_LPDDR5, 0);
+		break;
+	case ROCKCHIP_DDRTYPE_LPDDR5:
+		*ctrl0 = FIELD_PREP_WM16(DDRMON_CTRL0_LPDDR23, 0) |
+			 FIELD_PREP_WM16(DDRMON_CTRL0_LPDDR4, 0);
+		*ctrl1 = FIELD_PREP_WM16(DDRMON_CTRL1_LPDDR5, 1) |
+			 FIELD_PREP_WM16(DDRMON_CTRL1_LP5_BANK_MODE_MASK,
+					dfi->lp5_bank_mode);
+		break;
 	default:
 		dev_err(&dfi->edev->dev, "unsupported memory type 0x%X\n",
 			dfi->ddr_type);
@@ -188,11 +216,12 @@ static int rockchip_dfi_ddrtype_to_ctrl(struct rockchip_dfi *dfi, u32 *ctrl)
 	return 0;
 }
 
+
 static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
 {
 	void __iomem *dfi_regs = dfi->regs;
+	u32 ctrl, ctrl1, ddrmon_ver;
 	int i, ret = 0;
-	u32 ctrl;
 
 	mutex_lock(&dfi->mutex);
 
@@ -207,7 +236,12 @@ static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
 		goto out;
 	}
 
-	ret = rockchip_dfi_ddrtype_to_ctrl(dfi, &ctrl);
+	ddrmon_ver = readl_relaxed(dfi->regs);
+	if (ddrmon_ver < 0x40)
+		ret = rockchip_dfi_ddrtype_to_ctrl(dfi, &ctrl);
+	else
+		ret = rockchip_dfi_v4_ddrtype_to_ctrl(dfi, &ctrl, &ctrl1);
+
 	if (ret) {
 		clk_bulk_disable_unprepare(dfi->variant->num_clks, dfi->clocks);
 		goto out;
@@ -227,6 +261,10 @@ static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
 		writel_relaxed(ctrl, dfi_regs + i * dfi->variant->stride +
 			       DDRMON_CTRL);
 
+		if (ddrmon_ver >= 0x40)
+			writel_relaxed(ctrl1, dfi_regs + i * dfi->variant->stride +
+				       DDRMON_CTRL1);
+
 		/* enable count, use software mode */
 		writel_relaxed(FIELD_PREP_WM16(DDRMON_CTRL_SOFTWARE_EN, 1),
 			       dfi_regs + i * dfi->variant->stride + DDRMON_CTRL);

-- 
2.53.0

