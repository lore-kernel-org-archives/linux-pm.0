Received: from mail-m254111.xmail.ntesmail.com (mail-m254111.xmail.ntesmail.com [103.129.254.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530FF3EC6B8;
	Fri, 17 Jul 2026 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.129.254.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284182; cv=none; b=lxyBfgxADG+Um6HLsC9O98lF9LGpL5ZArONyf5k2VyucKGDICulWNxFKBtzrTEd1nKGCZJLeQLFkzNupyWxhELPforUfW1IN64S+b2NuH1HkHwnruwxQulUf1mWAuqAN7CYQrAKrmnc4+i4vJiwqhq3VejOICYwSvzPm4bXmpYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284182; c=relaxed/simple;
	bh=uU8Xp4qKvatV4pto0+cYI79e66saAXQOgxQOxlIuuls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fu2J3j6jsvISC9wqtJsiz6ICd724SMAuzy1HEwabDYxnGepmhgr5jJAFFaOhagZVNJ4KXSP4D7Gb7d0g9UlE5AADzvGqJzsopWbHxQdjykzc0yZTxrzRlurAcKYAcCwPl3gqMMqB9RLU9cf4K9WQHY86y2TL21++zhVfp6Iao6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=VBK/Hss6; arc=none smtp.client-ip=103.129.254.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="VBK/Hss6"
Received: from [172.16.12.90] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4696dc272;
	Fri, 17 Jul 2026 18:29:28 +0800 (GMT+08:00)
Message-ID: <0ef1cfc3-1c7d-4dd4-bb5a-cbf5f29c475a@rock-chips.com>
Date: Fri, 17 Jul 2026 18:29:27 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 7/9] accel/rocket: add RK3576 NPU (RKNN) support
To: Jiaxing Hu <gahing@gahingwoo.com>, tomeu@tomeuvizoso.net,
 heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, ulfh@kernel.org,
 p.zabel@pengutronix.de, ogabbay@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260717085220.3212274-1-gahing@gahingwoo.com>
 <20260717085220.3212274-8-gahing@gahingwoo.com>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <20260717085220.3212274-8-gahing@gahingwoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f6f9fc07803a7kunm8fda5c1f8f1b8
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSk0dVkIeSR9PGEweHhpPHlYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=VBK/Hss6Odr0xl2H62NbweykUOkBXv0DqfxV2qfXTmuD5q87M2iUM8nNLcaJIksVWI4zpsrhPudaiIKPldThkeI2gn+dkOSUAf19GU6Thybf60SaVy2tVAeud5ntGjvXPn6ZANyT6r84W6dkwecvG0/sNf8fDV/UAxG4kePYk4w=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=wQ0NxpDcsJi+Mf5VNx57sNCOj7v89pGrLJBMGSgunk8=;
	h=date:mime-version:subject:message-id:from;

Hello Jiaxing,

On 7/17/2026 4:50 PM, Jiaxing Hu wrote:
> Add RK3576 support to the rocket DRM accelerator driver (used with the
> Mesa Teflon TFLite delegate).
> 
>   - match rockchip,rk3576-rknn-core; iterate its nodes at probe
>   - add named clock IDs (aclk/hclk/npu/pclk) and the CBUF clock domain
>     (ACLK/HCLK_RKNN_CBUF); the CNA fills the CBUF and CORE reads from it,
>     so the compute path stalls if those clocks are not held for a job
>   - guard rocket_job_timedout() MMIO behind pm_runtime_active()
>   - hrtimer completion poll: OP_EN never clears on RK3576 (unlike
>     RK3588), so poll INTERRUPT_RAW_STATUS PC_DONE bits instead

This doesn't look like a correct implementation.

>   - map the DPU (0x4000) and DPU_RDMA (0x5000) blocks and pre-arm them
>   - attach both NPU power domains (PD_NPU0 + PD_NPU1): the CBUF->CMAC
>     read path is only fully powered with NPU1 up
> 
> Tested on a Radxa ROCK 4D: the NPU probes, powers on, brings up its
> IOMMUs and runs submitted jobs to completion. Full multi-layer inference
> is not yet correct on this SoC (only the first operation per power
> session produces valid output); see the cover letter.
> 
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  drivers/accel/rocket/rocket_core.c   |  43 +++++++-
>  drivers/accel/rocket/rocket_core.h   |  22 +++-
>  drivers/accel/rocket/rocket_device.c |   4 +
>  drivers/accel/rocket/rocket_drv.c    |   1 +
>  drivers/accel/rocket/rocket_job.c    | 154 +++++++++++++++++++++------
>  5 files changed, 187 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/rocket_core.c
> index b3b2fa9ba..7b0c48e4d 100644
> --- a/drivers/accel/rocket/rocket_core.c
> +++ b/drivers/accel/rocket/rocket_core.c
> @@ -8,6 +8,7 @@
>  #include <linux/err.h>
>  #include <linux/iommu.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
>  
> @@ -22,12 +23,23 @@ int rocket_core_init(struct rocket_core *core)
>  	int err = 0;
>  
>  	core->resets[0].id = "srst_a";
> -	core->resets[1].id = "srst_h";
>  	err = devm_reset_control_bulk_get_exclusive(&pdev->dev, ARRAY_SIZE(core->resets),
>  						    core->resets);
>  	if (err)
>  		return dev_err_probe(dev, err, "failed to get resets for core %d\n", core->index);
>  
> +	core->clks[0].id = "aclk";
> +	core->clks[1].id = "hclk";
> +	core->clks[2].id = "npu";
> +	core->clks[3].id = "pclk";
> +	/*
> +	 * RK3576: the CBUF (convolution buffer) has its own clock domain. The CNA
> +	 * fills the CBUF and CORE reads from it; without these the compute path
> +	 * stalls after loading one slice (RDMA, which bypasses the CBUF, still
> +	 * runs). The vendor keeps all NPU clocks on whenever powered.
> +	 */
> +	core->clks[4].id = "aclk_cbuf";
> +	core->clks[5].id = "hclk_cbuf";
>  	err = devm_clk_bulk_get(dev, ARRAY_SIZE(core->clks), core->clks);
>  	if (err)
>  		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", core->index);
> @@ -50,6 +62,18 @@ int rocket_core_init(struct rocket_core *core)
>  		return PTR_ERR(core->core_iomem);
>  	}
>  
> +	core->dpu_iomem = devm_platform_ioremap_resource_byname(pdev, "dpu");
> +	if (IS_ERR(core->dpu_iomem)) {
> +		dev_warn(dev, "no DPU registers; DPU S_POINTER won't be pre-armed\n");
> +		core->dpu_iomem = NULL;
> +	}
> +
> +	core->dpu_rdma_iomem = devm_platform_ioremap_resource_byname(pdev, "dpu_rdma");
> +	if (IS_ERR(core->dpu_rdma_iomem)) {
> +		dev_warn(dev, "no DPU_RDMA registers; DPU_RDMA S_POINTER won't be pre-armed\n");
> +		core->dpu_rdma_iomem = NULL;
> +	}
> +
>  	dma_set_max_seg_size(dev, UINT_MAX);
>  
>  	err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
> @@ -65,6 +89,23 @@ int rocket_core_init(struct rocket_core *core)
>  		return err;
>  	}
>  
> +	/*
> +	 * RK3576: the NPU spans TWO power domains (PD_NPU0 + PD_NPU1). The vendor
> +	 * powers BOTH from its single NPU node even when computing on one core --
> +	 * the CBUF->CMAC read path only works fully with NPU1 powered. The board DT
> +	 * lists both power-domains on rknn_core_0; a multi-PD device skips the
> +	 * driver-core single-PD auto-attach, so attach the list explicitly. With
> +	 * one PD in DT this is a no-op (returns 1) and behaves as before.
> +	 */
> +	{
> +		struct dev_pm_domain_list *pd_list;
> +
> +		err = devm_pm_domain_attach_list(dev, NULL, &pd_list);
> +		if (err < 0)
> +			return dev_err_probe(dev, err,
> +					     "failed to attach NPU power domains\n");
> +	}
> +
>  	pm_runtime_use_autosuspend(dev);
>  
>  	/*
> diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/rocket_core.h
> index f6d738285..e959b26dd 100644
> --- a/drivers/accel/rocket/rocket_core.h
> +++ b/drivers/accel/rocket/rocket_core.h
> @@ -6,6 +6,7 @@
>  
>  #include <drm/gpu_scheduler.h>
>  #include <linux/clk.h>
> +#include <linux/hrtimer.h>
>  #include <linux/io.h>
>  #include <linux/mutex_types.h>
>  #include <linux/reset.h>
> @@ -27,6 +28,16 @@
>  #define rocket_core_writel(core, reg, value) \
>  	writel(value, (core)->core_iomem + (REG_CORE_##reg) - REG_CORE_S_STATUS)
>  
> +#define rocket_dpu_readl(core, reg) \
> +	readl((core)->dpu_iomem + (REG_DPU_##reg) - REG_DPU_S_STATUS)
> +#define rocket_dpu_writel(core, reg, value) \
> +	writel(value, (core)->dpu_iomem + (REG_DPU_##reg) - REG_DPU_S_STATUS)
> +
> +#define rocket_dpu_rdma_readl(core, reg) \
> +	readl((core)->dpu_rdma_iomem + (REG_DPU_RDMA_##reg) - REG_DPU_RDMA_RDMA_S_STATUS)
> +#define rocket_dpu_rdma_writel(core, reg, value) \
> +	writel(value, (core)->dpu_rdma_iomem + (REG_DPU_RDMA_##reg) - REG_DPU_RDMA_RDMA_S_STATUS)
> +

Where are these macros used?

>  struct rocket_core {
>  	struct device *dev;
>  	struct rocket_device *rdev;
> @@ -36,8 +47,10 @@ struct rocket_core {
>  	void __iomem *pc_iomem;
>  	void __iomem *cna_iomem;
>  	void __iomem *core_iomem;
> -	struct clk_bulk_data clks[4];
> -	struct reset_control_bulk_data resets[2];
> +	void __iomem *dpu_iomem;
> +	void __iomem *dpu_rdma_iomem;
> +	struct clk_bulk_data clks[6];
> +	struct reset_control_bulk_data resets[1];
>  
>  	struct iommu_group *iommu_group;
>  
> @@ -52,6 +65,11 @@ struct rocket_core {
>  		atomic_t pending;
>  	} reset;
>  
> +	/* RK3576 has no completion IRQ; poll for PC_DONE via hrtimer. */
> +	struct hrtimer poll_timer;
> +	struct work_struct poll_work;
> +	atomic_t poll_active;
> +
>  	struct drm_gpu_scheduler sched;
>  	u64 fence_context;
>  	u64 emit_seqno;
> diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/rocket/rocket_device.c
> index 46e6ee1e7..bfb00f967 100644
> --- a/drivers/accel/rocket/rocket_device.c
> +++ b/drivers/accel/rocket/rocket_device.c
> @@ -31,6 +31,10 @@ struct rocket_device *rocket_device_init(struct platform_device *pdev,
>  		if (of_device_is_available(core_node))
>  			num_cores++;
>  
> +	for_each_compatible_node(core_node, NULL, "rockchip,rk3576-rknn-core")
> +		if (of_device_is_available(core_node))
> +			num_cores++;
> +
>  	rdev->cores = devm_kcalloc(dev, num_cores, sizeof(*rdev->cores), GFP_KERNEL);
>  	if (!rdev->cores)
>  		return ERR_PTR(-ENOMEM);
> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
> index 8bbbce594..8f6a02d50 100644
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c
> @@ -215,6 +215,7 @@ static void rocket_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id dt_match[] = {
>  	{ .compatible = "rockchip,rk3588-rknn-core" },
> +	{ .compatible = "rockchip,rk3576-rknn-core" },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, dt_match);
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/rocket_job.c
> index 2f1861f96..94461bf71 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -7,6 +7,7 @@
>  #include <drm/drm_file.h>
>  #include <drm/drm_gem.h>
>  #include <drm/rocket_accel.h>
> +#include <linux/hrtimer.h>
>  #include <linux/interrupt.h>
>  #include <linux/iommu.h>
>  #include <linux/platform_device.h>
> @@ -20,6 +21,16 @@
>  
>  #define JOB_TIMEOUT_MS 500
>  
> +/*
> + * RK3576: INTERRUPT_MASK bits 28-29 are read-only (hardware rejects the write),
> + * so the PC_DONE completion signal cannot be routed to the GIC via the normal
> + * interrupt-mask path.  We poll OPERATION_ENABLE every RK3576_POLL_INTERVAL_NS
> + * instead of waiting for a completion IRQ.
> + */
> +#define PC_INTERRUPT_MASK_RK3576_PC_DONE_0  0x10000000u
> +#define PC_INTERRUPT_MASK_RK3576_PC_DONE_1  0x20000000u
> +#define RK3576_POLL_INTERVAL_NS  1000000LL  /* 1 ms */
> +
>  static struct rocket_job *
>  to_rocket_job(struct drm_sched_job *sched_job)
>  {
> @@ -137,8 +148,21 @@ static void rocket_job_hw_submit(struct rocket_core *core, struct rocket_job *jo
>  	rocket_pc_writel(core, REGISTER_AMOUNTS,
>  			 PC_REGISTER_AMOUNTS_PC_DATA_AMOUNT((task->regcmd_count + 1) / 2 - 1));
>  
> -	rocket_pc_writel(core, INTERRUPT_MASK, PC_INTERRUPT_MASK_DPU_0 | PC_INTERRUPT_MASK_DPU_1);
> -	rocket_pc_writel(core, INTERRUPT_CLEAR, PC_INTERRUPT_CLEAR_DPU_0 | PC_INTERRUPT_CLEAR_DPU_1);
> +	/* Enable DMA-error interrupts; PC_DONE (bits 28-29) is polled, see above. */
> +	rocket_pc_writel(core, INTERRUPT_MASK,
> +			 PC_INTERRUPT_MASK_DPU_0    | PC_INTERRUPT_MASK_DPU_1    |
> +			 PC_INTERRUPT_MASK_CORE_0   | PC_INTERRUPT_MASK_CORE_1   |
> +			 PC_INTERRUPT_MASK_PPU_0    | PC_INTERRUPT_MASK_PPU_1    |
> +			 PC_INTERRUPT_MASK_CNA_CSC_0 | PC_INTERRUPT_MASK_CNA_CSC_1 |
> +			 PC_INTERRUPT_MASK_DMA_READ_ERROR |
> +			 PC_INTERRUPT_MASK_DMA_WRITE_ERROR);
> +	rocket_pc_writel(core, INTERRUPT_CLEAR,
> +			 PC_INTERRUPT_CLEAR_DPU_0    | PC_INTERRUPT_CLEAR_DPU_1    |
> +			 PC_INTERRUPT_CLEAR_CORE_0   | PC_INTERRUPT_CLEAR_CORE_1   |
> +			 PC_INTERRUPT_CLEAR_PPU_0    | PC_INTERRUPT_CLEAR_PPU_1    |
> +			 PC_INTERRUPT_CLEAR_CNA_CSC_0 | PC_INTERRUPT_CLEAR_CNA_CSC_1 |
> +			 PC_INTERRUPT_MASK_RK3576_PC_DONE_0 |
> +			 PC_INTERRUPT_MASK_RK3576_PC_DONE_1);
>  
>  	rocket_pc_writel(core, TASK_CON, PC_TASK_CON_RESERVED_0(1) |
>  					 PC_TASK_CON_TASK_COUNT_CLEAR(1) |
> @@ -149,7 +173,9 @@ static void rocket_job_hw_submit(struct rocket_core *core, struct rocket_job *jo
>  
>  	rocket_pc_writel(core, OPERATION_ENABLE, PC_OPERATION_ENABLE_OP_EN(1));
>  
> -	dev_dbg(core->dev, "Submitted regcmd at 0x%llx to core %d", task->regcmd, core->index);
> +	atomic_set(&core->poll_active, 1);
> +	hrtimer_start(&core->poll_timer, ns_to_ktime(RK3576_POLL_INTERVAL_NS),
> +		      HRTIMER_MODE_REL);
>  }
>  
>  static int rocket_acquire_object_fences(struct drm_gem_object **bos,
> @@ -326,56 +352,99 @@ static struct dma_fence *rocket_job_run(struct drm_sched_job *sched_job)
>  	return fence;
>  }
>  
> +static void rocket_job_handle_irq(struct rocket_core *core);
> +
> +static enum hrtimer_restart rocket_poll_timer_fn(struct hrtimer *timer)
> +{
> +	struct rocket_core *core = container_of(timer, struct rocket_core, poll_timer);
> +
> +	if (!atomic_read(&core->poll_active))
> +		return HRTIMER_NORESTART;
> +
> +	/*
> +	 * On RK3576, OPERATION_ENABLE is not cleared by hardware on completion;
> +	 * check INTERRUPT_RAW_STATUS bits 28-29 (PC_DONE_0/1) instead.
> +	 */
> +	if (rocket_pc_readl(core, OPERATION_ENABLE) == 0 ||
> +	    (rocket_pc_readl(core, INTERRUPT_RAW_STATUS) &
> +	     (PC_INTERRUPT_MASK_RK3576_PC_DONE_0 |
> +	      PC_INTERRUPT_MASK_RK3576_PC_DONE_1))) {
> +		atomic_set(&core->poll_active, 0);
> +		schedule_work(&core->poll_work);
> +		return HRTIMER_NORESTART;
> +	}
> +
> +	hrtimer_forward_now(timer, ns_to_ktime(RK3576_POLL_INTERVAL_NS));
> +	return HRTIMER_RESTART;
> +}
> +
> +static void rocket_poll_work_fn(struct work_struct *work)
> +{
> +	struct rocket_core *core = container_of(work, struct rocket_core, poll_work);
> +
> +	rocket_job_handle_irq(core);
> +}
> +
>  static void rocket_job_handle_irq(struct rocket_core *core)
>  {
> +	struct rocket_job *job;
> +
> +	/* Stop the completion poll — we're handling it now. */
> +	atomic_set(&core->poll_active, 0);
> +	hrtimer_cancel(&core->poll_timer);
> +
>  	pm_runtime_mark_last_busy(core->dev);
>  
>  	rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
> -	rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
> -
> -	scoped_guard(mutex, &core->job_lock)
> -		if (core->in_flight_job) {
> -			if (core->in_flight_job->next_task_idx < core->in_flight_job->task_count) {
> -				rocket_job_hw_submit(core, core->in_flight_job);
> -				return;
> -			}
> -
> -			iommu_detach_group(NULL, iommu_group_get(core->dev));
> -			dma_fence_signal(core->in_flight_job->done_fence);
> -			pm_runtime_put_autosuspend(core->dev);
> -			core->in_flight_job = NULL;
> +	rocket_pc_writel(core, INTERRUPT_CLEAR,
> +			 0x1ffff |
> +			 PC_INTERRUPT_MASK_RK3576_PC_DONE_0 |
> +			 PC_INTERRUPT_MASK_RK3576_PC_DONE_1);
> +
> +	scoped_guard(mutex, &core->job_lock) {
> +		job = core->in_flight_job;
> +		if (!job)
> +			return;
> +
> +		if (job->next_task_idx < job->task_count) {
> +			rocket_job_hw_submit(core, job);
> +			return;
>  		}
> +
> +		iommu_detach_group(job->domain->domain, core->iommu_group);
> +		dma_fence_signal(job->done_fence);
> +		pm_runtime_put_autosuspend(core->dev);
> +		core->in_flight_job = NULL;
> +	}
>  }
>  
>  static void
>  rocket_reset(struct rocket_core *core, struct drm_sched_job *bad)
>  {
> +	struct rocket_job *job;
> +
>  	if (!atomic_read(&core->reset.pending))
>  		return;
>  
> +	atomic_set(&core->poll_active, 0);
> +	hrtimer_cancel(&core->poll_timer);
> +	cancel_work(&core->poll_work);
> +
>  	drm_sched_stop(&core->sched, bad);
>  
> -	/*
> -	 * Remaining interrupts have been handled, but we might still have
> -	 * stuck jobs. Let's make sure the PM counters stay balanced by
> -	 * manually calling pm_runtime_put_noidle().
> -	 */
>  	scoped_guard(mutex, &core->job_lock) {
> -		if (core->in_flight_job)
> +		job = core->in_flight_job;
> +		if (job) {
>  			pm_runtime_put_noidle(core->dev);
> -
> -		iommu_detach_group(NULL, core->iommu_group);
> -
> -		core->in_flight_job = NULL;
> +			iommu_detach_group(job->domain->domain, core->iommu_group);
> +			core->in_flight_job = NULL;
> +		}
>  	}
>  
> -	/* Proceed with reset now. */
>  	rocket_core_reset(core);
>  
> -	/* NPU has been reset, we can clear the reset pending bit. */
>  	atomic_set(&core->reset.pending, 0);
>  
> -	/* Restart the scheduler */
>  	drm_sched_start(&core->sched, 0);
>  }
>  
> @@ -385,7 +454,14 @@ static enum drm_gpu_sched_stat rocket_job_timedout(struct drm_sched_job *sched_j
>  	struct rocket_device *rdev = job->rdev;
>  	struct rocket_core *core = sched_to_core(rdev, sched_job->sched);
>  
> -	dev_err(core->dev, "NPU job timed out");
> +	if (pm_runtime_active(core->dev))
> +		dev_err(core->dev,
> +			"NPU job timed out: RAW_STATUS=0x%08x MASK=0x%08x OP_EN=0x%08x\n",
> +			rocket_pc_readl(core, INTERRUPT_RAW_STATUS),
> +			rocket_pc_readl(core, INTERRUPT_MASK),
> +			rocket_pc_readl(core, OPERATION_ENABLE));
> +	else
> +		dev_err(core->dev, "NPU job timed out (device not active)\n");
>  
>  	atomic_set(&core->reset.pending, 1);
>  	rocket_reset(core, sched_job);
> @@ -420,14 +496,16 @@ static irqreturn_t rocket_job_irq_handler(int irq, void *data)
>  {
>  	struct rocket_core *core = data;
>  	u32 raw_status = rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
> +	/* Only bits 0-13 (DMA errors) can raise this IRQ; PC_DONE is polled. */
> +	u32 active = raw_status & 0x3fff;
> +
> +	if (!active)
> +		return IRQ_NONE;
>  
>  	WARN_ON(raw_status & PC_INTERRUPT_RAW_STATUS_DMA_READ_ERROR);
>  	WARN_ON(raw_status & PC_INTERRUPT_RAW_STATUS_DMA_WRITE_ERROR);
>  
> -	if (!(raw_status & PC_INTERRUPT_RAW_STATUS_DPU_0 ||
> -	      raw_status & PC_INTERRUPT_RAW_STATUS_DPU_1))
> -		return IRQ_NONE;
> -
> +	rocket_pc_writel(core, INTERRUPT_CLEAR, active);
>  	rocket_pc_writel(core, INTERRUPT_MASK, 0x0);
>  
>  	return IRQ_WAKE_THREAD;
> @@ -445,6 +523,10 @@ int rocket_job_init(struct rocket_core *core)
>  	int ret;
>  
>  	INIT_WORK(&core->reset.work, rocket_reset_work);
> +	INIT_WORK(&core->poll_work, rocket_poll_work_fn);
> +	hrtimer_setup(&core->poll_timer, rocket_poll_timer_fn, CLOCK_MONOTONIC,
> +		      HRTIMER_MODE_REL);
> +	atomic_set(&core->poll_active, 0);
>  	spin_lock_init(&core->fence_lock);
>  	mutex_init(&core->job_lock);
>  
> @@ -486,6 +568,10 @@ int rocket_job_init(struct rocket_core *core)
>  
>  void rocket_job_fini(struct rocket_core *core)
>  {
> +	atomic_set(&core->poll_active, 0);
> +	hrtimer_cancel(&core->poll_timer);
> +	cancel_work_sync(&core->poll_work);
> +
>  	drm_sched_fini(&core->sched);
>  
>  	cancel_work_sync(&core->reset.work);

-- 
Best, 
Chaoyi
