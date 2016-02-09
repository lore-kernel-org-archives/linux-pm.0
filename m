From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 0/7] cpufreq: Locking fixes and cleanups
Date: Tue,  9 Feb 2016 09:16:12 +0530
Message-ID: <cover.1454988792.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35364 "EHLO
	mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbcBIDrV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 22:47:21 -0500
Received: by mail-pf0-f178.google.com with SMTP id c10so53699677pfc.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2016 19:47:20 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, juri.lelli@arm.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shilpa.bhat@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

These are rest of the patches that fix some more locking issues with
policy->rwsem and do some minor optimization/cleanups.

These were part of the 13 patch series which was sent earlier. The last
patch is new, and does what I suggested to one of your commits.

V3->V4:
- Reordered all the patches and created a new series.
- s/global/common for common tunables
- One new patch

@Juri/Shilpa: I have added your Tested-by for the first 6 patches,
please let me know if you don't want to add that.

Viresh Kumar (7):
  cpufreq: Merge cpufreq_offline_prepare/finish routines
  cpufreq: Call __cpufreq_governor() with policy->rwsem held
  cpufreq: Remove cpufreq_governor_lock
  cpufreq: governor: Move common sysfs tunables to cpufreq_governor.c
  cpufreq: governor: No need to manage state machine now
  cpufreq: conservative: Update sample_delay_ns immediately
  cpufreq: ondemand: Rearrange od_dbs_timer() to void updating delay

 drivers/cpufreq/cpufreq.c              |  93 +++++++++---------
 drivers/cpufreq/cpufreq_conservative.c |  80 +++-------------
 drivers/cpufreq/cpufreq_governor.c     | 170 ++++++++++++++++++++++++++++-----
 drivers/cpufreq/cpufreq_governor.h     |  16 +++-
 drivers/cpufreq/cpufreq_ondemand.c     | 153 +++++------------------------
 5 files changed, 240 insertions(+), 272 deletions(-)

-- 
2.7.1.370.gb2aa7f8

