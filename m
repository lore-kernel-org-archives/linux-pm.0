From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: create link to policy only for registered CPUs
Date: Fri, 9 Sep 2016 16:52:04 +0530
Message-ID: <20160909112204.GE18547@vireshk-i7>
References: <20160819110032.GM1041@n2100.armlinux.org.uk>
 <a0469c333e08b3953bfe9e8356c6919c26578349.1473414746.git.viresh.kumar@linaro.org>
 <20160909111620.GQ1041@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33220 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754043AbcIILWH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Sep 2016 07:22:07 -0400
Received: by mail-pf0-f175.google.com with SMTP id g202so28780924pfb.0
        for <linux-pm@vger.kernel.org>; Fri, 09 Sep 2016 04:22:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20160909111620.GQ1041@n2100.armlinux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 09-09-16, 12:16, Russell King - ARM Linux wrote:
> On Fri, Sep 09, 2016 at 03:24:14PM +0530, Viresh Kumar wrote:
> > If a cpufreq driver is registered very early in the boot stage (e.g.
> > registered from postcore_initcall()), then cpufreq core may generate
> > kernel warnings for it.
> > 
> > In this case, the CPUs are registered as devices with the kernel only
> > after the cpufreq driver is registered, while the CPUs were brought
> > online way before that.
> 
> This seems confusing, maybe:
> 
> "In this case, the CPUs are brought online, then the cpufreq driver is
> registered, and then the CPU topology devices are registered."
> 
> which gives more of a linear A happens, then B, then C.

Sure, thanks for the tip..

> > ... And by the time cpufreq_add_dev() gets called,
> > the cpu device isn't stored in the per-cpu variable (cpu_sys_devices,)
> > which is read by get_cpu_device().
> 
> s/And by/By/ or "However, by"
> 
> > And so cpufreq core fails to get device for the CPU, for which
> > cpufreq_add_dev() was called in the first place and we will hit a
> > WARN_ON(!cpu_dev).
> 
> s/And so/So the/
> 
> This isn't the WARN_ON() statement that's triggering for me.

The WARN_ON() that was triggering for you was already removed by a
patch from Rafael (see below), but with that patch, you would have hit
this WARN_ON() :(.

> > Even if we reuse the 'dev' parameter passed to cpufreq_add_dev() to
> > avoid that warning, there might be other CPUs online that share the
> > policy with the cpu for which cpufreq_add_dev() is called. And
> > eventually get_cpu_device() will return NULL for them as well, and we
> > will hit the same WARN_ON() again.
> 
> s/And eventually/Eventually/

Thanks for all the suggestions..

> > In order to fix these issues, change cpufreq core to create links to the
> > policy for a cpu only when cpufreq_add_dev() is called for that CPU.
> > 
> > Reuse the 'real_cpus' mask to track that as well.
> > 
> > Note that cpufreq_remove_dev() already handles removal of the links for
> > individual CPUs and cpufreq_add_dev() has aligned with that now.
> 
> I applied this patch, but I still get:
> 
> WARNING: CPU: 0 PID: 1 at drivers/cpufreq/cpufreq.c:1040 cpufreq_add_dev+0x144/0x634
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper Not tainted 4.8.0-rc5+ #1061
> Hardware name: Intel-Assabet
> Backtrace:
> [<c0212190>] (dump_backtrace) from [<c021249c>] (show_stack+0x18/0x1c)
>  r6:00000000 r5:c05ca11d r4:00000000
> [<c0212484>] (show_stack) from [<c036e84c>] (dump_stack+0x20/0x28)
> [<c036e82c>] (dump_stack) from [<c021f7ec>] (__warn+0xd0/0xfc)
> [<c021f71c>] (__warn) from [<c021f840>] (warn_slowpath_null+0x28/0x30)
>  r10:00000000 r8:c062927c r7:00000000 r6:00000000 r5:c063d288 r4:00000000
> [<c021f818>] (warn_slowpath_null) from [<c043dc84>] (cpufreq_add_dev+0x144/0x634)
> [<c043db40>] (cpufreq_add_dev) from [<c03dc43c>] (bus_probe_device+0x5c/0x84)
>  r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:c062927c r5:c063d288
>  r4:c0640148
> [<c03dc3e0>] (bus_probe_device) from [<c03da7c4>] (device_add+0x390/0x520)
>  r6:c0629284 r5:00000000 r4:c062927c
> [<c03da434>] (device_add) from [<c03daad8>] (device_register+0x1c/0x20)
>  r10:c061d848 r8:c0603524 r7:00000001 r6:00000000 r5:c062927c r4:c062927c
> [<c03daabc>] (device_register) from [<c03df5e8>] (register_cpu+0x88/0xac)
>  r4:c0629274
> [<c03df560>] (register_cpu) from [<c0603544>] (topology_init+0x20/0x2c)
>  r7:c0646760 r6:c0623568 r5:c061d834 r4:00000000
> [<c0603524>] (topology_init) from [<c020974c>] (do_one_initcall+0xc0/0x178)
>  r4:00000004
> [<c020968c>] (do_one_initcall) from [<c0600e70>] (kernel_init_freeable+0xfc/0x1c4)
>  r10:c061d848 r9:00000000 r8:0000008c r7:c0646760 r6:c0623568 r5:c061d834
>  r4:00000004
> [<c0600d74>] (kernel_init_freeable) from [<c052b6cc>] (kernel_init+0x10/0xf4)
>  r10:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c052b6bc r4:00000000
> [<c052b6bc>] (kernel_init) from [<c020fcf0>] (ret_from_fork+0x14/0x24)
>  r4:00000000
> ---[ end trace d7209ea270f4f585 ]---
> 
> I'm afraid I rather predicted that after reading the patch but before
> running the test: the patch does nothing to solve the original warning,
> as the code path which gets us to that warning remains untouched by
> this patch.
> 
> The code path is:
> 
> static int cpufreq_add_dev(struct device *dev, struct subsys_interface *sif)
> {
>         if (cpu_online(cpu))
>                 return cpufreq_online(cpu);
> 
> static int cpufreq_online(unsigned int cpu)
> {
>         policy = per_cpu(cpufreq_cpu_data, cpu);
>         if (policy) {
>         } else {
>                 new_policy = true;
>                 policy = cpufreq_policy_alloc(cpu);
> 
> static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
> {
>         if (WARN_ON(!dev))
>                 return NULL;
> 
> The only change in your patch that affected this path was this:
> 
> -       if (cpu_online(cpu))
> -               return cpufreq_online(cpu);
> +       if (cpu_online(cpu)) {
> +               ret = cpufreq_online(cpu);
> +               if (ret)
> +                       return ret;
> +       }
> 
> which obviously has no bearing on that WARN_ON() firing.
> 
> Maybe I'm testing the wrong patch.

Thanks for testing it.. You need another patch from Rafael, which
should be in linux-next by now..

commit 3689ad7ed6a8 ("cpufreq: Drop unnecessary check from
cpufreq_policy_alloc()")

Both patches combined will fix the problem you were getting.

-- 
viresh
