From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/4] PM / OPP: Fixes
Date: Thu,  5 Nov 2015 14:21:17 +0530
Message-ID: <cover.1446713282.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33458 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032923AbbKEIve (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2015 03:51:34 -0500
Received: by pabfh17 with SMTP id fh17so81604018pab.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2015 00:51:34 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

V1 only contained a single patch, i.e. 2/4 from this series. And then
there were few suggestions to incorporate.

All are marked for stable 4.3, as this got changed recently.

I have tested it on exynos (Yeah, I was able to reproduce the lockdep
with few config changes).

Viresh Kumar (4):
  PM / OPP: Propagate error properly from dev_pm_opp_set_sharing_cpus()
  PM / OPP: Protect updates to list_dev with mutex
  PM / OPP: Hold dev_opp_list_lock for writers
  PM / OPP: Add opp_rcu_lockdep_assert() to _find_device_opp()

 drivers/base/power/opp/core.c | 21 +++++++++++++++++----
 drivers/base/power/opp/cpu.c  | 10 +++++-----
 drivers/base/power/opp/opp.h  |  3 +++
 3 files changed, 25 insertions(+), 9 deletions(-)

-- 
2.6.2.198.g614a2ac

