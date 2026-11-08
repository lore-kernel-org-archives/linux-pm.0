Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794121361;
	b=KIrJevf7kIM2e9Slo/P+Xtewb+yNtJ4Y4yeqUH+ZZLh25wnfZXMB81g0pbK292Jdjlr2
	 RMr2uBp0SmpH7lIvkdKGnkACyfLp3Dc06Hdid+arL36k+cH1y6x0ZRRtrg1snZxwxCxHf
	 gZS7X0O4AMSyARD1sq5uH+ErEV9NVDXHFWCRV7Z0kYQmPF3CNM7PR1wx1Y+e/45T9uEv0
	 JedvaOdYyE/Q3c+1Bb16JPkSTWtRDCBw0Z7czgLQXCRUIlpNl9oaaurGtfcydU6LYsGPn
	 qmW2PkXMh7HJwYXjRW4Ye8r72MBAjhzMkcgPketn8f8rfBprcdTEcFghr7vZ8YbWm8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794121361;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=YuP1M84mtHZ6+9tDpx0o714X9as9Hb8rA+5Zuurb0GU=;
	b=3iiC4/ME1+rzMUCHmuRL3KCWooXl7YIpyK/I6ClG8D+dAdWIEiEDrXJsAd3EMesOOjI4
	 JUYabf0QT+FT6yEHWeFxVE5a45RWLrFWbyCtYFxGwu0Mpffg4P+nP5q26JXPP4AIbrEb0
	 IUjth+ltkNHlNBicciqmMSRvCEKIEqn3Cm3nvgHW5u5svdtYmTBljGFp8OTioZlnJfMN/
	 qDwhZxA1rCQFyp/TbbQezYXU6ZZuNYuw5zGXl3eOtgbKd/excPEK1VlIZ/xdVJVuAgkeW
	 ErUinARUQa624lFPeOcybyXPD8bASGeMlOaNTpTmMLllvebYO7Y1Mkunvq7NsCb4Idw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gahingwoo.com;
	spf=pass smtp.mailfrom=gahingwoo.com;
	dkim=pass header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=Z2Jk3UOn;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dT7cmPK6;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5D8606A31C
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 07:02:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA5D8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gahingwoo.com header.i=@gahingwoo.com header.a=rsa-sha256 header.s=fm1 header.b=Z2Jk3UOn;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=dT7cmPK6
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6683E1D0017C
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 02:02:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 08 Nov 2026 02:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1794121356; x=
	1794207756; bh=YuP1M84mtHZ6+9tDpx0o714X9as9Hb8rA+5Zuurb0GU=; b=Z
	2Jk3UOnqqMaHpNz5crNHjWpFn+5j8ewy+A7IML9x53glSExvwE74ZevREcuFgQ7x
	3QzlDw5aA3VViWOShf17Y44RY3J0JQn0fCXe5/kYJg4C9XZl0gaorJf1RL3NCrlS
	HDz3J0ubGqcAuns45bUlBGqH8PQEa1GZPB45u/bMQtTC6TgsP2raEfEtw+2b6vgO
	YSk96wfAhjWdw7b2vMTLbmi/p5lpm6hmj+4Nw858zq7lGBxdHc5ZraZj3oS7T3un
	6fbVWD5GNrClQNcgV+FMo8xOvu0SsY+DMX9pm851U//H+FR2XPJGOHUEO509SX9b
	e5ZsP0IrJx0Oy+PNWurOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1794121356; x=1794207756; bh=Y
	uP1M84mtHZ6+9tDpx0o714X9as9Hb8rA+5Zuurb0GU=; b=dT7cmPK62Vw9Ifl+M
	bj0py1i2kHkJXX6RRGgR96NCk2SI5YliDIC9RoaZEXwUsq/8sINnxk3si2LB06B5
	fcQE1JdZkVcpMynijch3K/iieQvsv6hmkLGyOZe8JS19ijPqIIWKIF1SBcqe5vCk
	4EkzkXXAt1pWOxqVAGicdbJqQ9YQDe1HdY7D6WoECgF3QqeMoZ1BVABB1ugE8ow5
	pqdantYHniJTLNFc4gTvEtF7V4DSZc15OpViIfHX+UK4zawQxkI6wVkRxsaeNuEQ
	F3VFvlNKifgiq+vVhh7U4+TwrCRT43Hy0ayQpuAaMUuS/SpG+fBvp5ttQEZd5rfJ
	Gljgg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=gahingwoo.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794121356; d=gahingwoo.com;
	mf=PGdhaGluZ0BnYWhpbmd3b28uY29tPg==;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:Qbt+QRVVAJDsYp5wihaHZHu80E4wsGI6ZQ7lrHn0UeuNWFi
	sjzSLvuIprkF/wn1KaySy1CIc9Y69XDWdlNiPkXo+hOeE/jq3AlbR0mmSaeVVdhO
	s0O3L2DkGPtV5Dcscyqd5NgFM90mlbvc4GQxlJ19bFcTMEx7FrNoTPFF9i9YjQzu
	i9yE7tpKKUcCRmk0VOs88sQwTXIdItk5YG6l7C4g6nveLokZCw9QD/9BcsJWh6cz
	F57C7v5zTHwJyDjKaDsX0PoxmpdT35jFhJIA9hVKJ+XAJq75AkIqXiYsu7VTc+Fi
	xxmwgbXLfUcfAoVfLoUTBnVUIy5fah+psSUoTYQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:+1HnbT0QnULyCFYm4s9Bmj2kBPzK7XWKE8LKwDwa9hE=:FTENYIcF1GraRtf1PRqiAuPabp0jeJCFomgowjmTcY8=;
X-ME-Sender: <xms:ix7warGYUHS5Ai2AHWjWuTcgIzQlCBdqmVqpqQxkGZqxqxSkUwNM_w>
    <xme:ix7wakyKOxQbF4K39OUQi1FZs0fqGKZAoV9wh6KrIVZRMmwKUjAPwkVoJorXxCcHt
    SPs8Jr69-IUUsc4nj4Un8eLEK2k15oxExMaMgnfUsUzAx4DjzBcUtGB>
X-ME-Received: <xmr:ix7wakZ1iIwBRvEi6xLBQW40gpNV2-svE3eUi_k7C7tzRPLRjkqrXl-Jfh6kREWoDQ4Rb72j>
X-ME-Proxy-Cause: dmFkZTFKhclCCJN9i5LFQp5fvn9DylL5PDR95+qcmUDEkBDvAaUlhVhO6JW1PTcA0oiilr
    afxU+kS37MwfkRVrV2sLhNS1OkBSH9hrpfUYkvEeAEfTx8oUhC1lvQdEqsrvfO12L2kPDm
    Y90xvEv61R5vWsABT3XVmqKcWsSTBPoQRHs33ySAWpN7mh8mIX7nfmpu6Q5St0DdZLVl6o
    GJpMHUC7TjUVqLMHfqfKk9SHn10f5lL6CdG6YeehrsosttZtbM1aNiFk46XYC+svmJcMBn
    4w1I3sJZaXrv8SSndHCWUOH7cbPZHBY65Sr1oZjnZZRxSV2wTTFO+3xU/Lmvhk4YCMlhGR
    sjXpYEdGJN2S9l638DpwwIDioV7PKg4nr5+2uB/PvDzw4VfPZn1ZTNSORT135TlirsbsRf
    lg6fPt6C4GxTrIUuKHLYvBGx9dAxacztDSd3NOgs0f2CgpXWH8wH5m1AqG13OlvWFHDld0
    HvJF9Oh5sXDPmKOrov+7yZDp3zggr6ltAHQc98VCvQkE/dEV2LpM9An6GPrGMiPWCL/VJL
    cXoSExqyPt5MzcDon4ymw7gCA7RiCGmMeQSaGwIEdoXeT+uNZSsTwQrsVzQctI6GbJjLHy
    Emc/OKE9Zt7x/pYb8yDmaZVFVJK3aLKPB/qoNpJkh1SLqFwSjvJs1xeUGyFg
X-ME-Proxy: <xmx:ix7wavnuU_1NC8qZgHuT4mIken0W6Ooh96BEHtSISdfKNkU-8u2FEw>
    <xmx:ix7wahnb39RhJRjDmIKfD_8lvlwc92j_XCWCyxXkzLq4C8ab2Y5Eig>
    <xmx:ix7waqO2tMHd6QtrOvQvP8XtNxqPbxIFeX0mZnVbW-BPVqcW1lWCWw>
    <xmx:ix7wajoqLmMlirHmEait8_eV_TVzNu9tIizfuv3z-iBtFfR4yqpN2w>
    <xmx:jB7wajs1kMfyV_6PiQLKdZdfoVRaDvl5KahL17P97BzWDHKab-SKhJ3K>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 02:02:26 -0500 (EST)
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
	shawn.lin@rock-chips.com,
	finley.xiao@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	leonard@lausen.nl,
	jeff.hugo@oss.qualcomm.com,
	rfoss@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v16 11/16] accel/rocket: select the per-core clock and reset counts from match data
Date: Sun,  8 Nov 2026 19:59:12 +1300
Message-ID: <20261108065917.135194-12-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108065917.135194-1-gahing@gahingwoo.com>
References: <20261108065917.135194-1-gahing@gahingwoo.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3576 and the RK3588 use the same NPU block, but with different
numbers of clocks and resets.

Take the number of clocks and resets for each core from soc_data in the
match data, so the driver uses the right count on each SoC.

The RK3588 keeps four clocks and two resets.

A device without match data fails before any resource is allocated.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_core.c |  8 ++++----
 drivers/accel/rocket/rocket_core.h |  6 ++++++
 drivers/accel/rocket/rocket_drv.c  | 18 +++++++++++++++---
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index 5dd260bacbff..b202d15816a3 100644
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
index f6d7382854ca..bfbf5110b524 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -27,9 +27,15 @@
 #define rocket_core_writel(core, reg, value) \
 	writel(value, (core)->core_iomem + (REG_CORE_##reg) - REG_CORE_S_STATUS)
 
+struct rocket_soc_data {
+	unsigned int num_clks;
+	unsigned int num_resets;
+};
+
 struct rocket_core {
 	struct device *dev;
 	struct rocket_device *rdev;
+	const struct rocket_soc_data *soc;
 	unsigned int index;
 
 	int irq;
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 5d7805c41dc3..1030d8407b78 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -159,8 +159,14 @@ static const struct drm_driver rocket_drm_driver = {
 
 static int rocket_probe(struct platform_device *pdev)
 {
+	const struct rocket_soc_data *soc = of_device_get_match_data(&pdev->dev);
 	int ret;
 
+	if (!soc) {
+		dev_err(&pdev->dev, "no match data for this device\n");
+		return -ENODEV;
+	}
+
 	if (rdev == NULL) {
 		/* First core probing, initialize DRM device. */
 		rdev = rocket_device_init(drm_dev, &rocket_drm_driver);
@@ -179,6 +185,7 @@ static int rocket_probe(struct platform_device *pdev)
 
 	rdev->cores[core].rdev = rdev;
 	rdev->cores[core].dev = &pdev->dev;
+	rdev->cores[core].soc = soc;
 	rdev->cores[core].index = core;
 
 	rdev->num_cores++;
@@ -216,8 +223,13 @@ static void rocket_remove(struct platform_device *pdev)
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
@@ -243,7 +255,7 @@ static int rocket_device_runtime_resume(struct device *dev)
 	if (core < 0)
 		return -ENODEV;
 
-	err = clk_bulk_prepare_enable(ARRAY_SIZE(rdev->cores[core].clks), rdev->cores[core].clks);
+	err = clk_bulk_prepare_enable(rdev->cores[core].soc->num_clks, rdev->cores[core].clks);
 	if (err) {
 		dev_err(dev, "failed to enable (%d) clocks for core %d\n", err, core);
 		return err;
@@ -263,7 +275,7 @@ static int rocket_device_runtime_suspend(struct device *dev)
 	if (!rocket_job_is_idle(&rdev->cores[core]))
 		return -EBUSY;
 
-	clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks), rdev->cores[core].clks);
+	clk_bulk_disable_unprepare(rdev->cores[core].soc->num_clks, rdev->cores[core].clks);
 
 	return 0;
 }
-- 
2.43.0

