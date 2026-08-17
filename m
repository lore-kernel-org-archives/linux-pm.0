Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526B0403156;
	Mon, 17 Aug 2026 11:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966669; cv=none; b=QJlvWlCM5B1u3p/KSTsflWDrGqA6NWiwFSYRfzaR8AeVY3Yn/ueCjx3WLDw8og3/GYd1DuxWbxSjrqYsXoXs2+Hn1WmekwINcKIM+iHZ1x9JKO7q0gQfagcd7WEv41XTA7nMgqQohYo+GMNdhtn24fUXutWYuICF8r99wMyBSAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966669; c=relaxed/simple;
	bh=kN06lZ9HD0pj4xFD/f2Qilt0vzfMYrJJB1Lsh3PgnAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=irH9DDfjnXgGLtz+nHKaDujaL3WdgXoXAcusMKQvbovFJOe7Yfj0iOnENY1GT9ngSM0ncGux3zsytr+wMWOPTiYtqpvtWxIt3pfywGwtsb6qR/dV4JsfJHaRvnn2Q0Cxra2EXec1KYEBHaNOZoZ9d0wIWBeNhrsxeY2UIyM3oRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=FTGi6Zcn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PhY42x6W; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="FTGi6Zcn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PhY42x6W"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id 7B97F1380159;
	Mon, 17 Aug 2026 07:37:47 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 17 Aug 2026 07:37:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786966667; x=
	1786970267; bh=mPwoBZVvD5IiMKU/tQGUb6tRYFOiIEKnit/tY33hzAg=; b=F
	TGi6ZcnYpixPjvbS34gubImthPixPheSIYYGZ056CKxxR1QLuidzOr6NndCOgnSf
	jjgbVfVW6h7GP6x/9Vo707S+8vTkQO6tEClxVm3VrvtHewbOYXYSAearsnvAlq/b
	3oeTRpBWf44rDr7+xJvEU5mg4OJUjRNutBjgZvNqfQLEJXLAV0xFshCuOo86dCkN
	R3sVzLDUshYI7eapRfHOc3RjYWpw6iAg5pIFiKUuOfxcESpZ0YgwVtSwNSv3xuzc
	eEjiiDQSh1S5Fx++So4WgMoW0qKUs+36//AM5lEfEf787cGnSWmjXEsBoDRE5WU5
	Ip+kcATjsheZNlPbZ9asQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786966667; x=1786970267; bh=m
	PwoBZVvD5IiMKU/tQGUb6tRYFOiIEKnit/tY33hzAg=; b=PhY42x6Wf71/eNgGV
	81TxgfGgblDGJgxdO5rViAqS11x1CUgdclf7PxLi/a8gq+zcUIlZQMfNnyB0BbtE
	wFmzDblg7+gLM/T229Yc9Pe8BYq3A1faaKfpl+zapLWmSXyGzi2OZcRQI6hqrR/R
	mZT/fBp/xko42ApGQClMxKbxszukuY2AO/EEl3VCaIT74moOXS+mPgJzokdr4ZSt
	+M5ByZWsMvxwsM/+FhIbD7zaiVNVWa878u/KRvVf06rHdxDvrdjlHFQ+dYmXrMTH
	f57m9tUzi6F2EEHYeu8cNJ5YvNRt0AYBcfHXilVIiVVaA9OTdFOUOC38Qfdf4Uxe
	zOXBA==
X-ME-Sender: <xms:i_KCapMHuALWGuaqJseC8qamVk5JxbK6DavcvHGnJyreo9p8nZDJew>
    <xme:i_KCaoF6T01OGwO6Y1MZRhw9lI1HvHSUu-_epVLJEYgCNIA2huLKwgCb9ENzUNmgq
    SZ3GuG1ndKla2RfzUTd-x-H6Ov2GUPIfd4FsHBac0GTv8vRCW3TSCk>
X-ME-Received: <xmr:i_KCakFbHUgvc4E18N7yqbX2CbWDS1LmNf_zu_daemhcvED-hCHTdLUVdLLHJPjRH5B2cmRU_A>
X-ME-Proxy-Cause: dmFkZTESDKZV2xjsQW8QTAN9sC9IzmAPkbEe0O7QtNg3nad6Cw6Zu1Lv0CCr7YchXGuo7X
    wo5u18UrgWokGX4apf2VQHyYJegQmXA1hFS3XEjW17p7V6Yk1toQwfAx7mA9KuIIcXMBhr
    7v46O0lmBHNM22rRDXC5Qpc02fRdv98oIB6p4GPckTMz0CFFh0T/qVxxTieUCFkmA5E5NB
    EShFN/E+A20tyLr6ueI2K9vhmC8VPsVnYEXRdjZ/FVQ7khPFiJA2Sllp7R9ai8OAA5hMg4
    WjwRcu020v+4GwAnX1vHOmKFiwo+h7wXxPMT4WZ85sLsSre8bSd4zGrl2Aor+gJDmOTEpa
    E2e0lfWios3QKHPysGyyR7vHecFYwuZTX3v/xUuIahkqXTnlTXHaeT39CZVGcCVdYb5xfq
    FZDeX29wKo4UPd3QZ0p+d+Xu+5JkSgyVcAdwwExM41ngB3Phwe2nq3i4x5tQsGNfzFgpOP
    Il59ndA3FAQYbWp42oHUFcBKm9012WXhwfPZA+vMGxqxBit8yUZ0GV/pH7bf5W/xCrdAQq
    i6O9lGmujNnJ+dDA8NbgtyRpVLfDcIyoaIwHIZGTEsN6Sddwdguaz//E8xl5k1ozCzWiVb
    JygT4OoZl4FgIm0vOkH1tMGMFTY80HCdvL2nR4vkwRwIntgnkJxkQ9GsYdtw
X-ME-Proxy: <xmx:i_KCavDbxCUoWFAmHISi3p83_gQ-1xHff6UbMDD4TaWwl_RHbswTYw>
    <xmx:i_KCahn2qdD2CI8eiNhacH-EMjPTO9E02No6-67HjDbR-j1XqgYB6g>
    <xmx:i_KCal4083FaqZf_LFqsyv1geTY1a9dIy2FRYsiJEkC9obLNnc5qqQ>
    <xmx:i_KCagsdrtQkffhbbkKo-KxpUUwbDGwzfFOkt6OUTW0oHnSoF_-Cow>
    <xmx:i_KCapTXUepIXqqqbzbUBNwF8E5L9RLhNUaiEGK3-uylqxH6Jcr-TA83>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 07:37:41 -0400 (EDT)
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
Subject: [PATCH v8 09/12] accel/rocket: select the per-core clock and reset counts from match data
Date: Mon, 17 Aug 2026 23:36:00 +1200
Message-ID: <20260817113603.1436067-10-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817113603.1436067-1-gahing@gahingwoo.com>
References: <20260817113603.1436067-1-gahing@gahingwoo.com>
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
RK3588 keeps four clocks and two resets, so nothing changes for it, and
the arrays keep their present sizes: the SoC that needs a longer one
grows it in the patch that adds the names.

rocket_core_reset() is switched over as well. It is the same array, and
leaving it on ARRAY_SIZE() would walk entries that were never acquired
once a SoC asks for fewer.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_core.c |  8 ++++----
 drivers/accel/rocket/rocket_core.h |  7 +++++++
 drivers/accel/rocket/rocket_drv.c  | 12 +++++++++---
 3 files changed, 20 insertions(+), 7 deletions(-)

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
index 8bbbce594..6e7dc91c5 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -176,6 +176,7 @@ static int rocket_probe(struct platform_device *pdev)
 
 	rdev->cores[core].rdev = rdev;
 	rdev->cores[core].dev = &pdev->dev;
+	rdev->cores[core].soc = of_device_get_match_data(&pdev->dev);
 	rdev->cores[core].index = core;
 
 	rdev->num_cores++;
@@ -213,8 +214,13 @@ static void rocket_remove(struct platform_device *pdev)
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
@@ -240,7 +246,7 @@ static int rocket_device_runtime_resume(struct device *dev)
 	if (core < 0)
 		return -ENODEV;
 
-	err = clk_bulk_prepare_enable(ARRAY_SIZE(rdev->cores[core].clks), rdev->cores[core].clks);
+	err = clk_bulk_prepare_enable(rdev->cores[core].soc->num_clks, rdev->cores[core].clks);
 	if (err) {
 		dev_err(dev, "failed to enable (%d) clocks for core %d\n", err, core);
 		return err;
@@ -260,7 +266,7 @@ static int rocket_device_runtime_suspend(struct device *dev)
 	if (!rocket_job_is_idle(&rdev->cores[core]))
 		return -EBUSY;
 
-	clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks), rdev->cores[core].clks);
+	clk_bulk_disable_unprepare(rdev->cores[core].soc->num_clks, rdev->cores[core].clks);
 
 	return 0;
 }
-- 
2.43.0

