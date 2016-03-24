From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/3] cpufreq: dt: Create platform device from generic code
Date: Thu, 24 Mar 2016 12:10:27 +0530
Message-ID: <cover.1458801338.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35515 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750850AbcCXGku (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Mar 2016 02:40:50 -0400
Received: by mail-pf0-f179.google.com with SMTP id n5so49782724pfn.2
        for <linux-pm@vger.kernel.org>; Wed, 23 Mar 2016 23:40:50 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, arnd.bergmann@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, kgene.kim@samsung.com, xf@rock-chips.com, heiko@sntech.de, mmcclint@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

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

@Arnd: Does this look sane? We can fix the arm64 (no platform code)
issue with this now.

Viresh Kumar (3):
  cpufreq: dt: Include types.h from cpufreq-dt.h
  cpufreq: dt: Add generic platform-device creation support
  cpufreq: exynos: Use generic platdev driver

 arch/arm/mach-exynos/exynos.c        | 25 -----------------
 drivers/cpufreq/Kconfig              | 11 ++++++++
 drivers/cpufreq/Makefile             |  1 +
 drivers/cpufreq/cpufreq-dt-platdev.c | 53 ++++++++++++++++++++++++++++++++++++
 include/linux/cpufreq-dt.h           |  2 ++
 5 files changed, 67 insertions(+), 25 deletions(-)
 create mode 100644 drivers/cpufreq/cpufreq-dt-platdev.c

-- 
2.7.1.410.g6faf27b

