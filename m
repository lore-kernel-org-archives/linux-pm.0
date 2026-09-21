Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69803515986;
	Mon, 21 Sep 2026 21:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025314; cv=none; b=jQz8WdscELjKyhhyYYamzPiL+mh6Dz2oTTEf1+sKjugiuD9Id6w0v7+tiTbrZoHJ/KcKEEdsUjTe0HjoWvGJRuyWUxcUDfdGATg3kn/bNmN1BADfaT7LrGbj/8HE9UlCyuXFx3EjlDfYeD1dfm6GbVJ7Zi/alDLio48S5pOA1/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025314; c=relaxed/simple;
	bh=khr+bJaYjJjoJSh5v4LpM9wTDjoEkflVWzoe5WtEJgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PrP+7FXcM9fsnq7gv9CjQ+bApmcJjvo2zjySVMGatVcW2cNbq+y3VPk3PHeqH4xzSgT2hVAS0pnbrUPOWjvmmokEjHveRk4p3mkadXWFh0JpdxtIr4tg2lRgy2vzoCOYQ/Wqopu8TvDesNjVk49HpE1DOH6ApouMJUFgX0Nd5mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AEsJUcKZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AEsJUcKZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790025307;
	bh=khr+bJaYjJjoJSh5v4LpM9wTDjoEkflVWzoe5WtEJgM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AEsJUcKZz8jjPJQbEedMpIGnmClUf9kNzHGD66QDEMex5erhp/SEuGaXsZzI52W4t
	 dJjad/hTkK9oxM21eJf2Z6FM6+FcyE7HQcbcS6DceH7qYp81jhWTkuYTlApprNazY0
	 OqTD7rXuurpIcKNXnr7PHI+Qjz5ylnVUoK7Honyqk3KSWIcUh98oniVMLWFktZdjOs
	 ZvJglaySkOI9GZ7CWWoZzeS7zdQSgrYhEy+0xPqyeYYJZe+4a/tR+IfBaVeKVLWPvr
	 zltJDvj6yFPiC7Ea6BWO4KySHee7yAFTCFBt0D6UWoIWomSxzlDY+JCyfktNXqUR85
	 XjMLPQWk7MlqA==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E74D717E09D6;
	Mon, 21 Sep 2026 23:15:06 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 5B136480038; Mon, 21 Sep 2026 23:15:06 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 21 Sep 2026 23:15:08 +0200
Subject: [PATCH v2 6/7] PM / devfreq: rockchip-dfi: prepare support for v4
 DDRMON
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-b4-rockchip-dfi-rk3576-support-v2-6-04f847016321@collabora.com>
References: <20260921-b4-rockchip-dfi-rk3576-support-v2-0-04f847016321@collabora.com>
In-Reply-To: <20260921-b4-rockchip-dfi-rk3576-support-v2-0-04f847016321@collabora.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5026;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=khr+bJaYjJjoJSh5v4LpM9wTDjoEkflVWzoe5WtEJgM=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqxnlpFesZYsAxSYjmhkEgH6o+ssMm59D3j7
 b5eU7Of51MSE4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqsZ5aAAoJENju1/PI
 O/qass0P/iyG1lRzao5MjQ1iRCSPCSbJip9pcDzwd1VhVCKq5EdtjZlYNT7pqzggKNH3XQev4br
 e13J+eqXjnkmyiYem+/dDku8++0p4kFXlWq63Vsk4QnditML6mg4S1QBEJle5vmGr+SUztp8tBM
 E6BMSAMHTK7A9A/BRGCxtZHt84Qx439yGOqCwOOQnjFavKf1REIK2neQQ65LaBmpTd5qsmx4xbV
 um3D94dFvIMoSdZel/d6xNOM3/DABc/4+s6C8FAM+woXevpM1EKTLPQY2k/5xZXnztHPtFo3QMm
 8Kfr4N7oIuaDPombXo3pvpCDrZll6KXE4XQSdzHCzQ83MM7FSxnbSTRMn7wxWtudYwiSmAZ/A/v
 5NCuS7IP+4+hgX4ZIhI/FZX08PCIlihLa2UURGJslIm5VDtphJ3P37fhCwUwYFOmtFRUxn/iK8O
 Fp1fkmMQwzZpUxumJlh2tmkA6CsPwbhVBhRQijoGXpDhdbWECJRw/CFhSqGlIHwlB6WI1nEfBhT
 sjCtrNYvnvpGq9MqJ8MAkQ6t6V9eY9wz/MtAoX0dt3QwYGugy8AyiGwu65dd/JXv+MhNRUkMQph
 iPjHww/MpMQL8tSzL5tAKVlSiBDW9fOelQ1TLom15NeKZSo3jyCVLWBsy5nb3zE1QPjLU4Tu+h5
 d5b0M9wkQ6Brdm8ZMmVEmaw==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Add support for the new control register layout found for DDRMON
controllers having version 0x40. This prepares the driver for
adding RK3576 support.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/devfreq/event/rockchip-dfi.c | 85 ++++++++++++++++++++++++++----------
 1 file changed, 62 insertions(+), 23 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 8490219f61be..8ba97af78e3d 100644
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
+			 FIELD_PREP_WM16(DDRMON_CTRL_LP5_BANK_MODE_MASK,
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
 
@@ -207,10 +236,16 @@ static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
 		goto out;
 	}
 
-	ret = rockchip_dfi_ddrtype_to_ctrl(dfi, &ctrl);
+	ddrmon_ver = readl_relaxed(dfi->regs);
+	if (ddrmon_ver < 0x40)
+		ret = rockchip_dfi_ddrtype_to_ctrl(dfi, &ctrl);
+	else
+		ret = rockchip_dfi_v4_ddrtype_to_ctrl(dfi, &ctrl, &ctrl1);
+
 	if (ret)
 		goto out;
 
+
 	for (i = 0; i < dfi->variant->max_channels; i++) {
 
 		if (!(dfi->channel_mask & BIT(i)))
@@ -225,6 +260,10 @@ static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
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

