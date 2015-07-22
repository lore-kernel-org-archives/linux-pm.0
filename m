From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2] cpufreq: Fix double addition of sysfs links
Date: Wed, 22 Jul 2015 14:44:46 +0200
Message-ID: <CAJZ5v0gEPb_hBqZfqEXf5Fr8rNu=MrN734odd-jVXMwWs6VwMQ@mail.gmail.com>
References: <20150718163149.GP7557@n2100.arm.linux.org.uk>
	<35d0bb6829c6c8a5fec7c55e45d9293946c0221b.1437566548.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:36363 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241AbbGVMos (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jul 2015 08:44:48 -0400
In-Reply-To: <35d0bb6829c6c8a5fec7c55e45d9293946c0221b.1437566548.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

Hi Viresh,

On Wed, Jul 22, 2015 at 2:07 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Consider a dual core (0/1) system with two CPUs:
> - sharing clock/voltage rails and hence cpufreq-policy
> - CPU1 is offline while the cpufreq driver is registered
> - cpufreq_add_dev() is called from subsys callback for CPU0 and we
>   create the policy for the group of CPUs and create links for all
>   present CPUs, i.e. CPU1 as well.
> - cpufreq_add_dev() is called from subsys callback for CPU1, we find
>   that the cpu is offline and we try to create a sysfs link for CPU1.
>
> This results in double addtion of the sysfs link and we will get this:
>
> WARNING: CPU: 0 PID: 1 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x60/0x7c()
> sysfs: cannot create duplicate filename '/devices/system/cpu/cpu1/cpufreq'
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.2.0-rc2+ #1704
> Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> Backtrace:
> [<c0013248>] (dump_backtrace) from [<c00133e4>] (show_stack+0x18/0x1c)
>  r6:c01a1f30 r5:0000001f r4:00000000 r3:00000000
> [<c00133cc>] (show_stack) from [<c076920c>] (dump_stack+0x7c/0x98)
> [<c0769190>] (dump_stack) from [<c0029ab4>] (warn_slowpath_common+0x80/0xbc)
>  r4:d74abbd0 r3:d74c0000
> [<c0029a34>] (warn_slowpath_common) from [<c0029b94>] (warn_slowpath_fmt+0x38/0x40)
>  r8:ffffffef r7:00000000 r6:d75a8960 r5:c0993280 r4:d6b4d000
> [<c0029b60>] (warn_slowpath_fmt) from [<c01a1f30>] (sysfs_warn_dup+0x60/0x7c)
>  r3:d6b4dfe7 r2:c0930750
> [<c01a1ed0>] (sysfs_warn_dup) from [<c01a22c8>] (sysfs_do_create_link_sd+0xb8/0xc0)
>  r6:d75a8960 r5:c0993280 r4:d00aba20
> [<c01a2210>] (sysfs_do_create_link_sd) from [<c01a22fc>] (sysfs_create_link+0x2c/0x3c)
>  r10:00000001 r8:c14db3c8 r7:d7b89010 r6:c0ae7c60 r5:d7b89010 r4:d00d1200
> [<c01a22d0>] (sysfs_create_link) from [<c0506160>] (add_cpu_dev_symlink+0x34/0x5c)
> [<c050612c>] (add_cpu_dev_symlink) from [<c05084d0>] (cpufreq_add_dev+0x674/0x794)
>  r5:00000001 r4:00000000
> [<c0507e5c>] (cpufreq_add_dev) from [<c03db114>] (subsys_interface_register+0x8c/0xd0)
>  r10:00000003 r9:d7bb01f0 r8:c14db3c8 r7:00106738 r6:c0ae7c60 r5:c0acbd08
>  r4:c0ae7e20
> [<c03db088>] (subsys_interface_register) from [<c0508a2c>] (cpufreq_register_driver+0x104/0x1f4)
>
> The check for offline-cpu in cpufreq_add_dev() is to ensure that link
> gets added for the CPUs which weren't physically present earlier and
> that misses the case where a CPU is offline while registering the
> driver.
>
> To fix this properly, don't create these links when the policy get
> initialized. Rather wait for individual subsys callback for CPUs to
> add/remove these links. This simplifies most of the code leaving
> cpufreq_remove_dev().
>
> The problem is that, we might remove cpu which was owner of policy->kobj
> in sysfs, before other CPUs are removed. Fix this by the solution we
> have been using until very recently, in which we move the kobject to any
> other CPU, for which remove is yet to be called.
>
> Tested on dual core exynos board with cpufreq-dt driver. The driver was
> compiled as module and inserted/removed multiple times on a running
> kernel.
>
> Fixes: 87549141d516 ("cpufreq: Stop migrating sysfs files on hotplug")
> Reported-and-suggested-by: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

That looks good to me overall, but please let me rename your new
"symlinks" CPU mask to "dependent_cpus".

> ---
> V1->V2: Completely changed, please review again :)
>
> @Rafael: I didn't review your solution and gave this one because I
> thought Russell suggested the right thing. i.e. don't create links in
> the beginning.

Sure.  I prefer this approach too.

> This is based of 4.2-rc3 and so your other patch,
> https://patchwork.kernel.org/patch/6839031/ has to be rebased over it.

OK

> I didn't rebase this patch over yours for two reasons:
> - Yours wasn't necessarily 4.2 material.

Right.

> - I already mentioned a problem in that patch.

I'm not sure if the problem is really there, but after the changes in
this patch it doesn't really matter. :-)

Thanks,
Rafael
