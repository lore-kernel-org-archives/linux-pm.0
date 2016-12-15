From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 0/7] PM / devfreq: Update the devfreq and devfreq-event device
Date: Thu, 15 Dec 2016 18:30:36 +0900
Message-ID: <1481794243-5046-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:45696 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934218AbcLOJbU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Dec 2016 04:31:20 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rjw@rjwysocki.net, chanwoo@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

This patches update the devfreq and devfreq-event device. I add the summary
of each patch as following.

- Patch1 is documented for bus frequency scaling of Exynos5433's VDD_INT.
  The related-to patches[1] were merged by Exynos SoC maintainer.
- Patch2 uses the regmap interface instead of raw_read/write function.
- Patch3/4 print the useful log for exynos-bus.c and exynos-ppmu.c driver.
- Patch5 fixes the checkpatch warning of devfreq.c.
- Patch6/7 modify the name of sysfs entry for devfreq/devfreq-event device

[1] https://lkml.org/lkml/2016/12/7/846
- ("[PATCH v2 0/5] arm64: dts: Enable bus frequency scaling on Exynos5433-based TM2 board")

Chanwoo Choi (7):
  PM / devfreq: exynos-bus: Add the detailed correlation for Exynos5433
  PM / devfreq: exynos-ppmu: Use the regmap interface to handle the registers
  PM / devfreq: exynos-bus: Print the real clock rate of bus
  PM / devfreq: exynos-ppmu: Show the registred device for ppmu device
  PM / devfreq: Fix the checkpatch warnings
  PM / devfreq: Modify the device name as devfreq[X] for sysfs
  PM / devfreq: Simplify the sysfs name of devfreq-event device

 .../devicetree/bindings/devfreq/exynos-bus.txt     |  14 +
 drivers/devfreq/devfreq-event.c                    |   2 +-
 drivers/devfreq/devfreq.c                          |  17 +-
 drivers/devfreq/event/exynos-ppmu.c                | 331 +++++++++++++++------
 drivers/devfreq/exynos-bus.c                       |   8 +-
 5 files changed, 270 insertions(+), 102 deletions(-)

-- 
1.9.1

