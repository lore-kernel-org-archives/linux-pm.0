From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 0/8] PM / devfreq: Update the devfreq and devfreq-event
 device
Date: Wed, 28 Dec 2016 20:56:44 +0900
Message-ID: <1482926212-19223-1-git-send-email-cw00.choi@samsung.com>
References: <CGME20161228115654epcas1p1dbe96f4f79ee451bd8eac960f1ea80c5@epcas1p1.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:52987 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbcL1L44 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Dec 2016 06:56:56 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: chanwoo@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>

This patches update the devfreq and devfreq-event device. I add the summary
of each patch as following.

- Patch1 is documented for bus frequency scaling of Exynos5433's VDD_INT.
  The related-to patches[1] were merged by Exynos SoC maintainer.
- Patch2 uses the regmap interface instead of raw_read/write function.
- Patch3/4 print the useful log for exynos-bus.c and exynos-ppmu.c driver.
- Patch5 fixes the checkpatch warning of devfreq.c.
- Patch6/7 modify the name of sysfs entry for devfreq/devfreq-event device
- Patch8 fixes the wrong description of govenro_userspace.c.

Changes from v1:
- Rebase these patches on v4.10-rc1.
- Include the separate patch[2] in these patches.

[1] https://lkml.org/lkml/2016/12/7/846
- [PATCH v2 0/5] arm64: dts: Enable bus frequency scaling on Exynos5433-based TM2 board
[2] https://lkml.org/lkml/2016/12/16/7
- [PATCH] PM / devfreq: Fix the wrong description for userspace governor


Depends on:
- These patches depend on both v4.10-rc1 and patches[3].

[3] https://lkml.org/lkml/2016/12/28/91
- [PATCH v2 0/3] PM / devfreq: Fix the bug and add reviewer for devfreq support

Chanwoo Choi (8):
  PM / devfreq: exynos-bus: Add the detailed correlation for Exynos5433
  PM / devfreq: exynos-ppmu: Use the regmap interface to handle the registers
  PM / devfreq: exynos-bus: Print the real clock rate of bus
  PM / devfreq: exynos-ppmu: Show the registred device for ppmu device
  PM / devfreq: Fix the checkpatch warnings
  PM / devfreq: Modify the device name as devfreq[X] for sysfs
  PM / devfreq: Simplify the sysfs name of devfreq-event device
  PM / devfreq: Fix the wrong description for userspace governor

 .../devicetree/bindings/devfreq/exynos-bus.txt     |  14 +
 drivers/devfreq/devfreq-event.c                    |   2 +-
 drivers/devfreq/devfreq.c                          |  17 +-
 drivers/devfreq/event/exynos-ppmu.c                | 331 +++++++++++++++------
 drivers/devfreq/exynos-bus.c                       |   8 +-
 drivers/devfreq/governor_userspace.c               |   3 +-
 6 files changed, 271 insertions(+), 104 deletions(-)

-- 
1.9.1

