From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 00/16] cpufreq: create & use cpufreq_generic_get() routine
Date: Fri, 23 Aug 2013 21:20:35 +0530
Message-ID: <cover.1377272740.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:52287 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754866Ab3HWPvq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2013 11:51:46 -0400
Received: by mail-pd0-f173.google.com with SMTP id p10so836138pdj.32
        for <linux-pm@vger.kernel.org>; Fri, 23 Aug 2013 08:51:46 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

CPUFreq drivers that use clock frameworks interface,i.e. clk_get_rate(), to get
CPUs clk rate, has similar sort of code used for most of them.

This patchset adds a generic ->get() which will do the same thing for them. All
those drivers are required to now is to set .get to cpufreq_generic_get() and
set their clk pointer in policy->clk during ->init().

Later part of this patchset fixes 17 drivers with this change.

That's part 7 of my generic cleanups for CPUFreq core, first six are here:

1: cpufreq: Introduce cpufreq_table_validate_and_show()
https://lkml.org/lkml/2013/8/8/263

2: cpufreq: define generic routines for cpufreq drivers
https://lkml.org/lkml/2013/8/10/48

3. CPUFreq: Implement light weight ->target(): for 3.13
https://lkml.org/lkml/2013/8/13/349

4. CPUFreq: set policy->cur in cpufreq core instead of drivers
https://lkml.org/lkml/2013/8/14/288

5. CPUFreq: Move freq change notifications out of drivers
https://lkml.org/lkml/2013/8/15/506

6. cpufreq: create & use cpufreq_generic_init() routine
http://lkml.org/lkml/2013/8/21/352

All these are pushed here:
https://git.linaro.org/gitweb?p=people/vireshk/linux.git;a=shortlog;h=refs/heads/for-v3.13

Viresh Kumar (16):
  cpufreq: create cpufreq_generic_get() routine
  cpufreq: arm_big_little: use cpufreq_generic_get() routine
  cpufreq: at32ap: use cpufreq_generic_get() routine
  cpufreq: cpu0: use cpufreq_generic_get() routine
  cpufreq: davinci: use cpufreq_generic_get() routine
  cpufreq: dbx500: use cpufreq_generic_get() routine
  cpufreq: exynos: use cpufreq_generic_get() routine
  cpufreq: imx6q: use cpufreq_generic_get() routine
  cpufreq: loongson2: use cpufreq_generic_get() routine
  cpufreq: omap: use cpufreq_generic_get() routine
  cpufreq: ppc: use cpufreq_generic_get() routine
  cpufreq: s3c: use cpufreq_generic_get() routine
  cpufreq: s5pv210: use cpufreq_generic_get() routine
  cpufreq: spear: use cpufreq_generic_get() routine
  cpufreq: tegra: use cpufreq_generic_get() routine
  cpufreq: unicore2: use cpufreq_generic_get() routine

 drivers/cpufreq/arm_big_little.c      | 10 ++--------
 drivers/cpufreq/at32ap-cpufreq.c      | 17 +++++------------
 drivers/cpufreq/cpufreq-cpu0.c        |  8 ++------
 drivers/cpufreq/cpufreq.c             | 26 ++++++++++++++++++++------
 drivers/cpufreq/davinci-cpufreq.c     | 13 +++----------
 drivers/cpufreq/dbx500-cpufreq.c      | 19 ++-----------------
 drivers/cpufreq/exynos-cpufreq.c      | 10 +++-------
 drivers/cpufreq/exynos5440-cpufreq.c  | 33 ++++++++++++++-------------------
 drivers/cpufreq/imx6q-cpufreq.c       |  8 ++------
 drivers/cpufreq/loongson2_cpufreq.c   | 15 +++++----------
 drivers/cpufreq/omap-cpufreq.c        | 32 ++++++++++----------------------
 drivers/cpufreq/ppc-corenet-cpufreq.c | 17 ++++-------------
 drivers/cpufreq/s3c24xx-cpufreq.c     | 10 +++-------
 drivers/cpufreq/s3c64xx-cpufreq.c     | 33 ++++++++++++---------------------
 drivers/cpufreq/s5pv210-cpufreq.c     | 21 ++++++---------------
 drivers/cpufreq/spear-cpufreq.c       |  8 ++------
 drivers/cpufreq/tegra-cpufreq.c       | 16 +++-------------
 drivers/cpufreq/unicore2-cpufreq.c    | 21 ++++++++-------------
 include/linux/cpufreq.h               |  3 +++
 19 files changed, 109 insertions(+), 211 deletions(-)

-- 
1.7.12.rc2.18.g61b472e

