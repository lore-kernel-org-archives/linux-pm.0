Received: from flow-b1-smtp.messagingengine.com (flow-b1-smtp.messagingengine.com [202.12.124.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9176C40926C;
	Mon, 24 Aug 2026 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569863; cv=none; b=RQ8LytnYG3PAquxXYUa/jIq6x+15cstRvQbBx4g86ux/OijFctI8WURmkKNZ5tHI323sXuhKaKYq59aAyZGxu0SyRwhhu0T15haZ8zBPopV9+NgLTFVBvzRPMMyerXyVeDdG6lyPF7YjcLjtfJh5hdNK2nlWuGuRZ95fPfj8wCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569863; c=relaxed/simple;
	bh=kN06lZ9HD0pj4xFD/f2Qilt0vzfMYrJJB1Lsh3PgnAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eseuLuhi5H4oJaNi3gai4ZCxpUf3sVgASqqAo0G+gewIUz38qRzNFjf388uDnGnTm35aoODNzIVHOkv+g2i0kIr+of1ys/CgO7/JTfZBIdSQfzgnQTW7Cl5lgJMOFYowjS5xJVPRZu9AqQ3NggLw8OBBChuMSnmEIxKSGsyUOxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=bEdFHpR+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aP5+D+pG; arc=none smtp.client-ip=202.12.124.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="bEdFHpR+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aP5+D+pG"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailflow.stl.internal (Postfix) with ESMTP id 3B6911300135;
	Mon, 24 Aug 2026 07:11:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 24 Aug 2026 07:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787569861; x=
	1787573461; bh=mPwoBZVvD5IiMKU/tQGUb6tRYFOiIEKnit/tY33hzAg=; b=b
	EdFHpR+0iIgguJ5knlecoPPU84GQRS2Q/rSaQ9FLWUJsrMAT2iz16aF6sUYj5d6L
	nO8uAZEtfHjcK2nTAmyHIfqFiVutggeWseXmqhwutApuq6m6FV4T+qD1DYTlXf7j
	VQzHuFZiHx+E/M8G3XuQwF92pmXBgLYqSQGQ8pMa3JblMOfKF92vpnIUzIUUZ9cn
	MfopijmbX6Qlgp3so/vH/GTiUS38K0bLSLv6iJydfgWnruw8p/2pqvzeILpnv3gl
	UwPH3mhnurSNbSHXgdPp+3RzUz9+/BA2TQhfKXHDxhSz6j/e6kKY6GgBhR/zfqHC
	B9DPhaKtAKuLmvg3I2kYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787569861; x=1787573461; bh=m
	PwoBZVvD5IiMKU/tQGUb6tRYFOiIEKnit/tY33hzAg=; b=aP5+D+pG0DkGZTXzV
	sMSkmnS3nIb5R9yaAH6vt33kouuCGN448Kghkm0igFnuiZwxYdurbqQlRsq+wBI/
	XWeiuOeYi9llFmbO/hX31D7fMgih/uYL++mFrf0upS9AKkfNG5Q4dWrPa4pgWI8M
	2ZRVKARc+gJFAmIOkirz58FAA0L/jbySG651LmfWRq2OajzGkmpX/XB7LUq1fo3d
	XkV0LSQzP5/j0FQrMNFj3V4imh9nTU5P1OPYa9UB4ZABBfIEMnG9egzY+IaFe2Od
	raBvKnUISMcf38AWJtcUWySRsYNgdi1F2DxtkC4bEAKSQhwodXpnxHnVb3QXjsdA
	eA76w==
X-ME-Sender: <xms:xCaMaiZRtDXy3gkAiW_G6h3y-KOr6tkhjblE2Lx9bpP5VGjspreXqQ>
    <xme:xCaMalQwmcKVnNJqPiFM_ntUrekTX48uPaiuU32kBtEFbk2Ego9JukWfQN8KMGHId
    Tjch8Mayd__jymMpP7SPvhMfp6UGG_rHwe8heYl1u_OluBNF4mRaRI>
X-ME-Received: <xmr:xCaMaqQS7Tj1BbNW-BM9ulAx6I3TOU_lH7vFilgiloRFwAG-eDiYmykvuEM7T0U7e0JYzIigAA>
X-ME-Proxy-Cause: dmFkZTEt2gBugJtB8YdAQO+aerkdLtvOUYoJ//IB6cDd1MOKFyvdoo19DoYWXq4Mp4hwHS
    sE6hGGhD8jZUQBFwSAEaqbrlLtNQJOHU12L29C7L5mnTVCRDAkeZmIOqYt5aFhTZMqqF3G
    unWCdor0kTLNZ6dWF7cUnC4Ml9JFy0XsJkLfAerTv9dDlmfLQuI7Z1HUYFax+IrCJ7fGCI
    XLH+e8l5UTeju4F0WLIDQKTm3VKh6I0RUAfiZDqICKkcn0tjqfxr5W0qSqbmY3m8OLjF81
    SRCTZ/Jk/x6QsFPKWShpc/DZt/tSPSQhu7KTzKKLnfU9kSgS3yyLa7Ees1TsHDveRaSRPZ
    u6xDZ/tzaQM0vEElZp+dLqHPRViVeyjwGiftjMqxn8X0Uops1J40hY8JLSdz3udEDkUK7S
    V1ZxQdQF8EpyL8iCqKP4M4DuhJ+TAn6021aMGKGgcKUGp8bPUfeNvsWvY3DwTrNAV1ZTAw
    /fanRDkyYg1h4gx7LgS6rPdUWh9WdG21Njmb1GgDqtER/58Ji3atdVjOpISc0PD5O7+J57
    XMKs5nmv9Ly8+r+zYqvFdnyINxMecIbHwfQQ6ULXNIjMwDPOJcdy5kyvvbD1BTODMUFfxa
    f0pBF3ozMq5XwAcz+q1gnyh+eom+mKZPiRLbLd0pFMsoqMLspveVkUAm6B8w
X-ME-Proxy: <xmx:xCaMag3_kIqowIFgETD1-v_PYjn_gZIA2dXq3MrXu8P_15Y0ZvJwPA>
    <xmx:xCaMaqwbZuEM811qHaZ12m3bUqc6c6k2992SYw0S6UUjhUd_UPusBA>
    <xmx:xCaMajuWwLIDGus6XafmMxJNvYiEJAygOCRWEtFLkMFwFGniYkbv4A>
    <xmx:xCaMasS0rekSOpDLtPXRaCeGOn-ChnW_DuC3bKE1rKFxrkq3ofpKIg>
    <xmx:xCaMavQxgkG4rGs3sZUHWWfXiAOSGeUCv56G3cUQAn4iYXe0T3izoCW1>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Aug 2026 07:10:53 -0400 (EDT)
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
Subject: [PATCH v9 10/13] accel/rocket: select the per-core clock and reset counts from match data
Date: Mon, 24 Aug 2026 23:08:59 +1200
Message-ID: <dccf59e99abeb12510e14187da03c6f3887685b2.1787568944.git.gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
References: <f1805c2bce56c89d8ace35f67c665b24bab90965.1787568944.git.gahing@gahingwoo.com>
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

