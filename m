From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/5] cpufreq: sysfs cleanup
Date: Thu, 15 Oct 2015 21:35:20 +0530
Message-ID: <cover.1444924623.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33008 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309AbbJOQFg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2015 12:05:36 -0400
Received: by pabrc13 with SMTP id rc13so91720448pab.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2015 09:05:36 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Rafael,

This is in response to the other thread where you and Saravana were
discussing this. It doesn't allow updating policy for offline CPUs yet,
but does cleanup the sysfs stuff.

This is untested by me as I didn't had access to the hardware to test
this week. But this is tested by Fengguang's build bot for some time
now.

Will be good if one of you can test this out.

V1->V2:
- Change log updated for the first patch
- One patch already applied and the last one is a new patch based on
  Saravana's comments.
- Reviewed-by tags from Saravana.

Viresh Kumar (5):
  cpufreq: Use cpumask_copy instead of cpumask_or to copy a mask
  cpufreq: create cpu/cpufreq at boot time
  cpufreq: remove cpufreq_sysfs_{create|remove}_file()
  cpufreq: create cpu/cpufreq/policyX directories
  cpufreq: postfix policy directory with the first CPU in related_cpus

 drivers/cpufreq/cpufreq.c          | 103 +++++++------------------------------
 drivers/cpufreq/cpufreq_governor.c |  20 ++-----
 include/linux/cpufreq.h            |   5 --
 3 files changed, 24 insertions(+), 104 deletions(-)

-- 
2.4.0

