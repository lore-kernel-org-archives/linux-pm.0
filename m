From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 00/14] cpufreq: stats: cleanups
Date: Fri,  2 Jan 2015 11:16:37 +0530
Message-ID: <cover.1420177186.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:40681 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbbABFrB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 00:47:01 -0500
Received: by mail-pd0-f169.google.com with SMTP id z10so23295587pdj.28
        for <linux-pm@vger.kernel.org>; Thu, 01 Jan 2015 21:47:01 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

This is a resend of cpufreq stats cleanups I had for sometime. Few issues were
reported from Fenguang's bot and are all fixed now and are stable..

V1->V2:
- Reviewed-by Prarit
- Replaced lock with mutex as we may sleep from within critical region and so a
  new patch "cpufreq: stats: replace spinlock with mutex".

Pushed here:
git://git.linaro.org/people/viresh.kumar/linux.git cpufreq/stats/cleanups

Viresh Kumar (14):
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
  cpufreq: stats: replace spinlock with mutex
  cpufreq: stats: Fix locking
  cpufreq: stats: call cpufreq_stats_update() with locks held

 drivers/cpufreq/cpufreq.c       |   6 --
 drivers/cpufreq/cpufreq_stats.c | 148 ++++++++++++++++++----------------------
 include/linux/cpufreq.h         |  10 +--
 3 files changed, 73 insertions(+), 91 deletions(-)

-- 
2.2.0

