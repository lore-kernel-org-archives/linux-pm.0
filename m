From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 00/10] cpufreq: governor: Avoid invalid state-transitions
Date: Fri, 19 Jun 2015 17:18:00 +0530
Message-ID: <cover.1434713657.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33312 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750724AbbFSLs2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2015 07:48:28 -0400
Received: by padev16 with SMTP id ev16so83987012pad.0
        for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2015 04:48:27 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael/Preeti,

This is another attempt to fix the crashes reported by Preeti. They work
quite well for me now, and I hope they would work well for Preeti as
well :)

So, patches [1-7,9] are already Reviewed by Preeti.

The first 5 patches are minor cleanups, 6th & 7th try to optimize few
things to make code less complex.

Patches 8-10 actually solve (or try to solve :)) the synchronization
problems, or the crashes I was getting.

V1->V2:
- 7/11 is dropped and only 8/11 is updated, which is 8/10 now.
- Avoid taking the same mutex in both cpufreq_governor_dbs() and
  work-handler as that has given us some locdeps, classic ABBA stuff.
- And so timer_mutex, responsible for synchronizing governor
  work-handlers is kept as is.
- Later patches are almost same with minor updates.
- Invalid state-transitions are sensed better now with improved checks.
- I have run enough tests on my exynos dual core board and failed to
  crash at all. Not that I wanted to crash :)

Rebased over pm/bleeeding-edge.

Viresh Kumar (10):
  cpufreq: governor: Name delayed-work as dwork
  cpufreq: governor: Drop unused field 'cpu'
  cpufreq: governor: Rename 'cpu_dbs_common_info' to 'cpu_dbs_info'
  cpufreq: governor: name pointer to cpu_dbs_info as 'cdbs'
  cpufreq: governor: rename cur_policy as policy
  cpufreq: governor: Keep single copy of information common to
    policy->cpus
  cpufreq: governor: split out common part of {cs|od}_dbs_timer()
  cpufreq: governor: Avoid invalid states with additional checks
  cpufreq: governor: Don't WARN on invalid states
  cpufreq: propagate errors returned from __cpufreq_governor()

 drivers/cpufreq/cpufreq.c              |  22 ++--
 drivers/cpufreq/cpufreq_conservative.c |  25 ++---
 drivers/cpufreq/cpufreq_governor.c     | 196 ++++++++++++++++++++++++---------
 drivers/cpufreq/cpufreq_governor.h     |  40 ++++---
 drivers/cpufreq/cpufreq_ondemand.c     |  67 ++++++-----
 5 files changed, 220 insertions(+), 130 deletions(-)

-- 
2.4.0

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
