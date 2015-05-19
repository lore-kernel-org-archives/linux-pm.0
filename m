From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V5 00/14] cpufreq: Don't loose cpufreq history on CPU hotplug
Date: Tue, 19 May 2015 02:34:47 +0200
Message-ID: <5515479.9CSMtpamVj@vostro.rjw.lan>
References: <cover.1431924457.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49726 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751576AbbESAJ2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2015 20:09:28 -0400
In-Reply-To: <cover.1431924457.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>

On Monday, May 18, 2015 10:43:23 AM Viresh Kumar wrote:
> Hi Rafael,
> 
> The aim of this series is to stop managing cpufreq sysfs directories on CPU
> hotplug.
> 
> Currently on removal of a 'cpu != policy->cpu', we remove its sysfs directories
> by removing the soft-link. And on removal of policy->cpu, we migrate the sysfs
> directories to the next cpu in policy. But if policy->cpu was the last CPU, we
> remove the policy completely and allocate it again once the CPUs come back.
> 
> This has shortcomings:
> 
> - Code Complexity
> - Slower hotplug
> - sysfs file permissions are reset after all policy->cpus are offlined
> - CPUFreq stats history lost after all policy->cpus are offlined
> - Special management of sysfs stuff during suspend/resume
> 
> 
> To make things simple we can stop playing with sysfs files unless the driver is
> getting removed. Also the policy can be kept intact to be used later.
> 
> First few patches provide a clean base for others *more important* patches.
> 
> Rebased-over: your linux-next branch as there were dependencies on my earlier
> patches.
> 
> Pushed here:
> git://git.linaro.org/people/viresh.kumar/linux.git cpufreq/core/sysfs-v4
> 
> V4-V5:
> - Sending all patches again
> - Fixed comments in one of the patches as suggested by you
> - Merged the last commit about "physical hotplug of CPUs" with "cpufreq: Stop
>   migrating sysfs files on hotplug".
> - A new patch (content is old, just separated out into its own patch) "cpufreq:
>   add/remove sysfs links via cpufreq_add_remove_dev_symlink()"
> 
> V3-V4:
> - Only four patches sent this time:
>   - [PATCH V4 01/14] cpufreq: Create for_each_{in}active_policy()
>   - [PATCH V4 04/14] cpufreq: Don't traverse all active policies to find
>   - [PATCH V4 05/14] cpufreq: Manage governor usage history with
>   - [PATCH V4 06/14] cpufreq: Mark policy->governor = NULL for inactive
> - Remove __temp from the arguments of for_each_[in]active_policies.
> - Simplified macros/next_policy, etc.
> 
> V2->V3:
> - First five are already applied by you and the 7th one was sent separately as a
>   fix earlier and got applied. So, V2 had 20 patches and V3 has 14.
> - Dropped while(1) and used do/while.
> - policy->governor marked as NULL only while removing the governor and not when
>   policy becomes inactive.
> - Commit logs/comments updated
> - Applied Acks from Saravan
> 
> v1->V2:
> - Dropped the idea of using policy-lists for getting policy for any cpu
> - Also dropped fallback list and its per-cpu variable
> - Stopped cleaning cpufreq_cpu_data and doing list_del(policy) on logical
>   hotplug.
> - Added support for physical hotplug of CPUs (Untested).
> 
> 
> Saravana Kannan (1):
>   cpufreq: Track cpu managing sysfs kobjects separately
> 
> Viresh Kumar (13):
>   cpufreq: Create for_each_{in}active_policy()
>   cpufreq: Don't clear cpufreq_cpu_data and policy list for inactive
>     policies
>   cpufreq: Get rid of cpufreq_cpu_data_fallback
>   cpufreq: Don't traverse all active policies to find policy for a cpu
>   cpufreq: Manage governor usage history with 'policy->last_governor'
>   cpufreq: Mark policy->governor = NULL for inactive policies
>   cpufreq: Don't allow updating inactive policies from sysfs
>   cpufreq: add/remove sysfs links via cpufreq_add_remove_dev_symlink()
>   cpufreq: Stop migrating sysfs files on hotplug
>   cpufreq: Remove cpufreq_update_policy()
>   cpufreq: Initialize policy->kobj while allocating policy
>   cpufreq: Call cpufreq_policy_put_kobj() from cpufreq_policy_free()
>   cpufreq: Restart governor as soon as possible
> 
>  drivers/cpufreq/cpufreq.c | 486 +++++++++++++++++++++++++---------------------
>  include/linux/cpufreq.h   |   5 +-
>  2 files changed, 268 insertions(+), 223 deletions(-)

I've applied patches [1-6/14] from your previous series.  Should I replace them
with the new ones?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
