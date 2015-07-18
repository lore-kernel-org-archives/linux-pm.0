From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 0/5] cpufreq: governor: Avoid invalid state-transitions
Date: Sat, 18 Jul 2015 11:30:58 +0530
Message-ID: <cover.1437199001.git.viresh.kumar@linaro.org>
References: <2874468.iRvuV1Y9DI@vostro.rjw.lan>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35203 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253AbbGRGBL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 18 Jul 2015 02:01:11 -0400
Received: by pdrg1 with SMTP id g1so71910827pdr.2
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2015 23:01:10 -0700 (PDT)
In-Reply-To: <2874468.iRvuV1Y9DI@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

These are rest of the patches after replacing 'ccdbs' with 'shared' as
you suggested.

Viresh Kumar (5):
  cpufreq: governor: Keep single copy of information common to
    policy->cpus
  cpufreq: governor: split out common part of {cs|od}_dbs_timer()
  cpufreq: governor: Avoid invalid states with additional checks
  cpufreq: governor: Don't WARN on invalid states
  cpufreq: propagate errors returned from __cpufreq_governor()

 drivers/cpufreq/cpufreq.c              |  31 ++++--
 drivers/cpufreq/cpufreq_conservative.c |  25 ++---
 drivers/cpufreq/cpufreq_governor.c     | 174 ++++++++++++++++++++++++++-------
 drivers/cpufreq/cpufreq_governor.h     |  26 +++--
 drivers/cpufreq/cpufreq_ondemand.c     |  58 +++++------
 5 files changed, 210 insertions(+), 104 deletions(-)

-- 
2.4.0

