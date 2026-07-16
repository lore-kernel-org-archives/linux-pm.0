Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377573DF002
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 08:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784191014; cv=none; b=QpvcR5/JsXODGgR72MfY4Q7zTOb0KBpvf3H4IP/D/REmCeilxE13ycDq11xE8g/g/7uYcZTxEQ9zgV1MDSYJQJMqU/vIeqHnQqf/YQtX5jX/P+T/sce/GY4yXC4fvpvHhF87F3Zwh5u/b4SjrmW5AhWr01BUu82uym/eKfKSPMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784191014; c=relaxed/simple;
	bh=pumjQfqzjMjIeWUjU1QR4ZopC6I8KNIXboQc9mPoVUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=sUh2rtWrU7LTYai7T+X6B9DrlQpKbAJy8lhj3DBHqhTBWoyUaPjLr9b1MawIUxYxUXt0R/P9le6qt8a/x7AKtVkojY2/g1muGN48oXkIYJkn45J9cEfo8rrluek7HkAq/JcmYBWW8i96o3z5ihC4y+IO4dGHzN5TWncjxRzCpv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=s1KabHFQ; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="s1KabHFQ"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260716083650euoutp02fec8617bfa30a6a3b2ce99cb05844eb3~CuEVXJ-w_0297202972euoutp02B
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 08:36:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260716083650euoutp02fec8617bfa30a6a3b2ce99cb05844eb3~CuEVXJ-w_0297202972euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1784191010;
	bh=ffX09h8I+lo5AeIOaMMCJ25NuuXiW3Yt4mD2gsWkhg8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=s1KabHFQTmTVNA/RNFoDetIz4GBvNMDKIgetkpZR2c/qyAOHEDwxN2517DRonNGHq
	 P3JGLOkCLQnxDXy8H1a+0FdFdCAYXecQT4AmToO4wk14+3n820DIYjbodh4ZtWVxNJ
	 mSYvGnSda+n32X0FU19Ffcy8Rr7HfWEYAE4KDlFY=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260716083649eucas1p19c7c3fcbc308967d31fe5931a53c99f0~CuEVCTFz-0044400444eucas1p1g;
	Thu, 16 Jul 2026 08:36:49 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260716083648eusmtip11da6887cbb110a6c7130fd2feac5538e~CuEUA2pcH3025830258eusmtip1d;
	Thu, 16 Jul 2026 08:36:48 +0000 (GMT)
Message-ID: <869727ae-e4b9-419a-98e2-798c1aec5223@samsung.com>
Date: Thu, 16 Jul 2026 10:36:48 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 3/3] arm64: dts: qcom: qcm2290: Hook up MPM
To: "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>, Ulf Hansson
	<ulf.hansson@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@somainline.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <ff6f8e27-5489-4d63-afeb-a38881d717d0@oss.qualcomm.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260716083649eucas1p19c7c3fcbc308967d31fe5931a53c99f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260709114143eucas1p18463122323bdeae8e63b1d13cd626b55
X-EPHeader: CA
X-CMS-RootMailID: 20260709114143eucas1p18463122323bdeae8e63b1d13cd626b55
References: <20231215-topic-mpm_dt-v1-0-c6636fc75ce3@linaro.org>
	<CGME20260709114143eucas1p18463122323bdeae8e63b1d13cd626b55@eucas1p1.samsung.com>
	<20231215-topic-mpm_dt-v1-3-c6636fc75ce3@linaro.org>
	<dadff7a9-bf04-49fb-8c55-5605e99be7fc@samsung.com>
	<CAPx+jO9d1qH12mxg-n1rkbp6Xd__sdrSMeoc7CPELE+jgxRYHA@mail.gmail.com>
	<e83dffd9-e54f-45a8-b997-e84b5beead71@oss.qualcomm.com>
	<b434e198-2778-4dd6-8896-f7f54bc9b8e2@samsung.com>
	<ff6f8e27-5489-4d63-afeb-a38881d717d0@oss.qualcomm.com>

On 15.07.2026 14:37, Maulik Shah (mkshah) wrote:
> On 7/15/2026 11:44 AM, Marek Szyprowski wrote:
>> On 14.07.2026 15:29, Maulik Shah (mkshah) wrote:
>>> On 7/14/2026 6:34 PM, Ulf Hansson wrote:
>>>> On Thu, Jul 9, 2026 at 1:41 PM Marek Szyprowski
>>>> <m.szyprowski@samsung.com> wrote:
>>> [...]
>>>
>>>> Without detailed HW expertise (still learning about the UnoQ), it
>>>> looks to me that the HW may have been modelled upside down.
>>>>
>>>> The power-domain-cpu-cluster should probably *not* be the consumer of
>>>> the mpm, but rather the opposite. This is how qcom,rpmh-rsc works, for
>>>> example.
>>> Agree, There is a series [1] sent out to fix modeling similar to how rpmh-rsc works.
>>>
>>> [1] https://lore.kernel.org/lkml/20260713-b4-shikra_lpm_addition-v1-0-3d858df2cbbf@oss.qualcomm.com/
>> Indeed that series fixes the modelling issue, but it doesn't change much
>> from the spinlock vs. raw_spinlock perspective. There is still the
>> 'invalid wait context' issue there, because mbox API cannot be properly
>> called from cpu_pm_notifier (which use raw_notifier internally):
> Okay, i see why series [1] did not help for agatti due to fallback on CPU PM notification.
>
> On PREEMPT_RT kernel, GENPD is marked as always RPM always on,
> So MPM driver never get the .power_off callback it registered for and hence MPM irqchip won't invoke mbox_() APIs.
>
> from drivers/cpuidle/cpuidle-psci-domain.c,
>
>         /*
>          * On a PREEMPT_RT based configuration the domain idle states are
>          * supported, but only during system-wide suspend.
>          */
>             if (IS_ENABLED(CONFIG_PREEMPT_RT))
>                         pd->flags |= GENPD_FLAG_RPM_ALWAYS_ON;
>
> The series [1] fallbacks to CPU_PM based notification if "power-domains" property is not added.
> having a power-domains property would have avoided the BUG for agatti on RT kernel.
>
> Agatti device tree change in the series [2] only removed power-domain-cells# but did not add power-domains = <&cluster_pd>;
> with the reason that qrb2210-rb1.dts had deleted "cluster_pd" however qrb2210-arduino-imola.dts still have it.
>
> so below change on top of [1] series would avoid the BUG from mpm_cpu_pm_callback().

This change moves the 'invalid wait context' warning from boot time to system suspend/resume path (although the system suspend/resume is and was broken on UnoQ at least with current next with and without the patchset from this thread):

root@target:~# time rtcwake -s5 -mmem
rtcwake: assuming RTC uses UTC ...
rtcwake: wakeup from "mem" using /dev/rtc0 at Thu Jan  1 00:03:11 1970
[  146.369961] PM: suspend entry (deep)
[  146.400523] Filesystems sync: 0.021 seconds
[  146.441862] Freezing user space processes
[  146.457851] Freezing user space processes completed (elapsed 0.011 seconds)
[  146.465487] OOM killer disabled.
[  146.468880] Freezing remaining freezable tasks
[  146.478491] Freezing remaining freezable tasks completed (elapsed 0.004 seconds)
[  146.486154] printk: Suspending console(s) (use no_console_suspend to debug)
[  146.782051] dwc3-qcom-legacy 4ef8800.usb: port-1 HS-PHY not in L2
[  146.859869] Disabling non-boot CPUs ...
[  146.912706] IRQ95: set affinity failed(-22).
[  146.912818] IRQ96: set affinity failed(-22).
[  146.913155] IRQ150: set affinity failed(-22).
[  146.918079] psci: CPU3 killed (polled 0 ms)
[  146.948827] IRQ95: set affinity failed(-22).
[  146.948896] IRQ96: set affinity failed(-22).
[  146.949230] IRQ150: set affinity failed(-22).
[  146.949685] psci: CPU2 killed (polled 0 ms)
[  146.982811] IRQ95: set affinity failed(-22).
[  146.982878] IRQ96: set affinity failed(-22).
[  146.983213] IRQ150: set affinity failed(-22).
[  146.984074] psci: CPU1 killed (polled 4 ms)
[  146.990260]  
[  146.990295] =============================
[  146.990299] [ BUG: Invalid wait context ]
[  146.990308] 7.2.0-rc3-next-20260714+ #16842 Not tainted
[  146.990318] -----------------------------
[  146.990321] rtcwake/673 is trying to lock:
[  146.990332] ffff0000008ac408 (&chan->lock){....}-{3:3}, at: mbox_send_message+0x3c/0x15c
[  146.990391] other info that might help us debug this:
[  146.990395] context-{5:5}
[  146.990399] locks held by rtcwake/673: 6, last CPU#0:
[  146.990404]  #0: ffff0000099a2438 (sb_writers#5){.+.+}-{0:0}, at: vfs_write+0x2dc/0x370
[  146.990432]  #1: ffff000016009280 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_fop_write_iter+0xf0/0x1c0
[  146.990462]  #2: ffff000000995f28 (kn->active#97){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x100/0x1c0
[  146.990481]  #3: ffffd083befc03f0 (system_transition_mutex){+.+.}-{4:4}, at: pm_suspend+0x200/0x370
[  146.990507]  #4: ffff00000036af50 (&genpd->raw_slock){....}-{2:2}, at: genpd_lock_raw_spin+0x1c/0x30
[  146.990534]  #5: ffff00000036a750 (&genpd->raw_slock/1){....}-{2:2}, at: genpd_lock_nested_raw_spin+0x1c/0x30
[  146.990557] stack backtrace:
[  146.990568] CPU: 0 UID: 0 PID: 673 Comm: rtcwake Not tainted 7.2.0-rc3-next-20260714+ #16842 PREEMPT  
[  146.990576] Hardware name: Arduino UnoQ (DT)
[  146.990582] Call trace:
[  146.990587]  show_stack+0x18/0x24 (C)
[  146.990600]  dump_stack_lvl+0x8c/0xcc
[  146.990615]  dump_stack+0x18/0x24
[  146.990622]  __lock_acquire+0x928/0x1f90
[  146.990635]  lock_acquire+0x2b8/0x3ec
[  146.990642]  _raw_spin_lock_irqsave+0x60/0x88
[  146.990656]  mbox_send_message+0x3c/0x15c
[  146.990664]  handle_rpm_notification+0x58/0x114
[  146.990678]  mpm_pd_power_cb+0x20/0x3c
[  146.990686]  notifier_call_chain+0xa0/0x234
[  146.990701]  raw_notifier_call_chain_robust+0x48/0xa8
[  146.990708]  _genpd_power_off+0x38/0x154
[  146.990714]  genpd_sync_power_off.part.0+0xa4/0x240
[  146.990723]  genpd_sync_power_off.part.0+0x224/0x240
[  146.990729]  genpd_switch_state+0x130/0x138
[  146.990739]  dev_pm_genpd_suspend+0x14/0x20
[  146.990747]  psci_idle_syscore_switch+0x118/0x120
[  146.990759]  psci_idle_syscore_suspend+0x14/0x24
[  146.990765]  syscore_suspend+0x74/0x1b8
[  146.990778]  suspend_devices_and_enter+0x1f4/0x7fc
[  146.990786]  pm_suspend+0x274/0x370
[  146.990792]  state_store+0x80/0x104
[  146.990798]  kobj_attr_store+0x18/0x2c
[  146.990809]  sysfs_kf_write+0x50/0x7c
[  146.990816]  kernfs_fop_write_iter+0x130/0x1c0
[  146.990822]  vfs_write+0x240/0x370
[  146.990828]  ksys_write+0x70/0x108
[  146.990835]  __arm64_sys_write+0x1c/0x28
[  146.990841]  invoke_syscall+0x54/0x10c
[  146.990849]  el0_svc_common.constprop.0+0x40/0xe0
[  146.990856]  do_el0_svc+0x1c/0x28
[  146.990861]  el0_svc+0x54/0x3a0
[  146.990867]  el0t_64_sync_handler+0xa0/0xe4
[  146.990872]  el0t_64_sync+0x198/0x19c
[  146.991113] Enabling non-boot CPUs ...
[  146.992161] Detected VIPT I-cache on CPU1
[  146.992262] GICv3: CPU1: found redistributor 1 region 0:0x000000000f320000
[  146.992407] CPU1: Booted secondary processor 0x0000000001 [0x51af8014]
[  146.995104] CPU1 is up
[  146.996182] Detected VIPT I-cache on CPU2
[  146.996282] GICv3: CPU2: found redistributor 2 region 0:0x000000000f340000
[  146.996425] CPU2: Booted secondary processor 0x0000000002 [0x51af8014]
[  146.998746] CPU2 is up
[  146.999673] Detected VIPT I-cache on CPU3
[  146.999760] GICv3: CPU3: found redistributor 3 region 0:0x000000000f360000
[  146.999893] CPU3: Booted secondary processor 0x0000000003 [0x51af8014]
[  147.002366] CPU3 is up
[  147.949024] OOM killer enabled.
[  147.952218] Restarting tasks: Starting
[  147.960927] Restarting tasks: Done
[  147.964583] random: crng reseeded on system resumption
[  147.976461] PM: suspend exit
rtcwake: write error

real    0m1.679s
user    0m0.000s
sys     0m0.688s


>
> --- a/arch/arm64/boot/dts/qcom/agatti.dtsi
> +++ b/arch/arm64/boot/dts/qcom/agatti.dtsi
> @@ -281,6 +281,7 @@ mpm: interrupt-controller {
>                         interrupt-controller;
>                         #interrupt-cells = <2>;
>                         interrupt-parent = <&intc>;
> +                       power-domains = <&cluster_pd>;
>                         qcom,mpm-pin-count = <96>;
>                         qcom,mpm-pin-map = <2 275>,  /* TSENS0 uplow */
>                                            <5 296>,  /* Soundwire master_irq */
> diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> index bf6fb12ad990..7dc2cade0a7f 100644
> --- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> +++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
> @@ -246,6 +246,10 @@ &cpu_pd3 {
>
>  /delete-node/ &cluster_pd;
>
> +&mpm {
> +       /delete-property/ power-domains;
> +};
> +
>
> [2] https://lore.kernel.org/linux-arm-msm/20260713-b4-shikra_lpm_addition-v1-0-3d858df2cbbf@oss.qualcomm.com/T/#m5bbdb535424c38209cc08e6afeae5e3aac9f6cc0
>
> Thanks,
> Maulik
>
>> =============================
>> [ BUG: Invalid wait context ]
>> 7.2.0-rc3-next-20260714+ #16842 Not tainted
>> -----------------------------
>> swapper/3/0 is trying to lock:
>> ffff0000008ac408 (&chan->lock){....}-{3:3}, at: mbox_send_message+0x3c/0x15c
>> other info that might help us debug this:
>> context-{5:5}
>> locks held by swapper/3/0: 1, last CPU#3:
>>  #0: ffffd99263a61228 (cpu_pm_notifier.lock){....}-{2:2}, at: cpu_pm_enter+0x28/0x78
>> stack backtrace:
>> CPU: 3 UID: 0 PID: 0 Comm: swapper/3 Not tainted 7.2.0-rc3-next-20260714+ #16842 PREEMPT
>> Hardware name: Arduino UnoQ (DT)
>> Call trace:
>>  show_stack+0x18/0x24 (C)
>>  dump_stack_lvl+0x8c/0xcc
>>  dump_stack+0x18/0x24
>>  __lock_acquire+0x928/0x1f90
>>  lock_acquire+0x2b8/0x3ec
>>  _raw_spin_lock_irqsave+0x60/0x88
>>  mbox_send_message+0x3c/0x15c
>>  handle_rpm_notification+0x58/0x114
>>  mpm_cpu_pm_callback+0x9c/0xdc
>>  notifier_call_chain+0xa0/0x234
>>  raw_notifier_call_chain_robust+0x48/0xa8
>>  cpu_pm_enter+0x40/0x78
>>  __psci_enter_domain_idle_state.isra.0+0x48/0x470
>>  psci_enter_domain_idle_state+0x18/0x24
>>  cpuidle_enter_state+0xbc/0x428
>>  cpuidle_enter+0x38/0x50
>>  do_idle+0x158/0x324
>>  cpu_startup_entry+0x38/0x3c
>>  secondary_start_kernel+0x138/0x158
>>  __secondary_switched+0xc0/0xc4
>>
>> Best regards
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

