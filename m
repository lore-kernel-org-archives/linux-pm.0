From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Kernel warning in cpufreq_add_dev()
Date: Mon, 22 Aug 2016 19:32:21 +0200
Message-ID: <2310664.2BksGViL4r@vostro.rjw.lan>
References: <20160819110032.GM1041@n2100.armlinux.org.uk> <1601399.OxUAWWKTJN@vostro.rjw.lan> <20160820014634.GA25143@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:64837 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1751774AbcHVR0o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Aug 2016 13:26:44 -0400
In-Reply-To: <20160820014634.GA25143@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Saturday, August 20, 2016 07:16:34 AM Viresh Kumar wrote:
> On 20-08-16, 03:29, Rafael J. Wysocki wrote:
> > On Friday, August 19, 2016 12:00:32 PM Russell King - ARM Linux wrote:
> > > While checking the kernel on SA1110 Assabet, CPUFREQ issues a warning:
> > > 
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 0 PID: 1 at /home/rmk/git/linux-rmk/drivers/cpufreq/cpufreq.c:1080 cpufreq_add_dev+0x140/0x62c
> > > Modules linked in:
> > > CPU: 0 PID: 1 Comm: swapper Not tainted 4.8.0-rc2+ #883
> > > Hardware name: Intel-Assabet
> > > Backtrace:
> > > [<c0212190>] (dump_backtrace) from [<c021249c>] (show_stack+0x18/0x1c)
> > >  r6:00000000 r5:c05e87c3 r4:00000000
> > > [<c0212484>] (show_stack) from [<c037260c>] (dump_stack+0x20/0x28)
> > > [<c03725ec>] (dump_stack) from [<c021f4cc>] (__warn+0xd0/0xfc)
> > > [<c021f3fc>] (__warn) from [<c021f520>] (warn_slowpath_null+0x28/0x30)
> > >  r10:00000000 r8:00000000 r7:00000000 r6:c064525c r5:00000000 r4:00000000
> > > [<c021f4f8>] (warn_slowpath_null) from [<c04343a8>] (cpufreq_add_dev+0x140/0x62c)
> > > [<c0434268>] (cpufreq_add_dev) from [<c03d83f4>] (bus_probe_device+0x5c/0x84)
> > >  r10:00000000 r8:00000000 r7:00000000 r6:c064525c r5:c0657d60 r4:c065a9f8
> > > [<c03d8398>] (bus_probe_device) from [<c03d677c>] (device_add+0x390/0x520)
> > >  r6:c0645264 r5:00000000 r4:c064525c
> > > [<c03d63ec>] (device_add) from [<c03d6a90>] (device_register+0x1c/0x20)
> > >  r10:c0639848 r8:c061e524 r7:00000001 r6:00000000 r5:c064525c r4:c064525c
> > > [<c03d6a74>] (device_register) from [<c03db5a0>] (register_cpu+0x88/0xac)
> > >  r4:c0645254
> > > [<c03db518>] (register_cpu) from [<c061e544>] (topology_init+0x20/0x2c)
> > >  r7:c0660b20 r6:c063f4a0 r5:c0639834 r4:00000000
> > > [<c061e524>] (topology_init) from [<c020974c>] (do_one_initcall+0xc0/0x178)
> > >  r4:00000004
> > > [<c020968c>] (do_one_initcall) from [<c061be70>] (kernel_init_freeable+0xfc/0x1c4)
> > >  r10:c0639848 r9:00000000 r8:00000088 r7:c0660b20 r6:c063f4a0 r5:c0639834
> > >  r4:00000004
> > > [<c061bd74>] (kernel_init_freeable) from [<c050d730>] (kernel_init+0x10/0xf4)
> > >  r10:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c050d720 r4:00000000
> > > [<c050d720>] (kernel_init) from [<c020fcf0>] (ret_from_fork+0x14/0x24)
> > >  r4:00000000
> > > ---[ end trace df94656649275917 ]---
> > > 
> > > This is because of an incompatibility between the expectations of cpufreq
> > > and how register_cpu() works:
> > > 
> > > int register_cpu(struct cpu *cpu, int num)
> > > {
> > > ...
> > >         error = device_register(&cpu->dev);
> > >         if (!error)
> > >                 per_cpu(cpu_sys_devices, num) = &cpu->dev;
> > > 
> > > When the device is registered via device_register(), any subsystems
> > > registered for the cpu_subsys will have their "add_dev" method called.
> > > 
> > > The cpufreq add_dev, via cpufreq_online() and cpufreq_policy_alloc(),
> > > tries to get the CPU device:
> > > 
> > > static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
> > > {
> > >         struct device *dev = get_cpu_device(cpu);
> > >         if (WARN_ON(!dev))
> > >                 return NULL;
> > > 
> > > but this fails:
> > > 
> > > struct device *get_cpu_device(unsigned cpu)
> > > {
> > >         if (cpu < nr_cpu_ids && cpu_possible(cpu))
> > >                 return per_cpu(cpu_sys_devices, cpu);
> > > 
> > > because the percpu data has not yet been written - it'll be written
> > > after a successful device registration.  So, using get_cpu_device()
> > > from within cpufreq_add_dev() is broken, and results in the above
> > > kernel warning.
> 
> Hmm, I am wondering why is your case special here and why we never saw the same
> behavior ? Is this because the driver is registered as arch_initcall() ?
> 
> In all the cases that I have seen at least, cpufreq_add_dev() doesn't get called
> via the path you mentioned, but only during the cpufreq driver is registered.

But it will be called in that path during physical CPU hot-add, won't it?

Thanks,
Rafael

