From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal-SoC management changes for v5.1-rc1
Date: Wed, 6 Mar 2019 08:12:09 -0800
Message-ID: <20190306161207.GA7365@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Rui Zhang <rui.zhang@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Linus,

Please consider the following thermal soc changes for v5.1-rc1.

The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:

  Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus

for you to fetch changes up to 6269e9f790e8d442b3e1529bf3b3de452dd4ac92:

  thermal: rcar_gen3_thermal: Register hwmon sysfs interface (2019-02-20 17:23:40 -0800)

Kernel CI output:
Full Boot Summary: https://kernelci.org/boot/all/job/evalenti/branch/for-kernelci/kernel/v5.0-rc5-15-g6269e9f790e8/
Full Build Summary: https://kernelci.org/build/evalenti/branch/for-kernelci/kernel/v5.0-rc5-15-g6269e9f790e8/

Specifics:
- mediatek thermal now supports MT8183
- broadcom thermal now supports Stingray
- qoirq now supports multiple sensors
- fixes on different drivers: rcar, tsens, tegra

Some new drivers are still pending further review and I chose to leave them
for the next merge window while still sending this material.

BR,

----------------------------------------------------------------
Marek Vasut (1):
      thermal: rcar_gen3_thermal: Register hwmon sysfs interface

Michael Kao (7):
      thermal: mediatek: fix register index error
      thermal: mediatek: add common index of vts settings.
      thermal: mediatek: add calibration item
      thermal: mediatek: add thermal controller offset
      thermal: mediatek: add flag for bank selection
      dt-bindings: thermal: add binding document for mt8183 thermal controller
      thermal: mediatek: add support for MT8183

Peng Hao (1):
      thermal/qcom/tsens-common : fix possible object reference leak

Pramod Kumar (2):
      dt-bindings: thermal: Add binding document for SR thermal
      thermal: broadcom: Add Stingray thermal driver

Wei Ni (3):
      thermal: tegra: remove unnecessary warnings
      thermal: tegra: fix memory allocation
      thermal: tegra: add get_trend ops

Yuantian Tang (1):
      thermal: qoriq: add multiple sensors support

 .../bindings/thermal/brcm,sr-thermal.txt           | 105 +++++++
 .../bindings/thermal/mediatek-thermal.txt          |   1 +
 drivers/thermal/Kconfig                            |   3 +-
 drivers/thermal/broadcom/Kconfig                   |   9 +
 drivers/thermal/broadcom/Makefile                  |   1 +
 drivers/thermal/broadcom/sr-thermal.c              | 121 ++++++++
 drivers/thermal/mtk_thermal.c                      | 316 +++++++++++++++++----
 drivers/thermal/qcom/tsens-common.c                |  33 ++-
 drivers/thermal/qoriq_thermal.c                    | 104 +++----
 drivers/thermal/rcar_gen3_thermal.c                |  19 ++
 drivers/thermal/tegra/soctherm.c                   |  38 ++-
 11 files changed, 620 insertions(+), 130 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,sr-thermal.txt
 create mode 100644 drivers/thermal/broadcom/sr-thermal.c
