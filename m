Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED137479867;
	Mon, 21 Sep 2026 20:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022801; cv=none; b=CCkRVuuIOvCUofZ/W6iOwYbTDVNgUVTA4OZJIyXr62JsvuJ4RacWzG2lmHWI7saREOGnOEm4r65R7oCfg4PFWXvzbdmr3fITNOBh7yPDrvgbhZ0GfauVvPEtxGKJRo/h/Nd8TOyyUzH4jrVvMUfeKSSyZ5AGkU0XoIOatYdTPDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022801; c=relaxed/simple;
	bh=tiAXtxGxkrnKvU2eq5NeqSXpRtY5IBhw2szF9OLHTKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=atgMRzHZNdrdknAyBJDx09dmAruOhKyHIfMDuXqgyad2r31kwEXcOcfcYaBXfINOy350WRG7+CQYuiZIiDVNiVp0rfKMLa37MGwQGdLJNfCH/Mvm6I45QpY/CNs+yefg3FZgk8jXkVkhgd4hF007i7gktkDW17lEW/Z9EB/Bt6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PrteYN7M; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PrteYN7M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790022792;
	bh=tiAXtxGxkrnKvU2eq5NeqSXpRtY5IBhw2szF9OLHTKs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PrteYN7M3bX4I2j26CG+OeV1cQhyOJImo22FSqS9oDKRLNb9FS09y5XTXrdC7F0Wq
	 /0YC/LcuusP1rGxT2rvaOmsh2JMjbTL9zCmluyWR4uaHPjkP2rtdNjXOxjoRcEkii0
	 fwxi1Fg/4mmu43PwHPMKXMf6OZ2xAdg2J/1VmClMtMTFSmimGTE9VLtRmQtiTwErjv
	 jFBd2lsQcFDhTCZHHeD7VPR52aYprJDcbamFxxD8qWa6C9cpfyYgp7/oAbCYVp+1X3
	 qKKjWkuzzFOoWZ7tDkdP8fD0WZR/fJ/nOo6bXkxU923nrtFtv/IURtKj/mD8SPzGFh
	 xxAZc70gdaZFw==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9806D17E0DF0;
	Mon, 21 Sep 2026 22:33:12 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id F3D3B48003A; Mon, 21 Sep 2026 22:33:11 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 21 Sep 2026 22:32:50 +0200
Subject: [PATCH v2 7/8] PM / devfreq: rockchip-dfi: make RK3588 use its
 clocks
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-rockchip-dfi-cleanup-v2-7-43ff34ac8599@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3489;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=qvocAYEOUWCK+4Q9yI0ZwLs4Fy1aQdG/tLvtq/e+Jqc=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqxlIf3CNUAFPMYVqFNp4MFUI2A8pkyMRxRs
 vDRfPJNPvLdL4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqsZSHAAoJENju1/PI
 O/qaN9QQAKiUaLYg3S8VlvBCe9XB6jUao/EllJMQHzYAOeMb3mtOwshB4meRmSKtxzdqt5AEv1I
 CIZubGuKNNG6rzy+WRZGX7fR6Ii2Z8UVtiNvlT67HICA2wy8D9mTSuOmi9DV8P6zZYNEdjoULtK
 R2EdJlykZCpawXNpfTC9hEtkUnn7lnQzRmHQMas8sHeHQHUgyN4798GmrNwYdbcEXYOPsmkMZJT
 dX+zt4WhWJdx70RLgfpk4oYC5WS0A3X6ckP1gRNKGP/H8CIUSU2ljiDjqWu2bczNqqEj/3QlZnq
 cnTT/ooa6U98Mh3q0TK6oSjtUYeoL+GM3EPuGPNcixl7wh55TiKYwXdMCwWT91o/doG9CUg1fJM
 0GUB0nj6guKaBLTBbdnC8cjW1w09/1kNltEY5nk2NO1Py+1vyGSLkb7s8Maar+a2yr6IkRgogz1
 KCD02uZxAbDCQk4khrfE6TL4OWaYlV8eZU8xXi0d+gvD6hPuRUS2EahR/KZzxkH7Bkn8oFeB3+s
 Q42eXzI6meD+ITq3qwM3TM7KNcKsUrF/FRiUgNTKCwCcojftpLcuwFTlEeSlepwyaxuhjt/EIzM
 btUxd6h0P1AheUFlR2k2YDalKya/8dmSPFybMl0scBxAEPhhV96wu4sAOrUP/1HCwTPBfywv9Dg
 5KyyU0WWoW54KcKVv6cwiIg==
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
index b61ec500eaed..380361a231a2 100644
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
@@ -804,6 +817,11 @@ static const char * const rk3399_clk_names[] = {
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
@@ -824,6 +842,9 @@ static const struct rockchip_dfi_variant rk3588_variant = {
 	.init = rk3588_dfi_init,
 	.stride = 0x4000,
 	.max_channels = 4,
+	.clk_names = rk3588_clk_names,
+	.num_clks = ARRAY_SIZE(rk3588_clk_names),
+	.clocks_optional = true,
 };
 
 static const struct of_device_id rockchip_dfi_id_match[] = {
@@ -883,8 +904,12 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
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

