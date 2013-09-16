From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 00/44] CPUFreq Cleanup Series: Part I
Date: Mon, 16 Sep 2013 18:56:02 +0530
Message-ID: <cover.1379309339.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:63568 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207Ab3IPN0x (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Sep 2013 09:26:53 -0400
Received: by mail-pb0-f47.google.com with SMTP id rr4so4050101pbb.6
        for <linux-pm@vger.kernel.org>; Mon, 16 Sep 2013 06:26:53 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

Hi Rafael,

This is resent of patches earlier sent as part of big patchset:

http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg503397.html

These contain first set of patches that you can now include in
bleeding-edge/linux-next branches of your repo. I have included all Acks/Tested
by tags into the patches..

--
viresh

Hans-Christian Egtvedt (1):
  cpufreq: at32ap: add frequency table

Viresh Kumar (43):
  cpufreq: Add new helper cpufreq_table_validate_and_show()
  cpufreq: pxa: call cpufreq_frequency_table_get_attr()
  cpufreq: s3cx4xx: call cpufreq_frequency_table_get_attr()
  cpufreq: sparc: call cpufreq_frequency_table_get_attr()
  cpufreq: acpi-cpufreq: use cpufreq_table_validate_and_show()
  cpufreq: arm_big_little: use cpufreq_table_validate_and_show()
  cpufreq: blackfin: use cpufreq_table_validate_and_show()
  cpufreq: cpufreq-cpu0: use cpufreq_table_validate_and_show()
  cpufreq: cris: use cpufreq_table_validate_and_show()
  cpufreq: davinci: use cpufreq_table_validate_and_show()
  cpufreq: dbx500: use cpufreq_table_validate_and_show()
  cpufreq: e_powersaver: use cpufreq_table_validate_and_show()
  cpufreq: elanfreq: use cpufreq_table_validate_and_show()
  cpufreq: exynos: use cpufreq_table_validate_and_show()
  cpufreq: ia64-acpi: use cpufreq_table_validate_and_show()
  cpufreq: imx6q: use cpufreq_table_validate_and_show()
  cpufreq: kirkwood: use cpufreq_table_validate_and_show()
  cpufreq: longhaul: use cpufreq_table_validate_and_show()
  cpufreq: loongson2: use cpufreq_table_validate_and_show()
  cpufreq: maple: use cpufreq_table_validate_and_show()
  cpufreq: omap: use cpufreq_table_validate_and_show()
  cpufreq: p4-clockmod: use cpufreq_table_validate_and_show()
  cpufreq: pasemi: use cpufreq_table_validate_and_show()
  cpufreq: pmac: use cpufreq_table_validate_and_show()
  cpufreq: powernow: use cpufreq_table_validate_and_show()
  cpufreq: ppc: use cpufreq_table_validate_and_show()
  cpufreq: pxa: use cpufreq_table_validate_and_show()
  cpufreq: s3cx4xx: use cpufreq_table_validate_and_show()
  cpufreq: s5pv210: use cpufreq_table_validate_and_show()
  cpufreq: sa11x0: Expose frequency table
  cpufreq: sa11x0: let cpufreq core initialize struct policy fields
  cpufreq: sc520: use cpufreq_table_validate_and_show()
  cpufreq: sh: use cpufreq_table_validate_and_show()
  cpufreq: sparc: use cpufreq_table_validate_and_show()
  cpufreq: spear: use cpufreq_table_validate_and_show()
  cpufreq: speedstep: use cpufreq_table_validate_and_show()
  cpufreq: tegra: use cpufreq_table_validate_and_show()
  cpufreq: tegra: fix implementation of ->exit()
  cpufreq: arm_big_little: call cpufreq_frequency_table_put_attr()
  cpufreq: blackfin: call cpufreq_frequency_table_put_attr()
  cpufreq: exynos: call cpufreq_frequency_table_put_attr()
  cpufreq: loongson2: call cpufreq_frequency_table_put_attr()
  cpufreq: omap: call cpufreq_frequency_table_put_attr()

 arch/arm/mach-sa1100/generic.c         | 45 +++++++++++++++----------------
 arch/arm/mach-sa1100/generic.h         |  1 +
 drivers/cpufreq/acpi-cpufreq.c         |  4 +--
 drivers/cpufreq/arm_big_little.c       |  5 ++--
 drivers/cpufreq/at32ap-cpufreq.c       | 49 +++++++++++++++++++++++++++++++---
 drivers/cpufreq/blackfin-cpufreq.c     | 11 ++++++--
 drivers/cpufreq/cpufreq-cpu0.c         |  4 +--
 drivers/cpufreq/cris-artpec3-cpufreq.c | 10 +------
 drivers/cpufreq/cris-etraxfs-cpufreq.c | 10 +------
 drivers/cpufreq/davinci-cpufreq.c      |  6 ++---
 drivers/cpufreq/dbx500-cpufreq.c       |  6 ++---
 drivers/cpufreq/e_powersaver.c         |  3 +--
 drivers/cpufreq/elanfreq.c             |  8 +-----
 drivers/cpufreq/exynos-cpufreq.c       |  4 +--
 drivers/cpufreq/exynos5440-cpufreq.c   |  9 +++++--
 drivers/cpufreq/freq_table.c           | 12 +++++++++
 drivers/cpufreq/ia64-acpi-cpufreq.c    |  4 +--
 drivers/cpufreq/imx6q-cpufreq.c        |  3 +--
 drivers/cpufreq/kirkwood-cpufreq.c     | 10 +------
 drivers/cpufreq/longhaul.c             |  8 +-----
 drivers/cpufreq/loongson2_cpufreq.c    |  6 ++---
 drivers/cpufreq/maple-cpufreq.c        |  4 +--
 drivers/cpufreq/omap-cpufreq.c         |  5 ++--
 drivers/cpufreq/p4-clockmod.c          |  3 +--
 drivers/cpufreq/pasemi-cpufreq.c       |  4 +--
 drivers/cpufreq/pmac32-cpufreq.c       |  3 +--
 drivers/cpufreq/pmac64-cpufreq.c       |  4 +--
 drivers/cpufreq/powernow-k6.c          |  9 +------
 drivers/cpufreq/powernow-k7.c          |  4 +--
 drivers/cpufreq/powernow-k8.c          |  4 +--
 drivers/cpufreq/ppc-corenet-cpufreq.c  |  3 +--
 drivers/cpufreq/ppc_cbe_cpufreq.c      |  4 +--
 drivers/cpufreq/pxa2xx-cpufreq.c       | 15 ++++++++---
 drivers/cpufreq/pxa3xx-cpufreq.c       |  9 ++++++-
 drivers/cpufreq/s3c2416-cpufreq.c      |  4 +--
 drivers/cpufreq/s3c24xx-cpufreq.c      |  2 +-
 drivers/cpufreq/s3c64xx-cpufreq.c      |  2 +-
 drivers/cpufreq/s5pv210-cpufreq.c      |  4 +--
 drivers/cpufreq/sa1100-cpufreq.c       |  7 +++--
 drivers/cpufreq/sa1110-cpufreq.c       |  7 +++--
 drivers/cpufreq/sc520_freq.c           |  9 +------
 drivers/cpufreq/sh-cpufreq.c           |  6 ++---
 drivers/cpufreq/sparc-us2e-cpufreq.c   |  6 +++--
 drivers/cpufreq/sparc-us3-cpufreq.c    |  6 +++--
 drivers/cpufreq/spear-cpufreq.c        |  5 ++--
 drivers/cpufreq/speedstep-centrino.c   | 10 +------
 drivers/cpufreq/speedstep-ich.c        |  9 +------
 drivers/cpufreq/speedstep-smi.c        |  8 +-----
 drivers/cpufreq/tegra-cpufreq.c        |  5 ++--
 include/linux/cpufreq.h                |  2 ++
 50 files changed, 179 insertions(+), 202 deletions(-)

-- 
1.7.12.rc2.18.g61b472e

