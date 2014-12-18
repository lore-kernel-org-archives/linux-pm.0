From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 00/13] cpufreq: stats: cleanups
Date: Thu, 18 Dec 2014 17:30:17 +0530
Message-ID: <cover.1418902789.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:40837 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752450AbaLRMBB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Dec 2014 07:01:01 -0500
Received: by mail-pa0-f50.google.com with SMTP id bj1so1274924pad.37
        for <linux-pm@vger.kernel.org>; Thu, 18 Dec 2014 04:01:01 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

I finally started looking at how to make cpufreq-core somewhat less complex with
respect to locking, its state machine, etc..

The first thing I had to get into was cpufreq-stats and so this series. Mostly
cleanups to make things better..

Please see if they make any sense at all.

I know we are at Merge window right now and you wouldn't apply it even to
linux-next. So, if they look fine, please don't hesitate in dropping a mail to
confirm they look fine, so that I can send the next set of cleanups atleast for
reviews. We can get these applied one by one then, once we are a bit confident
of them.

Pushed here:
git://git.linaro.org/people/viresh.kumar/linux.git cpufreq/stats/cleanups

Viresh Kumar (13):
  cpufreq: stats: don't break strings into multiple lines
  cpufreq: stats: return -EEXIST when stats are already allocated
  cpufreq: stats: don't check for freq table while freeing stats
  cpufreq: stats: pass 'stat' to cpufreq_stats_update()
  cpufreq: stats: get rid of per-cpu cpufreq_stats_table
  cpufreq: Remove (now) unused 'last_cpu' from struct cpufreq_policy
  cpufreq: stats: remove cpufreq_stats_update_policy_cpu()
  cpufreq: remove CPUFREQ_UPDATE_POLICY_CPU notifications
  cpufreq: stats: create sysfs group once we are ready
  cpufreq: stats: don't update stats from show_trans_table()
  cpufreq: stats: don't update stats on false notifiers
  cpufreq: stats: Fix locking
  cpufreq: stats: call cpufreq_stats_update() with locks held

 drivers/cpufreq/cpufreq.c       |   6 --
 drivers/cpufreq/cpufreq_stats.c | 140 ++++++++++++++++++----------------------
 include/linux/cpufreq.h         |  10 +--
 3 files changed, 69 insertions(+), 87 deletions(-)

-- 
2.2.0

