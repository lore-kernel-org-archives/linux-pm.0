From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 00/13] cpufreq: governors: Fix ABBA lockups
Date: Mon,  8 Feb 2016 17:09:14 +0530
Message-ID: <cover.1454931188.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36758 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbcBHLkD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 06:40:03 -0500
Received: by mail-pa0-f50.google.com with SMTP id yy13so72535040pab.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2016 03:40:03 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, shilpa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

Things look much much better now. I have rebased this series over
pm/bleeding-edge, that has all your patches.

I have moved ahead and done few more changes in this series, that should
get rid of all the lockdeps we were getting earlier, that includes
fixing lockdep issue in update_sampling_rate() that we were chasing.

These are pushed here again:
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/governor-kobject

@Juri/Shilpa: Can you please confirm if all the issues got resolved now
?

V2->V3:
- The first patch from V2, that was moving min_sampling_rate to
  per governor structure was dropped, as you suggested.
- Also, I have moved common tunables to struct dbs_data now, which you
  also suggested sometime back.
- Last 5 patches are all new and fix rest of the issues we were facing.

--
viresh

Viresh Kumar (13):
  cpufreq: governor: Create generic macro for global tuners
  cpufreq: governor: Move common tunables to 'struct dbs_data'
  cpufreq: governor: New sysfs show/store callbacks for governor
    tunables
  cpufreq: governor: Drop unused macros for creating governor tunable
    attributes
  Revert "cpufreq: Drop rwsem lock around CPUFREQ_GOV_POLICY_EXIT"
  cpufreq: Merge cpufreq_offline_prepare/finish routines
  cpufreq: Call __cpufreq_governor() with policy->rwsem held
  cpufreq: Remove cpufreq_governor_lock
  cpufreq: governor: Move common sysfs tunables to cpufreq_governor.c
  cpufreq: governor: No need to manage state machine now
  cpufreq: governor: Keep list of policy_dbs within dbs_data
  cpufreq: ondemand: Traverse list of policy_dbs in
    update_sampling_rate()
  cpufreq: conservative: Update sample_delay_ns immediately

 drivers/cpufreq/cpufreq.c              |  98 ++++++------
 drivers/cpufreq/cpufreq_conservative.c | 143 ++++--------------
 drivers/cpufreq/cpufreq_governor.c     | 266 +++++++++++++++++++++++++--------
 drivers/cpufreq/cpufreq_governor.h     | 156 ++++++++-----------
 drivers/cpufreq/cpufreq_ondemand.c     | 241 +++++------------------------
 include/linux/cpufreq.h                |   4 -
 6 files changed, 381 insertions(+), 527 deletions(-)

-- 
2.7.1.370.gb2aa7f8

