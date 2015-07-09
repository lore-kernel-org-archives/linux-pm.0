From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [BUG] Kernel splat when taking CPUs offline
Date: Thu, 09 Jul 2015 02:13:45 +0200
Message-ID: <1625417.XZkzNdoaJA@vostro.rjw.lan>
References: <20150708152456.4438d60f@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55999 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751299AbbGHXrR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 19:47:17 -0400
In-Reply-To: <20150708152456.4438d60f@gandalf.local.home>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Saravana Kannan <skannan@codeaurora.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wednesday, July 08, 2015 03:24:56 PM Steven Rostedt wrote:
> 
> My tests for ftrace includes testing the mmiotracer, which to run
> requires taking all CPUs offline but one of them. This test crashed
> every so often, and I was able to bisect down to this commit:
> 
> commit 87549141d516 ("cpufreq: Stop migrating sysfs files on hotplug")

Thanks for the report, adding linux-pm and linux-acpi to the CC.


> Just to make sure this wasn't just the mmiotracer causing the issue, I
> was able to trigger this same bug by simply doing the following:
> 
> 
> (on a 4 cpu machine)
> 
> 
>  # echo 0 > /sys/devices/system/cpu/cpu1/online 
>  # echo 0 > /sys/devices/system/cpu/cpu2/online 
>  # echo 0 > /sys/devices/system/cpu/cpu3/online 
>  # echo 1 > /sys/devices/system/cpu/cpu1/online 
>  # echo 1 > /sys/devices/system/cpu/cpu2/online 
>  # echo 1 > /sys/devices/system/cpu/cpu3/online 
>  # echo 0 > /sys/devices/system/cpu/cpu1/online 
>  # echo 0 > /sys/devices/system/cpu/cpu2/online 
>  # echo 0 > /sys/devices/system/cpu/cpu2/online 
>  # echo 0 > /sys/devices/system/cpu/cpu3/online 
>  # echo 1 > /sys/devices/system/cpu/cpu1/online 
>  # echo 1 > /sys/devices/system/cpu/cpu2/online 
>  # echo 1 > /sys/devices/system/cpu/cpu3/online 
> 
> It usually takes two or three tries (shutting down all but one CPU, and
> starting them again) before it triggers.
> 
> Here's the splat:
> 
> Initializing CPU#1
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1609 at /home/rostedt/work/git/linux-trace.git/drivers/cpufreq/cpufreq.c:2350 cpufreq_update_policy+0xc8/0x139()

So the cpufreq driver's ->get() callback returns 0 for the given CPU and
that's what triggers the WARN_ON().  And it most likely returns 0, because
its internal data structure for that CPU is not present.

I *guess* that before the above commit policy was NULL in cpufreq_update_policy()
and we didn't get to the point where ->get() was called.

There seems to be a couple of ways to address that, but I'd like Viresh to have
a look at this too.


> Modules linked in: ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables ipv6 ppdev parport_pc r8169 parport microcode
> CPU: 0 PID: 1609 Comm: bash Tainted: G        W       4.2.0-rc1-test #26
> Hardware name: MSI MS-7823/CSM-H87M-G43 (MS-7823), BIOS V1.6 02/22/2014
>  00000000 00000000 ee47db9c c0cd04e6 c10d4463 ee47dbcc c0440fbe c1010460
>  00000000 00000649 c10d4463 0000092e c0a6dd28 c0a6dd28 f13fd600 00000000
>  ee47dda8 ee47dbdc c0440ff7 00000009 00000000 ee47ddb8 c0a6dd28 efb01bc0
> Call Trace:
>  [<c0cd04e6>] dump_stack+0x41/0x52
>  [<c0440fbe>] warn_slowpath_common+0x9d/0xb4
>  [<c0a6dd28>] ? cpufreq_update_policy+0xc8/0x139
>  [<c0a6dd28>] ? cpufreq_update_policy+0xc8/0x139
>  [<c0440ff7>] warn_slowpath_null+0x22/0x24
>  [<c0a6dd28>] cpufreq_update_policy+0xc8/0x139
>  [<c0a6dd99>] ? cpufreq_update_policy+0x139/0x139
>  [<c0a6dc9b>] ? cpufreq_update_policy+0x3b/0x139
>  [<c0a6bef7>] ? cpufreq_freq_transition_begin+0x97/0xd9
>  [<c046ea90>] ? __wake_up+0x1a/0x47
>  [<c0772682>] acpi_processor_ppc_has_changed+0x54/0x5d
>  [<c076f6b9>] acpi_cpu_soft_notify+0xb0/0xf1
>  [<c06d2859>] ? compute_batch_value+0xd/0x22
>  [<c06d2a38>] ? percpu_counter_hotcpu_callback+0x11/0x80
>  [<c0458c35>] notifier_call_chain+0x68/0x91
>  [<c047007b>] ? sched_debug_header+0x15c/0x58e
>  [<c0458c7c>] __raw_notifier_call_chain+0x1e/0x23
>  [<c04410c2>] __cpu_notify+0x24/0x39
>  [<c04414d9>] _cpu_up+0xef/0x105
>  [<c044153d>] cpu_up+0x4e/0x5f
>  [<c0ccb642>] cpu_subsys_online+0x13/0x15
>  [<c09134b4>] device_online+0x45/0x6e
>  [<c091350f>] online_store+0x32/0x4f
>  [<c09134dd>] ? device_online+0x6e/0x6e
>  [<c0911570>] dev_attr_store+0x24/0x29
>  [<c0587f31>] sysfs_kf_write+0x3a/0x41
>  [<c0587ef7>] ? sysfs_file_ops+0x48/0x48
>  [<c0587244>] kernfs_fop_write+0xe2/0x11f
>  [<c0587162>] ? kernfs_vma_page_mkwrite+0x6c/0x6c
>  [<c0532e3a>] __vfs_write+0x24/0x9b
>  [<c0532d25>] ? file_start_write+0x27/0x29
>  [<c0533355>] ? rw_verify_area+0xce/0xef
>  [<c0533843>] vfs_write+0x7a/0xc4
>  [<c0533a09>] SyS_write+0x54/0x7f
>  [<c0cdae58>] sysenter_do_call+0x12/0x12
> ---[ end trace e2c32eead4f4e541 ]---
> 
> I'll dig more into it, but wanted to give people a heads up.


