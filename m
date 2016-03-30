From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 0/4] cpufreq: dt: Create platform device from generic code
Date: Wed, 30 Mar 2016 13:45:24 +0530
Message-ID: <cover.1459325515.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33147 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526AbcC3IPg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 04:15:36 -0400
Received: by mail-pf0-f180.google.com with SMTP id 4so36226022pfd.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Mar 2016 01:15:36 -0700 (PDT)
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

The first patch fixes an issue that came up with an earlier version of
patch 2/4, but its still worth fixing it.  The second one creates a new
driver to create platform-device based on current platform and the last
two converts exynos platform to use this common infrastructure.

I will migrate rest of the platforms after this is accepted as the right
way ahead.

V2->V3:
- 2/3 is very lightweight now and doesn't support cpufreq-dt
  platform-data and an extra depends_on from Kconfig is dropped as well.
- 3/3 is separated into two patches.

Viresh Kumar (4):
  cpufreq: dt: Include types.h from cpufreq-dt.h
  cpufreq: dt: Add generic platform-device creation support
  ARM: exynos: exynos-cpufreq platform device isn't supported anymore
  cpufreq: exynos: Use generic platdev driver

 arch/arm/mach-exynos/exynos.c        | 29 -------------------------
 drivers/cpufreq/Kconfig              | 10 +++++++++
 drivers/cpufreq/Makefile             |  1 +
 drivers/cpufreq/cpufreq-dt-platdev.c | 41 ++++++++++++++++++++++++++++++++++++
 include/linux/cpufreq-dt.h           |  2 ++
 5 files changed, 54 insertions(+), 29 deletions(-)
 create mode 100644 drivers/cpufreq/cpufreq-dt-platdev.c

-- 
2.7.1.410.g6faf27b

