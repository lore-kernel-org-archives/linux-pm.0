From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/3] cpufreq: governor: Fix potential races
Date: Wed,  3 Jun 2015 15:57:10 +0530
Message-ID: <cover.1433326032.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:33455 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbbFCK1m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2015 06:27:42 -0400
Received: by pdbqa5 with SMTP id qa5so4659902pdb.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2015 03:27:42 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

Preeti recently highlighted [1] some issues in cpufreq core locking with
respect to governors. I wanted to solve them after we have simplified
the hotplug paths in cpufreq core with my latest patches, but now that
she has poked me, I have done some work in that area.

I am trying to solve only a part of the bigger problem (in a way that I
feel is the right way ahead). The first patches restructures code to
make it more readable and the last patch does all the major changes. The
logs in that one should be good enough to explain why and what I am
doing.

The first two shouldn't bring any functional change and so can be
applied early if you are confident about them.

@Preeti: I would like you to test these patches. These should get rid of
the crashes you were facing but may generate a WARN() from line 447 of
cpufreq_governor.c, if the sequence is wrong. That has to be fixed
separately.

Line 447: WARN_ON(!dbs_data && (event != CPUFREQ_GOV_POLICY_INIT))

Rebased over: v4.1-rc6
Tested-on: ARM dual Cortex -A15 Exynos board.

[1] http://marc.info/?i=20150601064031.2972.59208.stgit%40perfhull-ltc.austin.ibm.com

Viresh Kumar (3):
  cpufreq: governor: register notifier from cs_init()
  cpufreq: governor: split cpufreq_governor_dbs()
  cpufreq: governor: Serialize governor callbacks

 drivers/cpufreq/cpufreq_conservative.c |  28 +--
 drivers/cpufreq/cpufreq_governor.c     | 340 ++++++++++++++++++---------------
 drivers/cpufreq/cpufreq_governor.h     |  16 +-
 drivers/cpufreq/cpufreq_ondemand.c     |   6 +-
 4 files changed, 209 insertions(+), 181 deletions(-)

-- 
2.4.0

