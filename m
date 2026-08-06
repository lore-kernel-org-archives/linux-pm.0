Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E8A3D47A0;
	Thu,  6 Aug 2026 06:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785998153; cv=none; b=SIObwafbZpm9DiG3ABminQ69tL18Tr/lHcRkaa4OcDXDedPR1ez5zSVmB7UAJsLkHtKclvIbiA4j+njZe2RMbJq+Y/xxJop8bLXgR0Yr36aGVuZgpvFf8n39yCyXSxsyCQHMIw6/oqiowLhPrQHgyDq8V1QbKqW82kOuTYT00eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785998153; c=relaxed/simple;
	bh=o/8Pvs1MYldfk33eI1ICx5+4NnGbs/hWPsCUegzjm9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAnJGQrix+5YIBtcDMq0RjoeP/SlXhNpK9FWDYcHbKJwUjpxb5mce3BAUmAZC4pioY52ggPdWaY1l7JWYWrrOduQoGyKKEsULm+toXUvBSdX5n36zuDbYIAmJ+0z2FlGK1rcqZ/bd52BO6FnNNMUBI48glx/J2uTCujT0ddJrFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=F2ZGHkzu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IsTNor+F; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="F2ZGHkzu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IsTNor+F"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 7345813000EF;
	Thu,  6 Aug 2026 02:35:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 06 Aug 2026 02:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785998142; x=
	1786001742; bh=GmuBkM73KLlqa/36tUjsDzMM4csk0Ei5R3UWOuK1ktA=; b=F
	2ZGHkzuCTLCT98D+J640ab2e/+Tu3E5LCJpqiQ4WOelrWWIv0ZMOeLh8ua9yOn32
	saTD7Q8k0E2YeCleqkpLU25Bp33wQdcJRmi3Nzp3HctvolgsuaIfjBXTyKwOUKyw
	nNUYrpboiFqaqOD5SQICAGxnxJeQD3/ZQxCA94ahw84R/6qdUohcoSzgQviNgjHn
	fkighYeYZLh+x+iMCWW2/dgLs4q3xTZNVrHH7Gptyg7blhi0mcdX3li8kG4I1l53
	q32l8DhtoaBkS8MVsrH9EVyYLZayqzw3meIwrEGpCOFw0peJrxQuYHbG2EEXGRjC
	MaiN8LFgQFNedHFMAU5oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1785998142; x=1786001742; bh=G
	muBkM73KLlqa/36tUjsDzMM4csk0Ei5R3UWOuK1ktA=; b=IsTNor+FYT6Uvh8gU
	g7BQmOmV1DJ2IVX7XzuneNJy3av6P37KOJcROir1k6Xw8oGelsg6M55d2me7pYw0
	CWUUa6KNuCu27SvGEA9ONv3SsP0WG5n+MDQcRz5Amz2fCCY9c0IO37LbUuDTXfbq
	v2G88ovrOM5pGrcB4fdHu8f9iQ1gTUV2wtHchfEo9CVbbzvaywiMbdYFo88CLLtO
	5VrnJ9LarvVP742tAPwIDnE3+29qIKMSQHV5kUi6QJVau0/S0RUc5CEvOOmyB8Xu
	7KR3aB5e6sV01+gaFde0UobKOuE/fXeakcGaMb0a9B3cGbP2sZXsKr0/a2FgyofX
	xmimw==
X-ME-Sender: <xms:PSt0al0UwuWqGKytKkCijZuqZDJ6c5_HiAUuSnSZNdcQ13NpotXpBw>
    <xme:PSt0aoNoTPZs9MSpSvGhiGgW8-S9B-XgTxslLq_olggEVrBD7X4l-AmNcW9qcX2zN
    xZ54WhK-Buxk1uXGufvhqVZTF62PhanROLIL6kRes1QeaI4GIk5Tc73>
X-ME-Received: <xmr:PSt0aht-fJ8fxJx4jwGiqiP6ml94pSIoxHYZGQFF01NIAPSUHgFKhWxAkXBE2y3TjkBKJUvcdg>
X-ME-Proxy-Cause: dmFkZTFQbKsdj8DJJQ/OlXuokGhrL3IctiU+Aho6/Au782tl2A9Lcp1DjOOP1aFVo8wVr+
    5zBbEuThCmGhoSeZ2riWlRgk6ecJT03G2BRfmNVDV7kvc/DsTyz9x3a4A8wwAafAvpqSEN
    Sp3ncPgRGBSLNUM52mNsFY2cfZs9fxoJ52PKHsn9YwmdjfB/paMVFf6UIRZv/ZhSR1QrF3
    sSgKZjmm3gYuitDHbld79nntj8oU8VxsM6IPNFQMGKn9BAbxrhGUw8MLfjddMvvirkOJPX
    tbB6z4TEEHXEDG8r+RJGF1y9HdGpRUq4ISJouuNf9jTuM1gBJojzlKZQVmBInKjyYp6pMf
    GzA9jfFHfJFStHblelrRvFvelkymzuLj17jWdzlNVir41ld1EYPGVvEc9uAxbYvVEqX+4Y
    P6H8lcWeNJFwcnuG+pmVu/nRtY4rNq9V0fiNfubOcxTWuV2J1/R3sepZBCeB/dtQA77lu9
    FAcTwxCtRn1qy/pgIlqeA952RATEZRpCKrT8NQuPT3Cvm0uOj+wdcvqJtAjPFGlGSAivSO
    /kMAd2SeyklrnsvYG2+65yEyp5aatUd9n1uEhIdub9p9MkEWWMwVS5m9xyF1YYcthWvfjo
    /D/exrRwvOckcYZHXbTWoHahYhBBm59zqU7usgBVOuRC2IC4y6BXOgzhZx+w
X-ME-Proxy: <xmx:PSt0asKOjv8vl2ILCqihaUbh7dEUs7JBLqftQNpYvHtGetSmy5AaiQ>
    <xmx:PSt0aoPFy7enxaaL-R_eWXX9mc-J0t8Bli1jzpCthgpgzjTzdfox_w>
    <xmx:PSt0aoDAaV1cHMVhSqEBJL8JgctLLPqVQEhWCgoguwJL98POykUhcw>
    <xmx:PSt0aoVTZkNZPPogjVjY-z8kNTroVX13g4AXvgzQ59EsFabJdpbJ5A>
    <xmx:Pit0ap_KKKCUXwON2TNVIXrCPTzpXShJ0In8QACxOk5pEPOE6bX5BIDS>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Aug 2026 02:35:34 -0400 (EDT)
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
Subject: [RFC PATCH v6 7/9] accel/rocket: add RK3576 NPU (RKNN) support
Date: Thu,  6 Aug 2026 18:34:11 +1200
Message-ID: <20260806063413.350184-8-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806063413.350184-1-gahing@gahingwoo.com>
References: <20260806063413.350184-1-gahing@gahingwoo.com>
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
 - the DPU completion interrupt is armed exactly as on RK3588 but never
   reaches the GIC. The completion is visible in INTERRUPT_RAW_STATUS,
   so sample that from an hrtimer rather than wait for an interrupt that
   does not come. The interrupt stays armed, and if it ever does arrive
   the two paths agree on which submit each completion belongs to.

All of it hangs off the soc_data added earlier, so the RK3588 path keeps
its existing counts and behaviour.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/accel/rocket/rocket_core.c   |  18 ++++
 drivers/accel/rocket/rocket_core.h   |  15 ++-
 drivers/accel/rocket/rocket_device.c |   4 +
 drivers/accel/rocket/rocket_drv.c    |  10 ++
 drivers/accel/rocket/rocket_job.c    | 142 ++++++++++++++++++++++++---
 5 files changed, 174 insertions(+), 15 deletions(-)

diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
index b202d1581..1c865e247 100644
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
@@ -69,6 +74,19 @@ int rocket_core_init(struct rocket_core *core)
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
index 0f424bb86..205ff070d 100644
--- a/drivers/accel/rocket/rocket_core.h
+++ b/drivers/accel/rocket/rocket_core.h
@@ -6,6 +6,7 @@
 
 #include <drm/gpu_scheduler.h>
 #include <linux/clk.h>
+#include <linux/hrtimer.h>
 #include <linux/io.h>
 #include <linux/mutex_types.h>
 #include <linux/reset.h>
@@ -29,8 +30,10 @@
 
 /* Per-SoC differences, selected by the of_device_id match data. */
 struct rocket_soc_data {
-	unsigned int num_clks;		/* clk_bulk count */
-	unsigned int num_resets;	/* reset_bulk count */
+	unsigned int num_clks;		/* clk_bulk count: 4 base, 6 with CBUF */
+	unsigned int num_resets;	/* reset_bulk count: 2 base, 1 on RK3576 */
+	bool multi_power_domain;	/* device spans more than one PM domain */
+	bool poll_completion;		/* completion IRQ never reaches the GIC */
 };
 
 struct rocket_core {
@@ -59,6 +62,14 @@ struct rocket_core {
 		atomic_t pending;
 	} reset;
 
+	struct hrtimer poll_timer;
+	struct work_struct poll_work;
+	atomic_t poll_active;
+	unsigned int poll_ticks;
+	unsigned int poll_seq;
+	unsigned int poll_work_seq;
+	bool poll_dying;
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
index 6e7dc91c5..7f7dfa374 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -217,10 +217,20 @@ static void rocket_remove(struct platform_device *pdev)
 static const struct rocket_soc_data rk3588_soc_data = {
 	.num_clks = 4,
 	.num_resets = 2,
+	.multi_power_domain = false,
+	.poll_completion = false,
+};
+
+static const struct rocket_soc_data rk3576_soc_data = {
+	.num_clks = 6,
+	.num_resets = 1,
+	.multi_power_domain = true,
+	.poll_completion = true,
 };
 
 static const struct of_device_id dt_match[] = {
 	{ .compatible = "rockchip,rk3588-rknn-core", .data = &rk3588_soc_data },
+	{ .compatible = "rockchip,rk3576-rknn-core", .data = &rk3576_soc_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, dt_match);
diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
index aa26e2977..c5f91f4c5 100644
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
@@ -151,6 +161,14 @@ static void rocket_job_hw_submit(struct rocket_core *core, struct rocket_job *jo
 
 	rocket_pc_writel(core, OPERATION_ENABLE, PC_OPERATION_ENABLE_OP_EN(1));
 
+	if (core->soc->poll_completion) {
+		core->poll_ticks = 0;
+		WRITE_ONCE(core->poll_seq, core->poll_seq + 1);
+		atomic_set(&core->poll_active, 1);
+		hrtimer_start(&core->poll_timer, ns_to_ktime(RK3576_POLL_INTERVAL_NS),
+			      HRTIMER_MODE_REL);
+	}
+
 	dev_dbg(core->dev, "Submitted regcmd at 0x%llx to core %d", task->regcmd, core->index);
 }
 
@@ -341,30 +359,108 @@ static struct dma_fence *rocket_job_run(struct drm_sched_job *sched_job)
 	return ERR_PTR(ret);
 }
 
+static enum hrtimer_restart rocket_poll_timer_fn(struct hrtimer *timer)
+{
+	struct rocket_core *core = container_of(timer, struct rocket_core, poll_timer);
+	u32 raw;
+
+	if (!atomic_read(&core->poll_active))
+		return HRTIMER_NORESTART;
+
+	WRITE_ONCE(core->poll_work_seq, READ_ONCE(core->poll_seq));
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
+static void rocket_poll_work_fn(struct work_struct *work)
+{
+	struct rocket_core *core = container_of(work, struct rocket_core, poll_work);
+
+	pm_runtime_mark_last_busy(core->dev);
+
+	scoped_guard(mutex, &core->job_lock) {
+		/*
+		 * The interrupt can land while this work is queued, retire the job
+		 * and start the next task. poll_seq only advances under job_lock,
+		 * in hw_submit, so comparing it here says whether that happened.
+		 */
+		if (READ_ONCE(core->poll_dying) ||
+		    READ_ONCE(core->poll_work_seq) != core->poll_seq)
+			return;
+
+		/*
+		 * Unlike an interrupt there is no hardware condition to ack here,
+		 * so with no job in flight there is nothing to write, and the
+		 * device may have autosuspended underneath this work already.
+		 */
+		if (!core->in_flight_job)
+			return;
+
+		rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
+		rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
+
+		rocket_job_next_locked(core);
+	}
+}
+
 static void rocket_job_handle_irq(struct rocket_core *core)
 {
+	unsigned int seq = 0;
+
+	if (core->soc->poll_completion) {
+		seq = READ_ONCE(core->poll_seq);
+		atomic_set(&core->poll_active, 0);
+		hrtimer_cancel(&core->poll_timer);
+	}
+
 	pm_runtime_mark_last_busy(core->dev);
 
 	scoped_guard(mutex, &core->job_lock) {
 		/*
-		 * Stopping the block belongs under the lock. hw_submit() writes
-		 * OPERATION_ENABLE too, and outside the lock this zero can land
-		 * after that one and kill a task that has only just started.
+		 * Stopping the block belongs under the lock. A submit from the
+		 * other completion path writes OPERATION_ENABLE too, and outside
+		 * the lock this zero can land after that one and kill a task that
+		 * has only just started.
 		 */
 		rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
 		rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
 
-		if (core->in_flight_job) {
-			if (core->in_flight_job->next_task_idx < core->in_flight_job->task_count) {
-				rocket_job_hw_submit(core, core->in_flight_job);
-				return;
-			}
+		/*
+		 * Where both completion paths are live, one whose submit the other
+		 * has already retired must not go on to start a further task.
+		 */
+		if (core->soc->poll_completion && seq != core->poll_seq)
+			return;
 
-			iommu_detach_group(NULL, iommu_group_get(core->dev));
-			dma_fence_signal(core->in_flight_job->done_fence);
-			pm_runtime_put_autosuspend(core->dev);
-			core->in_flight_job = NULL;
-		}
+		rocket_job_next_locked(core);
 	}
 }
 
@@ -466,6 +562,11 @@ int rocket_job_init(struct rocket_core *core)
 	int ret;
 
 	INIT_WORK(&core->reset.work, rocket_reset_work);
+	INIT_WORK(&core->poll_work, rocket_poll_work_fn);
+	hrtimer_setup(&core->poll_timer, rocket_poll_timer_fn, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
+	atomic_set(&core->poll_active, 0);
+	core->poll_dying = false;
 	spin_lock_init(&core->fence_lock);
 	mutex_init(&core->job_lock);
 
@@ -507,8 +608,23 @@ int rocket_job_init(struct rocket_core *core)
 
 void rocket_job_fini(struct rocket_core *core)
 {
+	/*
+	 * Stop the poll from starting hardware work before tearing anything
+	 * down: it submits the next task, and drm_sched_fini() does not wait
+	 * for work already queued. Cancel after the scheduler is gone, so a
+	 * job running now cannot re-arm the timer behind the cancel.
+	 */
+	if (core->soc->poll_completion)
+		WRITE_ONCE(core->poll_dying, true);
+
 	drm_sched_fini(&core->sched);
 
+	if (core->soc->poll_completion) {
+		atomic_set(&core->poll_active, 0);
+		hrtimer_cancel(&core->poll_timer);
+		cancel_work_sync(&core->poll_work);
+	}
+
 	cancel_work_sync(&core->reset.work);
 	destroy_workqueue(core->reset.wq);
 }
-- 
2.43.0

