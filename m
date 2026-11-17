Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929790;
	b=DcDPYl3he/5ulZxj1Rj4qLCsvuqkoNH0lOiP8UdFyO1YZZd1rA/YxvmTKZOW4xYFTc0r
	 ZgkV4YfYgJnAyLFEImTojD8hoNwwtI/zRGl2qzdwous3ajjDyROdPavsTDG8W6r7gBu1t
	 0MbzFyhidvC8O2u/8NZQk01p8punDFA+ixH+bH+a0NAfd9+Qtf9nAWF9buRfbgmCHxoae
	 MMI5RmA+k64TOq4Cnm0/Z2UzbxozZ2/J26zYVjD+Co918PgTYiYG6VsMgX0/GPASBCdyc
	 cuWaGJoWJcMt7vDkG68g+kMjv3+OhczZPppo7yLLC1SIhZHeFI1Ju1Kalcb7mHmknag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929790;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=k+uTaGPuqVC+JsL6GD2QEc91Mh3yFORTEZZbMaHGODo=;
	b=GUbiv0UBho9bIQ1PoJiJvvru5+SDas2GhcN4KgiFBFhRqDLbIoJQFwcSa1uBaOm5mw2Q
	 RVVkv/dCvamTXg+H2/vYnYKd3P/zLk+xTrbI2dSN3PftE9us5LxiVvvQyF/0pbl34DJGI
	 wtyvK0r0WKmUAclzm6q5C25kL2332frv0RN00fgvokCNaJtU5UajVg+b7V7VkHRyrPggj
	 zdPpLKOaxCcebOfL4S4YDWjuJnQ9dj/w4i2KPb54pY9iQdTiVzq4AHYmsAfN5MgC6v0f0
	 hm9H0b9bia2A91NSLaBlkBUtsNr4QnIIORFJv0c8gJ0CqmOvzjcMhwEzh257yGCxPEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=X5dMJqjL;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A62D606A8B0;
	Tue, 17 Nov 2026 15:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A62D606A8B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=X5dMJqjL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794929785;
	bh=9for1UP9wX5Z1UAK6zoFnp1sPaWJj+6RNd+CXhI5yOA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X5dMJqjLLbPbtpEJ/Ympm/oa+t66LxQwoinlZoZOr2qxn4h6fX7XVF3aXU0rzt0QC
	 yL6nFuMDbij2u7znGXS9uWvKvLU+Hoywq826uVRzzR5fpIH1nATd6sI1SidZF41r21
	 Y3jsqjJA4Msx5WiOQhF3Th8PBovkD88CGbUOvhcmB2Tepj9Oxe4qt1DFbtcTfShjnB
	 0AU1OqALDAEV6ldFxo35eXHCAbt00NIw7o5sIbq+baHqPf7lieM1orXIPoD6hCvAsQ
	 e2HROqS+1ZyldlJ/2OXcDWK2y6EmRrzc5FpGQ94VFgfRaL6AXbUfLmQccEF0lsHku3
	 37tzVY1YThrow==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 393CD17E1515;
	Tue, 17 Nov 2026 16:36:25 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id A232D480038; Tue, 17 Nov 2026 16:36:24 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 17 Nov 2026 16:35:41 +0100
Subject: [PATCH v3 5/9] PM / devfreq: rockchip-dfi: use bulk clock APIs
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
Message-Id: <20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-5-32ff1546b0e4@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4275;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=FVc67IsDHrR4UyUBuyybA1XJo/lDVvbhLdBY6eZUezo=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr8dHj526wxTglMsvgcnZSpLThG79dnHyOKY
 S/QB/N63iWCdYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq/HR4AAoJENju1/PI
 O/qawbUP/Rt5jALTCMY62ik7nCsbPy1U5ullcwLddejMvQ33QCCtceooj/ET05kP7J/N/AlG2T4
 x0MimsraHjk3mh3Zb/8MoTJnjhMTiHBrgaXzRTcnOdgZXwB7LTDP4SBbjZHjrEc/WH3zON3/LK4
 ogkomYa/ud9ioKwdjcWm/gw5g5uxNj5zMTgB7b0brGBOW+zJrCzoMDuH0XbVqtWVaYN2Qf42JLW
 x/zRrUpuWH2xrTlcLyyUroj1UkGVFFggJTeQAN20hVW6QI3S7zG5ZV/McfziBKv6ow0tj4EThkc
 FP2yM/Shd2NYVd/8OzZm8hwH0loKm471FQ00A9WT0/0ZKO3u9aKDy4hQJmVUs9WIb4wJJOP4bov
 qSp9s+a8yr+PleQUhqpEjgjPkCvfrDIo2gEcSpwEUe+cyNEXExT4LgCnTeAKC8TDTSc6EQYLuNA
 Ug0O5+UEaaGYNb8kLc7uxVnV73n90YGRCgONXKWtIwIfuSOXlI03ixv+Gg0FfRReYlyjBRZDaw8
 O+ML0fjLVcWyHJ0K68lHgQ1wSjitbQKrDdNK1sx+bDGU+hVSEoUuPaAVlVUPdkdksAwdafp+M5N
 NeJ17qHvxNttKrV5yWmkYsxWTkhS/VIbN6ZYA3aAQLnEYPpkCmalIIEtNFBJvJ9o5zbnvG/JSrG
 YScquLek61UxddqdfftQv9Q==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Currently, the only clock rockchip-dfi will ever use is on the rk3399,
namely pclk_ddr_mon. However, this is mainly because every other SoC's
mainline clock tree and bindings are probably lying and not telling us
about some clock gate branches that do exist in hardware, but nothing
happens ever gate.

Get preparations out of the way to fix this by moving to the bulk clock
APIs, which will make handling the one-clock-per-channel cases easier to
deal with.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/devfreq/event/rockchip-dfi.c | 41 +++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index eb47a1f622b1..150fdf577e11 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -98,7 +98,7 @@ struct rockchip_dfi {
 	struct device *dev;
 	void __iomem *regs;
 	struct regmap *regmap_pmu;
-	struct clk *clk;
+	struct clk_bulk_data *clocks;
 	int usecount;
 	struct mutex mutex;
 	u32 ddr_type;
@@ -122,6 +122,8 @@ struct rockchip_dfi_variant {
 	int stride;
 	bool ctrl_single;
 	unsigned int max_channels;
+	const char * const *clk_names;
+	unsigned int num_clks;
 };
 
 static int rockchip_dfi_ddrtype_to_ctrl(struct rockchip_dfi *dfi, u32 *ctrl)
@@ -183,15 +185,16 @@ static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
 	if (dfi->usecount > 1)
 		goto out;
 
-	ret = clk_prepare_enable(dfi->clk);
+	ret = clk_bulk_prepare_enable(dfi->variant->num_clks, dfi->clocks);
 	if (ret) {
-		dev_err(&dfi->edev->dev, "failed to enable dfi clk: %d\n", ret);
+		dev_err(&dfi->edev->dev, "failed to enable dfi clocks: %pe\n",
+			ERR_PTR(ret));
 		goto out;
 	}
 
 	ret = rockchip_dfi_ddrtype_to_ctrl(dfi, &ctrl);
 	if (ret) {
-		clk_disable_unprepare(dfi->clk);
+		clk_bulk_disable_unprepare(dfi->variant->num_clks, dfi->clocks);
 		goto out;
 	}
 
@@ -247,7 +250,7 @@ static void rockchip_dfi_disable(struct rockchip_dfi *dfi)
 			break;
 	}
 
-	clk_disable_unprepare(dfi->clk);
+	clk_bulk_disable_unprepare(dfi->variant->num_clks, dfi->clocks);
 out:
 	mutex_unlock(&dfi->mutex);
 }
@@ -723,11 +726,6 @@ static int rk3399_dfi_init(struct rockchip_dfi *dfi)
 	struct regmap *regmap_pmu = dfi->regmap_pmu;
 	u32 val;
 
-	dfi->clk = devm_clk_get(dfi->dev, "pclk_ddr_mon");
-	if (IS_ERR(dfi->clk))
-		return dev_err_probe(dfi->dev, PTR_ERR(dfi->clk),
-				     "Cannot get the clk pclk_ddr_mon\n");
-
 	/* get ddr type */
 	regmap_read(regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
 	dfi->ddr_type = FIELD_GET(RK3399_PMUGRF_OS_REG2_DDRTYPE, val);
@@ -804,11 +802,17 @@ static int rk3588_dfi_init(struct rockchip_dfi *dfi)
 	return 0;
 };
 
+static const char * const rk3399_clk_names[] = {
+	"pclk_ddr_mon",
+};
+
 static const struct rockchip_dfi_variant rk3399_variant = {
 	.init = rk3399_dfi_init,
 	.stride = 0x14,
 	.ctrl_single = true,
 	.max_channels = 2,
+	.clk_names = rk3399_clk_names,
+	.num_clks = ARRAY_SIZE(rk3399_clk_names),
 };
 
 static const struct rockchip_dfi_variant rk3568_variant = {
@@ -839,6 +843,7 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
 	struct rockchip_dfi *dfi;
 	struct devfreq_event_desc *desc;
 	struct device_node *np = pdev->dev.of_node, *node;
+	unsigned int i;
 	int ret;
 
 	dfi = devm_kzalloc_obj(dev, *dfi);
@@ -870,6 +875,22 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
 	desc->driver_data = dfi;
 	desc->name = np->name;
 
+	if (dfi->variant->num_clks) {
+		/* NB: CCF is fine with us leaving this NULL if num_clks = 0 */
+		dfi->clocks = devm_kcalloc(dev, dfi->variant->num_clks,
+					   sizeof(*dfi->clocks), GFP_KERNEL);
+		if (!dfi->clocks)
+			return -ENOMEM;
+
+		for (i = 0; i < dfi->variant->num_clks; i++)
+			dfi->clocks[i].id = dfi->variant->clk_names[i];
+
+		ret = devm_clk_bulk_get(dev, dfi->variant->num_clks,
+					dfi->clocks);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to get clocks\n");
+	}
+
 	ret = dfi->variant->init(dfi);
 	if (ret)
 		return ret;

-- 
2.53.0

