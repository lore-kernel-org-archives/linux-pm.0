From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/5] CPUFreq: Last set of updates for 3.13
Date: Wed, 11 Sep 2013 15:43:06 +0530
Message-ID: <cover.1378893296.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:54452 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068Ab3IKKQU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Sep 2013 06:16:20 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so8889216pbb.34
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2013 03:16:19 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

I really tried to stop after you asked me to, but still got few more patches..
These are very minor changes and a fairly smaller patchset..

I have rebased this over your linux-next branch

7c218b1 Merge branch 'acpi-bind-next' into linux-next

and tested over my exynos board.. I don't expect them to do any crappy stuff..

You can include these first (if they look fine) and then I will send all other
patches that I have queued up for 3.13.. I will send all of them in one lot,
with partition numbers mentioned (i.e. patches that should go together) and then
you can apply them the way you wish.. Set by set or all at once..

Thanks..

Viresh Kumar (5):
  cpufreq: Optimize cpufreq_frequency_table_verify()
  cpufreq: rename __cpufreq_set_policy() as cpufreq_set_policy()
  cpufreq: rewrite cpufreq_driver->flags using shift operator
  cpufreq: use cpufreq_driver->flags to mark
    CPUFREQ_HAVE_GOVERNOR_PER_POLICY
  cpufreq: add new routine cpufreq_verify_within_cpu_limits()

 drivers/cpufreq/arm_big_little.c     |  4 ++--
 drivers/cpufreq/cpufreq-nforce2.c    |  4 +---
 drivers/cpufreq/cpufreq.c            | 24 ++++++++++-------------
 drivers/cpufreq/cpufreq_governor.h   |  5 ++++-
 drivers/cpufreq/davinci-cpufreq.c    |  4 +---
 drivers/cpufreq/freq_table.c         | 27 +++++++++++++-------------
 drivers/cpufreq/integrator-cpufreq.c |  9 ++-------
 drivers/cpufreq/intel_pstate.c       |  4 +---
 drivers/cpufreq/longrun.c            |  4 +---
 drivers/cpufreq/pcc-cpufreq.c        |  3 +--
 drivers/cpufreq/sh-cpufreq.c         |  7 ++-----
 drivers/cpufreq/unicore2-cpufreq.c   |  4 +---
 include/linux/cpufreq.h              | 37 ++++++++++++++++++++++--------------
 13 files changed, 62 insertions(+), 74 deletions(-)

-- 
1.7.12.rc2.18.g61b472e

