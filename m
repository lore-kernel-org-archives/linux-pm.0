From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/5] cpufreq: sysfs cleanup
Date: Sun, 11 Oct 2015 22:51:09 +0530
Message-ID: <cover.1444583718.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35035 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbbJKRVX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 11 Oct 2015 13:21:23 -0400
Received: by pabve7 with SMTP id ve7so74360327pab.2
        for <linux-pm@vger.kernel.org>; Sun, 11 Oct 2015 10:21:23 -0700 (PDT)
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

Viresh Kumar (5):
  cpufreq: Use cpumask_copy instead of cpumask_or to copy a mask
  cpufreq: create cpu/cpufreq at boot time
  cpufreq: remove cpufreq_sysfs_{create|remove}_file()
  cpufreq: create cpu/cpufreq/policyX directories
  cpufreq: Drop redundant check for inactive policies

 drivers/cpufreq/cpufreq.c          | 95 +++++---------------------------------
 drivers/cpufreq/cpufreq_governor.c | 20 ++------
 include/linux/cpufreq.h            |  5 --
 3 files changed, 16 insertions(+), 104 deletions(-)

-- 
2.4.0

