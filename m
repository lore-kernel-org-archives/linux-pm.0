Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAF333F5B1
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 13:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638975; cv=pass; b=cS+xXMzjk6UK8Q7+ZjTVz9GGWgBqIljapqk9d8ZWNRQ9qTkHG0XYGeFoUs5wLD0eI2cnJg4THqmT4JoXi/1CX0PEZUnmkoKbNNhjoAobPnRL1zQEVNWKmjiY4d0TYLMqEEBbhSXMP3+0Mu6DZsg1XwWYWtZzj9LRdv9q9uYUbR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638975; c=relaxed/simple;
	bh=/Oh0ypFHF/MeCKdDZKZv3m+0QRpoUmuQ3pwi6V0uN70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxepgdRHsthHq3bJVvPgHCfPTMBMft1DMa9TcrPkuxIjDSE+k0Fnyev1vetjyI8Yr4QABiFUypJTKgsvvIi5rNB0ckj26Cf0FyWOl+ZUNiwmz1Rj8aE6a/9bIYW1U9ffCiJmC1yNVWda7s54SbRlrP7CEhlNSetsuifhTcwDiM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=uOGRjR3v; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="uOGRjR3v"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6984169c126so559778a12.1
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:02:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784638971; cv=none;
        d=google.com; s=arc-20260327;
        b=o/biBrOxTKn86pM49rB+JlMkCLFeKD0+EutUv9VstBKP6Wfx2lyhASWKWzoYSOeNF2
         CUtD+hQfnao8y0BLwcC9utUa4HcswXks0FDqQIa39yvS/R+99myUT5YU1NGlZLmFn5Pd
         zl25GSH1a3khRAHEqH7dez6F4ij4qv6tjkFaEQoffuuBi4rg4vrC3O4tM46WmEo5ifY3
         9txtAxO+0McGPzjURHXNU+W0oi1NyHtjxm94v0CTP6BC1C2DW2pDX8Vbvs6WminTJv0S
         J7jAwkXDY4D6dqIrQ2NPOGkZkhGOWsMo7jqDBvHvYQ3vjAS/YRWq8gbHFpEoGl0RI3kp
         F+JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PLoRxgeU4eLbTE5cBel+nzCrJ1tx2QkUTBvlydG2Zzg=;
        fh=smTIwXay85LHS2UgG3bqCl3wSiH1+n3gGG4SvXTkwJ8=;
        b=sn9teDl0jATu5co2zra9zcNFShRpcWsGAbm6zL4M0ekKtrleTgQrXsYvPw2sPFyXa4
         wwiCzc6YNVcWZkbyu1b09WfOhJsKGNr5LttzrlrZNmOo7vgk+ptyWCisbJ6l5pGFWUDx
         gA87jGRAgUIder/OSX9dK/ghHfAT2dKl9zM7yCJD2byw6S3bo9PLapwzpGoloSpmGYj/
         5/EUhy4MGpah5+fUMReHnpGfFZxOJeujF3BqfddsdOqTzBLA/jaZDhxBHPvDV7hkEWGq
         tEhZoGD+avD0RZ9Qnu6994hdkqhhlWigbSq/699Y0hnrsY+m3ylIt3G8zXnWcGwajceR
         Vbow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1784638971; x=1785243771; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PLoRxgeU4eLbTE5cBel+nzCrJ1tx2QkUTBvlydG2Zzg=;
        b=uOGRjR3v6G2FNbZhIFQo4W9KhBJvhJKHOusSE6cl/gulQf9Je4P5e5FUa+qtW1nWV0
         xwZ8tXkI+Kw82+9vJAWJmwBboQOuQtyFUjggfO8R1tRiewhCgkt05rynkVClvPLpl4yk
         S/Sn1Bo87gq0EVCdptpMYzBD4gSKc6y6x5zGT6tUoEFPTouLM5vblHP8Q2QHayrotDd3
         8PuBQ7Hcq1L6Q3Vvox0vvMs7QCy2Iq4NBvpc8652Y6IBahpkiqtPgVNRkCjkArl6RyRE
         5uD5PVKozwsRqyGr9fSnaBmI9qWqhEoBhCdcJaHbSHW6Fh89OpoPCs4afgUwLIMZeWlV
         ZMcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784638971; x=1785243771;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PLoRxgeU4eLbTE5cBel+nzCrJ1tx2QkUTBvlydG2Zzg=;
        b=X46c45YfHFssZFlZc41SiNxeZpw7BK0ZwiqIyJ5i+wtwgbJCkETzOlAxzw0vzixlxz
         QKaII97btKFaMoaNhgz1+wf5FWmoAgfZHhi6gt7AJxBiIuHeAF8KKs7ELY0Ej42PzeZP
         RlbhbM29qSEZ4Q2dhgIlWmI+aa2KlCTcASdi6eDQtmPVy2uwuuxKofcbAGKCr5jFRkRA
         j76xAuSKXXh26RtKwmnbYjLcdInbm7qqx8mPcP5Y4MJLagsoEJl4dqFYJDGXlUI7IzxX
         EmxUsk/00VpVHPFezSOnb3NhpPJslNxOhsoUCXa8Y+lGlbviIFSU81GkXVOyp7XQUSk5
         yTwQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq4x6OR4yZYQnGbdqG2YZhNuiyoVc2MYPoBPQJIkBH2YQXJJo8G9ombFEMYjEIvJheK8agERxrmsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQmHo5m5b83LpbIPdDxKyhWGYTEFMKVmmKQWaVlgb0YymFVjLZ
	ncNtv5zQAHQtwlnSOE6/L12sOu/QZK4xJ7/fQqofeziJwcYYpVohqvmFmDsI2SM3aNc3l7OcgXG
	f76Rbm+kwsNluv4zRK4iN9kk9+iWL0pUofght5O8Kyw==
X-Gm-Gg: AR+sD13+M/yQW2EDPNr2doP90IxwU0pHiXVL9XmpKbmMWuigYM7F8HHu4qpA+nOZ3FY
	3BQsJL8MnAQXjaySjFu+xBZeWy8iWqJRrgylO2xYyta6k6ClsRg+BVIzdMzB4bgZziMe64sBA4s
	v7nxNbhEceVR+yiG0W+soj1njRewjsydi6OLmr33EvbW/06tWMHD2Difqc6Ti9hpGExqMxI1d6G
	r1ONCUos2htrDn0YxtLgwR4bddNFB63Yy9qs1ZsCpJahZZy00n4BKw9MJV0XVy54isXLitf/jOT
	Lh+39i8zgaCqg7Xh0g==
X-Received: by 2002:a17:906:ee81:b0:c12:34ed:e0fe with SMTP id
 a640c23a62f3a-c16b486b059mr764236766b.60.1784638970824; Tue, 21 Jul 2026
 06:02:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718031146.3368811-1-gahing@gahingwoo.com> <20260718031146.3368811-7-gahing@gahingwoo.com>
In-Reply-To: <20260718031146.3368811-7-gahing@gahingwoo.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 21 Jul 2026 17:02:36 +0400
X-Gm-Features: AUfX_mybR4TJcD7UtKT7vkslJHd83avKACirSY-Al4DoJE_V_nYHHDDfXmU2CdM
Message-ID: <CAKTNdwHL2Z3h-FN7LLPshz5B0duiMw_pyfe=VG4UDhfm8igZ6Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 6/8] accel/rocket: add RK3576 NPU (RKNN) support
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: tomeu@tomeuvizoso.net, heiko@sntech.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, ulfh@kernel.org, p.zabel@pengutronix.de, 
	ogabbay@kernel.org, chaoyi.chen@rock-chips.com, 
	dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
	iommu@lists.linux.dev, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiaxing,

On Sat, Jul 18, 2026 at 7:11=E2=80=AFAM Jiaxing Hu <gahing@gahingwoo.com> w=
rote:
>
> Add RK3576 support to the rocket DRM accelerator driver (used with the
> Mesa Teflon TFLite delegate).  Per-SoC differences are selected by new
> of_device_id match data (struct rocket_soc_data) so the RK3588 path stays
> unchanged:
>
>   - match rockchip,rk3576-rknn-core; iterate its nodes at probe
>   - RK3576 takes six clocks (adds the CBUF domain ACLK/HCLK_RKNN_CBUF):
>     the CNA fills the CBUF and CORE reads from it, so the compute path
>     stalls without them.  RK3588 keeps its four clocks.
>   - RK3576 requests one reset (srst_a); its BIU reset (srst_h) is driven
>     from the power domain.  RK3588 keeps both.
>   - RK3576 spans two power domains (PD_NPU0 + PD_NPU1) and attaches the
>     list explicitly; RK3588 is single-domain and keeps the driver-core
>     auto-attach.
>   - RK3576 has no maskable completion interrupt (PC_DONE is read-only in
>     INTERRUPT_MASK), so it polls PC_DONE via an hrtimer; RK3588 keeps the
>     DPU completion IRQ.
>   - guard rocket_job_timedout() MMIO behind pm_runtime_active()
>
> Tested on a Radxa ROCK 4D: the NPU probes, powers on, brings up its
> IOMMUs and runs submitted jobs to completion.  Full multi-layer inference
> is not yet correct on this SoC (only the first operation per power sessio=
n
> produces valid output); see the cover letter.
>
> Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
> ---
>  drivers/accel/rocket/rocket_core.c   |  39 +++++++-
>  drivers/accel/rocket/rocket_core.h   |  22 ++++-
>  drivers/accel/rocket/rocket_device.c |   4 +
>  drivers/accel/rocket/rocket_drv.c    |  22 ++++-
>  drivers/accel/rocket/rocket_job.c    | 127 +++++++++++++++++++++++++--
>  5 files changed, 200 insertions(+), 14 deletions(-)

[...]

> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 2f1861f96..ce3f7c92e 100644
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
> + * RK3576: INTERRUPT_MASK bits 28-29 are read-only (hardware rejects the=
 write),
> + * so the PC_DONE completion signal cannot be routed to the GIC via the =
normal
> + * interrupt-mask path.  We poll OPERATION_ENABLE every RK3576_POLL_INTE=
RVAL_NS
> + * instead of waiting for a completion IRQ.
> + */
> +#define PC_INTERRUPT_MASK_RK3576_PC_DONE_0  0x10000000u
> +#define PC_INTERRUPT_MASK_RK3576_PC_DONE_1  0x20000000u
> +#define RK3576_POLL_INTERVAL_NS  1000000LL  /* 1 ms */
> +
>  static struct rocket_job *
>  to_rocket_job(struct drm_sched_job *sched_job)
>  {
> @@ -137,8 +148,24 @@ static void rocket_job_hw_submit(struct rocket_core =
*core, struct rocket_job *jo
>         rocket_pc_writel(core, REGISTER_AMOUNTS,
>                          PC_REGISTER_AMOUNTS_PC_DATA_AMOUNT((task->regcmd=
_count + 1) / 2 - 1));
>
> -       rocket_pc_writel(core, INTERRUPT_MASK, PC_INTERRUPT_MASK_DPU_0 | =
PC_INTERRUPT_MASK_DPU_1);
> -       rocket_pc_writel(core, INTERRUPT_CLEAR, PC_INTERRUPT_CLEAR_DPU_0 =
| PC_INTERRUPT_CLEAR_DPU_1);
> +       if (core->soc->poll_completion) {
> +               /*
> +                * RK3576: PC_DONE (bits 28-29) is read-only in INTERRUPT=
_MASK, so
> +                * it cannot be routed to the GIC; enable the DMA-error i=
nterrupts
> +                * and poll PC_DONE via the hrtimer started below.
> +                */
> +               rocket_pc_writel(core, INTERRUPT_MASK,
> +                                PC_INTERRUPT_MASK_DMA_READ_ERROR |
> +                                PC_INTERRUPT_MASK_DMA_WRITE_ERROR);
> +               rocket_pc_writel(core, INTERRUPT_CLEAR,
> +                                PC_INTERRUPT_MASK_RK3576_PC_DONE_0 |
> +                                PC_INTERRUPT_MASK_RK3576_PC_DONE_1);
> +       } else {
> +               rocket_pc_writel(core, INTERRUPT_MASK,
> +                                PC_INTERRUPT_MASK_DPU_0 | PC_INTERRUPT_M=
ASK_DPU_1);
> +               rocket_pc_writel(core, INTERRUPT_CLEAR,
> +                                PC_INTERRUPT_CLEAR_DPU_0 | PC_INTERRUPT_=
CLEAR_DPU_1);
> +       }

This whole polled-interrupt part looks very suspicious. Does the
vendor stack do the same thing?

It's hard to believe Rockchip would release performance-critical and
hype-heavy silicon which can't properly raise the most often triggered
interrupt in its critical path, so there must be something else going
on here.

One theory could be that the interrupt bits are not "read-only" per
se, but rather gated inactive by some internal hardware state which
must be cleared before jobs are submitted (e.g. some buffers not
drained, or init sequence not completed, or voltages/frequencies not
set, or memory mappings not written out, ...). If so, this same
hardware state (or something related to it) may well be the cause of
your observed "first (forced) job completes, others don't".

Best regards,
Alexey
