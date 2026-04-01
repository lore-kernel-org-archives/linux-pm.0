Received: from mail-m49196.qiye.163.com (mail-m49196.qiye.163.com [45.254.49.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55721A3160;
	Wed,  1 Apr 2026 01:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775006590; cv=none; b=Ek8zrhvQXNn4GuoT96U8U5O5afMM/yGpO1Qo5PBUcHxdQHYYyQAB45b0wcz7D018lqlLwXEFmLnnPCHFB8xWmLhfGNK/joX6wx01hXjKqDuMuW3l9UxpjG7iEgN8A0f5mrLszJyMsuwibmCZStJIf2YH0f0kCKdoqjkZKp2tk9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775006590; c=relaxed/simple;
	bh=YSGyW/KdWD7TJVeXuAE2a0yxacvnVpCIMiy7wXRxOlA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=q2KZGLbbCy8nFB9XlptFUuLbR408sw0ZGTotDHqtBviIwLwQkzXxkic6DQWHpwem+wdu3yy5kBt64HlyPMOJI65Gy2cYS52tOPyWEcRZt9+07DJDheclBcc98AiHT21wkE4PlTT8zh4TlLqUpIyxFTuu6UsHH4mfjewrJJA4Obs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=NoDHYN/y; arc=none smtp.client-ip=45.254.49.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="NoDHYN/y"
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 39100b138;
	Wed, 1 Apr 2026 09:17:48 +0800 (GMT+08:00)
Message-ID: <5c8732a3-6cc9-5d02-f56b-fc7ba29c7ce0@rock-chips.com>
Date: Wed, 1 Apr 2026 09:17:45 +0800
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
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260331180223.1682283-1-daniel@orb.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d469e3dd509cckunmbd42e9a8f80c51
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU5OTFYeQ0pNTkpCH08dS05WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=NoDHYN/y933X4usXs+vkbBkTesgf6cA+1duQalmTmx8Gn1TlLa2iKxI9gxB2vzmj/EpBNVcqd2LwvQdVxfUI7IitMgL0RgSAQD273Zo83qkzWNQeo8Zr2LzW2FU09PAtpMH7/oXcg/HAIEyH9Ioq942sWk7KYCzlTLjwk6dyDZA=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=84tddcSLoInqnr4qLcDW/JZ/jewF+U0Wxnidmb7LaMs=;
	h=date:mime-version:subject:message-id:from;

Hi Daniel,

在 2026/04/01 星期三 2:02, Daniel Bozeman 写道:
> Idle-only power domains (pwr_mask == 0) cannot actually be powered
> on or off. rockchip_do_pmu_set_power_domain() already returns early
> for these domains, but rockchip_pd_power() still attempts QoS save
> and idle requests before reaching that check.
> 
> On RK3528, the idle-only domains (PD_RKVENC, PD_VO, PD_VPU) have
> QoS registers that may be inaccessible when the generic power domain
> framework attempts to power them off, leading to synchronous external
> aborts.
> 

Is it the real abort happened on your RK3528 board? I am trying to
understand the problem first. Even with idle-only powerdomain, the code
also save the QoS registers before set idle to the powerdomain, so
how the QoS registers become inaccessible?

> Return early from rockchip_pd_power() when pwr_mask is zero, matching
> the existing guard in rockchip_do_pmu_set_power_domain().
> 
> Fixes: 1fe767a56c32 ("soc: rockchip: power-domain: allow domains only handling idle requests")
> Signed-off-by: Daniel Bozeman <daniel@orb.net>
> ---
>   drivers/pmdomain/rockchip/pm-domains.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
> index 490bbb1d1d..2eecae092a 100644
> --- a/drivers/pmdomain/rockchip/pm-domains.c
> +++ b/drivers/pmdomain/rockchip/pm-domains.c
> @@ -640,6 +640,9 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
>   	if (rockchip_pmu_domain_is_on(pd) == power_on)
>   		return 0;
>   
> +	if (pd->info->pwr_mask == 0)
> +		return 0;
> +
>   	ret = clk_bulk_enable(pd->num_clks, pd->clks);
>   	if (ret < 0) {
>   		dev_err(pmu->dev, "failed to enable clocks\n");
> 
> base-commit: bc330699801d3b4f99110365512caed5adcfaca3
