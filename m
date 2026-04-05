Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831E2331A77
	for <linux-pm@vger.kernel.org>; Sun,  5 Apr 2026 23:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775431793; cv=none; b=A3VGqGUZjd75zaA0GeQVGYSpkWEwYMwARztErZUKYaT8tOaaS5LOdAJz9vcgroau6DPi3JaxsL+dyTPwMkUbQfh2qurpSLilQCtwpXzX576cqVRq9Z4JbR7LUMTvVgkjqTlthE48ufq/EWoV26xGKDxc7eQhNjfN0tGZTehrbao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775431793; c=relaxed/simple;
	bh=et/TFHqQPLEN8rZExoJfpYhqpY3Y8A6I5sPv62UkElg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=DYR2+3n51eN5L8X9XEECf9nQ51+s/qtUUvwOSaSAg3bcDBLx6NLeCT2mxcMuTJBmlKfg3mte6MpqxuEHpTuFsUCfbxEBT3ntaa/jMZ6Q+A0C3be+u2eRBhVVA5+SUk1XYIRJWWUOmRdgQzgRix7XMFBxSbrkPdQRV5Q9K2UvQy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=AmY9WfKm; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="AmY9WfKm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: Cc:
 References: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1775431784;
 bh=j+3GpbRroDEsaYbjyzLr+o1XWCEL4kj4mK45WwiU6FI=;
 b=AmY9WfKmpRS6+RBVta82KyLEf0r0WlD4uW46IZ6SEewUU5GGzV4bevDhE6L3bekY/h5pR4ixv
 njBHNbEqCpI38Bsgvd7e9bfOAo8pe2CYM+gwKWqwVjj+aO85KdRuzgG56WmbRatotFk37vTWmF7
 A/D9tTQiWYocmdGno4zfT1vJo4lvzWma7NM8zeVWgRtNDG9rBb4/xfEl6tcJritXWkxPeLYy7WZ
 c5MxL1oExGxU7pnBBG9gK5Zbp+MCkOjaac6FJwSZAe1C62P06AHByF/iUBpGF2rZR0bu6QqpJro
 qrqhWvTn5LbcbGbNjtRoD0xR0EvKItH670I4hdNWGdmg==
X-Forward-Email-ID: 69d2f061e23c9321167a0c52
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 2.6.68
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <693c6c27-6ff2-4ab0-994f-3821e5ffcec8@kwiboo.se>
Date: Mon, 6 Apr 2026 01:29:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] pmdomain/rockchip: skip QoS operations for idle-only
 domains
To: Shawn Lin <shawn.lin@rock-chips.com>, Daniel Bozeman <daniel@orb.net>,
 "finley.xiao@rock-chips.com" <finley.xiao@rock-chips.com>
References: <20260331180223.1682283-1-daniel@orb.net>
 <5c8732a3-6cc9-5d02-f56b-fc7ba29c7ce0@rock-chips.com>
 <fbf16b5a-1565-39c9-0d92-33a7a577212f@rock-chips.com>
 <adAwtiaU-32qjRRE@claude-dev>
 <f1b9a97a-f1f9-0757-5dc7-33960318be61@rock-chips.com>
Content-Language: en-US
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
 "heiko@sntech.de" <heiko@sntech.de>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <f1b9a97a-f1f9-0757-5dc7-33960318be61@rock-chips.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 4/4/2026 1:40 PM, Shawn Lin wrote:
> + Jonas
> 
> 在 2026/04/04 星期六 5:27, Daniel Bozeman 写道:
>> I ran both tests you requested:
>>
>> Test 1: Added pr_err to rockchip_pd_power_on/off to identify
>> the crashing domain. With patch 2 only (skip EPROBE_DEFER),
>> the crash occurs on PD_VO:
> 
> Thanks for fing the PD_VO, and I'm still requesting more docs internally
> to check what's going on. I see there are several qos nodes under PD_VO,
> but I'm not sure if they all belong to PD_VO and even not sure if their
> registers are define correctly.
> 
> Perhaps, could you help dig more by removing the qos one by one from
> PD_VO to narrow down the broken qos?
> 
> I also loop in Jonas who submited the code, to have a look.(I'm  also
> surprised to see there aren't any Qos nodes under PD_VO in vendor
> kernel for reference, but upstream code has...)

Upstream included all QoS that seemed to be related to each power domains
based on e.g. vendor DTs, clock driver and other hints.

Vendor kernel mostly seemed to take the easy way out and flagged all
rk3528 power domains as always on or similar, if I recall correctly.

For upstream we have instead tried to describe all power domains without
any always on flag and instead ensure all devices belong to a power
domain.

I do not have access to any rk3528 TRM or similar, so I would not be
surprised if there could be some wrong details. However, runtime
testing at time of patches was sent upstream did not show any issues.

I was however able to reproduce a crash using next-20260403 + rk3528 usb
series [1][2]. Such crash was not happening at the original submission
of the pmdomain or usb series.

Looking at pmdomain core and rk pmdomain driver changes since rk3528
merge I see that there are some changes that may have changed behavior
of the driver since initial rk3528 merge. I.e. GENPD_FLAG_NO_STAY_ON.

Following quick diff seem to remove any changed behavior introduced in
commit 2bc12a8199a0 ("pmdomain: rockchip: Fix regulator dependency with
GENPD_FLAG_NO_STAY_ON"), and fixes the crash for me.

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 490bbb1d1d8e..4d69b9f68886 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -892,7 +892,9 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	pd->genpd.power_on = rockchip_pd_power_on;
 	pd->genpd.attach_dev = rockchip_pd_attach_dev;
 	pd->genpd.detach_dev = rockchip_pd_detach_dev;
-	pd->genpd.flags = GENPD_FLAG_PM_CLK | GENPD_FLAG_NO_STAY_ON;
+	pd->genpd.flags = GENPD_FLAG_PM_CLK;
+	if (pd->info->pwr_mask || pd->info->status_mask)
+		pd->genpd.flags |= GENPD_FLAG_NO_STAY_ON;
 	if (pd_info->active_wakeup)
 		pd->genpd.flags |= GENPD_FLAG_ACTIVE_WAKEUP;
 	pm_genpd_init(&pd->genpd, NULL,

Could also be that GENPD_FLAG_NO_STAY_ON only need to be applied to
need_regulator domains?

[1] https://lore.kernel.org/r/20250723122323.2344916-1-jonas@kwiboo.se/
[2] https://github.com/Kwiboo/linux-rockchip/commits/next-20260403-rk3528/

Regards,
Jonas

> 
>>
>>    rockchip_pd_power_off: vo pwr_mask=0x0
>>    Internal error: synchronous external abort: 0000000096000010
>>    Workqueue: pm genpd_power_off_work_fn
>>    Call trace:
>>     regmap_mmio_read32le+0x8/0x20
>>     _regmap_bus_reg_read+0x6c/0xac
>>     _regmap_read+0x60/0xd8
>>     regmap_read+0x4c/0x7c
>>     rockchip_pmu_set_idle_request.isra.0+0x98/0x16c
>>     rockchip_pd_power+0x130/0x48c
>>     rockchip_pd_power_off+0x38/0x48
>>     genpd_power_off.isra.0+0x1f0/0x2f0
>>     genpd_power_off_work_fn+0x34/0x54
>>
>> Test 2: Same debug build, booted with clk_ignore_unused
>> added to kernel cmdline via U-Boot. Same crash, same domain:
>>
>>    rockchip_pd_power_off: vo pwr_mask=0x0
>>    Internal error: synchronous external abort: 0000000096000010
>>    (identical call trace)
>>
>> The crash occurs even with clk_ignore_unused. The QoS
>> registers for PD_VO are inaccessible when genpd attempts
>> to power off this idle-only domain.
>>

