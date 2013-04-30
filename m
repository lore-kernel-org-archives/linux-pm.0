From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/2] CPUFreq core fixes for v3.10-rc2
Date: Tue, 30 Apr 2013 20:02:16 +0530
Message-ID: <cover.1367332148.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:43698 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932252Ab3D3Occ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Apr 2013 10:32:32 -0400
Received: by mail-pd0-f170.google.com with SMTP id 15so336614pdi.29
        for <linux-pm@vger.kernel.org>; Tue, 30 Apr 2013 07:32:31 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

I just saw your pull request and so these should go in rc2 now.

These are fixes for cpufreq core and common governor part. They mostly impact
systems which have set have_governor_per_policy to true. i.e. big LITTLE cpufreq
driver.

Viresh Kumar (2):
  cpufreq: governors: Fix CPUFREQ_GOV_POLICY_{INIT|EXIT} notifiers
  cpufreq: Issue CPUFREQ_GOV_POLICY_EXIT notifier before dropping
    policy refcount

 drivers/cpufreq/cpufreq.c          |  6 +++---
 drivers/cpufreq/cpufreq_governor.c | 11 +++++++----
 drivers/cpufreq/cpufreq_governor.h |  1 +
 3 files changed, 11 insertions(+), 7 deletions(-)

-- 
1.7.12.rc2.18.g61b472e

