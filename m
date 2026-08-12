Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C3341379E;
	Wed, 12 Aug 2026 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527774; cv=none; b=ebekYJbVuyp0lQS80vQ3EABHnpIvzNk5ZuR78/e/1QG1lYEOj37UksCJ6HpnRuWjOopqrwKNpTxTr9NJQ7WcICQJ2IsO7NYGdAKbY0i2MyWdSO1xI899sYdHTMo+rPcBw43mcTDV4FcuALmCD13JGnvwTd6xY4ePdWB87kUHIdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527774; c=relaxed/simple;
	bh=w2QX+grqyRheRd96qiMhEOC+89UCTzv+j2xK0OU0fuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P49SugAN19bJ8eyfgcmhCvQpA3xcHRs5abXrRCgizQbRR3PoMfmfBD23Yo4CqMlyFbdRFIsuRNIOuRCsL82gXsCKbkQYDCgEmG0GMYmWtTlCKh70TxFLwJD/MtPM4Z/3IapzBNHFQYHnPOgwLHR2yXBp5RT1zIw2yiqZn4Glyl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=OSFMji2X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hy/7+4ZM; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="OSFMji2X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hy/7+4ZM"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.stl.internal (Postfix) with ESMTP id 1B9121300228;
	Wed, 12 Aug 2026 05:42:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 12 Aug 2026 05:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786527770; x=
	1786531370; bh=Ati4Eflk6xp2IrUggBs6aXWkanzDwAoo1oh6SFMUrR8=; b=O
	SFMji2XgfNMg+uVkN5hdjKYD7sVzCrZYuGHqngRCh7BdyLjv3rOTbJNRk/xUZHJU
	tF6E6fwDlYvjaOxU84g9KNKCbJ3IDMN+hWEPzjI01lmFrBntaY63xJHWAlAptWMo
	vIsDH9L9wYDOMcsJPPuF+DKmpKVD/cQ/l8NEqHLlupIGnsj5+IlUs4NobSvJfo14
	8wNQQqD6ggSF61gIDUQJq3EvMCj/jr9ahnQGbM3OHonW+2hMH5BrGAowaMOAVx++
	EOv4YrsjPrsQRKPdgSGp8FUewDhnr7nyrmjB66ftLG+QInXuu3xIdAKKzolmh4jJ
	n4KWznR1lKApugZvTMNiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786527770; x=1786531370; bh=A
	ti4Eflk6xp2IrUggBs6aXWkanzDwAoo1oh6SFMUrR8=; b=hy/7+4ZMfaAcm0QlI
	OLboT4+0+6LXaed1DvZKZ38Tg4JGCdnfcArTnJT88HqZOgG7Y8k5QMi/mxVOeltT
	F2ZV/CiEPtMx+vjJ3ZF6Ofg/oz+p8cSHg/REF1wAbH/0hWPljgMC2PyvHRQPMQR+
	sYGnbhyn4wDI5TUo1l2rWSPZtm06uDYiiixfrPzT823rhRpCXMJxb6i5vdy3v46M
	PC11zZT4akzG8ySiL729lu12nLwFK8mzmDUeby2PgqYJ/SdKpHHUDlnmEdQrjJ3d
	t8YEMFPzuHmpVtmvJaaTGynzpkZ6VmC1wcfIbQ5oisl8IFDQlunc5IV6QCXm5vIg
	vc4fw==
X-ME-Sender: <xms:GkB8aq-zcV-rSiOPWXBCz_g-5Dxhmy2DUhyJ2lzPwhE2_zrVyC0WBw>
    <xme:GkB8am3qzooUIo3aTLQk8KpJjquV0NriTv3dyqyKTRuD_IqNTT63Dz_0zMD8lAPc6
    QcAwNE7dpjRoDOv788pb22bnFakWf0qpzFHbz2CjW04ouIWytmqkUg>
X-ME-Received: <xmr:GkB8ar0KfsuBn0rF8Ql47Js0Jsa7IDc54TMUuyyu-M5r_i_2AWFZayyMCW9jYjZ9td0pB_-TQQ>
X-ME-Proxy-Cause: dmFkZTGDFg2YYgRuZDKXyF65GRSgCQx0Oa6STfe6GS/YD81051fgilENCaCeauLVmePeeQ
    Xfs+tmV31ZNOdQgrJ8wE2ZWDp08nCZhe5yK0hU0NWYXlF84X5HrdmUBwmj879MQZ5ylTNX
    0ZgYCXUoSgR0sXClW7HpRe/nOITVe6ebubQjQr4vz6adj1FQ/k/zcemH7K9Es2jxhVEQPo
    lVXQbf/+wybzKFQnTbLBTrnDm+XasQ+0WE73ss72oMg71PWsNiDitFUd15Ibu9E+FvIeKK
    MPbFOlaFw21sZr682VJJXOyDtzel7G+Yct0NwP/uSCJqgLbCVhhMmls8X1PdVCdt3XGIG1
    W/z0E6lLK5L2k78xr3D2648D5ts14m5R/Dnr5WaAJkK+YgNdTHH0H12G7UxAEaP65jxyVm
    vKPfKHmLzzzhpSBfBWRgPDpsq6ftubSCkxpzk15RxSRRNO4Fdiv2tpLewYO0BwLVLmq7Kz
    KBbhtwI1HKNT+qC2AndK//xwW/cqeNi4Hkv3qvlR+bDckEYoMGwoOgDBBj5EonhJvASW60
    hK7HaBjULkLvBQw420k9wwZsK4t4kUV5Fs8MIWRQHQAG2dE2/+W2/Nac45HC8YcLm+CL4N
    ze30PhCvP2nO1BZfCXOhEPp41pfiBR0xXbDkg0w6kFz1An6A7hwxsca8Grkw
X-ME-Proxy: <xmx:GkB8arz76EHWrIOYSZxTmBqUWGENSiDU4iQ_gbjE2wJpzfx17Gq7zQ>
    <xmx:GkB8avXHrHiUyRxvfFISA4Bf_JMaMWirYmj_3IE_Y6q4Wd2fgWcPnQ>
    <xmx:GkB8ago3gsILfSkrlmXydcJgLpNtH84A_I1Si5z6gQp4poNOWkRqqQ>
    <xmx:GkB8akfIiDwTrUhaG30TtUMnX3F5ji7MFbugLOIbPzD9Fph_2DsqPw>
    <xmx:GkB8aiBYIq0S89QGg2Fl2yb4yA-2_XfsLDC4CF04RRQ_ztHrsr194cSc>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 05:42:39 -0400 (EDT)
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
	alchark@flipper.net,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v7 08/10] accel/rocket: add RK3576 NPU (RKNN) support
Date: Wed, 12 Aug 2026 21:41:03 +1200
Message-ID: <20260812094106.1391698-9-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812094106.1391698-1-gahing@gahingwoo.com>
References: <20260812094106.1391698-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3576 has two cores of the same RKNN block and a few platform
differences:

 - the CBUF (convolution buffer) has its own clock domain, so the core
   needs six clocks rather than four;
 - the BIU reset moved into the power domain, leaving one reset here;
 - the NPU spans two power domains, and a device with more than one is
   skipped by the driver-core single-domain auto-attach, so the list has
   to be attached explicitly;
 - PC_TASK_CON packs the task number with sixteen bits rather than
   twelve, moving the three controls above it up by four.

That last one is the reason this series has been reporting, since v3,
that the block accepts exactly one task per reset. rocket_registers.h is
generated from the RK3588 description, so writing it unchanged to an
RK3576 asks for task_number 0x7001, which is 28673 tasks, and puts
TASK_COUNT_CLEAR on a bit that does nothing. The counter is then only
ever cleared by a reset.

The layout was confirmed by Chaoyi Chen of Rockchip, including a fourth
control at BIT(18), task_last_layer_clear, which belongs on every submit
alongside the count clear:

  https://lore.kernel.org/all/4f300b78-d96d-4d98-8819-dc292b0c9b97@rock-chips.com/

With that written correctly a job of several tasks runs to completion,
the completion interrupt arrives, and /proc/interrupts counts up. A
convolution submitted three times with three different inputs is byte
exact against the CPU reference each time, with no reset in between and
with nothing retiring the job but the interrupt.

All of it hangs off the soc_data added earlier, so the RK3588 path keeps
its existing counts and behaviour.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_core.c   | 20 ++++++++
 drivers/accel/rocket/rocket_core.h   |  8 +--
 drivers/accel/rocket/rocket_device.c |  4 ++
 drivers/accel/rocket/rocket_drv.c    | 10 ++++
 drivers/accel/rocket/rocket_job.c    | 76 ++++++++++++++++++++++------
 5 files changed, 99 insertions(+), 19 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index b202d1581..5f3155135 100644
--- a/drivers/accel/rocket/rocket_core.c
+++ b/drivers/accel/rocket/rocket_core.c
@@ -8,6 +8,7 @@
 #include <linux/err.h>
 #include <linux/iommu.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
@@ -21,6 +22,7 @@ int rocket_core_init(struct rocket_core *core)
 	u32 version;
 	int err = 0;
 
+	/* RK3576 moves the BIU reset into its power domain and takes only srst_a. */
 	core->resets[0].id = "srst_a";
 	core->resets[1].id = "srst_h";
 	err = devm_reset_control_bulk_get_exclusive(&pdev->dev, core->soc->num_resets,
@@ -32,6 +34,9 @@ int rocket_core_init(struct rocket_core *core)
 	core->clks[1].id = "hclk";
 	core->clks[2].id = "npu";
 	core->clks[3].id = "pclk";
+	/* RK3576 clocks the CBUF separately; the compute path stalls without these. */
+	core->clks[4].id = "aclk_cbuf";
+	core->clks[5].id = "hclk_cbuf";
 	err = devm_clk_bulk_get(dev, core->soc->num_clks, core->clks);
 	if (err)
 		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", core->index);
@@ -60,6 +65,21 @@ int rocket_core_init(struct rocket_core *core)
 	if (err)
 		return err;
 
+	/*
+	 * RK3576 spans two power domains, and a multi-domain device is skipped
+	 * by the driver-core single-domain auto-attach, so attach the list here.
+	 * This goes before the first thing that would have to be unwound, so a
+	 * failure can simply return.
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
 	core->iommu_group = iommu_group_get(dev);
 
 	err = rocket_job_init(core);
diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
index ba74c5339..8c8d1f453 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -29,8 +29,10 @@
 
 /* Per-SoC differences, selected by the of_device_id match data. */
 struct rocket_soc_data {
-	unsigned int num_clks;		/* clk_bulk count */
-	unsigned int num_resets;	/* reset_bulk count */
+	unsigned int num_clks;		/* clk_bulk count: 4 base, 6 with CBUF */
+	unsigned int num_resets;	/* reset_bulk count: 2 base, 1 on RK3576 */
+	bool multi_power_domain;	/* device spans more than one PM domain */
+	bool task_con_16bit;		/* PC_TASK_CON uses the 16-bit task number */
 };
 
 struct rocket_core {
@@ -43,7 +45,7 @@ struct rocket_core {
 	void __iomem *pc_iomem;
 	void __iomem *cna_iomem;
 	void __iomem *core_iomem;
-	struct clk_bulk_data clks[4];
+	struct clk_bulk_data clks[6];
 	struct reset_control_bulk_data resets[2];
 
 	struct iommu_group *iommu_group;
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
index 6e7dc91c5..f333fe466 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -217,10 +217,20 @@ static void rocket_remove(struct platform_device *pdev)
 static const struct rocket_soc_data rk3588_soc_data = {
 	.num_clks = 4,
 	.num_resets = 2,
+	.multi_power_domain = false,
+	.task_con_16bit = false,
+};
+
+static const struct rocket_soc_data rk3576_soc_data = {
+	.num_clks = 6,
+	.num_resets = 1,
+	.multi_power_domain = true,
+	.task_con_16bit = true,
 };
 
 static const struct of_device_id dt_match[] = {
 	{ .compatible = "rockchip,rk3588-rknn-core", .data = &rk3588_soc_data },
+	{ .compatible = "rockchip,rk3576-rknn-core", .data = &rk3576_soc_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index 4c01b703e..493b3bf97 100644
--- a/drivers/accel/rocket/rocket_job.c
+++ b/drivers/accel/rocket/rocket_job.c
@@ -21,6 +21,35 @@
 
 #define JOB_TIMEOUT_MS 500
 
+/*
+ * RK3576 arms the same DPU completion as RK3588, but the interrupt never
+ * reaches the GIC. The completion itself is visible in INTERRUPT_RAW_STATUS,
+ * so sample that instead. The tick cap bounds jobs that never raise it at all,
+ * which is the same open problem as the wrong inference results.
+ */
+/*
+ * PC_TASK_CON packs the task number with three controls, and the field widths
+ * are not the same on every SoC. rocket_registers.h is generated from the
+ * RK3588 description, where the task number is twelve bits:
+ *
+ *   RK3588   BIT[11:0] task_number, BIT[12] pp_en, BIT[13] count_clear
+ *   RK3576   BIT[15:0] task_number, BIT[16] pp_en, BIT[17] count_clear,
+ *            BIT[18] last_layer_clear
+ *
+ * The RK3576 layout was confirmed by Chaoyi Chen of Rockchip:
+ * https://lore.kernel.org/all/4f300b78-d96d-4d98-8819-dc292b0c9b97@rock-chips.com/
+ *
+ * Writing the RK3588 layout to an RK3576 therefore asks for task_number
+ * 0x7001, that is 28673 tasks, and lands the count clear on a bit that does
+ * nothing. The task counter is then only ever cleared by a reset, which is
+ * exactly the "one task per reset" behaviour this series has been reporting
+ * since v3.
+ */
+#define RK3576_PC_TASK_CON_TASK_NUMBER(n)	((n) & 0xffff)
+#define RK3576_PC_TASK_CON_PP_EN		BIT(16)
+#define RK3576_PC_TASK_CON_COUNT_CLEAR		BIT(17)
+#define RK3576_PC_TASK_CON_LAST_LAYER_CLEAR	BIT(18)
+
 static struct rocket_job *
 to_rocket_job(struct drm_sched_job *sched_job)
 {
@@ -142,10 +171,17 @@ static void rocket_job_hw_submit(struct rocket_core *core, struct rocket_job *jo
 	rocket_pc_writel(core, INTERRUPT_MASK, PC_INTERRUPT_MASK_DPU_0 | PC_INTERRUPT_MASK_DPU_1);
 	rocket_pc_writel(core, INTERRUPT_CLEAR, PC_INTERRUPT_CLEAR_DPU_0 | PC_INTERRUPT_CLEAR_DPU_1);
 
-	rocket_pc_writel(core, TASK_CON, PC_TASK_CON_RESERVED_0(1) |
-					 PC_TASK_CON_TASK_COUNT_CLEAR(1) |
-					 PC_TASK_CON_TASK_NUMBER(1) |
-					 PC_TASK_CON_TASK_PP_EN(1));
+	if (core->soc->task_con_16bit)
+		rocket_pc_writel(core, TASK_CON,
+				 RK3576_PC_TASK_CON_LAST_LAYER_CLEAR |
+				 RK3576_PC_TASK_CON_COUNT_CLEAR |
+				 RK3576_PC_TASK_CON_PP_EN |
+				 RK3576_PC_TASK_CON_TASK_NUMBER(1));
+	else
+		rocket_pc_writel(core, TASK_CON, PC_TASK_CON_RESERVED_0(1) |
+						 PC_TASK_CON_TASK_COUNT_CLEAR(1) |
+						 PC_TASK_CON_TASK_NUMBER(1) |
+						 PC_TASK_CON_TASK_PP_EN(1));
 
 	rocket_pc_writel(core, TASK_DMA_BASE_ADDR, PC_TASK_DMA_BASE_ADDR_DMA_BASE_ADDR(0x0));
 
@@ -341,6 +377,25 @@ static struct dma_fence *rocket_job_run(struct drm_sched_job *sched_job)
 	return ERR_PTR(ret);
 }
 
+/* Start the job's next task, or retire it. Caller holds job_lock. */
+static void rocket_job_next_locked(struct rocket_core *core)
+{
+	lockdep_assert_held(&core->job_lock);
+
+	if (!core->in_flight_job)
+		return;
+
+	if (core->in_flight_job->next_task_idx < core->in_flight_job->task_count) {
+		rocket_job_hw_submit(core, core->in_flight_job);
+		return;
+	}
+
+	iommu_detach_group(NULL, iommu_group_get(core->dev));
+	dma_fence_signal(core->in_flight_job->done_fence);
+	pm_runtime_put_autosuspend(core->dev);
+	core->in_flight_job = NULL;
+}
+
 static void rocket_job_handle_irq(struct rocket_core *core)
 {
 	pm_runtime_mark_last_busy(core->dev);
@@ -354,17 +409,7 @@ static void rocket_job_handle_irq(struct rocket_core *core)
 		rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
 		rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
 
-		if (core->in_flight_job) {
-			if (core->in_flight_job->next_task_idx < core->in_flight_job->task_count) {
-				rocket_job_hw_submit(core, core->in_flight_job);
-				return;
-			}
-
-			iommu_detach_group(NULL, iommu_group_get(core->dev));
-			dma_fence_signal(core->in_flight_job->done_fence);
-			pm_runtime_put_autosuspend(core->dev);
-			core->in_flight_job = NULL;
-		}
+		rocket_job_next_locked(core);
 	}
 }
 
@@ -644,7 +689,6 @@ int rocket_ioctl_submit(struct drm_device *dev, void *data, struct drm_file *fil
 		}
 	}
 
-
 	for (i = 0; i < args->job_count; i++)
 		rocket_ioctl_submit_job(dev, file, &jobs[i]);
 
-- 
2.43.0

