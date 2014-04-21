From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: cpufreq framework questions.
Date: Mon, 21 Apr 2014 11:18:26 +0530
Message-ID: <CAKohpokPfD70+zVgYqU3safWe9mUdzcyQnZT8x5+x2vgdwdVOw@mail.gmail.com>
References: <4737A960563B524DA805CA602BE04B30724FDD3FF9@SC-VEXCH2.marvell.com>
	<CAKohpo=yc_xRx2+Rp+1Y3U+wPSEzETYa6RKuQmM5dz7hp1hh3w@mail.gmail.com>
	<4737A960563B524DA805CA602BE04B30724FDD4367@SC-VEXCH2.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:60138 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbaDUFs0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Apr 2014 01:48:26 -0400
Received: by mail-ob0-f179.google.com with SMTP id vb8so1427138obc.24
        for <linux-pm@vger.kernel.org>; Sun, 20 Apr 2014 22:48:26 -0700 (PDT)
In-Reply-To: <4737A960563B524DA805CA602BE04B30724FDD4367@SC-VEXCH2.marvell.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yipeng Yao <ypyao@marvell.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>

Just for my knowledge, what's your systems configuration?
- 4 ARM Processors
- All sharing a single clock line ? i.e. a single cluster?

On 21 April 2014 10:58, Yipeng Yao <ypyao@marvell.com> wrote:
> Hi Viresh,
> Thank you for your reply and here is the kernel warning about sysfs node error:
> ------------------------------------------------------------------
> [   91.995795] c1 3458 (power_s_devfreq) CPU3: shutdown
> sh: can't create /sys/devices/system/cpu/cpufreq/conservative/up_threshold: No s
> uch file or directory
> sh: can't create /sys/devices/system/cpu/cpufreq/conservative/down_threshold: No
>  such file or directory

You are probably playing between ondemand and conservative governors
here and you script tried to print for a governor which doesn't exist anymore?

> [   92.023903] c1 3458 (power_s_devfreq) CPU2: shutdown
> [   92.059310] c0 3458 (power_s_devfreq) cpufreq: __cpufreq_remove_dev: Failed t
> o stop governor
> sh: write error: Invalid argument
> sh: write error: Invalid argument
> sh: write error: Invalid argument
> sh: write error: Invalid argument

Dont' know why these came.

> sh: write error: Invalid argumen[   92.081525] c0 3458 (power_s_devfreq) CPU1: s
> hutdown
> t
> sh: write error: Invalid argument
> [   92.154168] c1 3458 (power_s_devfreq) ------------[ cut here ]------------
> [   92.164749] c1 3458 (power_s_devfreq) WARNING: at fs/sysfs/dir.c:530 sysfs_ad
> d_one+0xac/0xd0()
> [   92.173543] c1 3458 (power_s_devfreq) sysfs: cannot create duplicate filename
>  '/devices/system/cpu/cpu1/cpufreq'
> [   92.183796] Modules linked in: runcase_sysfs(O) audiostub cidatattydev gs_mod
> em ccinetdev cci_datastub citty iml_module seh cploaddev msocketk galcore(O)
> [   92.200246] c1 3458 (power_s_devfreq) CPU: 1 PID: 3458 Comm: power_s_devfreq
> Tainted: G           O 3.10.33 #59
> [   92.210649] c1 3458 (power_s_devfreq) Call trace:
> [   92.215585] c1 3458 (power_s_devfreq) [<ffffffc000087e50>] dump_backtrace+0x0
> /0x16c
> [   92.223299] c1 3458 (power_s_devfreq) [<ffffffc000087fcc>] show_stack+0x10/0x
> 1c
> [   92.231907] c1 3458 (power_s_devfreq) [<ffffffc00075e9e4>] dump_stack+0x1c/0x
> 28
> [   92.239373] c1 3458 (power_s_devfreq) [<ffffffc00009b718>] warn_slowpath_comm
> on+0x74/0x9c
> [   92.247700] c1 3458 (power_s_devfreq) [<ffffffc00009b804>] warn_slowpath_fmt+
> 0x4c/0x58
> [   92.255828] c1 3458 (power_s_devfreq) [<ffffffc0001fa21c>] sysfs_add_one+0xa8
> /0xd0
> [   92.263515] c1 3458 (power_s_devfreq) [<ffffffc0001fae18>] sysfs_do_create_li
> nk_sd+0xa8/0x240
> [   92.272189] c1 3458 (power_s_devfreq) [<ffffffc0001fafc8>] sysfs_create_link+
> 0x18/0x38
> [   92.280271] c1 3458 (power_s_devfreq) [<ffffffc000472388>] cpufreq_add_dev+0x
> 200/0x5b4
> [   92.288339] c1 3458 (power_s_devfreq) [<ffffffc00075a0c0>] cpufreq_cpu_callba
> ck+0x64/0x94
> [   92.297437] c1 3458 (power_s_devfreq) [<ffffffc0000caa44>] notifier_call_chai
> n+0x44/0x88
> [   92.305693] c1 3458 (power_s_devfreq) [<ffffffc0000cab2c>] __raw_notifier_cal
> l_chain+0x8/0x14
> [   92.314253] c1 3458 (power_s_devfreq) [<ffffffc00009f400>] __cpu_notify+0x2c/
> 0x58
> [   92.321894] c1 3458 (power_s_devfreq) [<ffffffc00009f43c>] cpu_notify+0x10/0x
> 1c
> [   92.329358] c1 3458 (power_s_devfreq) [<ffffffc00009f714>] _cpu_up+0x118/0x19
> 8
> [   92.336710] c1 3458 (power_s_devfreq) [<ffffffc00009f840>] cpu_up+0x68/0x88
> [   92.343710] c1 3458 (power_s_devfreq) [<ffffffc000757fcc>] store_online+0x64/
> 0xa4
> [   92.351435] c1 3458 (power_s_devfreq) [<ffffffc00035e990>] dev_attr_store+0x1
> 4/0x28
> [   92.359235] c1 3458 (power_s_devfreq) [<ffffffc0001f8d64>] sysfs_write_file+0
> xd4/0x150
> [   92.367273] c1 3458 (power_s_devfreq) [<ffffffc000194a44>] vfs_write+0xa8/0x1
> a4
> [   92.374616] c1 3458 (power_s_devfreq) [<ffffffc000194e74>] SyS_write+0x40/0x8
> c
> [   92.381968] c1 3458 (power_s_devfreq) ---[ end trace 591e205773234268 ]---

This must be fixed in upstream kernel.. Don't remember which commit
did it as there
were lots of patches around these lines.
