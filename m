Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929788;
	b=rxv+ryrYZfNipQr0/z21Bj8q529WBRRotTFs8VvuLysp49zUML6NRUnYA+cgtf2JtcRB
	 x0ycjhKQ4xsFXQQ93qPxmB58tjpSs0zykkPKk2xBMWhVPrvSrgNgbdiKjd2zw+vpf9wPb
	 oVoj3ugWWHf8ajJ4wGzp1jTJabHgbih3yL5PdC4XnRZMTlLDG9FXvw7ZphsTRbphUaTm4
	 Yz6l8ErI1IghmybvVPiWV+QjXWiSQSJOh/z0VgjKnHHMW8bo8iuDfh4EH8/28TJ9Indoe
	 PE/oA9l1UXEl47CTfIwEunvEluNeUDnmaLYxHlHJhI+/+i/VFnyVCRsufjpUaLzKxxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929788;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=vHpmFm9uLU/BQwpwWgYZOaExDqDrGZWS7dV11F1s1Bw=;
	b=qmm4AHDRVwKA2sxhB6ax1AsbDOokme28pBGBo4jHYWWhY7zc7Xc7v6KUsXlD6dGWIMUL
	 KqtUkMBL5sojuJARE6d4lniKMyvXEHDQd9NqhQpgtKR9JX4gEeCKx4UFKvWZpyU3JleY8
	 U6kXQNz8pGOFjojzcXNijuSrh+mEN3ADfzlvLnT+e9E8t3tRfXnvtPk3RcirObMn7FwPS
	 uyJWdP7qyLtWBi609KIvXT5O452XPel+5GDoyFWKRJmH3zbvxY4pm1HQltn0zB1g8dLQS
	 6hbRbyMGeCROCtYVBSHMBZugYq5novaCddoR7fcYoatOO5MyzWfJJP4PTdLgON9qovA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=GCREOlcy;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9563606A31C;
	Tue, 17 Nov 2026 15:36:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9563606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=GCREOlcy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794929785;
	bh=7GoAWptegRv/cDijOkhodFadWGZgOk7IPO1AGcY1Os4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GCREOlcyLOZIKpgr/R2zL5frVBStMwL1qOGdmXwraJErGO4vv/mjH/PoI8N27yw5n
	 w35cA0z0sehUFde1zH/9eeN0DAF3oRPu/tZw7Cy1QsWzBXcv4r9jPf9RQSiXTVOD5E
	 PnPPReRdPAJo4M8iEcEfPy3DG4EE8Kz14C2ABBI0thuyFmKDUAsRgS9F3ksALUux/z
	 KJb6nWyhfGA9btq72K0ktfZyRuV9Xb2Do62bbDPyaQ3svkzzYLlzGGqpDUuV96FBpM
	 AkIh0E91t0PiE03pArfQsgHrkNzKhmNFXrZLlfJn4JUW0yaOjO1tENXXU/cUI9p2ll
	 LZMnevhcoIQHQ==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E0D8017E1136;
	Tue, 17 Nov 2026 16:36:24 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 9E756480031; Tue, 17 Nov 2026 16:36:24 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 17 Nov 2026 16:35:39 +0100
Subject: [PATCH v3 3/9] PM / devfreq: rockchip-dfi: move to per-variant
 const structs
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
Message-Id: <20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-3-32ff1546b0e4@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9589;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=eU4EgEpy7UxsxJjBW2dvb1HlzTTiqSEDSVWkQ9LdX4I=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr8dHjmNoU7t/a5RXPOOtqzXEHdb5STmMEtg
 mr8xMp7bCCErIkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq/HR4AAoJENju1/PI
 O/qaVtMP/1tBehlrIN1gkYdGYuBAy8C73/WQq8N9u8O8TFXMoLn88LQxlvLOwkyJbZLsV/pmwKx
 hzFtln7Gjfk4mc1P0nfTXoBGL6DlzKTNhwlrpSboYjgibruAsmtQPwiTBXvrnm2BG0zG+zpZVXc
 7vgt38g6pGMtiiGRmb8BcdNTVs6bOQrJrout5m3+L3rG4Xxn/sEelecZRyAVqaXkwyXmRhVoWmG
 BjfokphMgprbUZzrRoFizhsRsLUOxjGGwCM2ZjrIb27HNQKeZghXJJ+djAIHEPOjcB/o8ckOWqr
 gvrvwgD42v4T5TH2ihQyPPAkdKgTN75gpWY3o7RZ+SAZ4/pJ4nFN7cKzI0AWT2WpBnTbk2JHMSe
 KDxcGpO02AHNopb/85IhyeadI0/1nZQpaLEak26eDE+7msQsOspwCSkyZX31vuussy3dgCGbWC1
 wrAGIFtG4zfRDe2dHkt/jx6MnxUMubZo7dhVAUq7+RxuFtp8RQmOk9gUeYBf6jRhWSK6hzb2ja5
 hqPN+WsmRws/xSV94XuFK6/6klxf6lt5p8DmK2zUN1AQI+wDRUe3QWoe3VLMYldp+d/dQiyVW7s
 pY9INbfgVeLKVVs2+7mbR/tI3xxiVPIzVMC0o+V29CZ0G7IqX0/XIun9nm8hyOPF/8hEm0ekXUC
 Ug3CyrqmncHXD8NMtgkA5wg==
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
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/devfreq/event/rockchip-dfi.c | 94 +++++++++++++++++++++---------------
 1 file changed, 54 insertions(+), 40 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index e0b942028e50..d02a01188ea2 100644
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
@@ -190,7 +195,7 @@ static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
 		goto out;
 	}
 
-	for (i = 0; i < dfi->max_channels; i++) {
+	for (i = 0; i < dfi->variant->max_channels; i++) {
 
 		if (!(dfi->channel_mask & BIT(i)))
 			continue;
@@ -199,16 +204,16 @@ static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
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
@@ -231,14 +236,14 @@ static void rockchip_dfi_disable(struct rockchip_dfi *dfi)
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
 
@@ -252,17 +257,17 @@ static void rockchip_dfi_read_counters(struct rockchip_dfi *dfi, struct dmc_coun
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
 
@@ -299,7 +304,7 @@ static int rockchip_dfi_get_event(struct devfreq_event_dev *edev,
 	rockchip_dfi_read_counters(dfi, &count);
 
 	/* We can only report one channel, so find the busiest one */
-	for (i = 0; i < dfi->max_channels; i++) {
+	for (i = 0; i < dfi->variant->max_channels; i++) {
 		u32 a, c;
 
 		if (!(dfi->channel_mask & BIT(i)))
@@ -338,7 +343,7 @@ static void rockchip_ddr_perf_counters_add(struct rockchip_dfi *dfi,
 	const struct dmc_count *last = &dfi->last_perf_count;
 	int i;
 
-	for (i = 0; i < dfi->max_channels; i++) {
+	for (i = 0; i < dfi->variant->max_channels; i++) {
 		res->c[i].read_access = dfi->total_count.c[i].read_access +
 			(u32)(now->c[i].read_access - last->c[i].read_access);
 		res->c[i].write_access = dfi->total_count.c[i].write_access +
@@ -479,11 +484,11 @@ static u64 rockchip_ddr_perf_event_get_count(struct perf_event *event)
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
@@ -511,7 +516,7 @@ static u64 rockchip_ddr_perf_event_get_count(struct perf_event *event)
 		count = total.c[3].write_access * blen * dfi->buswidth[3];
 		break;
 	case PERF_EVENT_BYTES:
-		for (i = 0; i < dfi->max_channels; i++)
+		for (i = 0; i < dfi->variant->max_channels; i++)
 			count += total.c[i].access * blen * dfi->buswidth[i];
 		break;
 	}
@@ -728,14 +733,10 @@ static int rk3399_dfi_init(struct rockchip_dfi *dfi)
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
 
@@ -758,13 +759,9 @@ static int rk3568_dfi_init(struct rockchip_dfi *dfi)
 		dfi->ddr_type |= FIELD_GET(RK3568_PMUGRF_OS_REG3_DRAMTYPE_INFO_V3, reg3) << 3;
 
 	dfi->channel_mask = BIT(0);
-	dfi->max_channels = 1;
 
 	dfi->buswidth[0] = FIELD_GET(RK3568_PMUGRF_OS_REG2_BW_CH0, reg2) == 0 ? 4 : 2;
 
-	dfi->ddrmon_stride = 0x0; /* not relevant, we only have a single channel on this SoC */
-	dfi->ddrmon_ctrl_single = true;
-
 	return 0;
 };
 
@@ -793,9 +790,7 @@ static int rk3588_dfi_init(struct rockchip_dfi *dfi)
 	dfi->buswidth[3] = FIELD_GET(RK3588_PMUGRF_OS_REG2_BW_CH1, reg4) == 0 ? 4 : 2;
 	dfi->channel_mask = FIELD_GET(RK3588_PMUGRF_OS_REG2_CH_INFO, reg2) |
 			    FIELD_GET(RK3588_PMUGRF_OS_REG2_CH_INFO, reg4) << 2;
-	dfi->max_channels = 4;
 
-	dfi->ddrmon_stride = 0x4000;
 	dfi->count_multiplier = 2;
 
 	if (dfi->ddr_type == ROCKCHIP_DDRTYPE_LPDDR5) {
@@ -809,10 +804,30 @@ static int rk3588_dfi_init(struct rockchip_dfi *dfi)
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
 
@@ -824,17 +839,16 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
 	struct rockchip_dfi *dfi;
 	struct devfreq_event_desc *desc;
 	struct device_node *np = pdev->dev.of_node, *node;
-	int (*soc_init)(struct rockchip_dfi *dfi);
 	int ret;
 
-	soc_init = of_device_get_match_data(&pdev->dev);
-	if (!soc_init)
-		return -EINVAL;
-
 	dfi = devm_kzalloc_obj(dev, *dfi);
 	if (!dfi)
 		return -ENOMEM;
 
+	dfi->variant = of_device_get_match_data(dev);
+	if (!dfi->variant)
+		return -EINVAL;
+
 	dfi->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(dfi->regs))
 		return PTR_ERR(dfi->regs);
@@ -856,7 +870,7 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
 	desc->driver_data = dfi;
 	desc->name = np->name;
 
-	ret = soc_init(dfi);
+	ret = dfi->variant->init(dfi);
 	if (ret)
 		return ret;
 

-- 
2.53.0

