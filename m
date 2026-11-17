Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929789;
	b=U0+PDlLIi3DyM9HsLaF+1mPnY1i9oHNItOije07JCwu3Mc0aaW9eodhLtWeVetkt2ExR
	 QhkxHqH0jzR0ujx32Dhvmb7ygA8FUwDFIhQDqip6/7wBXDF6sf5RhsYloxhfde/sEQ3gi
	 K3ZoJtaZP8llPbkEnk0TreXFlWWORBBxrFDQQYVBYEp76PGFTL7jnA1z0k31tnHhwwCe3
	 gI3ntc4MAR2BUeTcZLE7hVGOs0qVVDe1SnV+T9A3J3Bvmhl/SfmGf34kzncKhhjMVz2qE
	 ZDZMUCtVXjtpHvdmutEBg4nRAjoFx6fbIUEZE8BtHt73QQNEEnPgfBzBybXhSUo5FLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929789;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=4sbyzpJAxIDFxgcpIrMAioNZlOET3S/iWQo4KfdgHXA=;
	b=etZCC246Ag7x4/J//tJ5ZCtrCWOzK1CWDLqBsTpTq7msFpl2TySn/SQUgF/QuP7iYP12
	 0ODhD3eDVpHl07nv0J5qHQ+qF4jezR7XmzzITKOednRW3Zm/1oHCQ5ZFERjwb6qhenO4g
	 XZ9XEI6ZT8ppCcOcE/tshfzprcgrtGUO3lkI9VEPunIHySS1tzbmuDNy4W/rO0N+PA9y7
	 f8H8ImzfbBekEuKG35aunfO93e8fmsRhMNDKxnj7ByLhjwzGfy+ziKZzn5SfCrR/wMrPh
	 G1x4qCd22RckUykjY4JJsqvPLKeTyl86wa5bkO3liB15YgY9iJIcNp97JsGNSR5+IAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=li1CeGRX;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0E8606A8AD;
	Tue, 17 Nov 2026 15:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C0E8606A8AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=li1CeGRX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794929785;
	bh=MkSaCXBSTxQzUuUwxdZcERKka6eJMOCmHXnmRjFV+Ks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=li1CeGRXekcgW3zNY8hte0CJoyyVtdFdi0KoxCi7HqqUh19dQv+fyp+71revbY61A
	 QaSB66XJjSXjTgrfxZ/eCVMijNC+O0VL4n/LSuzGR2Sfx/iGBgDiYck4g8YUtWtBZl
	 7Cm4pYgPwX14BOQEU6/zlCwc8rIXJ0woOJsfWaSFrRea+38nPa55XGHvJFMnpsv+DD
	 mBQ+nBYxeNl88/6w2utW4fuVjYoqSZEU5sdT1msuU1IY7hEiMQBRnDeEMAr7RS9CSi
	 Q+aOBnCSVme8vn0gM/YFtr3mvMC0r7qyE+Qu/LFDBsezJhHdP8VEuO/W8VZIsLsnXm
	 4uj6rIOxe7IkQ==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3A47217E15E8;
	Tue, 17 Nov 2026 16:36:25 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id A3F1248003A; Tue, 17 Nov 2026 16:36:24 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 17 Nov 2026 16:35:42 +0100
Subject: [PATCH v3 6/9] PM / devfreq: rockchip-dfi: make RK3588 use its
 clocks
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
Message-Id: <20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-6-32ff1546b0e4@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3489;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=0155YjzP9zSEapLDG7dpTk7D9ZfSA9H0fNKY2sr4DCo=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr8dHhdw/lAcFQs+G+ZMCZs+qix8ub0XsiTS
 q/8DlhJYIwa84kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq/HR4AAoJENju1/PI
 O/qanOIP/1avEdOO2y0p8l38LpIcgRUepoCcfVnmLsjeyt/Fb+8uYhYLeEWHihq1MxOPjGvFw3Q
 PoHMrdhWvkh91TmieP+yQUi0TiG1SFw6W/wprTJVUC0Jzmbv5ohegBcasPr9wVQYnPZSXImITAJ
 jQtAQ3Xzy5lY+4Tbw2vOpHIKWxBdHwL/yulFyPXZ4CxMsniSa8rWvClbJHT2D4itaHDXG/xfmAO
 g6HqIJpNDekdEmN/zCvAEz0q4CVtbY/xg3lWeum4reSSVeXVNYWBvGdL2C0bZLl5r/8RHscGatl
 pZqacgsKzBkhDdh5raeXJzZTERKZOHv/2vmlSqnh9DRBwd+YAhyyr2vvz9uck3OgWowEbc+Alcq
 mb9x5mGuIoXJ2GGHR/5hqmEVDbe7l2tCdGGDL2o0ho6AIUjXGZQOjy1rO5PJSPZZ2LXbmfeo6ig
 PySYEcF/DhDGuyWY3q1W4CqK4AtcRZmisy4JFwcOUVDxLcmS8DqnevMGnZn3CgdQpDWYo5SawKJ
 Ngn16nsO79gJZ0nH1cjpU5pawlH6KUHhIVQ8k1N5u1QCTc2Y53+RJSWr9P2qKQmEXLhuDy9q1F8
 N/4VpWmgSvjLzt4FHBxK0rpeEe2vLtwdQDVCxf3npzcu8+ZAz2fTnhj/KsiX5WBgbU6APqOOw5i
 A7gqB/FZ9OtpA7bXrgHou9w==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

So far, RK3588 doesn't have the pclks for DDRMON used in the driver, as
they weren't modelled before.

However, they are now correctly modelled, so the driver should use them
when possible.

Instead of unconditionally getting them for this SoC, add a new variant
member that specifies whether the driver should let missing clocks
slide. This is needed because we want old device trees to keep
functioning, as otherwise we'd be introducing a breaking change for
literally no functional difference here.

Fill out a clock name list for this variant as well, and hand it to it.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/devfreq/event/rockchip-dfi.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 150fdf577e11..a97c63cdab57 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -117,6 +117,18 @@ struct rockchip_dfi {
 	const struct rockchip_dfi_variant *variant;
 };
 
+/**
+ * struct rockchip_dfi_variant
+ * @init: pointer to the variant-specific initialisation function
+ * @stride: address offset between the DDRMON per-channel instances
+ * @ctrl_single: whether only one DDRMON instance monitors multiple channels
+ * @max_channels: maximum number of memory channels for this SoC
+ * @clk_names: pointer to a constant array of constant clock name strings
+ * @num_clk: the number of elements in the @clk_names array
+ * @clocks_optional: whether not finding the clocks is non-fatal. Set if the
+ *                   DT binding for this variant didn't require clocks in the
+ *                   past, so that the driver remains compatible with old DTs.
+ */
 struct rockchip_dfi_variant {
 	int (*init)(struct rockchip_dfi *dfi);
 	int stride;
@@ -124,6 +136,7 @@ struct rockchip_dfi_variant {
 	unsigned int max_channels;
 	const char * const *clk_names;
 	unsigned int num_clks;
+	bool clocks_optional;
 };
 
 static int rockchip_dfi_ddrtype_to_ctrl(struct rockchip_dfi *dfi, u32 *ctrl)
@@ -806,6 +819,11 @@ static const char * const rk3399_clk_names[] = {
 	"pclk_ddr_mon",
 };
 
+static const char * const rk3588_clk_names[] = {
+	"pclk_ddr_mon_ch0", "pclk_ddr_mon_ch1", "pclk_ddr_mon_ch2",
+	"pclk_ddr_mon_ch3",
+};
+
 static const struct rockchip_dfi_variant rk3399_variant = {
 	.init = rk3399_dfi_init,
 	.stride = 0x14,
@@ -826,6 +844,9 @@ static const struct rockchip_dfi_variant rk3588_variant = {
 	.init = rk3588_dfi_init,
 	.stride = 0x4000,
 	.max_channels = 4,
+	.clk_names = rk3588_clk_names,
+	.num_clks = ARRAY_SIZE(rk3588_clk_names),
+	.clocks_optional = true,
 };
 
 static const struct of_device_id rockchip_dfi_id_match[] = {
@@ -885,8 +906,12 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
 		for (i = 0; i < dfi->variant->num_clks; i++)
 			dfi->clocks[i].id = dfi->variant->clk_names[i];
 
-		ret = devm_clk_bulk_get(dev, dfi->variant->num_clks,
-					dfi->clocks);
+		if (dfi->variant->clocks_optional)
+			ret = devm_clk_bulk_get_optional(dev, dfi->variant->num_clks,
+							 dfi->clocks);
+		else
+			ret = devm_clk_bulk_get(dev, dfi->variant->num_clks,
+						dfi->clocks);
 		if (ret)
 			return dev_err_probe(dev, ret, "failed to get clocks\n");
 	}

-- 
2.53.0

