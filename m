From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/7] CPUFreq: Minor cleanups
Date: Mon,  3 Aug 2015 08:36:13 +0530
Message-ID: <cover.1438571116.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:32953 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752335AbbHCDG0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 2 Aug 2015 23:06:26 -0400
Received: by padck2 with SMTP id ck2so78247063pad.0
        for <linux-pm@vger.kernel.org>; Sun, 02 Aug 2015 20:06:26 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

I was looking at cpufreq core this morning for some work and got these
minor fixes on the way. Please see if they look good.

--
viresh

Viresh Kumar (7):
  cpufreq: remove redundant CPUFREQ_INCOMPATIBLE notifier event
  cpufreq: use memcpy() to copy policy
  cpufreq: update user_policy.* on success
  cpufreq: remove redundant 'governor' field from user_policy
  cpufreq: remove redundant 'policy' field from user_policy
  cpufreq: rename cpufreq_real_policy as cpufreq_user_policy
  cpufreq: drop !cpufreq_driver check from cpufreq_parse_governor()

 Documentation/cpu-freq/core.txt       |  7 ++-----
 drivers/acpi/processor_perflib.c      |  2 +-
 drivers/cpufreq/cpufreq.c             | 31 +++----------------------------
 drivers/cpufreq/ppc_cbe_cpufreq_pmi.c |  4 ++--
 drivers/video/fbdev/pxafb.c           |  1 -
 drivers/video/fbdev/sa1100fb.c        |  1 -
 include/linux/cpufreq.h               | 15 ++++++---------
 7 files changed, 14 insertions(+), 47 deletions(-)

-- 
2.4.0

