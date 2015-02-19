From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 00/20] cpufreq: Don't loose cpufreq history on CPU hotplug
Date: Thu, 19 Feb 2015 17:02:02 +0530
Message-ID: <cover.1424345053.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35738 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753354AbbBSLdV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Feb 2015 06:33:21 -0500
Received: by padfa1 with SMTP id fa1so8893280pad.2
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2015 03:33:20 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>, Srivatsa Bhat <srivatsa@mit.edu>

Hi Rafael,

The aim of this series is to stop managing cpufreq sysfs directories on CPU
hotplugs.

Currently on removal of a 'cpu != policy->cpu', we remove its sysfs directories
by removing the soft-link. And on removal of policy->cpu, we migrate the sysfs
directories to the next cpu. But if policy->cpu was the last CPU, we remove the
policy completely and allocate it again as soon as the CPUs come back. This has
shortcomings:

- Code Complexity
- Slower hotplug
- sysfs file permissions are reset after all policy->cpus are offlined
- CPUFreq stats history lost after all policy->cpus are offlined
- Special management of sysfs stuff during suspend/resume


To make things simple we stop playing with sysfs files unless the driver is
getting removed. Also the policy is kept intact to be used later.

First few patches provide a clean base for others *more important* patches.

Rebased-over: your bleeding edge branch as there were dependencies on my earlier
patches.

Pushed here:

git://git.linaro.org/people/viresh.kumar/linux.git cpufreq/core/sysfs

v1->V2:
- Dropped the idea of using policy-lists for getting policy for any cpu
- Also dropped fallback list and its per-cpu variable
- Stopped cleaning cpufreq_cpu_data and doing list_del(policy) on logical
  hotplug.
- Added support for physical hotplug of CPUs (Untested).

@Srivatsa: Can you please have a look at the above change? I have cc'd you only
on this one.

Saravana Kannan (1):
  cpufreq: Track cpu managing sysfs kobjects separately

Cc: Srivatsa Bhat <srivatsa@mit.edu>

Viresh Kumar (19):
  cpufreq: Add doc style comment about cpufreq_cpu_{get|put}()
  cpufreq: Merge __cpufreq_add_dev() and cpufreq_add_dev()
  cpufreq: Throw warning when we try to get policy for an invalid CPU
  cpufreq: Keep a single path for adding managed CPUs
  cpufreq: Clear policy->cpus even for the last CPU
  cpufreq: Create for_each_{in}active_policy()
  cpufreq: Call schedule_work() for the last active policy
  cpufreq: Don't clear cpufreq_cpu_data and policy list for inactive
    policies
  cpufreq: Get rid of cpufreq_cpu_data_fallback
  cpufreq: Don't traverse list of all policies for adding policy for a
    cpu
  cpufreq: Manage governor usage history with 'policy->last_governor'
  cpufreq: Mark policy->governor = NULL for inactive policies
  cpufreq: Don't allow updating inactive-policies from sysfs
  cpufreq: Stop migrating sysfs files on hotplug
  cpufreq: Remove cpufreq_update_policy()
  cpufreq: Initialize policy->kobj while allocating policy
  cpufreq: Call cpufreq_policy_put_kobj() from cpufreq_policy_free()
  cpufreq: Restart governor as soon as possible
  cpufreq: Add support for physical hoplug of CPUs

 drivers/cpufreq/cpufreq.c | 593 ++++++++++++++++++++++++++--------------------
 include/linux/cpufreq.h   |   5 +-
 2 files changed, 340 insertions(+), 258 deletions(-)

-- 
2.3.0.rc0.44.ga94655d

