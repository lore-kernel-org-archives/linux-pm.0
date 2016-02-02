From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/5] cpufreq: governors: Solve the ABBA lockups
Date: Tue,  2 Feb 2016 16:27:20 +0530
Message-ID: <cover.1454410226.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34810 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754364AbcBBK5l (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2016 05:57:41 -0500
Received: by mail-pf0-f171.google.com with SMTP id o185so96542817pfb.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Feb 2016 02:57:41 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, peterz@infradead.org, mturquette@baylibre.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

Sorry for doing this, I know you were also looking to fix this in a
possibly different way. But I thought, it would be better if we fix
that. We can scrap this version and take yours if that looks better.

The root cause of all the issues we were facing, was that we were taking
policy->rwsem while accessing governor sysfs attributes. And that
happened because we were sharing the show/store calls present in
cpufreq.c.

I thought, perhaps the best way to fix it is to give separate sysfs-ops
to governors. And that's what I did.

@Juri: I need your help in testing these. My platform doesn't give me
those lockups (even without these patches) and Juno/Tc2 would fit
better.

Can you please run some tests on these?

They are pushed here for easy access (and auto test by build-bot):
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/governor-kobject

--
viresh

Viresh Kumar (5):
  cpufreq: governor: Kill declare_show_sampling_rate_min()
  cpufreq: governor: Create separate sysfs-ops
  cpufreq: governor: Remove unused sysfs attribute macros
  cpufreq: Don't drop rwsem before calling CPUFREQ_GOV_POLICY_EXIT
  cpufreq: Get rid of ->governor_enabled and its lock

 drivers/cpufreq/cpufreq.c              |  29 ----------
 drivers/cpufreq/cpufreq_conservative.c |  77 ++++++++++---------------
 drivers/cpufreq/cpufreq_governor.c     |  86 ++++++++++++++++++++--------
 drivers/cpufreq/cpufreq_governor.h     | 101 +++++++--------------------------
 drivers/cpufreq/cpufreq_ondemand.c     |  77 ++++++++++---------------
 include/linux/cpufreq.h                |   5 --
 6 files changed, 143 insertions(+), 232 deletions(-)

-- 
2.7.0.79.gdc08a19

