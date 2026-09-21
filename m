Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EA14457DB;
	Mon, 21 Sep 2026 20:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022796; cv=none; b=Vx3+Qer8F1BASxSF+H3Z75AfKCO+5XqPuxS6yZZpMutsE8j07q/byeKI/n2DD/EY5QTKuKQuNweIOAphw1qSCuE2agn0wnry6+6902MTxHBD9AhAeGy9EwFL1/JLsabgayO37n8r6/LG9MV5aeM2RM0UMG5xfAf1XFLZGybQ5n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022796; c=relaxed/simple;
	bh=aT58dFKDyhiJqaN2cKniCqERGQtyp3W/fZdagjPbqYo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eA4INaZ6hNvdxbz+HjjuPr4Ssd91BeLURQjMJFA1aywnNNFIoBI8lCGNCSw5MvKQaxUntlqFouSfhp2RQTfyDa206LwKogRmORQNkN1lyVdmrkrRn9LAyykZMLhdjZY+X8rAPp/w0+dFqfcAsHUsWGg47Tn3A0gyKstL/skT1hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FZKM7PyV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FZKM7PyV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790022792;
	bh=aT58dFKDyhiJqaN2cKniCqERGQtyp3W/fZdagjPbqYo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FZKM7PyV2pAJ6BqsVszY/d8Z7XfsXU314HnOfsWPdyYd9D8G8RYvsIR23Y02wTY9J
	 eLGLETT0Rpc6HTE3lZR0B1p/sD+4sm5OiKk0uVyS3vwwDGd2XI+5PsO3si1b/WfN61
	 wu2O4i1QU4o49T0A7T8qiPHh0b4Rf2F04A0SR7KcQ0DzPTn8cEK2RGgScdUY2HgkjO
	 +L2cYimvTYTDIXoZnaGAv/PGr4skRSC4kApk6fE5erT6Szb7zwbvVcmrGXxCMKeqJI
	 JQXzf6iRphHU2Tnte+9bYWpHd1e2DOPpHRI63wyaoo0I+y3rdsdp/eTTGi7OcL14pQ
	 wBkGSTpjrNFsw==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 400B017E09ED;
	Mon, 21 Sep 2026 22:33:12 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id ED147480030; Mon, 21 Sep 2026 22:33:11 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Mon, 21 Sep 2026 22:32:46 +0200
Subject: [PATCH v2 3/8] PM / devfreq: rockchip-dfi: move to per-variant
 const structs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-rockchip-dfi-cleanup-v2-3-43ff34ac8599@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9544;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=y65RBL8I0JRF1EhPVMN7EiGUEBnlIwsg0XksNw4AoAc=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqxlIeRCTLZrT1pbC4fp8PqJpJaHRZsdKEki
 Wi3fc0LPCl6x4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqsZSHAAoJENju1/PI
 O/qaQFUP/iTBGdKoxHQARE+4fu/3p/DjovVXKrVIup01dvpNykQ7x2o0SxOFI4SsHV7UgM4xG7G
 C5ZTcSicGNiBBoHnsUDBsTc/HzsTZZtUb7xw9UtjS0Ko7VFShvmn/YJk0TYoLIFP4KFyRgVRP7k
 blrhrD3zjRazyv/oWAXfT3NbhjakEPkBMB8WU5PpZLerhDapxrZsnsjD8Cjtx85WhF0pA6oSc1i
 J2I5HQ/6NTRK+ubGt93FR5bvyCJKYo465hTa31ifsFk3gpBPZAIls9yjzKj6C6iN3IH7V/UEEWq
 tZexsexbm3XG8XMXtRUeYDQs+/8ACb4is38pCuKk0qT5KK9REQodKQk7VU4uEtU48oP4OzUFMDb
 +LaaoMfhb5gn5jW8izyMEgc48yf7L8zDX123xudVcslxC/gWsnSKUVdQlHZu5nbPGn00iDFRgjH
 ssp8ma9oUuumS77pxUv0SEEsdFDolByfx364TfcPb9NJgMRaLOD5gDk0UxDim13djnvVLtf4mpY
 QrqKA5adqx46FcYVWVYXSpAhUlgvrzS1HvIVcHBAoLl2MHnTIS6Sf5HcMmlVa+Hp9lO8kuAEIi2
 qZln6edlcC87jUcIndElEiwE9Q+CKO8n+a6H3BPVMrARebJXdmmSXBjvPstjTb2rZBpklPyAm5z
 tS/Xw66jMvgIcNV769PwscQ==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

The rockchip-dfi driver supports several variants of the DDR monitoring
hardware. The differences in these variants are handled with one init
function for each variant.

However, some of the members that these init functions set are actually
constants, specific to that variant, with no runtime involvement from
reading registers or anything.

Refactor the code to move those values (and the soc_init function
pointer) into a new struct. Declare some const instances of this variant
struct, and use it wherever needed.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/devfreq/event/rockchip-dfi.c | 94 +++++++++++++++++++++---------------
 1 file changed, 54 insertions(+), 40 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 255aee1bdd91..5339616f7ca6 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -103,7 +103,6 @@ struct rockchip_dfi {
 	struct mutex mutex;
 	u32 ddr_type;
 	unsigned int channel_mask;
-	unsigned int max_channels;
 	enum cpuhp_state cpuhp_state;
 	struct hlist_node node;
 	struct pmu pmu;
@@ -112,11 +111,17 @@ struct rockchip_dfi {
 	int active_events;
 	int burst_len;
 	int buswidth[DMC_MAX_CHANNELS];
-	int ddrmon_stride;
-	bool ddrmon_ctrl_single;
 	u32 lp5_bank_mode;
 	bool lp5_ckr;	/* true if in 4:1 command-to-data clock ratio mode */
 	unsigned int count_multiplier;	/* number of data clocks per count */
+	const struct rockchip_dfi_variant *variant;
+};
+
+struct rockchip_dfi_variant {
+	int (*init)(struct rockchip_dfi *dfi);
+	int stride;
+	bool ctrl_single;
+	unsigned int max_channels;
 };
 
 static int rockchip_dfi_ddrtype_to_ctrl(struct rockchip_dfi *dfi, u32 *ctrl)
@@ -188,7 +193,7 @@ static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
 	if (ret)
 		goto out;
 
-	for (i = 0; i < dfi->max_channels; i++) {
+	for (i = 0; i < dfi->variant->max_channels; i++) {
 
 		if (!(dfi->channel_mask & BIT(i)))
 			continue;
@@ -197,16 +202,16 @@ static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
 		writel_relaxed(FIELD_PREP_WM16(DDRMON_CTRL_TIMER_CNT_EN, 0) |
 			       FIELD_PREP_WM16(DDRMON_CTRL_SOFTWARE_EN, 0) |
 			       FIELD_PREP_WM16(DDRMON_CTRL_HARDWARE_EN, 0),
-			       dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
+			       dfi_regs + i * dfi->variant->stride + DDRMON_CTRL);
 
-		writel_relaxed(ctrl, dfi_regs + i * dfi->ddrmon_stride +
+		writel_relaxed(ctrl, dfi_regs + i * dfi->variant->stride +
 			       DDRMON_CTRL);
 
 		/* enable count, use software mode */
 		writel_relaxed(FIELD_PREP_WM16(DDRMON_CTRL_SOFTWARE_EN, 1),
-			       dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
+			       dfi_regs + i * dfi->variant->stride + DDRMON_CTRL);
 
-		if (dfi->ddrmon_ctrl_single)
+		if (dfi->variant->ctrl_single)
 			break;
 	}
 out:
@@ -229,14 +234,14 @@ static void rockchip_dfi_disable(struct rockchip_dfi *dfi)
 	if (dfi->usecount > 0)
 		goto out;
 
-	for (i = 0; i < dfi->max_channels; i++) {
+	for (i = 0; i < dfi->variant->max_channels; i++) {
 		if (!(dfi->channel_mask & BIT(i)))
 			continue;
 
 		writel_relaxed(FIELD_PREP_WM16(DDRMON_CTRL_SOFTWARE_EN, 0),
-			       dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
+			       dfi_regs + i * dfi->variant->stride + DDRMON_CTRL);
 
-		if (dfi->ddrmon_ctrl_single)
+		if (dfi->variant->ctrl_single)
 			break;
 	}
 
@@ -250,17 +255,17 @@ static void rockchip_dfi_read_counters(struct rockchip_dfi *dfi, struct dmc_coun
 	u32 i;
 	void __iomem *dfi_regs = dfi->regs;
 
-	for (i = 0; i < dfi->max_channels; i++) {
+	for (i = 0; i < dfi->variant->max_channels; i++) {
 		if (!(dfi->channel_mask & BIT(i)))
 			continue;
 		res->c[i].read_access = readl_relaxed(dfi_regs +
-				DDRMON_CH0_RD_NUM + i * dfi->ddrmon_stride);
+				DDRMON_CH0_RD_NUM + i * dfi->variant->stride);
 		res->c[i].write_access = readl_relaxed(dfi_regs +
-				DDRMON_CH0_WR_NUM + i * dfi->ddrmon_stride);
+				DDRMON_CH0_WR_NUM + i * dfi->variant->stride);
 		res->c[i].access = readl_relaxed(dfi_regs +
-				DDRMON_CH0_DFI_ACCESS_NUM + i * dfi->ddrmon_stride);
+				DDRMON_CH0_DFI_ACCESS_NUM + i * dfi->variant->stride);
 		res->c[i].clock_cycles = readl_relaxed(dfi_regs +
-				DDRMON_CH0_COUNT_NUM + i * dfi->ddrmon_stride);
+				DDRMON_CH0_COUNT_NUM + i * dfi->variant->stride);
 	}
 }
 
@@ -297,7 +302,7 @@ static int rockchip_dfi_get_event(struct devfreq_event_dev *edev,
 	rockchip_dfi_read_counters(dfi, &count);
 
 	/* We can only report one channel, so find the busiest one */
-	for (i = 0; i < dfi->max_channels; i++) {
+	for (i = 0; i < dfi->variant->max_channels; i++) {
 		u32 a, c;
 
 		if (!(dfi->channel_mask & BIT(i)))
@@ -336,7 +341,7 @@ static void rockchip_ddr_perf_counters_add(struct rockchip_dfi *dfi,
 	const struct dmc_count *last = &dfi->last_perf_count;
 	int i;
 
-	for (i = 0; i < dfi->max_channels; i++) {
+	for (i = 0; i < dfi->variant->max_channels; i++) {
 		res->c[i].read_access = dfi->total_count.c[i].read_access +
 			(u32)(now->c[i].read_access - last->c[i].read_access);
 		res->c[i].write_access = dfi->total_count.c[i].write_access +
@@ -477,11 +482,11 @@ static u64 rockchip_ddr_perf_event_get_count(struct perf_event *event)
 		count = total.c[0].clock_cycles * dfi->count_multiplier;
 		break;
 	case PERF_EVENT_READ_BYTES:
-		for (i = 0; i < dfi->max_channels; i++)
+		for (i = 0; i < dfi->variant->max_channels; i++)
 			count += total.c[i].read_access * blen * dfi->buswidth[i];
 		break;
 	case PERF_EVENT_WRITE_BYTES:
-		for (i = 0; i < dfi->max_channels; i++)
+		for (i = 0; i < dfi->variant->max_channels; i++)
 			count += total.c[i].write_access * blen * dfi->buswidth[i];
 		break;
 	case PERF_EVENT_READ_BYTES0:
@@ -509,7 +514,7 @@ static u64 rockchip_ddr_perf_event_get_count(struct perf_event *event)
 		count = total.c[3].write_access * blen * dfi->buswidth[3];
 		break;
 	case PERF_EVENT_BYTES:
-		for (i = 0; i < dfi->max_channels; i++)
+		for (i = 0; i < dfi->variant->max_channels; i++)
 			count += total.c[i].access * blen * dfi->buswidth[i];
 		break;
 	}
@@ -726,14 +731,10 @@ static int rk3399_dfi_init(struct rockchip_dfi *dfi)
 	dfi->ddr_type = FIELD_GET(RK3399_PMUGRF_OS_REG2_DDRTYPE, val);
 
 	dfi->channel_mask = GENMASK(1, 0);
-	dfi->max_channels = 2;
 
 	dfi->buswidth[0] = FIELD_GET(RK3399_PMUGRF_OS_REG2_BW_CH0, val) == 0 ? 4 : 2;
 	dfi->buswidth[1] = FIELD_GET(RK3399_PMUGRF_OS_REG2_BW_CH1, val) == 0 ? 4 : 2;
 
-	dfi->ddrmon_stride = 0x14;
-	dfi->ddrmon_ctrl_single = true;
-
 	return 0;
 };
 
@@ -756,13 +757,9 @@ static int rk3568_dfi_init(struct rockchip_dfi *dfi)
 		dfi->ddr_type |= FIELD_GET(RK3568_PMUGRF_OS_REG3_DRAMTYPE_INFO_V3, reg3) << 3;
 
 	dfi->channel_mask = BIT(0);
-	dfi->max_channels = 1;
 
 	dfi->buswidth[0] = FIELD_GET(RK3568_PMUGRF_OS_REG2_BW_CH0, reg2) == 0 ? 4 : 2;
 
-	dfi->ddrmon_stride = 0x0; /* not relevant, we only have a single channel on this SoC */
-	dfi->ddrmon_ctrl_single = true;
-
 	return 0;
 };
 
@@ -791,9 +788,7 @@ static int rk3588_dfi_init(struct rockchip_dfi *dfi)
 	dfi->buswidth[3] = FIELD_GET(RK3588_PMUGRF_OS_REG2_BW_CH1, reg4) == 0 ? 4 : 2;
 	dfi->channel_mask = FIELD_GET(RK3588_PMUGRF_OS_REG2_CH_INFO, reg2) |
 			    FIELD_GET(RK3588_PMUGRF_OS_REG2_CH_INFO, reg4) << 2;
-	dfi->max_channels = 4;
 
-	dfi->ddrmon_stride = 0x4000;
 	dfi->count_multiplier = 2;
 
 	if (dfi->ddr_type == ROCKCHIP_DDRTYPE_LPDDR5) {
@@ -807,10 +802,30 @@ static int rk3588_dfi_init(struct rockchip_dfi *dfi)
 	return 0;
 };
 
+static const struct rockchip_dfi_variant rk3399_variant = {
+	.init = rk3399_dfi_init,
+	.stride = 0x14,
+	.ctrl_single = true,
+	.max_channels = 2,
+};
+
+static const struct rockchip_dfi_variant rk3568_variant = {
+	.init = rk3568_dfi_init,
+	.stride = 0x0,
+	.ctrl_single = true,
+	.max_channels = 1,
+};
+
+static const struct rockchip_dfi_variant rk3588_variant = {
+	.init = rk3588_dfi_init,
+	.stride = 0x4000,
+	.max_channels = 4,
+};
+
 static const struct of_device_id rockchip_dfi_id_match[] = {
-	{ .compatible = "rockchip,rk3399-dfi", .data = rk3399_dfi_init },
-	{ .compatible = "rockchip,rk3568-dfi", .data = rk3568_dfi_init },
-	{ .compatible = "rockchip,rk3588-dfi", .data = rk3588_dfi_init },
+	{ .compatible = "rockchip,rk3399-dfi", .data = &rk3399_variant },
+	{ .compatible = "rockchip,rk3568-dfi", .data = &rk3568_variant },
+	{ .compatible = "rockchip,rk3588-dfi", .data = &rk3588_variant },
 	{ },
 };
 
@@ -822,17 +837,16 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
 	struct rockchip_dfi *dfi;
 	struct devfreq_event_desc *desc;
 	struct device_node *np = pdev->dev.of_node, *node;
-	int (*soc_init)(struct rockchip_dfi *dfi);
 	int ret;
 
-	soc_init = of_device_get_match_data(&pdev->dev);
-	if (!soc_init)
-		return -EINVAL;
-
 	dfi = devm_kzalloc(dev, sizeof(*dfi), GFP_KERNEL);
 	if (!dfi)
 		return -ENOMEM;
 
+	dfi->variant = of_device_get_match_data(dev);
+	if (!dfi->variant)
+		return -EINVAL;
+
 	dfi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dfi->regs))
 		return PTR_ERR(dfi->regs);
@@ -854,7 +868,7 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
 	desc->driver_data = dfi;
 	desc->name = np->name;
 
-	ret = soc_init(dfi);
+	ret = dfi->variant->init(dfi);
 	if (ret)
 		return ret;
 

-- 
2.53.0

