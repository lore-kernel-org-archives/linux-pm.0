From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal-SoC management updates for v4.10-rc7
Date: Wed, 1 Feb 2017 20:34:50 -0800
Message-ID: <20170202043448.GB6377@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Rui Zhang <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Hello Rui,

Please consider the following four small fixes on TI and MTK thermal
drivers.

BR,
Eduardo

The following changes since commit a4685d2f58e2230d4e27fb2ee581d7ea35e5d046:

  Merge branch 'stable' of git://git.kernel.org/pub/scm/linux/kernel/git/cmetcalf/linux-tile (2017-01-23 13:51:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes

for you to fetch changes up to fd8e146de4837462b84a0cbf279bd73138f91991:

  thermal: mtk_thermal: Staticise a number of data variables (2017-01-24 02:13:17 -0800)

----------------------------------------------------------------
Keerthy (3):
      thermal: ti-soc-thermal: Remove CPU_THERMAL Dependency from TI_THERMAL
      thermal: arm: dra752: Remove TSHUT configuration
      thermal: arm: dra752: Remove all TSHUT related definitions

Vivek Gautam (1):
      thermal: mtk_thermal: Staticise a number of data variables

 drivers/thermal/mtk_thermal.c                      | 16 ++++++-------
 drivers/thermal/ti-soc-thermal/Kconfig             |  1 -
 drivers/thermal/ti-soc-thermal/dra752-bandgap.h    | 19 ---------------
 .../thermal/ti-soc-thermal/dra752-thermal-data.c   | 28 +---------------------
 4 files changed, 9 insertions(+), 55 deletions(-)
