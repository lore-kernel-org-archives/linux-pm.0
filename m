Received: from mail-m49196.qiye.163.com (mail-m49196.qiye.163.com [45.254.49.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40451FF7C8;
	Sat,  4 Apr 2026 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775303160; cv=none; b=VEPR6GjspFnr+nWdpg5wW8ro8YFdAWzUmrUFRWK5jgq0TIQezySYrURR7yOjCFphglQoAvc2SSSD+nG7Eoc6BjAU3g7A+G0Ins/KxaDkKiuYpIhB3+yo+cBhUfvRI/XRWlQ4XKyh5/U5OY1mIxbAKN+fEtEpIql7ACZCzAVO9GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775303160; c=relaxed/simple;
	bh=UtUxC2O2WgN7eAaBi0io4bhEyy3yve7AnWXMaPmemAw=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qhMgvYszm/RZdUNkAH6gMoPC7yeN3lN7DdJ/qJmhGfhKz5o3DKBfxRafZyqhYPXF65U6wmD0lrt8HQpRQeG9uMPE+YejjYoKYs3wMcePWP83Rep87zFSRRTcE6ejIR9h1JEIz2t9CFbdvRQGhst7Doua4ehsJjUAT0DYdjNAEVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=BpidNjhv; arc=none smtp.client-ip=45.254.49.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="BpidNjhv"
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 398ad1038;
	Sat, 4 Apr 2026 19:40:38 +0800 (GMT+08:00)
Message-ID: <f1b9a97a-f1f9-0757-5dc7-33960318be61@rock-chips.com>
Date: Sat, 4 Apr 2026 19:40:36 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Cc: shawn.lin@rock-chips.com
Subject: Re: [PATCH 1/2] pmdomain/rockchip: skip QoS operations for idle-only
 domains
To: Daniel Bozeman <daniel@orb.net>, finley.xiao@rock-chips.com,
 ulf.hansson@linaro.org, heiko@sntech.de, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Jonas Karlman <jonas@kwiboo.se>
References: <20260331180223.1682283-1-daniel@orb.net>
 <5c8732a3-6cc9-5d02-f56b-fc7ba29c7ce0@rock-chips.com>
 <fbf16b5a-1565-39c9-0d92-33a7a577212f@rock-chips.com>
 <adAwtiaU-32qjRRE@claude-dev>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <adAwtiaU-32qjRRE@claude-dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d584b88b609cckunm47ea691a1661c0
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU4dHlYaGR4fGB9MTkJCS0xWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=BpidNjhv1rke4/4+Gu342PUGVXa/6ZvmfPqF6dwimxlCX49Zk7Ou2PEcgzRY5t/xEG3n2xQi3VE5psBA0jJqZxyO87ly6dC7+09Y8mqUxVQ63M7CsIJ1GLVrv74fR8aAZSniw6cWqns0zFrRdvv1kpu+R6SjqAfiWKk93DY54Vo=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=ppO08De5fKDNxsOEOVN6crncqIPTkWq/KYv7kgENJ/Q=;
	h=date:mime-version:subject:message-id:from;

+ Jonas

在 2026/04/04 星期六 5:27, Daniel Bozeman 写道:
> I ran both tests you requested:
> 
> Test 1: Added pr_err to rockchip_pd_power_on/off to identify
> the crashing domain. With patch 2 only (skip EPROBE_DEFER),
> the crash occurs on PD_VO:

Thanks for fing the PD_VO, and I'm still requesting more docs internally
to check what's going on. I see there are several qos nodes under PD_VO,
but I'm not sure if they all belong to PD_VO and even not sure if their
registers are define correctly.

Perhaps, could you help dig more by removing the qos one by one from
PD_VO to narrow down the broken qos?

I also loop in Jonas who submited the code, to have a look.(I'm  also
surprised to see there aren't any Qos nodes under PD_VO in vendor
kernel for reference, but upstream code has...)

> 
>    rockchip_pd_power_off: vo pwr_mask=0x0
>    Internal error: synchronous external abort: 0000000096000010
>    Workqueue: pm genpd_power_off_work_fn
>    Call trace:
>     regmap_mmio_read32le+0x8/0x20
>     _regmap_bus_reg_read+0x6c/0xac
>     _regmap_read+0x60/0xd8
>     regmap_read+0x4c/0x7c
>     rockchip_pmu_set_idle_request.isra.0+0x98/0x16c
>     rockchip_pd_power+0x130/0x48c
>     rockchip_pd_power_off+0x38/0x48
>     genpd_power_off.isra.0+0x1f0/0x2f0
>     genpd_power_off_work_fn+0x34/0x54
> 
> Test 2: Same debug build, booted with clk_ignore_unused
> added to kernel cmdline via U-Boot. Same crash, same domain:
> 
>    rockchip_pd_power_off: vo pwr_mask=0x0
>    Internal error: synchronous external abort: 0000000096000010
>    (identical call trace)
> 
> The crash occurs even with clk_ignore_unused. The QoS
> registers for PD_VO are inaccessible when genpd attempts
> to power off this idle-only domain.
> 
