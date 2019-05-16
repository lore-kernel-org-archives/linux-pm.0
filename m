From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal management updates for v5.2-rc1
Date: Thu, 16 May 2019 23:29:01 +0800
Message-ID: <1558020541.12827.25.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi, Linus,

Please pull from
  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive the latest Thermal management updates for v5.2-rc1 with
top-most commit 6df24c3e81b9ba9c5e8d815e593826c169e3f366:

  Merge branches 'thermal-core', 'thermal-built-it' and 'thermal-intel' 
into next (2019-05-07 21:54:11 +0800)

on top of commit dc4060a5dc2557e6b5aa813bf5b73677299d62d2:

  Linux 5.1-rc5 (2019-04-14 15:17:41 -0700)

Specifics:

- Remove the 'module' Kconfig option for thermal subsystem framework
because the thermal framework are required to be ready as early as
possible to avoid overheat at boot time. (Daniel Lezcano)

- Fix a bug that thermal framework pokes disabled thermal zones upon
resume. (Wei Wang)

- A couple of cleanups and trivial fixes on int340x thermal drivers.
(Srinivas Pandruvada, Zhang Rui, Sumeet Pawnikar)

thanks,
rui

----------------------------------------------------------------
Daniel Lezcano (5):
      thermal/drivers/core: Remove the module Kconfig's option
      thermal/drivers/core: Remove module unload code
      thermal/drivers/core: Remove depends on THERMAL in Kconfig
      thermal/drivers/core: Fix typo in the option name
      hwmon/drivers/core: Simplify complex dependency

Geert Uytterhoeven (1):
      mlxsw: Remove obsolete dependency on THERMAL=m

Jean-Francois Dagenais (1):
      thermal: make device_register's type argument const

Srinivas Pandruvada (1):
      drivers: thermal: processor_thermal: Downgrade error message

Sumeet Pawnikar (1):
      thermal: intel: int340x: processor_thermal_device: simplify to
get driver data

Wei Wang (1):
      thermal: core: skip update disabled thermal zones after suspend

Zhang Rui (2):
      thermal/int3403_thermal: favor _TMP instead of PTYP
      Merge branches 'thermal-core', 'thermal-built-it' and 'thermal-
intel' into next

 arch/arm/configs/mini2440_defconfig                |  2 +-
 arch/arm/configs/pxa_defconfig                     |  2 +-
 arch/mips/configs/ip22_defconfig                   |  2 +-
 arch/mips/configs/ip27_defconfig                   |  2 +-
 arch/unicore32/configs/unicore32_defconfig         |  2 +-
 drivers/hwmon/hwmon.c                              |  4 +--
 drivers/net/ethernet/mellanox/mlxsw/Kconfig        |  1 -
 drivers/thermal/Kconfig                            |  8 +++---
 drivers/thermal/intel/Kconfig                      |  1 -
 .../intel/int340x_thermal/int3403_thermal.c        | 16 +++++------
 .../int340x_thermal/processor_thermal_device.c     | 13 ++-------
 drivers/thermal/qcom/Kconfig                       |  1 -
 drivers/thermal/thermal_core.c                     | 31 +++++++++-----
--------
 include/linux/thermal.h                            |  6 ++---
 14 files changed, 34 insertions(+), 57 deletions(-)
