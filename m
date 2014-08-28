From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 00/10] CPUFreq: cpufreq-cpu0 updates for 3.{17|18 ?}
Date: Thu, 28 Aug 2014 11:22:22 +0530
Message-ID: <cover.1409201048.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:65124 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbaH1Fwq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Aug 2014 01:52:46 -0400
Received: by mail-pa0-f49.google.com with SMTP id kq14so1106858pab.36
        for <linux-pm@vger.kernel.org>; Wed, 27 Aug 2014 22:52:45 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shawn.guo@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, spk.linux@gmail.com, thomas.ab@samsung.com, t.figa@samsung.com, santosh.shilimkar@ti.com, thomas.petazzoni@free-electrons.com, pramod.gurav@smartplayin.com, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

I am sending this again, but without the controversial part this time. I have
dropped last two patches which were about detecting clock sharing among CPUs.
Would fix up that later once other Maintainers get in sync about the bindings.

So, what's left here ? These are mostly updates/reorders which can be applied
the patches which I have dropped now. These are all well reviewed and tested
by others. Getting them in shouldn't break anything, I believe. Its better
people start using the updates we already have, otherwise they will keep on
sending fixes they get (The way Pramod Gurav tried it today).

Can we please get them in 3.17 if its still allowed? Or -next otherwise.

V2: https://lkml.org/lkml/2014/7/1/358

Rebased over: 3.17-rc2

git://git.linaro.org/people/viresh.kumar/linux.git cpufreq/cpu0-updates-v3

V2->V3: Dropped few patches, nothing much.

--
Thanks
Viresh

Viresh Kumar (10):
  cpufreq: Add support for per-policy driver data
  cpufreq: cpu0: Update Module Author
  cpufreq: cpu0: don't validate clock on clk_put()
  cpufreq: cpu0: print relevant error when we defer probe
  cpufreq: cpu0: use dev_{err|warn|dbg} instead of pr_{err|warn|debug}
  cpufreq: cpu0: Move per-cluster initialization code to ->init()
  cpufreq: cpu0: try regulators with name "cpu-supply"
  cpufreq: cpu0: Make allocate_resources() work for any CPU
  cpufreq: cpu0: rename driver and internals to 'cpufreq_generic'
  cpufreq: generic: set platform_{driver|device} '.name' to
    'cpufreq-generic'

 .../{cpufreq-cpu0.txt => cpufreq-generic.txt}      |   8 +-
 arch/arm/mach-imx/imx27-dt.c                       |   2 +-
 arch/arm/mach-imx/mach-imx51.c                     |   2 +-
 arch/arm/mach-omap2/pm.c                           |   2 +-
 arch/arm/mach-shmobile/board-ape6evm-reference.c   |   2 +-
 arch/arm/mach-shmobile/cpufreq.c                   |   2 +-
 arch/arm/mach-shmobile/setup-sh73a0.c              |   4 +-
 arch/arm/mach-zynq/common.c                        |   2 +-
 drivers/cpufreq/Kconfig                            |  10 +-
 drivers/cpufreq/Kconfig.arm                        |   2 +-
 drivers/cpufreq/Makefile                           |   2 +-
 drivers/cpufreq/cpufreq-cpu0.c                     | 248 --------------
 drivers/cpufreq/cpufreq-generic.c                  | 363 +++++++++++++++++++++
 drivers/cpufreq/exynos4210-cpufreq.c               |   2 +-
 drivers/cpufreq/exynos4x12-cpufreq.c               |   2 +-
 drivers/cpufreq/exynos5250-cpufreq.c               |   2 +-
 drivers/cpufreq/highbank-cpufreq.c                 |   6 +-
 drivers/cpufreq/s5pv210-cpufreq.c                  |   2 +-
 include/linux/cpufreq.h                            |   3 +
 19 files changed, 392 insertions(+), 274 deletions(-)
 rename Documentation/devicetree/bindings/cpufreq/{cpufreq-cpu0.txt => cpufreq-generic.txt} (85%)
 delete mode 100644 drivers/cpufreq/cpufreq-cpu0.c
 create mode 100644 drivers/cpufreq/cpufreq-generic.c

-- 
2.0.3.693.g996b0fd

