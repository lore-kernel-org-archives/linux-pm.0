Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9F546F4BB;
	Mon, 21 Sep 2026 20:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022801; cv=none; b=Cu8dgjiMJcQqa5/xE5gMZCyFYdwL5nAVVohJVUebI7TKh/JO+ImXqh0JhjeNJZSuUbqjApeGkZzalv4teCBN/yArel94mA7nVy0CklD8mmTuZoXj4My/aF48Wpe8pRkx9146W9+w9vda2nxBvYYfGPljBKVj/O0DTZidr1Nw4+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022801; c=relaxed/simple;
	bh=Vwa4GrOJLj5QOmHKF3cPLVhahqIlD9N15DaKOL6XZow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ILwuzAK6jFjZJTXiIh5oiDG3kpMTN89gx8XKz/tPuJ/D8yXTcMCXNDhyxFXGJXp+2wQ7pngNFyQiwNJrbWdwFS6s43CocDdHQ9NvMo4OblJFEI3bjXyZmSYBg7+Mm4b922kGs7Q3ClHWMxxBa/VC1eiX+tWyIisS0Nl+yGc2ths=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=m1pYZAKD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="m1pYZAKD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790022792;
	bh=Vwa4GrOJLj5QOmHKF3cPLVhahqIlD9N15DaKOL6XZow=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m1pYZAKDQWI31IoFrJiol9B/OSGfe/CYu3iCEYXQoN9L6Ml6qPsbdGJ1Td+p0iG73
	 TJMDGpWAQlVkH7xUVGFfym+VOs9ndpVHC69TQtd2NRDUocGt2/RwrYqtPhsQ1MDWG7
	 2hHRR8p+7kfWESPaRataHzfonMXaoScixz9X47ZwCpWuTWPz/n1YiRAjH/JpWNkn/m
	 HW5UkewmJcVw+8ZdrHrgcUlldNJR5QVNFPThc9ahOLdrDOsLF7pwHcmEdgCC7BnFUD
	 PlS56Ace0Y7s20ApZrMoHJ8EHg/+D5uAHNxakMilzh+ZIKj66A3cXzvqVOMvO20PV+
	 e4Gol3wPzoTYg==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8F7B717E0C7E;
	Mon, 21 Sep 2026 22:33:12 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id F09C0480035; Mon, 21 Sep 2026 22:33:11 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 21 Sep 2026 22:32:48 +0200
Subject: [PATCH v2 5/8] PM / devfreq: rockchip-dfi: use bulk clock APIs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-rockchip-dfi-cleanup-v2-5-43ff34ac8599@collabora.com>
References: <20260921-rockchip-dfi-cleanup-v2-0-43ff34ac8599@collabora.com>
In-Reply-To: <20260921-rockchip-dfi-cleanup-v2-0-43ff34ac8599@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4096;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=lvpRuYQwgyj92YlzDFeJ2yAKSqPbRarTndix/sTx4H4=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqxlIe3hvcTWmYlgv3zGSXBVY7NPWy0iLXgl
 Yd/f3TsoW82C4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqsZSHAAoJENju1/PI
 O/qaOeIP/1OW/FkVxQcsCFIdag5fXftJFsc88N6dEwloUAscmgmL5ZpsLXOa3rCp4JyF+zRS5Jf
 dLIyC0EVk5D1scLOM/42QlGTOuDilSZ5irQcqrcgfmn3YWg1O1A9P1dbuLHSHYiyX27rsEjEMuu
 xqhw55qFrn06QWtfdEsTC0drRv7dkkQxZM/gno57DU7hVohLcxKZgG/ZO5SUUfyILqYOuIV96oy
 wI5zpfvlK4BPUxea5BOaJ9oI6pv262DzF0dp/5fW9nDOOjJdscfbP9vGQzs8bSMT0YSe6fEj3xq
 h5R31r5AhTjI5cLBGNQ2E5W3PPaJLq49c4sYZrDDBwD3rDMtMSZbQbKP6cL7EXy+EB3mJj8/1Xn
 6ARoAmVuiteFKZWyB7SjlwkGWXB7tldqIfnk8TU1BoExlrFY3zJrPwea0LG0W4mQfds19A7/nYh
 b8wBHmc4zLQeNZ5yqi+Mu7zTti9KVfwOI7Rclske86pSDZJfeTedDO8XM1Sz67dl4YrSMLDlxTA
 GnM3SQ/1TmmpmTznOk8L5eKpZcXfGy5Mm2TSq2aciFmnX2fiuPAaXYXT3yDwj6ebmpMRVxilGT7
 dOTQCeUTlZ7BGNIe1GOJLVEw9mqsBqw02IuN1mDdxw+sw9bzLerdp4yeV4jWxHJSLQZ5iQ4Md4e
 2CtvINCQ8H1MAXGC2S9Aw1A==
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
 drivers/devfreq/event/rockchip-dfi.c | 39 +++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index dd9edfd6a674..b61ec500eaed 100644
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
@@ -183,9 +185,10 @@ static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
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
 
@@ -245,7 +248,7 @@ static void rockchip_dfi_disable(struct rockchip_dfi *dfi)
 			break;
 	}
 
-	clk_disable_unprepare(dfi->clk);
+	clk_bulk_disable_unprepare(dfi->variant->num_clks, dfi->clocks);
 out:
 	mutex_unlock(&dfi->mutex);
 }
@@ -721,11 +724,6 @@ static int rk3399_dfi_init(struct rockchip_dfi *dfi)
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
@@ -802,11 +800,17 @@ static int rk3588_dfi_init(struct rockchip_dfi *dfi)
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
@@ -837,6 +841,7 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
 	struct rockchip_dfi *dfi;
 	struct devfreq_event_desc *desc;
 	struct device_node *np = pdev->dev.of_node, *node;
+	unsigned int i;
 	int ret;
 
 	dfi = devm_kzalloc(dev, sizeof(*dfi), GFP_KERNEL);
@@ -868,6 +873,22 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
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

