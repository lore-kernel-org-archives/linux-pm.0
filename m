From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 00/18] cpufreq: don't loose cpufreq history on CPU hotplug
Date: Tue, 27 Jan 2015 14:06:06 +0530
Message-ID: <cover.1422346933.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:40090 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754030AbbA0Igl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 03:36:41 -0500
Received: by mail-pa0-f44.google.com with SMTP id rd3so17162826pab.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2015 00:36:41 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

The aim of this series is to stop managing cpufreq sysfs directories on CPU
hotplugs.

This issue has been raised multiple times earlier, the latest being tried by
Saravana. While working on the $Subject thread, I did lots of cleanups, most of
which are already pushed by you.

The two remaining ones are added to this series..

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

@Saravana/Prarit: It would be good if you can provide your feedback/reviews on
this. Thanks in advance.

@Saravana: Few patches might look very similar to what you have done, please add
your SOB for those :)

--
viresh

Viresh Kumar (18):
  cpufreq: Drop cpufreq_disabled() check from cpufreq_cpu_{get|put}()
  cpufreq: Create for_each_policy()
  cpufreq: Create for_each_governor()
  cpufreq: Manage fallback policies in a list
  cpufreq: Manage governor usage history with 'policy->last_governor'
  cpufreq: Reuse policy list instead of per-cpu variable
    'cpufreq_cpu_data'
  cpufreq: Drop (now) useless check 'cpu > nr_cpu_ids'
  cpufreq: Add doc style comment about cpufreq_cpu_{get|put}()
  cpufreq: Mark policy->governor = NULL for fallback policies
  cpufreq: Don't allow updating inactive-policies from sysfs
  cpufreq: Track cpu managing sysfs kobjects separately
  cpufreq: Stop migrating sysfs files on hotplug
  cpufreq: Keep a single path for adding managed CPUs
  cpufreq: Remove cpufreq_update_policy()
  cpufreq: Initialize policy->kobj while allocating policy
  cpufreq: Call cpufreq_policy_put_kobj() from cpufreq_policy_free()
  cpufreq: Restart governor as soon as possible
  cpufreq: Merge __cpufreq_add_dev() and cpufreq_add_dev()

 drivers/cpufreq/cpufreq.c | 551 +++++++++++++++++++++++-----------------------
 include/linux/cpufreq.h   |  10 +-
 2 files changed, 287 insertions(+), 274 deletions(-)

-- 
2.3.0.rc0.44.ga94655d

