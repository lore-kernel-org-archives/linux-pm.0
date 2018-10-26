From: Eduardo Valentin <edubezval@gmail.com>
Subject: [GIT PULL] Thermal-SoC management updates for v4.20-rc1
Date: Fri, 26 Oct 2018 08:39:05 -0700
Message-ID: <20181026153901.GA3744@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Rui Zhang <rui.zhang@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Linus,

Please consider pulling from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus

to receive Thermal-SoC Management updates for v4.20-rc1 with top-most

760eea43f8c6d48684f1f34b8a02fddc1456e849:

  thermal: da9062/61: Prevent hardware access during system suspend (2018-10-25 10:44:55 -0700)

on top of commit 2ad0d52699700a91660a406a4046017a2d7f246a:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-08-19 11:51:45 -0700)

Several new stuff coming up. Specifics:
- Rework of tsens thermal driver
- Rework of hisi thermal driver
- OF-thermal now allows sharing multiple cooling devices on maps
- Added support for r8a7744 and R8A77970  on rcar thermal driver
- Added support for r8a774a1 on rcar_gen3 thermal driver
- New thermal driver  stm32
- Fixes on multiple thermal drivers: of-thermal, imx, qoriq, armada, qcom-spmi, rcar, da9062/61

Bot results:
Full Boot Summary: https://kernelci.org/boot/all/job/evalenti/branch/for-kernelci/kernel/v4.18-10762-g760eea43f8c6/
Full Build Summary: https://kernelci.org/build/evalenti/branch/for-kernelci/kernel/v4.18-10762-g760eea43f8c6/


BR,

Eduardo Valentin

----------------------------------------------------------------
Amit Kucheria (8):
      thermal: tsens: Prepare 8916 and 8974 tsens to use SROT and TM address space
      thermal: tsens: Add SPDX license identifiers
      thermal: tsens: Get rid of dead code
      thermal: tsens: Rename map field in order to add a second address map
      thermal: tsens: Add the SROT address map
      thermal: tsens: Pass register offsets as private data
      thermal: tsens: Check if the IP is correctly enabled by firmware
      dt-bindings: thermal: Fix a typo in documentation

Anson Huang (3):
      thermal: qoriq: add i.mx8mq support
      thermal: imx: improve error message
      thermal: imx: handle error path in one place to save duplicated code

Biju Das (1):
      dt-bindings: thermal: rcar: Add device tree support for r8a7744

Dan Carpenter (1):
      thermal: armada: fix a test in probe()

Daniel Lezcano (11):
      thermal/drivers/hisi: Change the platform data pointer to sensor ops
      thermal/drivers/hisi: Change the driver to be sensor oriented
      thermal/drivers/hisi: Set the thermal zone private data to the sensor pointer
      thermal/drivers/hisi: Factor out the probe functions
      thermal/drivers/hisi: Prepare to support multiple sensors
      thermal/drivers/hisi: Add multiple sensors support
      thermal/drivers/hisi: Replace macro name with relevant sensor location
      thermal/drivers/hisi: Use platform_get_irq_byname
      thermal/drivers/hisi: Remove pointless irq field
      thermal/drivers/hisi: Add more sensors channel
      thermal/drivers/hisi: Add the dual clusters sensors for hi3660

David HERNANDEZ SANCHEZ (2):
      dt-bindings: stm32-thermal: add binding documentation
      thermal: add stm32 thermal driver

Fabrizio Castro (2):
      thermal: rcar_gen3_thermal: Add r8a774a1 support
      dt-bindings: thermal: rcar-gen3-thermal: Add r8a774a1 support

Geert Uytterhoeven (3):
      thermal: rcar_thermal: Prevent hardware access during system suspend
      thermal: rcar_thermal: Prevent doing work after unbind
      thermal: da9062/61: Prevent hardware access during system suspend

Matthias Kaehlcke (3):
      dt-bindings: thermal: qcom-spmi-temp-alarm: Fix documentation of 'reg'
      dt-bindings: thermal: qcom-spmi-temp-alarm: Improve thermal zone in example
      thermal: qcom-spmi: Use PMIC thermal stage 2 for critical trip points

Rob Herring (1):
      thermal: Convert to using %pOFn instead of device_node.name

Sergei Shtylyov (5):
      thermal: rcar_thermal: fix duplicate IRQ request
      dt-bindings: thermal: rcar-thermal: document R8A77970 bindings
      thermal: rcar_thermal: add R8A77970 support
      dt-bindings: thermal: rcar-gen3-thermal: document R8A77980 bindings
      thermal: rcar_gen3_thermal: add R8A77980 support

Viresh Kumar (1):
      of: thermal: Allow multiple devices to share cooling map

 .../bindings/thermal/qcom-spmi-temp-alarm.txt      |  16 +-
 .../devicetree/bindings/thermal/qoriq-thermal.txt  |   6 +-
 .../bindings/thermal/rcar-gen3-thermal.txt         |   5 +-
 .../devicetree/bindings/thermal/rcar-thermal.txt   |   6 +-
 .../devicetree/bindings/thermal/stm32-thermal.txt  |  61 ++
 .../devicetree/bindings/thermal/thermal.txt        |   2 +-
 drivers/thermal/Kconfig                            |   2 +-
 drivers/thermal/Makefile                           |   2 +-
 drivers/thermal/armada_thermal.c                   |   4 +-
 drivers/thermal/da9062-thermal.c                   |   4 +-
 drivers/thermal/hisi_thermal.c                     | 249 ++++---
 drivers/thermal/imx_thermal.c                      |  31 +-
 drivers/thermal/of-thermal.c                       | 152 +++--
 drivers/thermal/qcom-spmi-temp-alarm.c             | 158 ++++-
 drivers/thermal/qcom/tsens-8916.c                  |  12 +-
 drivers/thermal/qcom/tsens-8960.c                  |  41 +-
 drivers/thermal/qcom/tsens-8974.c                  |  12 +-
 drivers/thermal/qcom/tsens-common.c                |  62 +-
 drivers/thermal/qcom/tsens-v2.c                    |   8 +-
 drivers/thermal/qcom/tsens.c                       |  19 +-
 drivers/thermal/qcom/tsens.h                       |  23 +-
 drivers/thermal/qoriq_thermal.c                    |   5 +-
 drivers/thermal/rcar_gen3_thermal.c                |   2 +
 drivers/thermal/rcar_thermal.c                     |  11 +-
 drivers/thermal/st/Kconfig                         |  14 +
 drivers/thermal/st/Makefile                        |   1 +
 drivers/thermal/st/stm_thermal.c                   | 760 +++++++++++++++++++++
 27 files changed, 1365 insertions(+), 303 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/stm32-thermal.txt
 create mode 100644 drivers/thermal/st/stm_thermal.c
