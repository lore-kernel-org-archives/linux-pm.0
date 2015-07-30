From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/6] thermal/cpu_cooling: Minor cleanups
Date: Thu, 30 Jul 2015 12:40:29 +0530
Message-ID: <cover.1438239727.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:35541 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775AbbG3HKo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 30 Jul 2015 03:10:44 -0400
Received: by pdrg1 with SMTP id g1so19665175pdr.2
        for <linux-pm@vger.kernel.org>; Thu, 30 Jul 2015 00:10:43 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, rui.zhang@intel.com, linux-pm@vger.kernel.org, radivoje.jovanovic@linux.intel.com, punit.agrawal@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

Eduardo,

Radivoje and Punit asked me to look into a patch Radivoje has posted
recently and that got me to fix few things. It doesn't do anything
related to what Radivoje had in his patch though.

Viresh Kumar (6):
  thermal/cpu_cooling: No need to initialize max_freq to 0
  thermal/cpu_cooling: quit early after updating policy
  thermal/cpu_cooling: convert 'switch' block to 'if' block in notifier
  thermal/cpu_cooling: rename cpufreq_val as clipped_freq
  thermal/cpu_cooling: rename max_freq as clipped_freq in notifier
  thermal/cpu_cooling: update policy limits if clipped_freq <
    policy->max

 drivers/thermal/cpu_cooling.c | 46 ++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 20 deletions(-)

-- 
2.4.0

