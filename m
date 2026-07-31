Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260DE353A77;
	Fri, 31 Jul 2026 04:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785472552; cv=none; b=VxT4hZTySYTttFy9Nbn5RiS8KCqNQzupoR8BTE5K872j8nZDv0YhCf+g93xXOhGpkw+B4PuSehriHYCU1AniDeAiKsuz9sTXlXnu9C8S7Vih0UEH0QQFgX/thlB4f9x2mBnBetUcOm525fAXR8b9AMGSjZMc4pW/HyAmDpWCJpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785472552; c=relaxed/simple;
	bh=n3CLnSds88NJm6/p3TaqKVGEtPtwNZCEP/tfsInVyrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gl7NixKpP1CQvfFvxrylnQb0kF2vFmOxR97/j+ILfeNVbENuM77dHV/cSQyh/6S3XD7NZyphgQkfn6YRRTCRG5PEa+9lEDyUq3OiMpBLwmhe89wsCKgncJ5/vtW32WO/5GTw34Yrx2ghr4xFTI9ZYUFI29dGd33FCYuvcXXX5/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=KNHgZSaI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AtvblsKs; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="KNHgZSaI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AtvblsKs"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 1286A1380308;
	Fri, 31 Jul 2026 00:35:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 31 Jul 2026 00:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785472549; x=
	1785476149; bh=rUWUZYWm1pFWOiIC8yyhB3QOTKEgk68LhExH2iHSy7k=; b=K
	NHgZSaIi13QvJY1PBYTHDe4ZKf7mZleIvv36ZhkAFmGmViXzNXkUaV9YzG/X17c3
	0DIcKffM0tyg3EYe0FNz7aZoYHlyPVc+gUNc+M9uLE6CShw2dEmP23OWP1OQEBGf
	tWPl9qYji/6lKm4i+lXfg9sydukLWgpzH0rGTnVf0J6zi0/C22nH2g9BqU/wXCNO
	Jx/bptyRM6323ScDp7/PqgTso6pxK6aMgEDDGmyXlqOBQesfLdTl07PhDvRwVGV9
	5wvgJY2q2k6X+I+VzTsxhmM69/Kpz7LAgCx+J82hWJWOpgq0/DJWLbrOhREpx6/Q
	bI/MJbuwUPFXONhbtUfNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1785472549; x=1785476149; bh=r
	UWUZYWm1pFWOiIC8yyhB3QOTKEgk68LhExH2iHSy7k=; b=AtvblsKsNLf/6+esF
	V0WCMZgZtL4nNVcBWCiRsNEalp4ETnJAJdhlLmANr2AY0GY5p4gG/GTBH1akmQDn
	b5D387CS/CcQVrIFIY9Z08qUAtU8kOeYovc11qQYY2U8jBaBv+jqVceu5MooioJM
	vu01ka+fBf+FhQpXTOrOhbqZXHDDondpL4Ab/0QM8ssOChYMiPrilujFV0Ei0TXm
	4Qpbhzpn5163fWJQ76xZg1H67vzQI2cbXRKT8ucPIwR+CMMGvVx05OOTI7RsnGz1
	d90Yk+OIWs1k4FDGd7qVv8DEYdHYZxz+2FQvl4wCvNUorSBhU2YSD5Li70RdrKMf
	FetTA==
X-ME-Sender: <xms:JCZsap_4nUd9Z1aGjN9le-VNno-W0Oekl5oSvbXPriToGgBMfbkyBg>
    <xme:JCZsalpsLITK5FBFel3rxIfRkuN6yE6lI-Erbz7ivO_m1p5BHGuFHdQV6CTS2t1i9
    jxmp-nlirYg1jSnxavkY95I-WITBqGD_EcK2WoiFXrtSJGNUOO2bw>
X-ME-Received: <xmr:JCZsauMH4TThKeQLD-nk0EXxTJpqPD9mDzfrWtou0bb4l3ZrYOt3YPkjmxoyY8kKV2urvsKOyA>
X-ME-Proxy-Cause: dmFkZTGYT4kL28qB16BISDukPuRI13bgUTT3tZ+FwfFOi9iyRIQ4cdWQvs+qtyjYhb8aZv
    7ZNLDkjsiNZpV57v6b2mii/c57NwdcNZfLGFST9tf2uM8u59dW+Prl9GdDUx4nV+E4lAra
    SQEwebYcIunW3qRo5j2tIFm46bFqTUlJGjqQ9G9vA9CMpIOxOxZMoG/yT+2+8464KOGHAY
    8imDrR7vRedTQm5ukLhDfImc5hqq/PMdpFBDkbYJy2uWgqM9NADLHcVQwbEaQMfbuf/RMq
    10+PB7Nd2itAuYvcdzVTZtUYUQ86psUPJqGvTKqOSymMowMLYjogTDdmqQ1+5Yqwyb6wHa
    YyWnWyqRtDcb/ih18bfpttptCqe/KWKk2RR4ZFEDIdMrAV1eCVnwERZfNb3zeItQOsAKTg
    JMK73pY9lPJxo0OVL8mB5TsBwdcb/dcoBWpyuf125Zn+E3KEtdjyC9V/lnztiY1gmXbZ6x
    mCjZC9YYweQ1SGQEiuR2wgzGmpMMiZ1libpn7IYf2HYXVs7z0iE+HqLfMlk+gvO2rPi6/u
    puZKWnE9JX6KQMaHHPRMpPLlOucoLwpr7fQPkrnmVvlfLWzpQ7yzuJumCmOX1rhrFI0DMd
    jYxXbs5a2oA2ah8uRbG5ZG8gTYyrNQs/CMFXFr0FDZh74Ui8S85y2awwObfw
X-ME-Proxy: <xmx:JCZsaj6rDeXFbkq_zBIamcIQ5l2ouw8lFb7JtjX9lm5ZbxZ00aaIGg>
    <xmx:JCZsaqXvwiH1JmbuMHEqJunVRxoypc4Zpsjcx37tucQOqIcd-jan1g>
    <xmx:JCZsal1_IKo5tXyMh7puWu7e21H6J4KdMnpyMUm9zWhCou6nwz5RLw>
    <xmx:JCZsahO9XsypfBsZm_zg1tqizJLuUUH_YReZDRRA2NPiRI_DayC0Ow>
    <xmx:JCZsamiBTIfEM5lX8chWDaFNgrxKZgJ3yDLKcfFESIIc3f18n5YlxHU->
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 00:35:42 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org
Cc: chaoyi.chen@rock-chips.com,
	alchark@flipper.net,
	royalnet026@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH v3 4/6] accel/rocket: add RK3576 NPU (RKNN) support
Date: Fri, 31 Jul 2026 16:35:05 +1200
Message-ID: <20260731043507.1832277-5-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731043507.1832277-1-gahing@gahingwoo.com>
References: <20260731043507.1832277-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3576 carries the same RKNN block as the RK3588, with two cores
instead of three and a few platform differences:

 - the CBUF (convolution buffer) has its own clock domain, so the core
   needs six clocks rather than four;
 - the BIU reset moved into the power domain, leaving one reset here;
 - the NPU spans two power domains, and a device with more than one is
   skipped by the driver-core single-domain auto-attach, so the list has
   to be attached explicitly;
 - the DPU completion interrupt is armed exactly as on RK3588 but never
   reaches the GIC. The completion is visible in INTERRUPT_RAW_STATUS,
   so sample that from an hrtimer rather than wait for an interrupt that
   does not come. The interrupt stays armed, so if it ever does arrive
   the normal handler finalises the job first.

Select all of that from of_device_id match data so the RK3588 path keeps
its existing counts and behaviour unchanged.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_core.c   | 26 ++++++++++++-
 drivers/accel/rocket/rocket_core.h   | 17 ++++++++-
 drivers/accel/rocket/rocket_device.c |  4 ++
 drivers/accel/rocket/rocket_drv.c    | 22 +++++++++--
 drivers/accel/rocket/rocket_job.c    | 55 ++++++++++++++++++++++++++++
 5 files changed, 118 insertions(+), 6 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index b3b2fa9ba..e08288c8c 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -8,6 +8,7 @@
 #include <linux/err.h>
 #include <linux/iommu.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
@@ -21,14 +22,22 @@ int rocket_core_init(struct rocket_core *core)
 	u32 version;
 	int err = 0;
 
+	/* RK3576 moves the BIU reset into its power domain and takes only srst_a. */
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
+	/* RK3576 clocks the CBUF separately; the compute path stalls without these. */
+	core->clks[4].id = "aclk_cbuf";
+	core->clks[5].id = "hclk_cbuf";
+	err = devm_clk_bulk_get(dev, core->soc->num_clks, core->clks);
 	if (err)
 		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", core->index);
 
@@ -65,6 +74,19 @@ int rocket_core_init(struct rocket_core *core)
 		return err;
 	}
 
+	/*
+	 * RK3576 spans two power domains, and a multi-domain device is skipped
+	 * by the driver-core single-domain auto-attach, so attach the list here.
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
index f6d738285..6afb8180a 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -6,6 +6,7 @@
 
 #include <drm/gpu_scheduler.h>
 #include <linux/clk.h>
+#include <linux/hrtimer.h>
 #include <linux/io.h>
 #include <linux/mutex_types.h>
 #include <linux/reset.h>
@@ -27,16 +28,25 @@
 #define rocket_core_writel(core, reg, value) \
 	writel(value, (core)->core_iomem + (REG_CORE_##reg) - REG_CORE_S_STATUS)
 
+/* Per-SoC differences, selected by the of_device_id match data. */
+struct rocket_soc_data {
+	unsigned int num_clks;		/* clk_bulk count: 4 base, 6 with CBUF */
+	unsigned int num_resets;	/* reset_bulk count: 2 base, 1 on RK3576 */
+	bool multi_power_domain;	/* device spans more than one PM domain */
+	bool poll_completion;		/* completion IRQ never reaches the GIC */
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
@@ -52,6 +62,11 @@ struct rocket_core {
 		atomic_t pending;
 	} reset;
 
+	struct hrtimer poll_timer;
+	struct work_struct poll_work;
+	atomic_t poll_active;
+	unsigned int poll_ticks;
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
index bb77b6bf0..e9103a930 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -7,6 +7,7 @@
 #include <drm/drm_file.h>
 #include <drm/drm_gem.h>
 #include <drm/rocket_accel.h>
+#include <linux/hrtimer.h>
 #include <linux/interrupt.h>
 #include <linux/overflow.h>
 #include <linux/iommu.h>
@@ -21,6 +22,15 @@
 
 #define JOB_TIMEOUT_MS 500
 
+/*
+ * RK3576 arms the same DPU completion as RK3588, but the interrupt never
+ * reaches the GIC. The completion itself is visible in INTERRUPT_RAW_STATUS,
+ * so sample that instead. The tick cap bounds jobs that never raise it at all,
+ * which is the same open problem as the wrong inference results.
+ */
+#define RK3576_POLL_INTERVAL_NS	1000000LL	/* 1 ms */
+#define RK3576_POLL_MAX_TICKS	8
+
 static struct rocket_job *
 to_rocket_job(struct drm_sched_job *sched_job)
 {
@@ -151,6 +161,13 @@ static void rocket_job_hw_submit(struct rocket_core *core, struct rocket_job *jo
 
 	rocket_pc_writel(core, OPERATION_ENABLE, PC_OPERATION_ENABLE_OP_EN(1));
 
+	if (core->soc->poll_completion) {
+		core->poll_ticks = 0;
+		atomic_set(&core->poll_active, 1);
+		hrtimer_start(&core->poll_timer, ns_to_ktime(RK3576_POLL_INTERVAL_NS),
+			      HRTIMER_MODE_REL);
+	}
+
 	dev_dbg(core->dev, "Submitted regcmd at 0x%llx to core %d", task->regcmd, core->index);
 }
 
@@ -341,8 +358,42 @@ static struct dma_fence *rocket_job_run(struct drm_sched_job *sched_job)
 	return ERR_PTR(ret);
 }
 
+static void rocket_job_handle_irq(struct rocket_core *core);
+
+static enum hrtimer_restart rocket_poll_timer_fn(struct hrtimer *timer)
+{
+	struct rocket_core *core = container_of(timer, struct rocket_core, poll_timer);
+	u32 raw;
+
+	if (!atomic_read(&core->poll_active))
+		return HRTIMER_NORESTART;
+
+	raw = rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
+	if ((raw & (PC_INTERRUPT_RAW_STATUS_DPU_0 | PC_INTERRUPT_RAW_STATUS_DPU_1)) ||
+	    ++core->poll_ticks >= RK3576_POLL_MAX_TICKS) {
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
+	if (core->soc->poll_completion) {
+		atomic_set(&core->poll_active, 0);
+		hrtimer_cancel(&core->poll_timer);
+	}
+
 	pm_runtime_mark_last_busy(core->dev);
 
 	rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
@@ -460,6 +511,10 @@ int rocket_job_init(struct rocket_core *core)
 	int ret;
 
 	INIT_WORK(&core->reset.work, rocket_reset_work);
+	INIT_WORK(&core->poll_work, rocket_poll_work_fn);
+	hrtimer_setup(&core->poll_timer, rocket_poll_timer_fn, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
+	atomic_set(&core->poll_active, 0);
 	spin_lock_init(&core->fence_lock);
 	mutex_init(&core->job_lock);
 
-- 
2.43.0

