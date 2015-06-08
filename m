From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V7 0/6] cpufreq: Don't loose cpufreq history on CPU hotplug
Date: Tue, 09 Jun 2015 01:17:16 +0200
Message-ID: <5222181.qP6uXoXqc5@vostro.rjw.lan>
References: <cover.1433767914.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58637 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752601AbbFHWv3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2015 18:51:29 -0400
In-Reply-To: <cover.1433767914.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>

On Monday, June 08, 2015 06:25:26 PM Viresh Kumar wrote:
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
> V6->V7:
> - Change the order of patches, "cpufreq: Remove cpufreq_update_policy"
>   is moved to the end of the series and updated its changelog.
> 
> V5-V6:
> - Merged v4 9/14 into 10/14 after some updates.
> - Keep separate routines to add/remove symlinks.
> - Only updated one patch in this version
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
> Viresh Kumar (6):
>   cpufreq: Don't allow updating inactive policies from sysfs
>   cpufreq: Stop migrating sysfs files on hotplug
>   cpufreq: Initialize policy->kobj while allocating policy
>   cpufreq: Call cpufreq_policy_put_kobj() from cpufreq_policy_free()
>   cpufreq: Restart governor as soon as possible
>   cpufreq: Remove cpufreq_update_policy()
> 
>  drivers/cpufreq/cpufreq.c | 303 +++++++++++++++++++++++++---------------------
>  1 file changed, 168 insertions(+), 135 deletions(-)

Overall, this looks good to me.  There are some nitpicks here and there, though
(please see replies to individual patches for details).


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
