Received: from mail-m83187.xmail.ntesmail.com (mail-m83187.xmail.ntesmail.com [156.224.83.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F0B3242AB;
	Wed,  1 Apr 2026 02:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.224.83.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775012075; cv=none; b=rk3sqxKcPi2CR4978RtGdSYDaI9MfT6rMFLsBPyKDzzQp5qIYISk+2DeJofscbewxyoqy6RTvDB45r2HR/nBtXg2ODkbQEDcncjOfaSts0VWFoLavkI70GMFHnRR0HHviDSqfYGfEhuMIGsVtyeCk14NMMBTsBwxEM15hkWyDls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775012075; c=relaxed/simple;
	bh=3aGaRah8f41O9g2ZXjdNh3i1RAkLp0reRltP0LPa2WU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AeXb7mHnA95j3jFOQZY45e6o6tE0II1AIg76+Itir7onT6FzjngX3kWyt9+nmqSD1jr/uifS1Is5oWNo4pMYp/of1+GRsHjguIS9MyIhtUVKf2MDY/0WF0hX7gx740xO4Rx/MGuCH0EfDCvg6h7ERnGZVdFkg8I1zxEggjyDurE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ZtfglWvV; arc=none smtp.client-ip=156.224.83.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ZtfglWvV"
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 39142f724;
	Wed, 1 Apr 2026 10:54:14 +0800 (GMT+08:00)
Message-ID: <fc6f00fa-10b0-44c8-d8b4-694f8ff3b9ea@rock-chips.com>
Date: Wed, 1 Apr 2026 10:54:13 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Cc: shawn.lin@rock-chips.com, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, ulf.hansson@linaro.org, heiko@sntech.de
Subject: Re: [PATCH 1/2] pmdomain/rockchip: skip QoS operations for idle-only
 domains
To: Daniel Bozeman <daniel@orb.net>
References: <20260331180223.1682283-1-daniel@orb.net>
 <5c8732a3-6cc9-5d02-f56b-fc7ba29c7ce0@rock-chips.com>
 <CAG+Ngm+xJCCQMPddZx8AbPEeH3rUrn3GKF575zXpGPJrnELvMw@mail.gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <CAG+Ngm+xJCCQMPddZx8AbPEeH3rUrn3GKF575zXpGPJrnELvMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d46f6852f09cckunm2fad582df958e2
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkNPTVYdT08aHk8YQh5PHUlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ZtfglWvVHDfRtUw1SGTqDQJJHeX/aurreDJr4KQff0OoDgR89JsUrhEFc8FCjs5g8RPp27wEGrwnqmNg0IRiYMUTxB4r9R++FGmn7rUDODjd+KScvBb8+3N5Wgfcz9rBpYzs1gcGfPI5Ia8uZTJTw/AMZD3Tm8Gf5Nt4C2LveZ0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=P9bx0JSQN5urEQ0kGf5GT9ZdgXv8ZZPvBz0eFEf+7pA=;
	h=date:mime-version:subject:message-id:from;

在 2026/04/01 星期三 10:34, Daniel Bozeman 写道:
> The NanoPi Zero2 (RK3528) kernel panics during boot when a
> GPIO-controlled USB VBUS regulator is defined on GPIO4 (which
> is in PD_RKVENC). The goal of this series is to make USB host
> power work on boards that use GPIO4 for regulator control.
> 
> The root cause is a probe ordering issue. On RK3528, the power
> domain controller's first probe attempt fails because PD_GPU's
> clock lookup returns -EPROBE_DEFER (CRU hasn't probed yet).
> The driver then tears down all domains, including PD_RKVENC
> which would have registered successfully (it has no clock
> requirements). During this window, the USB regulator driver
> probes and requests GPIO4, which is in the now-unregistered
> PD_RKVENC. This triggers a synchronous external abort.
> 
> With patch 2 alone (skipping deferred domains), the idle-only
> domains register successfully. But the genpd framework then
> attempts to power them off via genpd_power_off_work_fn. This
> calls rockchip_pd_power(), which does QoS save and idle
> requests on domains with pwr_mask == 0 that cannot actually
> be powered off.
> 
> To your question about why QoS registers become inaccessible
> on idle-only domains: I have not root-caused that specifically.
> What I can confirm is the crash trace below, which occurs when
> patch 2 is applied without patch 1. The abort happens during


This sounds like a parent-child dependency which hasn't been sorted
out. My another question will be: with patch 1 applied, how to save-
restore qos registers during normal S2R usage?

> rockchip_pmu_set_idle_request on an idle-only domain:
> 
>    Internal error: synchronous external abort: 0000000096000010
>    CPU: 2 PID: 60 Comm: kworker/2:3
>    Workqueue: pm genpd_power_off_work_fn
>    pc : regmap_mmio_read32le+0x8/0x20
>    lr : regmap_mmio_read+0x44/0x70
>    Call trace:
>     regmap_mmio_read32le+0x8/0x20
>     _regmap_bus_reg_read+0x6c/0xac
>     _regmap_read+0x60/0xd8
>     regmap_read+0x4c/0x7c
>     rockchip_pmu_set_idle_request.isra.0+0x94/0x1b4
>     rockchip_pd_power+0x37c/0x608
>     rockchip_pd_power_off+0x14/0x38
>     genpd_power_off.isra.0+0x1f0/0x2f0
>     genpd_power_off_work_fn+0x34/0x54
> 
> The two patches work together: patch 1 prevents QoS access
> on idle-only domains, and patch 2 prevents the full probe
> teardown when a single domain defers.
> 
> Tested on NanoPi Zero2 (fixes panic) and Radxa E20C (no
> regression).
> 
> On Tue, Mar 31, 2026 at 6:17 PM Shawn Lin <shawn.lin@rock-chips.com 
> <mailto:shawn.lin@rock-chips.com>> wrote:
> 
>     Hi Daniel,
> 
>     在 2026/04/01 星期三 2:02, Daniel Bozeman 写道:
>      > Idle-only power domains (pwr_mask == 0) cannot actually be powered
>      > on or off. rockchip_do_pmu_set_power_domain() already returns early
>      > for these domains, but rockchip_pd_power() still attempts QoS save
>      > and idle requests before reaching that check.
>      >
>      > On RK3528, the idle-only domains (PD_RKVENC, PD_VO, PD_VPU) have
>      > QoS registers that may be inaccessible when the generic power domain
>      > framework attempts to power them off, leading to synchronous external
>      > aborts.
>      >
> 
>     Is it the real abort happened on your RK3528 board? I am trying to
>     understand the problem first. Even with idle-only powerdomain, the code
>     also save the QoS registers before set idle to the powerdomain, so
>     how the QoS registers become inaccessible?
> 
>      > Return early from rockchip_pd_power() when pwr_mask is zero, matching
>      > the existing guard in rockchip_do_pmu_set_power_domain().
>      >
>      > Fixes: 1fe767a56c32 ("soc: rockchip: power-domain: allow domains
>     only handling idle requests")
>      > Signed-off-by: Daniel Bozeman <daniel@orb.net
>     <mailto:daniel@orb.net>>
>      > ---
>      >   drivers/pmdomain/rockchip/pm-domains.c | 3 +++
>      >   1 file changed, 3 insertions(+)
>      >
>      > diff --git a/drivers/pmdomain/rockchip/pm-domains.c
>     b/drivers/pmdomain/rockchip/pm-domains.c
>      > index 490bbb1d1d..2eecae092a 100644
>      > --- a/drivers/pmdomain/rockchip/pm-domains.c
>      > +++ b/drivers/pmdomain/rockchip/pm-domains.c
>      > @@ -640,6 +640,9 @@ static int rockchip_pd_power(struct
>     rockchip_pm_domain *pd, bool power_on)
>      >       if (rockchip_pmu_domain_is_on(pd) == power_on)
>      >               return 0;
>      >
>      > +     if (pd->info->pwr_mask == 0)
>      > +             return 0;
>      > +
>      >       ret = clk_bulk_enable(pd->num_clks, pd->clks);
>      >       if (ret < 0) {
>      >               dev_err(pmu->dev, "failed to enable clocks\n");
>      >
>      > base-commit: bc330699801d3b4f99110365512caed5adcfaca3
> 
