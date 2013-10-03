From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 Resend 00/92] CPUFreq Cleanup Series: Part II
Date: Thu,  3 Oct 2013 20:27:54 +0530
Message-ID: <cover.1380783079.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

As discussed earlier, Part I is now part of your linux-next branch and so
sending Part II for inclusion in bleeding-edge..

These are mostly oriented towards using generic .attr, .init(), .exit() and
.verify() and are so clubbed together.

These doesn't conflict mostly with the other 11 cpufreq core cleanup patches
that are floating around:
http://www.spinics.net/lists/cpufreq/msg07920.html

Only a minor conflict with following patch of that series for arm_big_little.c
file:
http://www.spinics.net/lists/cpufreq/msg07929.html

You can resolve it easily, pretty straight forward.

These are based of your linux-next branch:
ba93c78 Merge branch 'pm-cpufreq-next' into linux-next

Thanks..

--
Viresh

Viresh Kumar (92):
  cpufreq: define generic .attr, .exit() and .verify() routines
  cpufreq: acpi: Use generic cpufreq routines
  cpufreq: arm_big_little: Use generic cpufreq routines
  cpufreq: at32ap: Use generic cpufreq routines
  cpufreq: blackfin: Use generic cpufreq routines
  cpufreq: cpu0: Use generic cpufreq routines
  cpufreq: cris: Use generic cpufreq routines
  cpufreq: davinci: Use generic cpufreq routines
  cpufreq: dbx500: Use generic cpufreq routines
  cpufreq: e_powersaver: Use generic cpufreq routines
  cpufreq: elanfreq: Use generic cpufreq routines
  cpufreq: exynos: Use generic cpufreq routines
  cpufreq: ia64-acpi: Use generic cpufreq routines
  cpufreq: imx6q: Use generic cpufreq routines
  cpufreq: kirkwood: Use generic cpufreq routines
  cpufreq: longhaul: Use generic cpufreq routines
  cpufreq: loongson2: Use generic cpufreq routines
  cpufreq: maple: Use generic cpufreq routines
  cpufreq: omap: Use generic cpufreq routines
  cpufreq: p4-clockmod: Use generic cpufreq routines
  cpufreq: pasemi: Use generic cpufreq routines
  cpufreq: pmac: Use generic cpufreq routines
  cpufreq: powernow: Use generic cpufreq routines
  cpufreq: ppc-corenet: Use generic cpufreq routines
  cpufreq: ppc_cbe: Use generic cpufreq routines
  cpufreq: pxa: Use generic cpufreq routines
  cpufreq: s3cx4xx: Use generic cpufreq routines
  cpufreq: s5pv210: Use generic cpufreq routines
  cpufreq: sa11x0: Use generic cpufreq routines
  cpufreq: sc520: Use generic cpufreq routines
  cpufreq: sh: Use generic cpufreq routines
  cpufreq: sparc: Use generic cpufreq routines
  cpufreq: spear: Use generic cpufreq routines
  cpufreq: speedstep: Use generic cpufreq routines
  cpufreq: tegra: Use generic cpufreq routines
  cpufreq: call cpufreq_driver->get() after calling ->init()
  cpufreq: acpi: don't initialize part of policy that is set by core
    too
  cpufreq: arm_big_little: don't initialize part of policy that is set
    by core too
  cpufreq: at32ap: don't initialize part of policy that is set by core
    too
  cpufreq: blackfin: don't initialize part of policy that is set by
    core too
  cpufreq: cpu0: don't initialize part of policy that is set by core
    too
  cpufreq: nforce2: don't initialize part of policy that is set by core
    too
  cpufreq: cris: don't initialize part of policy that is set by core
    too
  cpufreq: davinci: don't initialize part of policy that is set by core
    too
  cpufreq: dbx500: don't initialize part of policy that is set by core
    too
  cpufreq: e_powersaver: don't initialize part of policy that is set by
    core too
  cpufreq: elanfreq: don't initialize part of policy that is set by
    core too
  cpufreq: exynos: don't initialize part of policy that is set by core
    too
  cpufreq: gx: don't initialize part of policy that is set by core too
  cpufreq: ia64-acpi: don't initialize part of policy that is set by
    core too
  cpufreq: imx6q: don't initialize part of policy that is set by core
    too
  cpufreq: integrator: don't initialize part of policy that is set by
    core too
  cpufreq: kirkwood: don't initialize part of policy that is set by
    core too
  cpufreq: longhaul: don't initialize part of policy that is set by
    core too
  cpufreq: loongson2: don't initialize part of policy that is set by
    core too
  cpufreq: maple: don't initialize part of policy that is set by core
    too
  cpufreq: omap: don't initialize part of policy that is set by core
    too
  cpufreq: p4: don't initialize part of policy that is set by core too
  cpufreq: pcc: don't initialize part of policy that is set by core too
  cpufreq: pmac: don't initialize part of policy that is set by core
    too
  cpufreq: powernow: don't initialize part of policy that is set by
    core too
  cpufreq: ppc: don't initialize part of policy that is set by core too
  cpufreq: pxa: don't initialize part of policy that is set by core too
  cpufreq: s3c: don't initialize part of policy that is set by core too
  cpufreq: s5pv210: don't initialize part of policy that is set by core
    too
  cpufreq: sa11x0: don't initialize part of policy that is set by core
    too
  cpufreq: sc520_freq: don't initialize part of policy that is set by
    core too
  cpufreq: sh: don't initialize part of policy that is set by core too
  cpufreq: spear: don't initialize part of policy that is set by core
    too
  cpufreq: speedstep: don't initialize part of policy that is set by
    core too
  cpufreq: tegra: don't initialize part of policy that is set by core
    too
  cpufreq: unicore2: don't initialize part of policy that is set by
    core too
  cpufreq: create cpufreq_generic_init() routine
  cpufreq: remove CONFIG_CPU_FREQ_TABLE
  cpufreq: cpu0: use cpufreq_generic_init() routine
  cpufreq: cris: use cpufreq_generic_init() routine
  cpufreq: davinci: use cpufreq_generic_init() routine
  cpufreq: dbx500: use cpufreq_generic_init() routine
  cpufreq: exynos: use cpufreq_generic_init() routine
  cpufreq: imx6q: use cpufreq_generic_init() routine
  cpufreq: kirkwood: use cpufreq_generic_init() routine
  cpufreq: loongson2: use cpufreq_generic_init() routine
  cpufreq: maple: use cpufreq_generic_init() routine
  cpufreq: omap: use cpufreq_generic_init() routine
  cpufreq: pasemi: use cpufreq_generic_init() routine
  cpufreq: pmac32: use cpufreq_generic_init() routine
  cpufreq: pmac64: use cpufreq_generic_init() routine
  cpufreq: s3c: use cpufreq_generic_init() routine
  cpufreq: s5pv210: use cpufreq_generic_init() routine
  cpufreq: sa11x0: use cpufreq_generic_init() routine
  cpufreq: spear: use cpufreq_generic_init() routine
  cpufreq: tegra: use cpufreq_generic_init() routine

 arch/arm/mach-davinci/Kconfig          |  1 -
 arch/arm/mach-pxa/Kconfig              |  3 --
 arch/arm/mach-sa1100/generic.c         | 22 ------------
 arch/arm/mach-sa1100/generic.h         |  1 -
 arch/arm/mach-ux500/Kconfig            |  1 -
 arch/blackfin/Kconfig                  |  1 -
 arch/cris/Kconfig                      |  2 --
 drivers/cpufreq/Kconfig                | 11 ------
 drivers/cpufreq/Kconfig.arm            | 11 ------
 drivers/cpufreq/Kconfig.powerpc        |  6 ----
 drivers/cpufreq/Kconfig.x86            | 13 --------
 drivers/cpufreq/Makefile               |  5 +--
 drivers/cpufreq/acpi-cpufreq.c         | 12 +------
 drivers/cpufreq/arm_big_little.c       | 20 ++---------
 drivers/cpufreq/at32ap-cpufreq.c       | 24 +++----------
 drivers/cpufreq/blackfin-cpufreq.c     | 24 ++-----------
 drivers/cpufreq/cpufreq-cpu0.c         | 43 +++---------------------
 drivers/cpufreq/cpufreq-nforce2.c      |  1 -
 drivers/cpufreq/cpufreq.c              | 44 ++++++++++++++++++++++--
 drivers/cpufreq/cris-artpec3-cpufreq.c | 30 +++--------------
 drivers/cpufreq/cris-etraxfs-cpufreq.c | 28 +++-------------
 drivers/cpufreq/davinci-cpufreq.c      | 27 ++-------------
 drivers/cpufreq/dbx500-cpufreq.c       | 40 ++--------------------
 drivers/cpufreq/e_powersaver.c         | 16 ++-------
 drivers/cpufreq/elanfreq.c             | 33 ++----------------
 drivers/cpufreq/exynos-cpufreq.c       | 32 +++---------------
 drivers/cpufreq/exynos5440-cpufreq.c   | 31 +++--------------
 drivers/cpufreq/freq_table.c           | 20 +++++++++++
 drivers/cpufreq/gx-suspmod.c           |  5 +--
 drivers/cpufreq/ia64-acpi-cpufreq.c    | 27 ++-------------
 drivers/cpufreq/imx6q-cpufreq.c        | 36 +++-----------------
 drivers/cpufreq/integrator-cpufreq.c   |  5 ++-
 drivers/cpufreq/kirkwood-cpufreq.c     | 28 +++-------------
 drivers/cpufreq/longhaul.c             | 24 ++-----------
 drivers/cpufreq/loongson2_cpufreq.c    | 20 ++---------
 drivers/cpufreq/maple-cpufreq.c        | 24 ++-----------
 drivers/cpufreq/omap-cpufreq.c         | 61 ++++++++--------------------------
 drivers/cpufreq/p4-clockmod.c          | 24 ++-----------
 drivers/cpufreq/pasemi-cpufreq.c       | 23 ++-----------
 drivers/cpufreq/pcc-cpufreq.c          |  7 ----
 drivers/cpufreq/pmac32-cpufreq.c       | 22 ++----------
 drivers/cpufreq/pmac64-cpufreq.c       | 24 ++-----------
 drivers/cpufreq/powernow-k6.c          | 23 ++-----------
 drivers/cpufreq/powernow-k7.c          | 16 ++-------
 drivers/cpufreq/powernow-k8.c          | 23 ++-----------
 drivers/cpufreq/ppc-corenet-cpufreq.c  | 19 ++---------
 drivers/cpufreq/ppc_cbe_cpufreq.c      | 15 ++-------
 drivers/cpufreq/pxa2xx-cpufreq.c       | 29 ++--------------
 drivers/cpufreq/pxa3xx-cpufreq.c       | 22 +++---------
 drivers/cpufreq/s3c2416-cpufreq.c      | 27 +++------------
 drivers/cpufreq/s3c24xx-cpufreq.c      | 27 +--------------
 drivers/cpufreq/s3c64xx-cpufreq.c      | 17 ++--------
 drivers/cpufreq/s5pv210-cpufreq.c      | 16 ++-------
 drivers/cpufreq/sa1100-cpufreq.c       |  9 ++---
 drivers/cpufreq/sa1110-cpufreq.c       |  9 ++---
 drivers/cpufreq/sc520_freq.c           | 25 ++------------
 drivers/cpufreq/sh-cpufreq.c           |  9 +----
 drivers/cpufreq/sparc-us2e-cpufreq.c   |  8 +----
 drivers/cpufreq/sparc-us3-cpufreq.c    |  8 +----
 drivers/cpufreq/spear-cpufreq.c        | 38 +++------------------
 drivers/cpufreq/speedstep-centrino.c   | 27 ++-------------
 drivers/cpufreq/speedstep-ich.c        | 45 +++----------------------
 drivers/cpufreq/speedstep-smi.c        | 43 ++----------------------
 drivers/cpufreq/tegra-cpufreq.c        | 30 +++++++----------
 drivers/cpufreq/unicore2-cpufreq.c     |  1 -
 drivers/thermal/Kconfig                |  1 -
 include/linux/cpufreq.h                | 11 ++++++
 67 files changed, 226 insertions(+), 1104 deletions(-)

-- 
1.7.12.rc2.18.g61b472e

