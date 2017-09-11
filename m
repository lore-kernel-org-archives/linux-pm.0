From: Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [1/2] cpufreq: dt-platdev: Automatically create cpufreq device
 with OPP v2
Date: Mon, 11 Sep 2017 09:18:46 -0500
Message-ID: <7c607393-2a3d-1e5e-7b54-3745cee416e3@ti.com>
References: <20170821131332.GA14662@verge.net.au>
 <20170821131735.GB14662@verge.net.au> <20170829101146.GF3101@ubuntu>
 <9f37e244-7c6d-d556-ee7c-a5f3c9d5f756@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:27340 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbdIKOTk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Sep 2017 10:19:40 -0400
In-Reply-To: <9f37e244-7c6d-d556-ee7c-a5f3c9d5f756@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>, Viresh Kumar <viresh.kumar@linaro.org>, Simon Horman <horms@verge.net.au>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, geert@linux-m68k.org, maxime.ripard@free-electrons.com, wens@csie.org, xuwei5@hisilicon.com, kgene@kernel.org, krzk@kernel.org, yamada.masahiro@socionext.com, jun.nie@linaro.org, baoyou.xie@linaro.org, linux-kernel@vger.kernel.org

Hi,
On 09/11/2017 07:13 AM, Keerthy wrote:
> 
> 
> On Tuesday 29 August 2017 03:41 PM, Viresh Kumar wrote:
>> On 21-08-17, 15:17, Simon Horman wrote:
>>> Sorry, I seem to have accidently sent this email as Virish rather than
>>> myself. I will try again.
>>
>> No issues. I see that Rafael has already applied my patches, you can send
>> additional patches over that to make sure everything is clear.
> 
> Viresh,
> 
> I see below warning with this patch on am57xx-beagle
> 
> [    3.545247] WARNING: CPU: 1 PID: 1 at fs/sysfs/dir.c:31
> sysfs_warn_dup+0x58/0x78
> [    3.553099] sysfs: cannot create duplicate filename
> '/devices/platform/cpufreq-dt'
> [    3.561126] Modules linked in:
> [    3.564402] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W
> 4.13.0-next-20170911-12690-ga31cc45-dirty #7
> [    3.575071] Hardware name: Generic DRA74X (Flattened Device Tree)
> [    3.581484] [<c0110a88>] (unwind_backtrace) from [<c010cae4>]
> (show_stack+0x10/0x14)
> [    3.589620] [<c010cae4>] (show_stack) from [<c0828184>]
> (dump_stack+0xac/0xe0)
> [    3.597209] [<c0828184>] (dump_stack) from [<c01374d0>]
> (__warn+0xd8/0x104)
> [    3.604532] [<c01374d0>] (__warn) from [<c0137530>]
> (warn_slowpath_fmt+0x34/0x44)
> [    3.612390] [<c0137530>] (warn_slowpath_fmt) from [<c0345b30>]
> (sysfs_warn_dup+0x58/0x78)
> [    3.620988] [<c0345b30>] (sysfs_warn_dup) from [<c0345c18>]
> (sysfs_create_dir_ns+0x80/0x98)
> [    3.629773] [<c0345c18>] (sysfs_create_dir_ns) from [<c082c974>]
> (kobject_add_internal+0x9c/0x2d4)
> [    3.639177] [<c082c974>] (kobject_add_internal) from [<c082cbf8>]
> (kobject_add+0x4c/0x9c)
> [    3.647764] [<c082cbf8>] (kobject_add) from [<c05805a8>]
> (device_add+0xcc/0x57c)
> [    3.655542] [<c05805a8>] (device_add) from [<c0584d38>]
> (platform_device_add+0x100/0x220)
> [    3.664138] [<c0584d38>] (platform_device_add) from [<c058576c>]
> (platform_device_register_full+0xf4/0x118)
> [    3.674378] [<c058576c>] (platform_device_register_full) from
> [<c0670514>] (ti_cpufreq_init+0x150/0x22c)
> [    3.684326] [<c0670514>] (ti_cpufreq_init) from [<c0101df4>]
> (do_one_initcall+0x3c/0x170)
> [    3.692916] [<c0101df4>] (do_one_initcall) from [<c0c00eb4>]
> (kernel_init_freeable+0x1fc/0x2c4)
> [    3.702049] [<c0c00eb4>] (kernel_init_freeable) from [<c083c0cc>]
> (kernel_init+0x8/0x110)
> [    3.710639] [<c083c0cc>] (kernel_init) from [<c0107d78>]
> (ret_from_fork+0x14/0x3c)
> [    3.718680] ---[ end trace 33482508cbb50156 ]---
> [    3.720850] ata1: SATA link down (SStatus 0 SControl 300)
> [    3.729278] ------------[ cut here ]------------
> [    3.734147] WARNING: CPU: 1 PID: 1 at lib/kobject.c:240
> kobject_add_internal+0x254/0x2d4
> [    3.742709] kobject_add_internal failed for cpufreq-dt with -EEXIST,
> don't try to register things with the same name in the same directory.
> [    3.755900] Modules linked in:
> [    3.759239] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W
> 4.13.0-next-20170911-12690-ga31cc45-dirty #7
> [    3.769907] Hardware name: Generic DRA74X (Flattened Device Tree)
> [    3.776321] [<c0110a88>] (unwind_backtrace) from [<c010cae4>]
> (show_stack+0x10/0x14)
> [    3.784454] [<c010cae4>] (show_stack) from [<c0828184>]
> (dump_stack+0xac/0xe0)
> [    3.792043] [<c0828184>] (dump_stack) from [<c01374d0>]
> (__warn+0xd8/0x104)
> [    3.799364] [<c01374d0>] (__warn) from [<c0137530>]
> (warn_slowpath_fmt+0x34/0x44)
> [    3.807227] [<c0137530>] (warn_slowpath_fmt) from [<c082cb2c>]
> (kobject_add_internal+0x254/0x2d4)
> [    3.816552] [<c082cb2c>] (kobject_add_internal) from [<c082cbf8>]
> (kobject_add+0x4c/0x9c)
> [    3.825139] [<c082cbf8>] (kobject_add) from [<c05805a8>]
> (device_add+0xcc/0x57c)
> [    3.832913] [<c05805a8>] (device_add) from [<c0584d38>]
> (platform_device_add+0x100/0x220)
> [    3.841504] [<c0584d38>] (platform_device_add) from [<c058576c>]
> (platform_device_register_full+0xf4/0x118)
> [    3.851729] [<c058576c>] (platform_device_register_full) from
> [<c0670514>] (ti_cpufreq_init+0x150/0x22c)
> [    3.861686] [<c0670514>] (ti_cpufreq_init) from [<c0101df4>]
> (do_one_initcall+0x3c/0x170)
> [    3.870273] [<c0101df4>] (do_one_initcall) from [<c0c00eb4>]
> (kernel_init_freeable+0x1fc/0x2c4)
> [    3.879412] [<c0c00eb4>] (kernel_init_freeable) from [<c083c0cc>]
> (kernel_init+0x8/0x110)
> [    3.888002] [<c083c0cc>] (kernel_init) from [<c0107d78>]
> (ret_from_fork+0x14/0x3c)
> [    3.896035] ---[ end trace 33482508cbb50157 ]---
> 
> I believe in two places platform_device_register_* calls are made with
> the same name 'cpufreq-dt'
> 
> First place is: cpufreq_dt_platdev_init and the other i believe is
> ti_cpufreq_init.
> 
> Dave,
> 
> Should the ti-cpufreq driver also be calling
> platform_device_register_simple?

Yes, ti-cpufreq registers the cpufreq-dt platdev in order to ensure the
ti-cpufreq driver probes first and provides the necessary opp-supported-hw for
cpufreq-dt. This applies to am335x, am437x, dra7xx, and am57xx. I suppose these
platforms will need to be added to the 'blacklist' to prevent the cpufreq-dt
platdev from being created automatically, unless there is a better way to handle
this dependency...

Regards,
Dave

> 
> Regards,
> Keerthy
> 
>>
