From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] cpufreq: Avoid double addition/removal of sysfs links
Date: Mon, 20 Jul 2015 11:36:24 +0100
Message-ID: <20150720103623.GQ7557@n2100.arm.linux.org.uk>
References: <20150718163149.GP7557@n2100.arm.linux.org.uk>
 <a8a3c524facf3b2c1621a54d09c7022f4267d2e5.1437385355.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:55155 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751203AbbGTKgd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jul 2015 06:36:33 -0400
Content-Disposition: inline
In-Reply-To: <a8a3c524facf3b2c1621a54d09c7022f4267d2e5.1437385355.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On Mon, Jul 20, 2015 at 03:17:10PM +0530, Viresh Kumar wrote:
> Consider a dual core (0/1) system with two CPUs:
> - sharing clock/voltage rails and hence cpufreq-policy
> - CPU1 is offline while the cpufreq driver is registered
> 
> - cpufreq_add_dev() is called from subsys callback for CPU0 and we
>   create the policy for the CPUs and create link for CPU1.
> - cpufreq_add_dev() is called from subsys callback for CPU1, we find
>   that the cpu is offline and we try to create a sysfs link for CPU1.
> - This results in double addition of the sysfs link and we get this:
> 
> 	WARNING: CPU: 0 PID: 1 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x60/0x7c()
> 	sysfs: cannot create duplicate filename '/devices/system/cpu/cpu1/cpufreq'
> 	Modules linked in:
> 	CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.2.0-rc2+ #1704
> 	Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> 	Backtrace:
> 	[<c0013248>] (dump_backtrace) from [<c00133e4>] (show_stack+0x18/0x1c)
> 	 r6:c01a1f30 r5:0000001f r4:00000000 r3:00000000
> 	[<c00133cc>] (show_stack) from [<c076920c>] (dump_stack+0x7c/0x98)
> 	[<c0769190>] (dump_stack) from [<c0029ab4>] (warn_slowpath_common+0x80/0xbc)
> 	 r4:d74abbd0 r3:d74c0000
> 	[<c0029a34>] (warn_slowpath_common) from [<c0029b94>] (warn_slowpath_fmt+0x38/0x40)
> 	 r8:ffffffef r7:00000000 r6:d75a8960 r5:c0993280 r4:d6b4d000
> 	[<c0029b60>] (warn_slowpath_fmt) from [<c01a1f30>] (sysfs_warn_dup+0x60/0x7c)
> 	 r3:d6b4dfe7 r2:c0930750
> 	[<c01a1ed0>] (sysfs_warn_dup) from [<c01a22c8>] (sysfs_do_create_link_sd+0xb8/0xc0)
> 	 r6:d75a8960 r5:c0993280 r4:d00aba20
> 	[<c01a2210>] (sysfs_do_create_link_sd) from [<c01a22fc>] (sysfs_create_link+0x2c/0x3c)
> 	 r10:00000001 r8:c14db3c8 r7:d7b89010 r6:c0ae7c60 r5:d7b89010 r4:d00d1200
> 	[<c01a22d0>] (sysfs_create_link) from [<c0506160>] (add_cpu_dev_symlink+0x34/0x5c)
> 	[<c050612c>] (add_cpu_dev_symlink) from [<c05084d0>] (cpufreq_add_dev+0x674/0x794)
> 	 r5:00000001 r4:00000000
> 	[<c0507e5c>] (cpufreq_add_dev) from [<c03db114>] (subsys_interface_register+0x8c/0xd0)
> 	 r10:00000003 r9:d7bb01f0 r8:c14db3c8 r7:00106738 r6:c0ae7c60 r5:c0acbd08
> 	 r4:c0ae7e20
> 	[<c03db088>] (subsys_interface_register) from [<c0508a2c>] (cpufreq_register_driver+0x104/0x1f4)
> 
> 
> The check for offline-cpu in cpufreq_add_dev() is present to ensure that
> link gets added for the CPUs, that weren't physically present earlier
> and we missed the case where a CPU is offline while registering the
> driver.
> 
> Fix this by keeping track of CPUs for which link is already created, and
> avoiding duplicate sysfs entries.

Why do we try to create the symlink for CPU devices which we haven't
"detected" yet (iow, we haven't had cpufreq_add_dev() called for)?
Surely we are guaranteed to have cpufreq_add_dev() called for every
CPU which exists in sysfs?  So why not _only_ create the sysfs symlinks
when cpufreq_add_dev() is notified that a CPU subsys interface is
present?

Sure, if the policy changes, we need to do maintanence on these symlinks,
but I see only one path down into cpufreq_add_dev_symlink(), which is:

	cpufreq_add_dev() -> cpufreq_add_dev_interface() ->
		cpufreq_add_dev_symlink()

In other words, only when we see a new CPU interface appears, not when
the policy changes.  If the set of related CPUs is policy independent,
why is this information carried in the cpufreq_policy struct?

If it is policy dependent, then I see no code which handles the effect
of a policy change where the policy->related_cpus is different.  To me,
that sounds like a rather huge design hole.

Things get worse.  Reading drivers/base/cpu.c, CPU interface nodes are
only ever created - they're created for the set of _possible_ CPUs in
the system, not those which are possible and present, and there is no
unregister_cpu() API, only a register_cpu() API.  So, cpufreq_remove_dev()
won't be called for CPUs which were present and are no longer present.
This appears to be a misunderstanding of CPU hotplug...

So, cpufreq_remove_dev() will only get called when you call
subsys_interface_unregister(), not when the CPU present mask changes.
I suspect that the code in cpufreq_remove_dev() dealing with "offline"
CPUs even works... I'd recommend reading Documentation/cpu-hotplug.txt:

| cpu_present_mask: Bitmap of CPUs currently present in the system. Not all
| of them may be online. When physical hotplug is processed by the relevant
| subsystem (e.g ACPI) can change and new bit either be added or removed
| from the map depending on the event is hot-add/hot-remove. There are
| currently no locking rules as of now. Typical usage is to init topology
| during boot, at which time hotplug is disabled.
|
| You really dont need to manipulate any of the system cpu maps. They should
| be read-only for most use. When setting up per-cpu resources almost always
| use cpu_possible_mask/for_each_possible_cpu() to iterate.

In other words, I think your usage of cpu_present_mask in this code is
buggy in itself.

Please rethink the design of this code - I think your original change is
mis-designed.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
