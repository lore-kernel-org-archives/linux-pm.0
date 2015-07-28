From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/4] cpufreq/opp: Turbo/boost mode support
Date: Tue, 28 Jul 2015 16:49:59 +0530
Message-ID: <cover.1438081962.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34370 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755601AbbG1LUQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 28 Jul 2015 07:20:16 -0400
Received: by pacan13 with SMTP id an13so69851276pac.1
        for <linux-pm@vger.kernel.org>; Tue, 28 Jul 2015 04:20:15 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, b.zolnierkie@samsung.com, nm@ti.com, sboyd@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

This is based of my opp-v2 series and so is sent as reply to that one.

Bartlomiej had few patches that he wanted to get into 4.3. I have picked
two of those and dropped one (the one that adds another field to
platform data). The dropped one is replaced with two patches from me.
There are minor modifications done in first two patches, based on the
review comments I gave to him earlier.

Completely Untested.

@Bartlomiej: Can you please give them some testing ?

Bartlomiej Zolnierkiewicz (2):
  opp: add dev_pm_opp_is_turbo() helper
  cpufreq: Update boost flag while initializing freq table from OPPs

Viresh Kumar (2):
  cpufreq: Allow drivers to enable boost support after registering
    driver
  cpufreq: dt: Add support for turbo/boost mode

 drivers/base/power/opp.c      | 30 ++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt.c  |  8 ++++++
 drivers/cpufreq/cpufreq.c     | 66 ++++++++++++++++++++++++++++++-------------
 drivers/cpufreq/cpufreq_opp.c |  4 +++
 drivers/cpufreq/freq_table.c  | 15 ++++++++++
 include/linux/cpufreq.h       | 12 ++++++++
 include/linux/pm_opp.h        |  7 +++++
 7 files changed, 122 insertions(+), 20 deletions(-)

-- 
2.4.0

