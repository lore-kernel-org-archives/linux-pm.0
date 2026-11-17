Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929790;
	b=j6upX6f9k3Ilq8cAHbnMbKJeh5x5lAfuMWUSIgU+Jl2zy24QArhxiclJ+0XAyXiXpTUE
	 EYTpRr35sW4uIPOKMRitNZGcneMyYLCB2p0wEtvftwpDceZ6keB9HkW1iP3/0IZc4PiGK
	 9EdZLsc7I3sUKKhz6S5LQe4BlLCkQbAPDt7nNM30BCZMUEUcvlbs26n4rXm5ht9mloeSs
	 Z5nD3/5KhL/lqH3tOnXLSaNUNwOYuDxhB+Q66B5657q0U8o11pjygYQ9L+UNh5JL78JBy
	 4vXWnpYjiowRFV1Wvpwxmer0iXtQVbvXwRzDAqucZU27d35rgoCQu4Smhcde72F9Qzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929790;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=6rHGSibkXeAMyitQUs7cECkd/i6Eq3lk/TPt+b4NONY=;
	b=HEJxYmaBL+1Zo0bUzgleAhsnd4LnN/7iP+oNqxveJctJrF6IamuqNxXEWAfxZFUOyQB8
	 fmZGQFKnE91y3MnrhrDTTPJvS122UbQ62h+Xk61Y0AokzAxoMO3jG+/OAQqNOiUW7MxTn
	 698ZLOK3GiYF6S/8xMhSOcHN+gJDcBccHSyvBzyh9ae80h4NheefOfjnXjRJwA1PT1MLp
	 0YpscSkWyG+b6JmqD5p63j0ijc2uIbvoNR3ImC/IjV8RNXrw5li+NxvzwlaJsograsEFt
	 AdG/I5K0hVQvcvi0Vq2/A1L8u4CiMs4whjVeXH16y2brtgvWop8iSKa/nKLnPNPQ6pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=F3nMwAZP;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67462606A8B5;
	Tue, 17 Nov 2026 15:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67462606A8B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=F3nMwAZP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794929785;
	bh=nhVJg4bYWvwW6u/6JHKMqODZiY5sA4DQ06OrpfY+Gto=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=F3nMwAZPSudLoXVI/BQZBRRwradAkX1+R3CNLXkJ2nnUSkULXp2JICoFyNvxt/Ppz
	 FL/8Xx7an6N9dfYqB2PRuurokYzlUKCoNmukXt9ByJI35QstVdEh2pus8VTtXaFd2L
	 9p2AV3M0n6Nq/caezyUSwOBGGD8aUfqPC5jo5LI6yPof3QNTeXA/xvdpdSexp2hozS
	 6Ob+EJ0NO4Ell0EwFyG+2LwyhYbEKFWG/yduVcMVg0zKZFQpLxuY1WHjb8aS7Y+fUH
	 CbghAKRQ0QBB92JPfJahYckjTGyF59HQtf1NdjDyDsHctOnptf9Vq9Vtn4mtd/2/Rk
	 KIEQrGLAMKPuQ==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 44CF417E361B;
	Tue, 17 Nov 2026 16:36:25 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id A75B7480041; Tue, 17 Nov 2026 16:36:24 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 17 Nov 2026 16:35:44 +0100
Subject: [PATCH v3 8/9] PM / devfreq: rockchip-dfi: prepare support for v4
 DDRMON
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
Message-Id: <20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-8-32ff1546b0e4@collabora.com>
References: <20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-0-32ff1546b0e4@collabora.com>
In-Reply-To: <20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-0-32ff1546b0e4@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5042;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=nhVJg4bYWvwW6u/6JHKMqODZiY5sA4DQ06OrpfY+Gto=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr8dHjd4Sq7Eo+u4UPG6oVGBK7mB18kL+G9P
 KJ8ZxsfbUGc+IkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq/HR4AAoJENju1/PI
 O/qaG9UQAI3/5ifYpiKuGyB8hPw4ECPOhBt4xp62bF/sJ0cPQCTZZCFiK6xCjdwCqsRMDXQ54kd
 48oX9CsJqMWEuwbjBZ7G1VEB0UoodI3yQcXcC8fQLCzygL2EFkvSgLcqvdQNwpDj9Ly2u9uZnf0
 n3gzJHSU8a/0Adm3is7qcz9/VuS6qjoktZ5bkcZ0/dJck3oCtLw4mlIbev+B29BybNKSKvf6l4t
 0ld7iMQy0fbkP0351by5WtVYQMy2AQRybx3cB/dSDxUaR76QDfbxqOVI0jsftSu9mVIhtWUapXT
 FdV0XylrtDo6dEuGuaYTIiGlI0IzAz1YZHvP+CvRov3ArNyof0xLdOCbEAL2tOegzRHpDLJXdpG
 e0m9JHfaActRpMe24jlzLuCSpQaoJUKncVLa/CmqIUFH2ijl+op5J9rOHN0R01b/enN5jkXYMjZ
 JfYe3GIH0Ym4XV4J0Wu6u5PwQ7N/Q7B7oB24IoRN7MZZcRmGJjm9/g3FxAXYYaCAHqANx05r3pK
 9d+IRLxhVODf2Cg/TLapF2EfPtJvO786jDP/9e8ZhHyyTHaZEbUhWI7byEi8f9uPT9VD5HYElKV
 9+RVR2uomgLG7zeewThlXdUyC0svPUhGxTGpuucWOaklEbieezy2fn6YcfzI1XS/5OlznpmUcIk
 rYIFTGbDgbZqkC65m1PstRg==
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
index 33a379618eb5..ed28dc6446f1 100644
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

