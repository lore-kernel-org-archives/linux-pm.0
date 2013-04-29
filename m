From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/5] CPUFreq: ARM big LITTLE Fixes
Date: Mon, 29 Apr 2013 18:54:43 +0530
Message-ID: <cover.1367241503.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:43550 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758002Ab3D2NZJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Apr 2013 09:25:09 -0400
Received: by mail-pd0-f171.google.com with SMTP id t10so819916pdi.30
        for <linux-pm@vger.kernel.org>; Mon, 29 Apr 2013 06:25:09 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, arvind.chauhan@arm.com, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

I know I am late for this merge window and you have already closed the gates :)
If you can still take them, its good, otherwise we will push this for v3.10-rc2.

These are minor fixes for ARM big LITTLE cpufreq driver. It doesn't impact any
other driver or cpufreq core and are fairly independent.

Viresh Kumar (5):
  cpufreq: ARM big LITTLE: Select PM_OPP
  cpufreq: ARM big LITTLE DT: Return correct transition latency
  cpufreq: ARM big LITTLE DT: Return CPUFREQ_ETERNAL if clock-latency
    isn't found
  cpufreq: ARM big LITTLE: Move cpu_to_cluster() to arm_big_little.h
  cpufreq: ARM big LITTLE: Improve print message

 drivers/cpufreq/Kconfig.arm         | 1 +
 drivers/cpufreq/arm_big_little.c    | 7 +------
 drivers/cpufreq/arm_big_little.h    | 5 +++++
 drivers/cpufreq/arm_big_little_dt.c | 9 +++++----
 4 files changed, 12 insertions(+), 10 deletions(-)

-- 
1.7.12.rc2.18.g61b472e

