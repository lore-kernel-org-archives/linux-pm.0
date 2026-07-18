Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA4C2D3A75;
	Sat, 18 Jul 2026 03:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784344388; cv=none; b=mWx0ZuJ+B1Tef1hC97Ua8UrYI2bl8jFT/hMVmvYPZCw1KxoHpIg+ysaTNrqu6YIP6pMkXpRsf3mckAM+H8QOz/gSd/HNvUPBVmgwPwqJBuR8NN6/UdXISrOqiibP0AI1zJCxYVr9UyfALNfdaiNqFnuBdnWnFMMmce/gzCP3QFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784344388; c=relaxed/simple;
	bh=xZ9GABoN9tWIDSb7n9nQYzUQG4xnAfpln9nQTP9eKIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXsNqfOeoeFlwYRsATlMB504yuSRRT6PdzUtWBsxLYHhBXrepI5SvqI5XrBsth1OB+l7oniHVzcBvuh7oE3iXp64yyle5fRoeh5++UrvzU1VrgbwfMHzfkqi3ppDFAikVVgB+hFpEOygvGurAxMXUQbhFXUTSMBqfjTgXiIM2sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=IRu6pxuQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IZnJ5xUa; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="IRu6pxuQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IZnJ5xUa"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 91AB7138032C;
	Fri, 17 Jul 2026 23:13:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 17 Jul 2026 23:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1784344385; x=
	1784347985; bh=Ou2i+qMmHBvQjCWQZwA9wjH7Rf6P921q+fjIwYlqA7c=; b=I
	Ru6pxuQxv8tPiU4ik/q+Gq26TbqE7NLgy0GH1xTmk6Bt/63dgokkCo+zwNPXDZiT
	rpxVLdyIqcVK8Dvchlj5vh+FVE5Ma18YIjrefdkgV9ZNLQR61xOPPjkW92gTuSmz
	Rxux9908Yg+iuIXzNSGa7fIW+Yy/HEcofbrOXvqycBzIL3199LSZ3hsgMTj//izp
	/AeFwyLHK2ElQSDcwmv408Dxpc5sVQSXftywrFWiv1Tn1QV66o/zKut1PRjLNCdT
	1ijNmuoOqLq9NdLb9mDuNwZ1SlHZurCusby+UwGRHSTzjJX1odK8p0G/FVW/65Vi
	Hy5+2jHkAc5F0OX9fTmfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784344385; x=1784347985; bh=O
	u2i+qMmHBvQjCWQZwA9wjH7Rf6P921q+fjIwYlqA7c=; b=IZnJ5xUaMtIttiBTP
	vFfjjm3ETUPm405pb5yXXdRkDfJRHEUY04wQZx/4lJ3+lYYsCjDWRUNgPUmLlKXh
	j2syLxw5E/qlHllbsNvf1FZLXecEIk7KuZreiNVkOCpTwf1CByetkA3sK81o54/n
	DDjvmYEnKnyEgfpf74SSJ3xC/8jQIftynEN10V3esM+ZkDgBgLYyWSNfI0tCfgLR
	i+upvIGXT1RZ5DNpYzbYTw+BnQAB1QWdJl+nhpM2vzH+/7ZPo5dpIpsRvfnEbiPe
	pMe9xw/gBrmg4IJhNbE377jWduBeZa9uDsAbGbuugFzvXNvmnGhft5LytBKZXL4x
	Kpivg==
X-ME-Sender: <xms:Qe9aaqS_Ndet-SYr075-ngb87oSrlIkfiW1diVYUQhcp9ak7rtXXFA>
    <xme:Qe9aagKlTpm1pMGWDainTDFT0X1eUxnALvMMe5VQL_hmpJG1ye7ciFnmW4h9j_m6b
    53sb6ZMxBTvk1sk52gPMDyujRrKlliY4-uczA3U70VCQ7f6vAwjBM4>
X-ME-Received: <xmr:Qe9aao8bTkdvpXrrLO2d38O21S_G8iS-hVfIzd5wFP9GCofO7LcYM9xmrtNSXVoSiuYbTHsOJrXioLm9c9s>
X-ME-Proxy-Cause: dmFkZTGo/Hd4L5rRwOTvh0WCJISmOoXEdIqPuYccPV++DcxWf8Powz1Ybe2qRyZPFweND+
    SC523aTq5VzMTUw6xzE3TE+6TtlEB8vrrH4BUWnWvZIVs8l+O8kw8bSbEXZq4tcxWLKFnA
    IwLpvCvHFvCqvDLsht2am+N9qIBZJoYs9mEGKuttiOELjod/llVLMCR0u1IHVoIgucxxIW
    anxc0LTCCqkvsrJPqxq1atY24kesrMc6Brp/3dB1YLFs+ElyHTkaHO2ZOqSszleqXA0zXU
    HezeftBat/hbrTwvfrp/eJrkQh8GYvdSWkVFdy401SIxYsUskCWq+ozS3QCLOeylVm+aaZ
    EnSJZuQGiFpHfO7ej9myl5FlDcEnUvSM8DojWQSxTrnlCPJ6GGCFJ4btFbHXi/4aFLTNMY
    f6fzAaEDIt0Wg0x8RBWRDjhe0bGKyQAOh69KoMvsKpC+XDq40IYIv8URm8rdodQE342J7F
    ClECUy0CRnKZwSfPAbQP9ek7g+o6pvZooCrz0zPeRjcGMy3BBKOZUWic1jJBqV5rpi6WNy
    ZDb5i4EiBSLjsOdqUZbV5BCEbjCCD0oCdFc+8183OQMc27sP11ppfpX8nuDiBrNGLU4L51
    7cQK7GaZA2twQOkjslqcdVkfJeXCc5Eu4gOEobxPxkxOQBZxZWxy6TKDevrg
X-ME-Proxy: <xmx:Qe9aaiDnqZDMVhr4ZdxxMwR9bG2jYydf-0-RiYpCSQmG8pibZfwsbw>
    <xmx:Qe9aaiotrapuYom2Vo1Xsw2PtRi91G864auihQEUa61eB8DM53UXSg>
    <xmx:Qe9aarKew_v5FN_XOONKACnDVxzacElPD6K5VgkD_kwV7aRogmyALg>
    <xmx:Qe9aakIbHOGeDcJP2I-6B6qwxcoUGYv6MzxQWhLXkf7eufd7sZ8eEg>
    <xmx:Qe9aavlSsno9D7bk-tAchbgfiVyohBiQI7JwFCKouneEQee1ejbOTHmX>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 23:12:57 -0400 (EDT)
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
	ogabbay@kernel.org
Cc: chaoyi.chen@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH v2 6/8] accel/rocket: add RK3576 NPU (RKNN) support
Date: Sat, 18 Jul 2026 15:11:44 +1200
Message-ID: <20260718031146.3368811-7-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718031146.3368811-1-gahing@gahingwoo.com>
References: <20260718031146.3368811-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add RK3576 support to the rocket DRM accelerator driver (used with the
Mesa Teflon TFLite delegate).  Per-SoC differences are selected by new
of_device_id match data (struct rocket_soc_data) so the RK3588 path stays
unchanged:

  - match rockchip,rk3576-rknn-core; iterate its nodes at probe
  - RK3576 takes six clocks (adds the CBUF domain ACLK/HCLK_RKNN_CBUF):
    the CNA fills the CBUF and CORE reads from it, so the compute path
    stalls without them.  RK3588 keeps its four clocks.
  - RK3576 requests one reset (srst_a); its BIU reset (srst_h) is driven
    from the power domain.  RK3588 keeps both.
  - RK3576 spans two power domains (PD_NPU0 + PD_NPU1) and attaches the
    list explicitly; RK3588 is single-domain and keeps the driver-core
    auto-attach.
  - RK3576 has no maskable completion interrupt (PC_DONE is read-only in
    INTERRUPT_MASK), so it polls PC_DONE via an hrtimer; RK3588 keeps the
    DPU completion IRQ.
  - guard rocket_job_timedout() MMIO behind pm_runtime_active()

Tested on a Radxa ROCK 4D: the NPU probes, powers on, brings up its
IOMMUs and runs submitted jobs to completion.  Full multi-layer inference
is not yet correct on this SoC (only the first operation per power session
produces valid output); see the cover letter.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_core.c   |  39 +++++++-
 drivers/accel/rocket/rocket_core.h   |  22 ++++-
 drivers/accel/rocket/rocket_device.c |   4 +
 drivers/accel/rocket/rocket_drv.c    |  22 ++++-
 drivers/accel/rocket/rocket_job.c    | 127 +++++++++++++++++++++++++--
 5 files changed, 200 insertions(+), 14 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index b3b2fa9ba..140e37969 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -8,6 +8,7 @@
 #include <linux/err.h>
 #include <linux/iommu.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
@@ -21,14 +22,31 @@ int rocket_core_init(struct rocket_core *core)
 	u32 version;
 	int err = 0;
 
+	/*
+	 * RK3576 moves the BIU (srst_h) reset to its power domain, so it only
+	 * requests srst_a here (soc->num_resets == 1); RK3588 keeps both.
+	 */
 	core->resets[0].id = "srst_a";
 	core->resets[1].id = "srst_h";
-	err = devm_reset_control_bulk_get_exclusive(&pdev->dev, ARRAY_SIZE(core->resets),
+	err = devm_reset_control_bulk_get_exclusive(&pdev->dev, core->soc->num_resets,
 						    core->resets);
 	if (err)
 		return dev_err_probe(dev, err, "failed to get resets for core %d\n", core->index);
 
-	err = devm_clk_bulk_get(dev, ARRAY_SIZE(core->clks), core->clks);
+	core->clks[0].id = "aclk";
+	core->clks[1].id = "hclk";
+	core->clks[2].id = "npu";
+	core->clks[3].id = "pclk";
+	/*
+	 * RK3576 (soc->num_clks == 6): the CBUF (convolution buffer) has its own
+	 * clock domain. The CNA fills the CBUF and CORE reads from it; without
+	 * these the compute path stalls after loading one slice (RDMA, which
+	 * bypasses the CBUF, still runs). The vendor keeps all NPU clocks on
+	 * whenever powered.
+	 */
+	core->clks[4].id = "aclk_cbuf";
+	core->clks[5].id = "hclk_cbuf";
+	err = devm_clk_bulk_get(dev, core->soc->num_clks, core->clks);
 	if (err)
 		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", core->index);
 
@@ -65,6 +83,23 @@ int rocket_core_init(struct rocket_core *core)
 		return err;
 	}
 
+	/*
+	 * RK3576: the NPU spans TWO power domains (PD_NPU0 + PD_NPU1). The vendor
+	 * powers BOTH from its single NPU node even when computing on one core --
+	 * the CBUF->CMAC read path only works fully with NPU1 powered. A device
+	 * with more than one power-domain is skipped by the driver-core single-PD
+	 * auto-attach, so attach the list explicitly.  RK3588 has a single domain
+	 * and keeps the driver-core auto-attach (soc->multi_power_domain == false).
+	 */
+	if (core->soc->multi_power_domain) {
+		struct dev_pm_domain_list *pd_list;
+
+		err = devm_pm_domain_attach_list(dev, NULL, &pd_list);
+		if (err < 0)
+			return dev_err_probe(dev, err,
+					     "failed to attach NPU power domains\n");
+	}
+
 	pm_runtime_use_autosuspend(dev);
 
 	/*
diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index f6d738285..2ab389c4b 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -6,6 +6,7 @@
 
 #include <drm/gpu_scheduler.h>
 #include <linux/clk.h>
+#include <linux/hrtimer.h>
 #include <linux/io.h>
 #include <linux/mutex_types.h>
 #include <linux/reset.h>
@@ -27,16 +28,30 @@
 #define rocket_core_writel(core, reg, value) \
 	writel(value, (core)->core_iomem + (REG_CORE_##reg) - REG_CORE_S_STATUS)
 
+/*
+ * Per-SoC differences, selected by the of_device_id match data.  The RK3588
+ * path (all flags/counts at their base values) must stay byte-for-byte the
+ * original behaviour; RK3576 opts in to the extra clocks, the multi-domain
+ * attach and the polled completion.
+ */
+struct rocket_soc_data {
+	unsigned int num_clks;		/* clk_bulk count: 4 base, 6 with CBUF */
+	unsigned int num_resets;	/* reset_bulk count: 2 base, 1 on RK3576 */
+	bool multi_power_domain;	/* device spans more than one PM domain */
+	bool poll_completion;		/* PC_DONE not routable to the GIC; poll it */
+};
+
 struct rocket_core {
 	struct device *dev;
 	struct rocket_device *rdev;
+	const struct rocket_soc_data *soc;
 	unsigned int index;
 
 	int irq;
 	void __iomem *pc_iomem;
 	void __iomem *cna_iomem;
 	void __iomem *core_iomem;
-	struct clk_bulk_data clks[4];
+	struct clk_bulk_data clks[6];
 	struct reset_control_bulk_data resets[2];
 
 	struct iommu_group *iommu_group;
@@ -52,6 +67,11 @@ struct rocket_core {
 		atomic_t pending;
 	} reset;
 
+	/* RK3576 has no completion IRQ; poll for PC_DONE via hrtimer. */
+	struct hrtimer poll_timer;
+	struct work_struct poll_work;
+	atomic_t poll_active;
+
 	struct drm_gpu_scheduler sched;
 	u64 fence_context;
 	u64 emit_seqno;
diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/rocket/rocket_device.c
index 46e6ee1e7..bfb00f967 100644
--- a/drivers/accel/rocket/rocket_device.c
+++ b/drivers/accel/rocket/rocket_device.c
@@ -31,6 +31,10 @@ struct rocket_device *rocket_device_init(struct platform_device *pdev,
 		if (of_device_is_available(core_node))
 			num_cores++;
 
+	for_each_compatible_node(core_node, NULL, "rockchip,rk3576-rknn-core")
+		if (of_device_is_available(core_node))
+			num_cores++;
+
 	rdev->cores = devm_kcalloc(dev, num_cores, sizeof(*rdev->cores), GFP_KERNEL);
 	if (!rdev->cores)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 8bbbce594..7f7dfa374 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -176,6 +176,7 @@ static int rocket_probe(struct platform_device *pdev)
 
 	rdev->cores[core].rdev = rdev;
 	rdev->cores[core].dev = &pdev->dev;
+	rdev->cores[core].soc = of_device_get_match_data(&pdev->dev);
 	rdev->cores[core].index = core;
 
 	rdev->num_cores++;
@@ -213,8 +214,23 @@ static void rocket_remove(struct platform_device *pdev)
 	}
 }
 
+static const struct rocket_soc_data rk3588_soc_data = {
+	.num_clks = 4,
+	.num_resets = 2,
+	.multi_power_domain = false,
+	.poll_completion = false,
+};
+
+static const struct rocket_soc_data rk3576_soc_data = {
+	.num_clks = 6,
+	.num_resets = 1,
+	.multi_power_domain = true,
+	.poll_completion = true,
+};
+
 static const struct of_device_id dt_match[] = {
-	{ .compatible = "rockchip,rk3588-rknn-core" },
+	{ .compatible = "rockchip,rk3588-rknn-core", .data = &rk3588_soc_data },
+	{ .compatible = "rockchip,rk3576-rknn-core", .data = &rk3576_soc_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
@@ -240,7 +256,7 @@ static int rocket_device_runtime_resume(struct device *dev)
 	if (core < 0)
 		return -ENODEV;
 
-	err = clk_bulk_prepare_enable(ARRAY_SIZE(rdev->cores[core].clks), rdev->cores[core].clks);
+	err = clk_bulk_prepare_enable(rdev->cores[core].soc->num_clks, rdev->cores[core].clks);
 	if (err) {
 		dev_err(dev, "failed to enable (%d) clocks for core %d\n", err, core);
 		return err;
@@ -260,7 +276,7 @@ static int rocket_device_runtime_suspend(struct device *dev)
 	if (!rocket_job_is_idle(&rdev->cores[core]))
 		return -EBUSY;
 
-	clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks), rdev->cores[core].clks);
+	clk_bulk_disable_unprepare(rdev->cores[core].soc->num_clks, rdev->cores[core].clks);
 
 	return 0;
 }
diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 2f1861f96..ce3f7c92e 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -7,6 +7,7 @@
 #include <drm/drm_file.h>
 #include <drm/drm_gem.h>
 #include <drm/rocket_accel.h>
+#include <linux/hrtimer.h>
 #include <linux/interrupt.h>
 #include <linux/iommu.h>
 #include <linux/platform_device.h>
@@ -20,6 +21,16 @@
 
 #define JOB_TIMEOUT_MS 500
 
+/*
+ * RK3576: INTERRUPT_MASK bits 28-29 are read-only (hardware rejects the write),
+ * so the PC_DONE completion signal cannot be routed to the GIC via the normal
+ * interrupt-mask path.  We poll OPERATION_ENABLE every RK3576_POLL_INTERVAL_NS
+ * instead of waiting for a completion IRQ.
+ */
+#define PC_INTERRUPT_MASK_RK3576_PC_DONE_0  0x10000000u
+#define PC_INTERRUPT_MASK_RK3576_PC_DONE_1  0x20000000u
+#define RK3576_POLL_INTERVAL_NS  1000000LL  /* 1 ms */
+
 static struct rocket_job *
 to_rocket_job(struct drm_sched_job *sched_job)
 {
@@ -137,8 +148,24 @@ static void rocket_job_hw_submit(struct rocket_core *core, struct rocket_job *jo
 	rocket_pc_writel(core, REGISTER_AMOUNTS,
 			 PC_REGISTER_AMOUNTS_PC_DATA_AMOUNT((task->regcmd_count + 1) / 2 - 1));
 
-	rocket_pc_writel(core, INTERRUPT_MASK, PC_INTERRUPT_MASK_DPU_0 | PC_INTERRUPT_MASK_DPU_1);
-	rocket_pc_writel(core, INTERRUPT_CLEAR, PC_INTERRUPT_CLEAR_DPU_0 | PC_INTERRUPT_CLEAR_DPU_1);
+	if (core->soc->poll_completion) {
+		/*
+		 * RK3576: PC_DONE (bits 28-29) is read-only in INTERRUPT_MASK, so
+		 * it cannot be routed to the GIC; enable the DMA-error interrupts
+		 * and poll PC_DONE via the hrtimer started below.
+		 */
+		rocket_pc_writel(core, INTERRUPT_MASK,
+				 PC_INTERRUPT_MASK_DMA_READ_ERROR |
+				 PC_INTERRUPT_MASK_DMA_WRITE_ERROR);
+		rocket_pc_writel(core, INTERRUPT_CLEAR,
+				 PC_INTERRUPT_MASK_RK3576_PC_DONE_0 |
+				 PC_INTERRUPT_MASK_RK3576_PC_DONE_1);
+	} else {
+		rocket_pc_writel(core, INTERRUPT_MASK,
+				 PC_INTERRUPT_MASK_DPU_0 | PC_INTERRUPT_MASK_DPU_1);
+		rocket_pc_writel(core, INTERRUPT_CLEAR,
+				 PC_INTERRUPT_CLEAR_DPU_0 | PC_INTERRUPT_CLEAR_DPU_1);
+	}
 
 	rocket_pc_writel(core, TASK_CON, PC_TASK_CON_RESERVED_0(1) |
 					 PC_TASK_CON_TASK_COUNT_CLEAR(1) |
@@ -149,7 +176,14 @@ static void rocket_job_hw_submit(struct rocket_core *core, struct rocket_job *jo
 
 	rocket_pc_writel(core, OPERATION_ENABLE, PC_OPERATION_ENABLE_OP_EN(1));
 
-	dev_dbg(core->dev, "Submitted regcmd at 0x%llx to core %d", task->regcmd, core->index);
+	if (core->soc->poll_completion) {
+		atomic_set(&core->poll_active, 1);
+		hrtimer_start(&core->poll_timer, ns_to_ktime(RK3576_POLL_INTERVAL_NS),
+			      HRTIMER_MODE_REL);
+	} else {
+		dev_dbg(core->dev, "Submitted regcmd at 0x%llx to core %d",
+			task->regcmd, core->index);
+	}
 }
 
 static int rocket_acquire_object_fences(struct drm_gem_object **bos,
@@ -326,12 +360,55 @@ static struct dma_fence *rocket_job_run(struct drm_sched_job *sched_job)
 	return fence;
 }
 
+static void rocket_job_handle_irq(struct rocket_core *core);
+
+static enum hrtimer_restart rocket_poll_timer_fn(struct hrtimer *timer)
+{
+	struct rocket_core *core = container_of(timer, struct rocket_core, poll_timer);
+
+	if (!atomic_read(&core->poll_active))
+		return HRTIMER_NORESTART;
+
+	/*
+	 * On RK3576, OPERATION_ENABLE is not cleared by hardware on completion;
+	 * check INTERRUPT_RAW_STATUS bits 28-29 (PC_DONE_0/1) instead.
+	 */
+	if (rocket_pc_readl(core, OPERATION_ENABLE) == 0 ||
+	    (rocket_pc_readl(core, INTERRUPT_RAW_STATUS) &
+	     (PC_INTERRUPT_MASK_RK3576_PC_DONE_0 |
+	      PC_INTERRUPT_MASK_RK3576_PC_DONE_1))) {
+		atomic_set(&core->poll_active, 0);
+		schedule_work(&core->poll_work);
+		return HRTIMER_NORESTART;
+	}
+
+	hrtimer_forward_now(timer, ns_to_ktime(RK3576_POLL_INTERVAL_NS));
+	return HRTIMER_RESTART;
+}
+
+static void rocket_poll_work_fn(struct work_struct *work)
+{
+	struct rocket_core *core = container_of(work, struct rocket_core, poll_work);
+
+	rocket_job_handle_irq(core);
+}
+
 static void rocket_job_handle_irq(struct rocket_core *core)
 {
+	u32 clear = 0x1ffff;
+
+	if (core->soc->poll_completion) {
+		/* Stop the completion poll -- we're handling it now. */
+		atomic_set(&core->poll_active, 0);
+		hrtimer_cancel(&core->poll_timer);
+		clear |= PC_INTERRUPT_MASK_RK3576_PC_DONE_0 |
+			 PC_INTERRUPT_MASK_RK3576_PC_DONE_1;
+	}
+
 	pm_runtime_mark_last_busy(core->dev);
 
 	rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
-	rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
+	rocket_pc_writel(core, INTERRUPT_CLEAR, clear);
 
 	scoped_guard(mutex, &core->job_lock)
 		if (core->in_flight_job) {
@@ -353,6 +430,12 @@ rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
 	if (!atomic_read(&core->reset.pending))
 		return;
 
+	if (core->soc->poll_completion) {
+		atomic_set(&core->poll_active, 0);
+		hrtimer_cancel(&core->poll_timer);
+		cancel_work_sync(&core->poll_work);
+	}
+
 	drm_sched_stop(&core->sched, bad);
 
 	/*
@@ -385,7 +468,14 @@ static enum drm_gpu_sched_stat rocket_job_timedout(struct drm_sched_job *sched_j
 	struct rocket_device *rdev = job->rdev;
 	struct rocket_core *core = sched_to_core(rdev, sched_job->sched);
 
-	dev_err(core->dev, "NPU job timed out");
+	if (pm_runtime_active(core->dev))
+		dev_err(core->dev,
+			"NPU job timed out: RAW_STATUS=0x%08x MASK=0x%08x OP_EN=0x%08x\n",
+			rocket_pc_readl(core, INTERRUPT_RAW_STATUS),
+			rocket_pc_readl(core, INTERRUPT_MASK),
+			rocket_pc_readl(core, OPERATION_ENABLE));
+	else
+		dev_err(core->dev, "NPU job timed out (device not active)\n");
 
 	atomic_set(&core->reset.pending, 1);
 	rocket_reset(core, sched_job);
@@ -424,9 +514,22 @@ static irqreturn_t rocket_job_irq_handler(int irq, void *data)
 	WARN_ON(raw_status & PC_INTERRUPT_RAW_STATUS_DMA_READ_ERROR);
 	WARN_ON(raw_status & PC_INTERRUPT_RAW_STATUS_DMA_WRITE_ERROR);
 
-	if (!(raw_status & PC_INTERRUPT_RAW_STATUS_DPU_0 ||
-	      raw_status & PC_INTERRUPT_RAW_STATUS_DPU_1))
-		return IRQ_NONE;
+	if (core->soc->poll_completion) {
+		/*
+		 * RK3576: completion is polled (rocket_poll_timer_fn); only the
+		 * DMA-error bits (0-13) can raise this shared IRQ.
+		 */
+		u32 active = raw_status & 0x3fff;
+
+		if (!active)
+			return IRQ_NONE;
+
+		rocket_pc_writel(core, INTERRUPT_CLEAR, active);
+	} else {
+		if (!(raw_status & PC_INTERRUPT_RAW_STATUS_DPU_0 ||
+		      raw_status & PC_INTERRUPT_RAW_STATUS_DPU_1))
+			return IRQ_NONE;
+	}
 
 	rocket_pc_writel(core, INTERRUPT_MASK, 0x0);
 
@@ -445,6 +548,10 @@ int rocket_job_init(struct rocket_core *core)
 	int ret;
 
 	INIT_WORK(&core->reset.work, rocket_reset_work);
+	INIT_WORK(&core->poll_work, rocket_poll_work_fn);
+	hrtimer_setup(&core->poll_timer, rocket_poll_timer_fn, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
+	atomic_set(&core->poll_active, 0);
 	spin_lock_init(&core->fence_lock);
 	mutex_init(&core->job_lock);
 
@@ -486,6 +593,10 @@ int rocket_job_init(struct rocket_core *core)
 
 void rocket_job_fini(struct rocket_core *core)
 {
+	atomic_set(&core->poll_active, 0);
+	hrtimer_cancel(&core->poll_timer);
+	cancel_work_sync(&core->poll_work);
+
 	drm_sched_fini(&core->sched);
 
 	cancel_work_sync(&core->reset.work);
-- 
2.43.0

