Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E72477981;
	Thu, 24 Sep 2026 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245448; cv=none; b=s9m1iTjmrQzrVT0JwCq+B//q/Nn92uf8r2/TJWWfXsWtCC1RKhWMCcFpMdqA0+UUx7UeiM1OZ1ZLPiRIauTbcDHs/VItwnUSRk8Koy/PEZQy5UzB/pdkeTrKJufAx7QTPBTGJ2lOdg5PNfolnKP0jtjeYxVAgN+1MEBf92Mn68w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245448; c=relaxed/simple;
	bh=TveW37yaibdZx8l9Y00E3FNWTiZq3lUybD29go77JZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPnVJrfyJaDu3oUHwttEBrxL7rsStQwVodjEr+SvlJFkCnoZsppD3XYtDblQMC7BMeR5bKOuBMZHdQfcLwgwcV+mRwPhNPOY2GvDzUsee0I2aNhGPJ9CZJjFYkitE3nrM+rGgPbA+TfiUK2hLV0ZVaDL2pqhyuRceOPDUqxilQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=sMO6K66j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GO3xKd0l; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="sMO6K66j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GO3xKd0l"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 66AB27A00A3;
	Thu, 24 Sep 2026 06:24:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 24 Sep 2026 06:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1790245445; x=
	1790331845; bh=tuI/OK5OfaNHZQjUYl6DoFnaccTmWpDR8NgWnd9AyLg=; b=s
	MO6K66jlM8WKdGIxXvN5pAHLRF3+Lbd181psYEi8Njlb1fB/9qgJD9jWlJpaQS3s
	X/LfN8dgg6620MMeoTvq1bYeXTWdcyGalw+gjDpu7wru2gZh5nFSX22r3BI1Alzl
	jijFcSuCC9asTQ9f3p5sB+14yHwipJhKDBn44DBXSONreLLrbXV8qfDhtrV/RPT3
	PtFXyUjKkYyYYcguOpWQ1JCRqPdk9viaJflbohbZh6PnZv+z2mdHjFPih/RLb9mV
	QMX9lDx8qRWvgAVKe26AXFBCqLO68O75mJN77bFeZaBZnrcg+sY4gRcDgpudZyiu
	NNP2HQh5fpxamqeqyHfJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790245445; x=1790331845; bh=t
	uI/OK5OfaNHZQjUYl6DoFnaccTmWpDR8NgWnd9AyLg=; b=GO3xKd0lQf/B2GCsS
	SgyPOSJb6iymkcYWTFOCaxCEqL3e6bd/lC+rF6X9WosQMTZ47V6cYpSFfzjWspAr
	MsjW5aZlhZ8hbc+x9q+SPWt/2NnsqBku67eV3kRJfF4YmQXhDzjFCjXa6PxJkbO+
	B3o7rgKu1m5RDwh03TO1gYTfFjA35/bUm+69ns54SBgANfbYHtlxjn53u8G4Pebr
	FIz5Q9kyx24B/5mz3ylYDuWcT32saojftANDJHIF5PrXS7/hK3RzrP7E1WEDBD82
	zdS65BKA3h2U2Y6AXIK/4O80Kib3Btrp24XLUAD2H5LnHBEaTM1OpDrzEFRyyKGu
	9Dz2A==
X-ME-Sender: <xms:Rfq0agRiPFetwjpG6sQbrav6YuI-9jyU2Ui56bM7xgytGrXZqm6LiA>
    <xme:Rfq0at4zfaZWGWW16XGtKG-oBhN5nqRtfzC-wx9CMVSu80CXfEfcPMt6Uf6XvWSBD
    6pePObmHAeulY3KyXV7CbD-HRocWmLidW3QedgEvur9PAEkSqFxz2KB>
X-ME-Received: <xmr:Rfq0arrnZq__z_Imdub9Y-YJL_cZpQao-izU3p80ly860SFjt54j-MmoKy-PykzpNU-jFoqxOw>
X-ME-Proxy-Cause: dmFkZTGDX9MhO02E6aN+xiCdNxSLlRQcCcCNuvJqlDq/EeMyqx9sOhFfhs0W3+1YUs0VtZ
    C4nEebFI0osOzqEkQHRvG/7wkcbKglvvfYaeqp3aI8yQkFiebpTmTpj4nhIcZkrHx5wdwr
    kRnVCaW8+aKaXLKS/OflxApldP8QfdDM+5W3jozW36QZJgdRxSemzjs9ko+Wb/wLHMQeLb
    eD+rruhjEh6WPODJKZu+5eS2P9OpWF1fvgBuOreOmXgkjB4+pF8qHyniimi1rz9dR9dFf+
    ZQpqbFvZmfrj6mFfFmlpuarA1kw/E5U/tvFDqLyFRTZ7flH2koDx6Na4EwL+XG2w7O70I4
    xkNSpU+7RdjT0vI60KGuvoKlATGzLQh3+41djNBUGBx6YWPT3vh/uO7a7MzZ3+uITax+Y8
    2fAzPwgyfj7Qd3s5iXv4dhlCyLdbUniSZwTZvl5S9H05HTZQrJC+VvWslbtSjcfo2DVLpF
    2Igmocafj8VV2SWZ10eEADU2XayFXgfSML88SLo+eMcCaG1mtIZzgWdkaoPBTZoJs11/mz
    otmC0xXfVlDkDRvdw6FaZrFziezKZnsuXNKcH8+oLSFcr0bDHudp+N6EzeBnO9KXjxUMV3
    nPsKCnraReyfX5f1aRbTpp7BZoKoRvv7F1zScpN3b93JzMOqlNx5A6HtE5dA
X-ME-Proxy: <xmx:Rfq0aoQFb6ILMKxFBEW6HhHsSExVGzjw2tcT3m48ldDN2T4U2Mmh0A>
    <xmx:Rfq0anufA9CIo7uHCzF14nTJQvFHA1hV71mEqaEZV4GaaC3rWL_dRQ>
    <xmx:Rfq0agNdvTF4wnospVqFQmXAPrjlKcjCVOnynFg-9ImvzNfBgz0Exw>
    <xmx:Rfq0apVyZ4v398PallqpyM-qOIlE8fPLL404vYHMjsrVdLLMT0j6HQ>
    <xmx:Rfq0avvoEhD1Lp-zJH0pMZVWbH4i2Eb6X-0yNhLYMWDY1pfbCHxlX9jo>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Sep 2026 06:23:56 -0400 (EDT)
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
Subject: [PATCH v14 11/15] accel/rocket: select the per-core clock and reset counts from match data
Date: Thu, 24 Sep 2026 22:21:31 +1200
Message-ID: <20260924102135.92217-12-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924102135.92217-1-gahing@gahingwoo.com>
References: <20260924102135.92217-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3576 has the same RKNN block with a different number of clocks and
resets. Take the counts from soc_data in the match data; RK3588 keeps four
and two. Check soc before anything is allocated, since a device bound by
name has no match data.

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

