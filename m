From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 15/19] cpufreq: remove useless usage of
 cpufreq_governor_mutex in __cpufreq_governor
Date: Wed, 20 Jan 2016 12:59:33 +0530
Message-ID: <20160120072933.GF22443@vireshk>
References: <1452533760-13787-1-git-send-email-juri.lelli@arm.com>
 <1452533760-13787-16-git-send-email-juri.lelli@arm.com>
 <20160112110658.GG1084@ubuntu>
 <20160115163031.GU18603@e106622-lin>
 <20160118055034.GC30762@vireshk>
 <20160119164941.GI8573@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35396 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbcATH3g (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 02:29:36 -0500
Received: by mail-pf0-f176.google.com with SMTP id 65so252739pff.2
        for <linux-pm@vger.kernel.org>; Tue, 19 Jan 2016 23:29:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160119164941.GI8573@e106622-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, rjw@rjwysocki.net, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com

On 19-01-16, 16:49, Juri Lelli wrote:
> I'm actually hitting this running sp2, on linux-pm/linux-next :/.

That's really bad .. Are you hitting this on Juno or x86 ?

And I am sure you would have hit that with your changes as well, but
now its on the currently merged patches :(

>  ======================================================
>  [ INFO: possible circular locking dependency detected ]
>  4.4.0+ #445 Not tainted
>  -------------------------------------------------------
>  trace.sh/1723 is trying to acquire lock:
>   (s_active#48){++++.+}, at: [<c01f78c8>] kernfs_remove_by_name_ns+0x4c/0x94
> 
>  but task is already holding lock:
>   (od_dbs_cdata.mutex){+.+.+.}, at: [<c05824a0>] cpufreq_governor_dbs+0x34/0x5d4
> 
>  which lock already depends on the new lock.
> 
> 
>  the existing dependency chain (in reverse order) is:
> 
> -> #2 (od_dbs_cdata.mutex){+.+.+.}:
>         [<c075b040>] mutex_lock_nested+0x7c/0x434
>         [<c05824a0>] cpufreq_governor_dbs+0x34/0x5d4
>         [<c0017c10>] return_to_handler+0x0/0x18
> 
> -> #1 (&policy->rwsem){+++++.}:
>         [<c075ca8c>] down_read+0x58/0x94
>         [<c057c244>] show+0x30/0x60
>         [<c01f934c>] sysfs_kf_seq_show+0x90/0xfc
>         [<c01f7ad8>] kernfs_seq_show+0x34/0x38
>         [<c01a22ec>] seq_read+0x1e4/0x4e4
>         [<c01f8694>] kernfs_fop_read+0x120/0x1a0
>         [<c01794b4>] __vfs_read+0x3c/0xe0
>         [<c017a378>] vfs_read+0x98/0x104
>         [<c017a434>] SyS_read+0x50/0x90
>         [<c000fd40>] ret_fast_syscall+0x0/0x1c
> 
> -> #0 (s_active#48){++++.+}:
>         [<c008238c>] lock_acquire+0xd4/0x20c
>         [<c01f6ae4>] __kernfs_remove+0x288/0x328
>         [<c01f78c8>] kernfs_remove_by_name_ns+0x4c/0x94
>         [<c01fa024>] remove_files+0x44/0x88
>         [<c01fa5a4>] sysfs_remove_group+0x50/0xa4
>         [<c058285c>] cpufreq_governor_dbs+0x3f0/0x5d4
>         [<c0017c10>] return_to_handler+0x0/0x18
> 
>  other info that might help us debug this:
> 
>  Chain exists of:
>   s_active#48 --> &policy->rwsem --> od_dbs_cdata.mutex
> 
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(od_dbs_cdata.mutex);
>                                 lock(&policy->rwsem);
>                                 lock(od_dbs_cdata.mutex);
>    lock(s_active#48);
> 
>   *** DEADLOCK ***
> 
>  5 locks held by trace.sh/1723:
>   #0:  (sb_writers#6){.+.+.+}, at: [<c017beb8>] __sb_start_write+0xb4/0xc0
>   #1:  (&of->mutex){+.+.+.}, at: [<c01f8418>] kernfs_fop_write+0x6c/0x1c8
>   #2:  (s_active#35){.+.+.+}, at: [<c01f8420>] kernfs_fop_write+0x74/0x1c8
>   #3:  (cpu_hotplug.lock){++++++}, at: [<c0029e6c>] get_online_cpus+0x48/0xb8
>   #4:  (od_dbs_cdata.mutex){+.+.+.}, at: [<c05824a0>] cpufreq_governor_dbs+0x34/0x5d4
> 
>  stack backtrace:
>  CPU: 2 PID: 1723 Comm: trace.sh Not tainted 4.4.0+ #445
>  Hardware name: ARM-Versatile Express
>  [<c001883c>] (unwind_backtrace) from [<c0013f50>] (show_stack+0x20/0x24)
>  [<c0013f50>] (show_stack) from [<c044ad90>] (dump_stack+0x80/0xb4)
>  [<c044ad90>] (dump_stack) from [<c0128edc>] (print_circular_bug+0x29c/0x2f0)
>  [<c0128edc>] (print_circular_bug) from [<c0081708>] (__lock_acquire+0x163c/0x1d74)
>  [<c0081708>] (__lock_acquire) from [<c008238c>] (lock_acquire+0xd4/0x20c)
>  [<c008238c>] (lock_acquire) from [<c01f6ae4>] (__kernfs_remove+0x288/0x328)
>  [<c01f6ae4>] (__kernfs_remove) from [<c01f78c8>] (kernfs_remove_by_name_ns+0x4c/0x94)
>  [<c01f78c8>] (kernfs_remove_by_name_ns) from [<c01fa024>] (remove_files+0x44/0x88)
>  [<c01fa024>] (remove_files) from [<c01fa5a4>] (sysfs_remove_group+0x50/0xa4)
>  [<c01fa5a4>] (sysfs_remove_group) from [<c058285c>] (cpufreq_governor_dbs+0x3f0/0x5d4)
>  [<c058285c>] (cpufreq_governor_dbs) from [<c0017c10>] (return_to_handler+0x0/0x18)
> 
> Now, I couldn't yet make sense of this, but it seems to be
> triggered by setting ondemand, printing its attributes and then
> switching to conservative (that's what sp2 does, right?). Also, s_active
> seems to come into play only when lockdep is enabled. Are you seeing
> this as well?

There is something about the platform you are running this on.. I
don't hit it most of the times in my exynos board (Dual A15), but x86
and powerpc guys used to report this all the time. I have tried with
both have-governor-per-policy and otherwise.

I have explained something similar in the earlier commits I pointed to
you, here is the commit log:

http://pastebin.com/JbEJBLzU

-- 
viresh
