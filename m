Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB84246AA62
	for <linux-pm@vger.kernel.org>; Wed,  5 Aug 2026 12:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785934379; cv=none; b=j0KAwryizP9T24GP8JFMB2yos9VjKAweFP41qoDyMyl2GI60x4DwjD33bNmVBPxhBXrQLrI9E92yWXSxtmhKePq3iRcE28DTGGV27RQnWsqYt1hsKK9bVOwam/CQnVGUdZzC2eMZ7Um6BDURPZzUWPfAg+9jOJxntXWs+orB/ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785934379; c=relaxed/simple;
	bh=YfQnn/dbIuW54QfigKTTMf+yLHYtKM4CF9ZW/iqSJa0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=neqgNA+J+8hfnQdhCoybQFiFBKIvcMANcdfcYHI9t5bPrYhivwUx7s1bodEwleq8XCYxcN7NW2IM+ifBCUQcgrwyvSC4qeVJ3vmWb3EmZRWEPE3Om9H6Byi9M23aGD460LWaJiKqVICTpIL+MY+nzQ49CGxNm5UxUfSBssDqQqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com; spf=pass smtp.mailfrom=cknow-tech.com; dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b=nIajNt3q; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow-tech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow-tech.com header.i=@cknow-tech.com header.b="nIajNt3q"
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow-tech.com;
	s=key1; t=1785934358;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vNhnb6jBQpoGsN5TmbYgz5dCfwxd5/O/xYd00sVY3Ls=;
	b=nIajNt3qjv825OzAIrvUT/uFNh0ISFr3TXlH+m6ASlKEJYrtZIdRHSRzaa6rXTOyMwX+RD
	I9M4XqE6a/XBBcnqkSY1v30HbYin0iFQqd3GR26zX4rh1H7ibu/9QGTje+CsM7RVauwf1g
	rO8Ov2a3emfdh78jieT8/+FjpEDkBJW3JAlOxiAeCchI9+W9tK67nol4ahmjXT033UIS6N
	Te14tKFPuaF10sDGrdHWzvW5/BoVqjwxXWA/2LNr8TXC9vZch6t2lt42UNrmhw6rP6vAw7
	Xa024CFdCT179KjLU526uh/AQko2rcZY61nAmkXWGCZolaytFvHkEQkCuMY+8Q==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Aug 2026 14:52:23 +0200
Message-Id: <DKH0VYV0DMRB.3F9GXE6E2TSZ@cknow-tech.com>
Cc: <royalnet026@gmail.com>, <alchark@flipper.net>,
 <chaoyi.chen@rock-chips.com>, <dri-devel@lists.freedesktop.org>,
 <linux-rockchip@lists.infradead.org>, <iommu@lists.linux.dev>,
 <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v5 v5 6/8] accel/rocket: add RK3576 NPU (RKNN)
 support
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <diederik@cknow-tech.com>
To: "Jiaxing Hu" <gahing@gahingwoo.com>, <tomeu@tomeuvizoso.net>,
 <heiko@sntech.de>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <joro@8bytes.org>, <will@kernel.org>,
 <robin.murphy@arm.com>, <ulfh@kernel.org>, <p.zabel@pengutronix.de>,
 <ogabbay@kernel.org>, <zhangqing@rock-chips.com>
References: <20260805063826.95682-1-gahing@gahingwoo.com>
 <20260805063826.95682-7-gahing@gahingwoo.com>
In-Reply-To: <20260805063826.95682-7-gahing@gahingwoo.com>
X-Migadu-Flow: FLOW_OUT

On Wed Aug 5, 2026 at 8:38 AM CEST, Jiaxing Hu wrote:
> The RK3576 carries the same RKNN block as the RK3588, with two cores
> instead of three and a few platform differences:
>
>  - the CBUF (convolution buffer) has its own clock domain, so the core
>    needs six clocks rather than four;
>  - the BIU reset moved into the power domain, leaving one reset here;
>  - the NPU spans two power domains, and a device with more than one is
>    skipped by the driver-core single-domain auto-attach, so the list has
>    to be attached explicitly;
>  - the DPU completion interrupt is armed exactly as on RK3588 but never
>    reaches the GIC. The completion is visible in INTERRUPT_RAW_STATUS,
>    so sample that from an hrtimer rather than wait for an interrupt that
>    does not come. The interrupt stays armed, so if it ever does arrive
>    the normal handler finalises the job first.
>
> Select all of that from of_device_id match data so the RK3588 path keeps
> its existing counts and behaviour unchanged.

Would it make sense to split this patch up in 2 patches:
1) Prepare for different NPU/RKNN implementations
2) Add support for RK3576 NPU/RKNN

It seems like you're changing the implementation for RK3588 in this patch
AND add support for RK3576. It's often better to split those things out.

Cheers,
  Diederik

> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  drivers/accel/rocket/rocket_core.c   |  26 +++++-
>  drivers/accel/rocket/rocket_core.h   |  20 ++++-
>  drivers/accel/rocket/rocket_device.c |   4 +
>  drivers/accel/rocket/rocket_drv.c    |  22 ++++-
>  drivers/accel/rocket/rocket_job.c    | 121 ++++++++++++++++++++++++---
>  5 files changed, 176 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/ro=
cket_core.c
> index b3b2fa9ba..e08288c8c 100644
> --- a/drivers/accel/rocket/rocket_core.c
> +++ b/drivers/accel/rocket/rocket_core.c
> @@ -8,6 +8,7 @@
>  #include <linux/err.h>
>  #include <linux/iommu.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_domain.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/reset.h>
> =20
> @@ -21,14 +22,22 @@ int rocket_core_init(struct rocket_core *core)
>  	u32 version;
>  	int err =3D 0;
> =20
> +	/* RK3576 moves the BIU reset into its power domain and takes only srst=
_a. */
>  	core->resets[0].id =3D "srst_a";
>  	core->resets[1].id =3D "srst_h";
> -	err =3D devm_reset_control_bulk_get_exclusive(&pdev->dev, ARRAY_SIZE(co=
re->resets),
> +	err =3D devm_reset_control_bulk_get_exclusive(&pdev->dev, core->soc->nu=
m_resets,
>  						    core->resets);
>  	if (err)
>  		return dev_err_probe(dev, err, "failed to get resets for core %d\n", c=
ore->index);
> =20
> -	err =3D devm_clk_bulk_get(dev, ARRAY_SIZE(core->clks), core->clks);
> +	core->clks[0].id =3D "aclk";
> +	core->clks[1].id =3D "hclk";
> +	core->clks[2].id =3D "npu";
> +	core->clks[3].id =3D "pclk";
> +	/* RK3576 clocks the CBUF separately; the compute path stalls without t=
hese. */
> +	core->clks[4].id =3D "aclk_cbuf";
> +	core->clks[5].id =3D "hclk_cbuf";
> +	err =3D devm_clk_bulk_get(dev, core->soc->num_clks, core->clks);
>  	if (err)
>  		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", c=
ore->index);
> =20
> @@ -65,6 +74,19 @@ int rocket_core_init(struct rocket_core *core)
>  		return err;
>  	}
> =20
> +	/*
> +	 * RK3576 spans two power domains, and a multi-domain device is skipped
> +	 * by the driver-core single-domain auto-attach, so attach the list her=
e.
> +	 */
> +	if (core->soc->multi_power_domain) {
> +		struct dev_pm_domain_list *pd_list;
> +
> +		err =3D devm_pm_domain_attach_list(dev, NULL, &pd_list);
> +		if (err < 0)
> +			return dev_err_probe(dev, err,
> +					     "failed to attach NPU power domains\n");
> +	}
> +
>  	pm_runtime_use_autosuspend(dev);
> =20
>  	/*
> diff --git a/drivers/accel/rocket/rocket_core.h b/drivers/accel/rocket/ro=
cket_core.h
> index f6d738285..205ff070d 100644
> --- a/drivers/accel/rocket/rocket_core.h
> +++ b/drivers/accel/rocket/rocket_core.h
> @@ -6,6 +6,7 @@
> =20
>  #include <drm/gpu_scheduler.h>
>  #include <linux/clk.h>
> +#include <linux/hrtimer.h>
>  #include <linux/io.h>
>  #include <linux/mutex_types.h>
>  #include <linux/reset.h>
> @@ -27,16 +28,25 @@
>  #define rocket_core_writel(core, reg, value) \
>  	writel(value, (core)->core_iomem + (REG_CORE_##reg) - REG_CORE_S_STATUS=
)
> =20
> +/* Per-SoC differences, selected by the of_device_id match data. */
> +struct rocket_soc_data {
> +	unsigned int num_clks;		/* clk_bulk count: 4 base, 6 with CBUF */
> +	unsigned int num_resets;	/* reset_bulk count: 2 base, 1 on RK3576 */
> +	bool multi_power_domain;	/* device spans more than one PM domain */
> +	bool poll_completion;		/* completion IRQ never reaches the GIC */
> +};
> +
>  struct rocket_core {
>  	struct device *dev;
>  	struct rocket_device *rdev;
> +	const struct rocket_soc_data *soc;
>  	unsigned int index;
> =20
>  	int irq;
>  	void __iomem *pc_iomem;
>  	void __iomem *cna_iomem;
>  	void __iomem *core_iomem;
> -	struct clk_bulk_data clks[4];
> +	struct clk_bulk_data clks[6];
>  	struct reset_control_bulk_data resets[2];
> =20
>  	struct iommu_group *iommu_group;
> @@ -52,6 +62,14 @@ struct rocket_core {
>  		atomic_t pending;
>  	} reset;
> =20
> +	struct hrtimer poll_timer;
> +	struct work_struct poll_work;
> +	atomic_t poll_active;
> +	unsigned int poll_ticks;
> +	unsigned int poll_seq;
> +	unsigned int poll_work_seq;
> +	bool poll_dying;
> +
>  	struct drm_gpu_scheduler sched;
>  	u64 fence_context;
>  	u64 emit_seqno;
> diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/rocket/=
rocket_device.c
> index 46e6ee1e7..bfb00f967 100644
> --- a/drivers/accel/rocket/rocket_device.c
> +++ b/drivers/accel/rocket/rocket_device.c
> @@ -31,6 +31,10 @@ struct rocket_device *rocket_device_init(struct platfo=
rm_device *pdev,
>  		if (of_device_is_available(core_node))
>  			num_cores++;
> =20
> +	for_each_compatible_node(core_node, NULL, "rockchip,rk3576-rknn-core")
> +		if (of_device_is_available(core_node))
> +			num_cores++;
> +
>  	rdev->cores =3D devm_kcalloc(dev, num_cores, sizeof(*rdev->cores), GFP_=
KERNEL);
>  	if (!rdev->cores)
>  		return ERR_PTR(-ENOMEM);
> diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/roc=
ket_drv.c
> index 8bbbce594..7f7dfa374 100644
> --- a/drivers/accel/rocket/rocket_drv.c
> +++ b/drivers/accel/rocket/rocket_drv.c
> @@ -176,6 +176,7 @@ static int rocket_probe(struct platform_device *pdev)
> =20
>  	rdev->cores[core].rdev =3D rdev;
>  	rdev->cores[core].dev =3D &pdev->dev;
> +	rdev->cores[core].soc =3D of_device_get_match_data(&pdev->dev);
>  	rdev->cores[core].index =3D core;
> =20
>  	rdev->num_cores++;
> @@ -213,8 +214,23 @@ static void rocket_remove(struct platform_device *pd=
ev)
>  	}
>  }
> =20
> +static const struct rocket_soc_data rk3588_soc_data =3D {
> +	.num_clks =3D 4,
> +	.num_resets =3D 2,
> +	.multi_power_domain =3D false,
> +	.poll_completion =3D false,
> +};
> +
> +static const struct rocket_soc_data rk3576_soc_data =3D {
> +	.num_clks =3D 6,
> +	.num_resets =3D 1,
> +	.multi_power_domain =3D true,
> +	.poll_completion =3D true,
> +};
> +
>  static const struct of_device_id dt_match[] =3D {
> -	{ .compatible =3D "rockchip,rk3588-rknn-core" },
> +	{ .compatible =3D "rockchip,rk3588-rknn-core", .data =3D &rk3588_soc_da=
ta },
> +	{ .compatible =3D "rockchip,rk3576-rknn-core", .data =3D &rk3576_soc_da=
ta },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, dt_match);
> @@ -240,7 +256,7 @@ static int rocket_device_runtime_resume(struct device=
 *dev)
>  	if (core < 0)
>  		return -ENODEV;
> =20
> -	err =3D clk_bulk_prepare_enable(ARRAY_SIZE(rdev->cores[core].clks), rde=
v->cores[core].clks);
> +	err =3D clk_bulk_prepare_enable(rdev->cores[core].soc->num_clks, rdev->=
cores[core].clks);
>  	if (err) {
>  		dev_err(dev, "failed to enable (%d) clocks for core %d\n", err, core);
>  		return err;
> @@ -260,7 +276,7 @@ static int rocket_device_runtime_suspend(struct devic=
e *dev)
>  	if (!rocket_job_is_idle(&rdev->cores[core]))
>  		return -EBUSY;
> =20
> -	clk_bulk_disable_unprepare(ARRAY_SIZE(rdev->cores[core].clks), rdev->co=
res[core].clks);
> +	clk_bulk_disable_unprepare(rdev->cores[core].soc->num_clks, rdev->cores=
[core].clks);
> =20
>  	return 0;
>  }
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index bb77b6bf0..28845ac4e 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -7,6 +7,7 @@
>  #include <drm/drm_file.h>
>  #include <drm/drm_gem.h>
>  #include <drm/rocket_accel.h>
> +#include <linux/hrtimer.h>
>  #include <linux/interrupt.h>
>  #include <linux/overflow.h>
>  #include <linux/iommu.h>
> @@ -21,6 +22,15 @@
> =20
>  #define JOB_TIMEOUT_MS 500
> =20
> +/*
> + * RK3576 arms the same DPU completion as RK3588, but the interrupt neve=
r
> + * reaches the GIC. The completion itself is visible in INTERRUPT_RAW_ST=
ATUS,
> + * so sample that instead. The tick cap bounds jobs that never raise it =
at all,
> + * which is the same open problem as the wrong inference results.
> + */
> +#define RK3576_POLL_INTERVAL_NS	1000000LL	/* 1 ms */
> +#define RK3576_POLL_MAX_TICKS	8
> +
>  static struct rocket_job *
>  to_rocket_job(struct drm_sched_job *sched_job)
>  {
> @@ -151,6 +161,14 @@ static void rocket_job_hw_submit(struct rocket_core =
*core, struct rocket_job *jo
> =20
>  	rocket_pc_writel(core, OPERATION_ENABLE, PC_OPERATION_ENABLE_OP_EN(1));
> =20
> +	if (core->soc->poll_completion) {
> +		core->poll_ticks =3D 0;
> +		core->poll_seq++;
> +		atomic_set(&core->poll_active, 1);
> +		hrtimer_start(&core->poll_timer, ns_to_ktime(RK3576_POLL_INTERVAL_NS),
> +			      HRTIMER_MODE_REL);
> +	}
> +
>  	dev_dbg(core->dev, "Submitted regcmd at 0x%llx to core %d", task->regcm=
d, core->index);
>  }
> =20
> @@ -341,25 +359,87 @@ static struct dma_fence *rocket_job_run(struct drm_=
sched_job *sched_job)
>  	return ERR_PTR(ret);
>  }
> =20
> +static void rocket_job_handle_irq(struct rocket_core *core);
> +
> +static enum hrtimer_restart rocket_poll_timer_fn(struct hrtimer *timer)
> +{
> +	struct rocket_core *core =3D container_of(timer, struct rocket_core, po=
ll_timer);
> +	u32 raw;
> +
> +	if (!atomic_read(&core->poll_active))
> +		return HRTIMER_NORESTART;
> +
> +	core->poll_work_seq =3D core->poll_seq;
> +
> +	raw =3D rocket_pc_readl(core, INTERRUPT_RAW_STATUS);
> +	if ((raw & (PC_INTERRUPT_RAW_STATUS_DPU_0 | PC_INTERRUPT_RAW_STATUS_DPU=
_1)) ||
> +	    ++core->poll_ticks >=3D RK3576_POLL_MAX_TICKS) {
> +		atomic_set(&core->poll_active, 0);
> +		schedule_work(&core->poll_work);
> +		return HRTIMER_NORESTART;
> +	}
> +
> +	hrtimer_forward_now(timer, ns_to_ktime(RK3576_POLL_INTERVAL_NS));
> +	return HRTIMER_RESTART;
> +}
> +
> +/* Start the job's next task, or retire it. Caller holds job_lock. */
> +static void rocket_job_next_locked(struct rocket_core *core)
> +{
> +	lockdep_assert_held(&core->job_lock);
> +
> +	if (!core->in_flight_job)
> +		return;
> +
> +	if (core->in_flight_job->next_task_idx < core->in_flight_job->task_coun=
t) {
> +		rocket_job_hw_submit(core, core->in_flight_job);
> +		return;
> +	}
> +
> +	iommu_detach_group(NULL, iommu_group_get(core->dev));
> +	dma_fence_signal(core->in_flight_job->done_fence);
> +	pm_runtime_put_autosuspend(core->dev);
> +	core->in_flight_job =3D NULL;
> +}
> +
> +static void rocket_poll_work_fn(struct work_struct *work)
> +{
> +	struct rocket_core *core =3D container_of(work, struct rocket_core, pol=
l_work);
> +
> +	pm_runtime_mark_last_busy(core->dev);
> +
> +	scoped_guard(mutex, &core->job_lock) {
> +		/*
> +		 * The interrupt can land while this work is queued, retire the job
> +		 * and start the next task. poll_seq only moves under job_lock, in
> +		 * hw_submit, so comparing it here says whether that happened. Doing
> +		 * it outside the lock would leave the window open rather than close
> +		 * it, and this work would then submit a task on top of a live one.
> +		 */
> +		if (READ_ONCE(core->poll_dying) || core->poll_work_seq !=3D core->poll=
_seq)
> +			return;
> +
> +		rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
> +		rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
> +
> +		rocket_job_next_locked(core);
> +	}
> +}
> +
>  static void rocket_job_handle_irq(struct rocket_core *core)
>  {
> +	if (core->soc->poll_completion) {
> +		atomic_set(&core->poll_active, 0);
> +		hrtimer_cancel(&core->poll_timer);
> +	}
> +
>  	pm_runtime_mark_last_busy(core->dev);
> =20
>  	rocket_pc_writel(core, OPERATION_ENABLE, 0x0);
>  	rocket_pc_writel(core, INTERRUPT_CLEAR, 0x1ffff);
> =20
>  	scoped_guard(mutex, &core->job_lock)
> -		if (core->in_flight_job) {
> -			if (core->in_flight_job->next_task_idx < core->in_flight_job->task_co=
unt) {
> -				rocket_job_hw_submit(core, core->in_flight_job);
> -				return;
> -			}
> -
> -			iommu_detach_group(NULL, iommu_group_get(core->dev));
> -			dma_fence_signal(core->in_flight_job->done_fence);
> -			pm_runtime_put_autosuspend(core->dev);
> -			core->in_flight_job =3D NULL;
> -		}
> +		rocket_job_next_locked(core);
>  }
> =20
>  static void
> @@ -460,6 +540,10 @@ int rocket_job_init(struct rocket_core *core)
>  	int ret;
> =20
>  	INIT_WORK(&core->reset.work, rocket_reset_work);
> +	INIT_WORK(&core->poll_work, rocket_poll_work_fn);
> +	hrtimer_setup(&core->poll_timer, rocket_poll_timer_fn, CLOCK_MONOTONIC,
> +		      HRTIMER_MODE_REL);
> +	atomic_set(&core->poll_active, 0);
>  	spin_lock_init(&core->fence_lock);
>  	mutex_init(&core->job_lock);
> =20
> @@ -501,8 +585,23 @@ int rocket_job_init(struct rocket_core *core)
> =20
>  void rocket_job_fini(struct rocket_core *core)
>  {
> +	/*
> +	 * Stop the poll from starting hardware work before tearing anything
> +	 * down: it submits the next task, and drm_sched_fini() does not wait
> +	 * for work already queued. Cancel after the scheduler is gone, so a
> +	 * job running now cannot re-arm the timer behind the cancel.
> +	 */
> +	if (core->soc->poll_completion)
> +		WRITE_ONCE(core->poll_dying, true);
> +
>  	drm_sched_fini(&core->sched);
> =20
> +	if (core->soc->poll_completion) {
> +		atomic_set(&core->poll_active, 0);
> +		hrtimer_cancel(&core->poll_timer);
> +		cancel_work_sync(&core->poll_work);
> +	}
> +
>  	cancel_work_sync(&core->reset.work);
>  	destroy_workqueue(core->reset.wq);
>  }

