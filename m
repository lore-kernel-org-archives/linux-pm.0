From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 00/12] cpufreq: Fix governor races - part 2
Date: Thu, 11 Jun 2015 16:21:43 +0530
Message-ID: <cover.1434019473.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34917 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751555AbbFKKwJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jun 2015 06:52:09 -0400
Received: by pacyx8 with SMTP id yx8so2264007pac.2
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2015 03:52:09 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi,

This is a next step of the earlier work I have posted [1].

The first 5 patches are minor cleanups, 6th & 7th try to optimize few
things to make code less complex.

Patches 8-11 actually solve (or try to solve :)) the synchronization
problems, or the crashes I was getting.

And the last one again optimizes code a bit.

I don't get the crashes anymore and want others to try. At least Preeti
and Ke Wang (Sorry if I haven't spelled it properly :( ), as you two
have reported the issues to me.

This patchset should be rebased over the earlier one [1].

To make things simple, all these patches are pushed here [2] and are
rebased over pm/bleeeding-edge because of some recent important changes
there:


[1] http://marc.info/?i=cover.1433326032.git.viresh.kumar%40linaro.org
[2] ssh://git@git.linaro.org/people/viresh.kumar/linux.git cpufreq/gov-locking

--
viresh

Viresh Kumar (12):
  cpufreq: governor: Name delayed-work as dwork
  cpufreq: governor: Drop unused field 'cpu'
  cpufreq: governor: Rename 'cpu_dbs_common_info' to 'cpu_dbs_info'
  cpufreq: governor: name pointer to cpu_dbs_info as 'cdbs'
  cpufreq: governor: rename cur_policy as policy
  cpufreq: governor: Keep single copy of information common to
    policy->cpus
  cpufreq: governor: split out common part of {cs|od}_dbs_timer()
  cpufreq: governor: synchronize work-handler with governor callbacks
  cpufreq: governor: Avoid invalid states with additional checks
  cpufreq: governor: Don't WARN on invalid states
  cpufreq: propagate errors returned from __cpufreq_governor()
  cpufreq: conservative: remove 'enable' field

 drivers/cpufreq/cpufreq.c              |  22 ++--
 drivers/cpufreq/cpufreq_conservative.c |  35 ++----
 drivers/cpufreq/cpufreq_governor.c     | 200 +++++++++++++++++++++++----------
 drivers/cpufreq/cpufreq_governor.h     |  36 +++---
 drivers/cpufreq/cpufreq_ondemand.c     |  68 +++++------
 5 files changed, 214 insertions(+), 147 deletions(-)

-- 
2.4.0

