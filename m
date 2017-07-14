From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management updates for v4.13-rc1
Date: Fri, 14 Jul 2017 21:58:59 +0800
Message-ID: <1500040739.2530.6.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:33612 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753634AbdGNN7E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Jul 2017 09:59:04 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal Management updates for v4.13-rc1 with
top-most commit 5d72ed35678a351a1aed4b454c25d583f8bccb28:

  Merge branches 'thermal-core', 'thermal-intel' and 'thermal-soc' into
next (2017-07-05 15:01:06 +0800)

on top of commit c0bc126f97fb929b3ae02c1c62322645d70eb408:

  Linux 4.12-rc7 (2017-06-25 18:30:05 -0700)

Specifics:

- Improve thermal cpu_cooling interaction with cpufreq core. The
cpu_cooling driver is designed to use CPU frequency scaling to avoid
high thermal states for a platform. But it wasn't glued really well
with cpufreq core. For example clipped-cpus is copied from the policy
structure and its much better to use the policy->cpus (or related_cpus)
fields directly as they may have got updated. Not that things were
broken before this series, but they can be optimized a bit more. This
series tries to improve interactions between cpufreq core and
cpu_cooling driver and does some fixes/cleanups to the cpu_cooling
driver. (Viresh Kumar)

- A couple of fixes and cleanups in thermal core and imx, hisilicon,
bcm_2835, int340x thermal drivers. (Arvind Yadav, Dan Carpenter, Sumeet
Pawnikar, Srinivas Pandruvada, Willy WOLFF)

thanks,
rui

----------------------------------------------------------------
Arvind Yadav (2):
      thermal: imx: Handle return value of clk_prepare_enable
      thermal: hisilicon: Handle return value of clk_prepare_enable

Dan Carpenter (1):
      thermal: bcm2835: fix an error code in probe()

Srinivas Pandruvada (1):
      thermal: int340x: check for sensor when PTYP is missing

Sumeet Pawnikar (1):
      Thermal/int340x: Fix few typos and kernel-doc style

Viresh Kumar (18):
      thermal: cpu_cooling: Avoid accessing potentially freed
structures
      thermal: cpu_cooling: rearrange globals
      thermal: cpu_cooling: Name cpufreq cooling devices as
cpufreq_cdev
      thermal: cpu_cooling: replace cool_dev with cdev
      thermal: cpu_cooling: remove cpufreq_cooling_get_level()
      thermal: cpu_cooling: get rid of a variable in
cpufreq_set_cur_state()
      thermal: cpu_cooling: use cpufreq_policy to register cooling
device
      cpufreq: create cpufreq_table_count_valid_entries()
      thermal: cpu_cooling: store cpufreq policy
      thermal: cpu_cooling: OPPs are registered for all CPUs
      thermal: cpu_cooling: get rid of 'allowed_cpus'
      thermal: cpu_cooling: merge frequency and power tables
      thermal: cpu_cooling: create structure for idle time stats
      thermal: cpu_cooling: get_level() can't fail
      thermal: cpu_cooling: don't store cpu_dev in cpufreq_cdev
      thermal: cpu_cooling: 'freq' can't be zero in
cpufreq_state2power()
      thermal: cpu_cooling: Rearrange struct cpufreq_cooling_device
      thermal: cpu_cooling: Replace kmalloc with kmalloc_array

Willy WOLFF (1):
      thermal: fix source code documentation for parameters

Zhang Rui (2):
      Merge branch 'linus' of git://git.kernel.org/.../evalenti/linux-
soc-thermal into thermal-soc
      Merge branches 'thermal-core', 'thermal-intel' and 'thermal-soc'
into next

 drivers/cpufreq/arm_big_little.c                   |   2 +-
 drivers/cpufreq/cpufreq-dt.c                       |   2 +-
 drivers/cpufreq/cpufreq_stats.c                    |  13 +-
 drivers/cpufreq/dbx500-cpufreq.c                   |   2 +-
 drivers/cpufreq/mt8173-cpufreq.c                   |   4 +-
 drivers/cpufreq/qoriq-cpufreq.c                    |   3 +-
 drivers/thermal/broadcom/bcm2835_thermal.c         |   1 -
 drivers/thermal/cpu_cooling.c                      | 609 +++++++++--
----------
 drivers/thermal/fair_share.c                       |   1 +
 drivers/thermal/hisi_thermal.c                     |   5 +-
 drivers/thermal/imx_thermal.c                      |  27 +-
 drivers/thermal/int340x_thermal/acpi_thermal_rel.c |   6 +-
 drivers/thermal/int340x_thermal/int3403_thermal.c  |  12 +-
 drivers/thermal/step_wise.c                        |   3 +-
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  22 +-
 drivers/thermal/user_space.c                       |   3 +-
 include/linux/cpu_cooling.h                        |  32 +-
 include/linux/cpufreq.h                            |  14 +
 18 files changed, 342 insertions(+), 419 deletions(-)
