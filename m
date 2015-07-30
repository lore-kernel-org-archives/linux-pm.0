From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] thermal: remove dangling 'weight_attr' device file
Date: Thu, 30 Jul 2015 11:44:38 +0530
Message-ID: <20150730061438.GA31351@linux>
References: <874682c7b1ab8b0fcc2abc905c71bc2bc041aaeb.1437642037.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:35138 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216AbbG3GOp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2015 02:14:45 -0400
Received: by pabkd10 with SMTP id kd10so18004931pab.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2015 23:14:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <874682c7b1ab8b0fcc2abc905c71bc2bc041aaeb.1437642037.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, javi.merino@arm.com, open list <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>

On 23-07-15, 14:32, Viresh Kumar wrote:
> This file isn't getting removed while we unbind a device from thermal
> zone. And this causes following messages when the device is registered
> again:
> 
> WARNING: CPU: 0 PID: 2228 at /home/viresh/linux/fs/sysfs/dir.c:31 sysfs_warn_dup+0x60/0x70()
> sysfs: cannot create duplicate filename '/devices/virtual/thermal/thermal_zone0/cdev0_weight'
> Modules linked in: cpufreq_dt(+) [last unloaded: cpufreq_dt]
> CPU: 0 PID: 2228 Comm: insmod Not tainted 4.2.0-rc3-00059-g44fffd9473eb #272
> Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> [<c00153e8>] (unwind_backtrace) from [<c0012368>] (show_stack+0x10/0x14)
> [<c0012368>] (show_stack) from [<c053a684>] (dump_stack+0x84/0xc4)
> [<c053a684>] (dump_stack) from [<c002284c>] (warn_slowpath_common+0x80/0xb0)
> [<c002284c>] (warn_slowpath_common) from [<c00228ac>] (warn_slowpath_fmt+0x30/0x40)
> [<c00228ac>] (warn_slowpath_fmt) from [<c012d524>] (sysfs_warn_dup+0x60/0x70)
> [<c012d524>] (sysfs_warn_dup) from [<c012d244>] (sysfs_add_file_mode_ns+0x13c/0x190)
> [<c012d244>] (sysfs_add_file_mode_ns) from [<c012d2d4>] (sysfs_create_file_ns+0x3c/0x48)
> [<c012d2d4>] (sysfs_create_file_ns) from [<c03c04a8>] (thermal_zone_bind_cooling_device+0x260/0x358)
> [<c03c04a8>] (thermal_zone_bind_cooling_device) from [<c03c2e70>] (of_thermal_bind+0x88/0xb4)
> [<c03c2e70>] (of_thermal_bind) from [<c03c10d0>] (__thermal_cooling_device_register+0x17c/0x2e0)
> [<c03c10d0>] (__thermal_cooling_device_register) from [<c03c3f50>] (__cpufreq_cooling_register+0x3a0/0x51c)
> [<c03c3f50>] (__cpufreq_cooling_register) from [<bf00505c>] (cpufreq_ready+0x44/0x88 [cpufreq_dt])
> [<bf00505c>] (cpufreq_ready [cpufreq_dt]) from [<c03d6c30>] (cpufreq_add_dev+0x4a0/0x7dc)
> [<c03d6c30>] (cpufreq_add_dev) from [<c02cd3ec>] (subsys_interface_register+0x94/0xd8)
> [<c02cd3ec>] (subsys_interface_register) from [<c03d785c>] (cpufreq_register_driver+0x10c/0x1f0)
> [<c03d785c>] (cpufreq_register_driver) from [<bf0057d4>] (dt_cpufreq_probe+0x60/0x8c [cpufreq_dt])
> [<bf0057d4>] (dt_cpufreq_probe [cpufreq_dt]) from [<c02d03e4>] (platform_drv_probe+0x44/0xa4)
> [<c02d03e4>] (platform_drv_probe) from [<c02cead8>] (driver_probe_device+0x174/0x2b4)
> [<c02cead8>] (driver_probe_device) from [<c02ceca4>] (__driver_attach+0x8c/0x90)
> [<c02ceca4>] (__driver_attach) from [<c02cd078>] (bus_for_each_dev+0x68/0x9c)
> [<c02cd078>] (bus_for_each_dev) from [<c02ce2f0>] (bus_add_driver+0x19c/0x214)
> [<c02ce2f0>] (bus_add_driver) from [<c02cf490>] (driver_register+0x78/0xf8)
> [<c02cf490>] (driver_register) from [<c0009710>] (do_one_initcall+0x8c/0x1d4)
> [<c0009710>] (do_one_initcall) from [<c05396b0>] (do_init_module+0x5c/0x1b8)
> [<c05396b0>] (do_init_module) from [<c0086490>] (load_module+0xd34/0xed8)
> [<c0086490>] (load_module) from [<c0086704>] (SyS_init_module+0xd0/0x120)
> [<c0086704>] (SyS_init_module) from [<c000f480>] (ret_fast_syscall+0x0/0x3c)
> ---[ end trace 3be0e7b7dc6e3c4f ]---
> 
> Fixes: db91651311c8 ("thermal: export weight to sysfs")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/thermal/thermal_core.c | 1 +
>  1 file changed, 1 insertion(+)

Hi Eduardo,

Not sure if you are on leaves right now, but this is an rc fix. Can
you please apply that ?

-- 
viresh
