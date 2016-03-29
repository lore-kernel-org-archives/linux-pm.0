From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/3] cpufreq: dt: Create platform device from generic code
Date: Tue, 29 Mar 2016 12:09:46 +0530
Message-ID: <cover.1459233524.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34981 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbcC2Gj6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 29 Mar 2016 02:39:58 -0400
Received: by mail-pa0-f42.google.com with SMTP id td3so6782822pab.2
        for <linux-pm@vger.kernel.org>; Mon, 28 Mar 2016 23:39:57 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com, xf@rock-chips.com, heiko@sntech.de, mmcclint@codeaurora.org, k.kozlowski@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>

Multiple platforms are using the generic cpufreq-dt driver now, and all
of them are required to create a platform device with name "cpufreq-dt",
in order to get the cpufreq-dt probed.

Many of them do it from platform code, others have special drivers just
to do that.

It would be more sensible to do this at a generic place, where all such
platform can mark their entries.

The first patch fixes an issue that becomes visible only after the
second patch is applied. The second one creates a new driver to create
platform-device based on current platform and the last one converts
exynos platform to use this common infrastructure.

I will migrate rest of the platforms after this is accepted as the right
way ahead.

V1->V2:
- Updated 3/3 to rebase on top of latest exynos changes
- Reviewed-by tags added

Viresh Kumar (3):
  cpufreq: dt: Include types.h from cpufreq-dt.h
  cpufreq: dt: Add generic platform-device creation support
  cpufreq: exynos: Use generic platdev driver

 arch/arm/mach-exynos/exynos.c        | 29 ------------------
 drivers/cpufreq/Kconfig              | 11 +++++++
 drivers/cpufreq/Makefile             |  1 +
 drivers/cpufreq/cpufreq-dt-platdev.c | 57 ++++++++++++++++++++++++++++++++++++
 include/linux/cpufreq-dt.h           |  2 ++
 5 files changed, 71 insertions(+), 29 deletions(-)
 create mode 100644 drivers/cpufreq/cpufreq-dt-platdev.c

-- 
2.7.1.410.g6faf27b

