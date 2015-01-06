From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 00/16] cpufreq: stats: cleanups
Date: Tue,  6 Jan 2015 21:08:59 +0530
Message-ID: <cover.1420558386.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:54942 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbbAFPj1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jan 2015 10:39:27 -0500
Received: by mail-pa0-f48.google.com with SMTP id rd3so31148548pab.35
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2015 07:39:27 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

This is V3 of the stats cleanup I sent earlier. Few things are improved based on
the feedback received (mostly from you). Please see if it looks any better.

Pushed here:
git://git.linaro.org/people/viresh.kumar/linux.git cpufreq/stats/cleanups

V1->V2:
- New patches:
  cpufreq: stats: remove unused cpufreq_stats_attribute
  cpufreq: stats: initialize 'cur_time' on its definition
  cpufreq: stats: rename 'struct cpufreq_stats' objects as 'stats'
  cpufreq: stats: drop unnecessary locking

- Patches dropped:
  cpufreq: stats: replace spinlock with mutex
  cpufreq: stats: Fix locking
  cpufreq: stats: call cpufreq_stats_update() with locks held

- Logs improved
- don't return error values notifiers on missing policy/stats
- rename stats_data as stats and make it cpufreq_stats pointer instead of void *

Viresh Kumar (16):
  cpufreq: stats: Improve module description string
  cpufreq: stats: return -EEXIST when stats are already allocated
  cpufreq: stats: remove unused cpufreq_stats_attribute
  cpufreq: stats: initialize 'cur_time' on its definition
  cpufreq: stats: don't check for freq table while freeing stats
  cpufreq: stats: pass 'stat' to cpufreq_stats_update()
  cpufreq: stats: get rid of per-cpu cpufreq_stats_table
  cpufreq: stats: rename 'struct cpufreq_stats' objects as 'stats'
  cpufreq: Remove (now) unused 'last_cpu' from struct cpufreq_policy
  cpufreq: stats: drop 'cpu' field of struct cpufreq_stats
  cpufreq: remove CPUFREQ_UPDATE_POLICY_CPU notifications
  cpufreq: stats: create sysfs group once we are ready
  cpufreq: stats: time_in_state can't be NULL in cpufreq_stats_update()
  cpufreq: stats: don't update stats from show_trans_table()
  cpufreq: stats: don't update stats on false notifiers
  cpufreq: stats: drop unnecessary locking

 drivers/cpufreq/cpufreq.c       |   6 --
 drivers/cpufreq/cpufreq_stats.c | 211 ++++++++++++++++++----------------------
 include/linux/cpufreq.h         |  10 +-
 3 files changed, 98 insertions(+), 129 deletions(-)

-- 
2.2.0

