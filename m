Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306393624BC;
	Sat, 12 Sep 2026 06:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789195996; cv=none; b=WMKtGC/oaRMxVPoJkaTpL+zzf9L/tm6CoU5KLCe/vYP8M08OyJ1xeO6KD2R3CFG7ZvD1nFFDSw0sUXJc0mGyeLx5gTHEq61gOaFsaMfuKRv6RIjxXXIdtDxZ6xtGY86iPtnNrCmhxKLQt7FD8VRGeU4zkAE29x1SFxdkSpV+BqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789195996; c=relaxed/simple;
	bh=IE3xWBXDo6VtwItgviJPad/JRbM0VHzIDuwI7KgwfBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2PPlhlkRJnlJpVVDa31icL+fqIFe3asOZaAiRi/Now5MvbzA2WqpKD+WJLzNkj9pdbH1xQP2eRd22XlsAH6deP57jD1XQgAhAVucwawDBOw2xHF3B2PGBNmybYVOLYd0VkGn4E98J2ZC1NsRZajTmviMYbAkkJ8mrPJRzlbtWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=gvHSvQ3r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=df0iVg3T; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="gvHSvQ3r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="df0iVg3T"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E6EE67A00BD;
	Sat, 12 Sep 2026 02:53:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 12 Sep 2026 02:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1789195993; x=
	1789282393; bh=eIbu+FRnuIaeFrU8yxIF1UYO5RWNoHkH+v38kjzzSXI=; b=g
	vHSvQ3r7v+l+egfUn2U8wl6Wppp4psnh5oINunj7Q5KZhxnHBA9zqm5WhrnXsm+O
	Uvxcs/Gm9k4z7+MbVzuroF1U+JHLcdF8ps4OnhkpYqcT/Tq/dkfrHqWRiXNkDQ3M
	VEA3EhlNcRQXk8CQ4PDV4OCzBlqwmsPGKWCvN1R51eiIh0Cvrp3mlT7cj+bU5r4N
	uC7IiHsAcHnHmrtohE77ke3iiIxHrd+QpC+gB5iHXwaa6fjFTtatXvhjnENouH61
	TzHqQcQOepRBMqh0hcc5llzqCawp05l28Zm56tlsJ/nOfW8i3yYLud2hsE7WxgDA
	9sg4ejDf3+fsrD/k/2fBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789195993; x=1789282393; bh=e
	Ibu+FRnuIaeFrU8yxIF1UYO5RWNoHkH+v38kjzzSXI=; b=df0iVg3THyYOPUXLv
	NybtfFnHYTLq+J9Un3Y98qNGYM9N5V59zzHgvjQy9FX0MU400iMADCOsP+CIL8Yz
	FfunFelSynqP7xJr9pdw1+3YrMRibSdMA4+C1U6yPOW5g8f3fFXClGOiFrG73WEA
	GrjZ5ed2iGt2dGqPBLRirMjlPi9PbHryYXTF4piIPL615gniFZ7eFR4uGQEdBCuL
	HMm3v7GLDEZwr+DcN66cBL/gVVu1ALCzHzIKNYt1oPttpZ/k4RtqQiyvo0f7ZKwB
	75GKqo+lZwgjsKW3CuTZ3kz04VRsB0FL5f3YDrkQQwtHP/KurEsbTu42fdJNJjYf
	HlSDA==
X-ME-Sender: <xms:2fakauhB_hTG3X5yo7S_qo3T0V7s_VIee3DYOpcmSKCz4RLtUbqDgg>
    <xme:2fakavJfYL-C-ctBlzrKp_WUqYq8uhzQw1iY2f7UZknPya3jNh9zIo5mHWd2_VXB7
    1w2FHSBLV1tktUbGcrEXPZr5VbGxZyKHn1slvIVVuT6olNhisTspoY>
X-ME-Received: <xmr:2fakaj6kKlwCxhatU-GpB6WhF0DtxyTexm9yqqFX_7H10ULNRkg6SJxBM2LPNXZxM2eA_CVVuw>
X-ME-Proxy-Cause: dmFkZTFADPy43ymxNR6XHAVFKRdNY4DpcYEBRSwa13JqCTHbL9NsQVfP9qCQ5TTmagE5kF
    RB532MExwgRSB4dKHz35IjH9JqP654WzyiSX+TI/62Bro3K5rJ+mWZ18Sxxo6D9XJjUSyu
    Eob4bmEwP/sHC/KMD1YX4DKomTq3nqtMsAoZtW6mHz74Bj+8J2iIqiPYSwY0Lln911wUXn
    2LrOxQMwefzQS/S4posukY87oskKCBLl/4tkcieL5kkqVMlf97XBcvzTaPE3LqTgGgxCyb
    hCopDHT7yawVnq3UuO8HWKojJnhhQiPlPVXjr7c5M9JZoLkZ/wGQ5AHB8kIddJPmNXv6gr
    4JsLzQZ8k2buCdwUXlSYtbl60UffPpcbB97xVkQv584B2n2hLCITvNjlA1Q/w3uuGHwiWf
    Ld7sHQDXQ3OHWIY8m3yUM2kJeVXqrexmLjHwajNdYH17yzMeyVQnAXeMscjyt5MlgWsvdr
    KX8HQVKUIfUlXTjZODeJJ2m2u34g5/stV9s8COxid7d2hSipcs8fKavPY2ZpgwERxrINKX
    h3QjLIK8kdeRjXXmLjm51ThFK/2WoLlKOvCXB3ZTI6/3FZNXkKn29hx+BBL9PeLWMwyNXA
    f+kBwUEl+RlNgZOwDE/5yzvaITD0sugxVcVv4nmI2ueODnj7JhMkoeh+p/Cw
X-ME-Proxy: <xmx:2fakarjh1E7IAaJWTR36H2kYitXcpRo6Zs6MetDiGJwOdMxygaRblA>
    <xmx:2fakap8ZKdPzub0Gslpw0vvOb6XTkjtKMnAJCBH4o83zuG3ulajIIw>
    <xmx:2fakale2ngXIVbdd3X42G0HCPj0a8IUE5gK5_HWtHJApYL0xfhS5mg>
    <xmx:2fakalnzC2rwf96dFKqPcujkcL7FcdOHSkjHyn1cgi9qZL3x7iEPcA>
    <xmx:2fakav9coGVnKajXQc7BxV811Rdp2dKI20LSK4njM11HsP7Q8WCdLvAf>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Sep 2026 02:53:05 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: royalnet026@gmail.com,
	abel.vesa@oss.qualcomm.com,
	sebastian.reichel@collabora.com,
	sidong.yang@furiosa.ai,
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v12 11/14] accel/rocket: select the per-core clock and reset counts from match data
Date: Sat, 12 Sep 2026 18:50:50 +1200
Message-ID: <20260912065053.1519165-12-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260912065053.1519165-1-gahing@gahingwoo.com>
References: <20260912065053.1519165-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3576 carries the same RKNN block with a different set of clocks and
resets, so the counts cannot stay compile-time constants. Add a soc_data
struct to the of_device_id match data and take the bulk counts from it.
RK3588 keeps four clocks and two resets, so nothing changes for it, and the
arrays keep their present sizes: the SoC that needs a longer one grows it
in the patch that adds the names.

rocket_core_reset() is switched over as well. It is the same array, and
leaving it on ARRAY_SIZE() would walk entries that were never acquired once
a SoC asks for fewer.

soc is checked at the top of rocket_probe(), before anything is allocated
and before the per-core fields are stored. of_device_get_match_data()
returns NULL for a device that bound by name rather than by compatible, and
such a device has no of_node, so it was never counted by the walk of
matching nodes that sizes rdev->cores[]. Storing into that array first and
checking afterwards would be writing past the end under the check's own
premise, and returning from there is the one error path in this function
that would skip the unwind the path below it does.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_core.c |  8 ++++----
 drivers/accel/rocket/rocket_core.h |  7 +++++++
 drivers/accel/rocket/rocket_drv.c  | 26 +++++++++++++++++++++++---
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index 5dd260bac..b202d1581 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -23,7 +23,7 @@ int rocket_core_init(struct rocket_core *core)
 
 	core->resets[0].id = "srst_a";
 	core->resets[1].id = "srst_h";
-	err = devm_reset_control_bulk_get_exclusive(&pdev->dev, ARRAY_SIZE(core->resets),
+	err = devm_reset_control_bulk_get_exclusive(&pdev->dev, core->soc->num_resets,
 						    core->resets);
 	if (err)
 		return dev_err_probe(dev, err, "failed to get resets for core %d\n", core->index);
@@ -32,7 +32,7 @@ int rocket_core_init(struct rocket_core *core)
 	core->clks[1].id = "hclk";
 	core->clks[2].id = "npu";
 	core->clks[3].id = "pclk";
-	err = devm_clk_bulk_get(dev, ARRAY_SIZE(core->clks), core->clks);
+	err = devm_clk_bulk_get(dev, core->soc->num_clks, core->clks);
 	if (err)
 		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", core->index);
 
@@ -109,9 +109,9 @@ void rocket_core_fini(struct rocket_core *core)
 
 void rocket_core_reset(struct rocket_core *core)
 {
-	reset_control_bulk_assert(ARRAY_SIZE(core->resets), core->resets);
+	reset_control_bulk_assert(core->soc->num_resets, core->resets);
 
 	udelay(10);
 
-	reset_control_bulk_deassert(ARRAY_SIZE(core->resets), core->resets);
+	reset_control_bulk_deassert(core->soc->num_resets, core->resets);
 }
diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index f6d738285..ba74c5339 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -27,9 +27,16 @@
 #define rocket_core_writel(core, reg, value) \
 	writel(value, (core)->core_iomem + (REG_CORE_##reg) - REG_CORE_S_STATUS)
 
+/* Per-SoC differences, selected by the of_device_id match data. */
+struct rocket_soc_data {
+	unsigned int num_clks;		/* clk_bulk count */
+	unsigned int num_resets;	/* reset_bulk count */
+};
+
 struct rocket_core {
 	struct device *dev;
 	struct rocket_device *rdev;
+	const struct rocket_soc_data *soc;
 	unsigned int index;
 
 	int irq;
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 8bbbce594..7ed64c131 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -159,8 +159,22 @@ static const struct drm_driver rocket_drm_driver = {
 
 static int rocket_probe(struct platform_device *pdev)
 {
+	const struct rocket_soc_data *soc = of_device_get_match_data(&pdev->dev);
 	int ret;
 
+	/*
+	 * soc is dereferenced without a check by every one of its users, and
+	 * rocket_core_init() below is the first of them. A device that bound
+	 * by name rather than by compatible has no match data, so fail before
+	 * anything is allocated rather than at the first dereference: the
+	 * number of cores comes from a walk of matching DT nodes, and a device
+	 * with no of_node was never counted by it.
+	 */
+	if (!soc) {
+		dev_err(&pdev->dev, "no match data for this device\n");
+		return -ENODEV;
+	}
+
 	if (rdev == NULL) {
 		/* First core probing, initialize DRM device. */
 		rdev = rocket_device_init(drm_dev, &rocket_drm_driver);
@@ -176,6 +190,7 @@ static int rocket_probe(struct platform_device *pdev)
 
 	rdev->cores[core].rdev = rdev;
 	rdev->cores[core].dev = &pdev->dev;
+	rdev->cores[core].soc = soc;
 	rdev->cores[core].index = core;
 
 	rdev->num_cores++;
@@ -213,8 +228,13 @@ static void rocket_remove(struct platform_device *pdev)
 	}
 }
 
+static const struct rocket_soc_data rk3588_soc_data = {
+	.num_clks = 4,
+	.num_resets = 2,
+};
+
 static const struct of_device_id dt_match[] = {
-	{ .compatible = "rockchip,rk3588-rknn-core" },
+	{ .compatible = "rockchip,rk3588-rknn-core", .data = &rk3588_soc_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
@@ -240,7 +260,7 @@ static int rocket_device_runtime_resume(struct device *dev)
 	if (core < 0)
 		return -ENODEV;
 
-	err = clk_bulk_prepare_enable(ARRAY_SIZE(rdev->cores[core].clks), rdev->cores[core].clks);
+	err = clk_bulk_prepare_enable(rdev->cores[core].soc->num_clks, rdev->cores[core].clks);
 	if (err) {
 		dev_err(dev, "failed to enable (%d) clocks for core %d\n", err, core);
 		return err;
@@ -260,7 +280,7 @@ static int rocket_device_runtime_suspend(struct device *dev)
 	if (!rocket_job_is_idle(&rdev->cores[core]))
 		return -EBUSY;
 
-	clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks), rdev->cores[core].clks);
+	clk_bulk_disable_unprepare(rdev->cores[core].soc->num_clks, rdev->cores[core].clks);
 
 	return 0;
 }
-- 
2.43.0

