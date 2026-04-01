Received: from mail-m32103.qiye.163.com (mail-m32103.qiye.163.com [220.197.32.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CFF28002B;
	Wed,  1 Apr 2026 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027491; cv=none; b=U/E0CTijNk+X0sJxirTdICISR4sEZDZYuJAH1TstazcQBvjfPcD0+ZHWnLehuwilmtDB1B1aDZQVHdrjqrfRt+C4G6tgtsUTGm+ig4ImMIUr2uzbl9rIpnI3e4hbuhYCE44nMINoy4irdhcqm1+aJwvBbE/Z4yHpKIlPonJoPKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027491; c=relaxed/simple;
	bh=W3tAorrBGtb1hFLj0zp9FvvZaPUuabaZ5Vm7PRAy6UA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UFQFq9ljELlgHfsjUyj3djUVthlZRFeldBFnboWfh4Q//gE5oNQ5gEX82LPnIAKagjFt7ELUAS8+7p8V0Ge5fPaglD0pk1QzUGqU30L3mPOZ+/cSibWy9wATLNfrGYTNM3ybWg1IFyrlcDSZ0XllxwnjUOgTUQ83iA9wUoRORe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=XK7L4fAB; arc=none smtp.client-ip=220.197.32.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="XK7L4fAB"
Received: from [172.16.12.17] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 391dff0b7;
	Wed, 1 Apr 2026 15:11:18 +0800 (GMT+08:00)
Message-ID: <fbf16b5a-1565-39c9-0d92-33a7a577212f@rock-chips.com>
Date: Wed, 1 Apr 2026 15:11:16 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Cc: shawn.lin@rock-chips.com, "finley.xiao" <finley.xiao@rock-chips.com>
Subject: Re: [PATCH 1/2] pmdomain/rockchip: skip QoS operations for idle-only
 domains
To: Daniel Bozeman <daniel@orb.net>, ulf.hansson@linaro.org, heiko@sntech.de,
 linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260331180223.1682283-1-daniel@orb.net>
 <5c8732a3-6cc9-5d02-f56b-fc7ba29c7ce0@rock-chips.com>
 <CAG+Ngm+xJCCQMPddZx8AbPEeH3rUrn3GKF575zXpGPJrnELvMw@mail.gmail.com>
 <acy3eP0dZBx6A950@claude-dev>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <acy3eP0dZBx6A950@claude-dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d47e1de0c09cckunm098604e3fd985d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUpLGFYZSk9OSk1JGE9KTENWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=XK7L4fAB8DVTWQs0ZKyABCZaY4MYlJiruuP1OSHK17Lk2Pzs+YyiLRLbyFXuzV+mgXQ9+RXOeAgtqFdyIGOVS5QQZTRn/2sw8DcwlTmyVIkWB+DOBA22inMmCF0k5u72WnyMY3dxPX2J8INrdHlfbOgp5CwAbXDru+pUE65dEP0=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=PTYD3BdeiKasj9p/65Qh1vCnQKo8NB1Gv0M28P71x98=;
	h=date:mime-version:subject:message-id:from;

+ Finley

在 2026/04/01 星期三 14:13, Daniel Bozeman 写道:
> <fc6f00fa-10b0-44c8-d8b4-694f8ff3b9ea@rock-chips.com>
> 
> I ran additional tests to gather evidence:
> 
> Test 1: Patch 2 only (skip EPROBE_DEFER), no patch 1.
> Result: kernel panic. The idle-only domains register
> successfully, but genpd_power_off_work_fn attempts to power
> them off and crashes in rockchip_pmu_set_idle_request:
> 
>    Internal error: synchronous external abort: 0000000096000010
>    CPU: 0 PID: 59 Comm: kworker/0:3
>    Workqueue: pm genpd_power_off_work_fn
>    pc : regmap_mmio_read32le+0x8/0x20
>    Call trace:
>     regmap_mmio_read32le+0x8/0x20
>     _regmap_bus_reg_read+0x6c/0xac
>     _regmap_read+0x60/0xd8
>     regmap_read+0x4c/0x7c
>     rockchip_pmu_set_idle_request.isra.0+0x94/0x1b4
>     rockchip_pd_power+0x378/0x604
>     rockchip_pd_power_off+0x14/0x34
>     genpd_power_off.isra.0+0x1f0/0x2f0
>     genpd_power_off_work_fn+0x34/0x54
> 
> Test 2: No kernel patches, PD_GPU disabled via
> status = "disabled" in DTS to avoid EPROBE_DEFER entirely.
> Result: same kernel panic. The idle-only domains register
> but crash identically when genpd tries to power them off.
> Same call trace as above.
> 
> So the crash is not caused by probe ordering or
> EPROBE_DEFER -- it happens whenever idle-only domains
> (pwr_mask == 0) are registered and genpd attempts to
> power them off. The QoS register access in
> rockchip_pmu_set_idle_request faults on these domains.
> 
> Regarding S2R: you raise a valid concern about skipping
> QoS save/restore. However, these idle-only domains cannot
> actually be powered off (pwr_mask == 0), so
> rockchip_do_pmu_set_power_domain already returns early for
> them. The QoS save/idle/restore cycle in rockchip_pd_power
> has no effect on these domains since the power state never
> changes -- the save and restore are paired around a no-op.
> Skipping the entire sequence for pwr_mask == 0 should be
> safe for S2R as well.
> 

Thanks for these details but I think it explains the phenomenon
and work around it but didn't explain the root cause.

RK3528 SoC can't power down these PDs but only support to idle them.
Right, idle these PDs could still make QoS registers inaccessable.
But from the code, rockchip_pmu_save_qos() and
rockchip_pmu_restore_qos() both are called under idle-free state.

One possible guess is it's clk related. Could you please help
test your environment with "clk_ignore_unused" set in cmdline?

Another test is to print out genpd->name in the entry of
rockchip_pd_power_on() and rockchip_pd_power_off() to see
which one is inaccessable.



> Both patches are needed:
> - Patch 1: prevents the QoS crash on idle-only domains
> - Patch 2: prevents probe teardown from making things worse
> 
> Tested on NanoPi Zero2 (RK3528) with all four scenarios:
> both patches (boots), patch 2 only (panic), DTS workaround
> (panic), both patches + E20C regression test (no issues).
> 
> The board DTS that triggers this (GPIO-controlled USB VBUS
> regulator on GPIO4/PD_RKVENC) can be seen at:
> https://github.com/dboze/openwrt/blob/add-nanopi-zero2-clean/target/linux/rockchip/patches-6.12/102-arm64-dts-rockchip-Add-FriendlyElec-NanoPi-Zero2.patch
> 
