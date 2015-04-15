From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [GIT PULL] ACPI and power management updates for v4.1-rc1
Date: Wed, 15 Apr 2015 02:56:27 +0200
Message-ID: <CAJZ5v0hFeOpB7R86EvYD+Dj6gKDGx19Dir2FRcw7Y45-BzCJLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

Please pull from

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm+acpi-4.1-rc1

to receive the first batch of power management and ACPI material for
v4.1-rc1 with top-most commit b5e82233cab43c25fc0a1c28d9136a086db4aa52

 Merge branches 'powercap' and 'pm-devfreq'

on top of commit 39a8804455fb23f09157341d3ba7db6d7ae6ee76

 Linux 4.0

These are mostly fixes and cleanups all over, although there are
a few items that sort of fall into the new feature category.

First off, we have new callbacks for PM domains that should help us
to handle some issues related to device initialization in a better
way.

There also is some consolidation in the unified device properties API
area allowing us to use that inferface for accessing data coming from
platform initialization code in addition to firmware-provided data.

We have some new device/CPU IDs in a few drivers, support for new
chips and a new cpufreq driver too.

Specifics:

 - Generic PM domains support update including new PM domain
   callbacks to handle device initialization better (Russell King,
   Rafael J Wysocki, Kevin Hilman).

 - Unified device properties API update including a new mechanism
   for accessing data provided by platform initialization code
   (Rafael J Wysocki, Adrian Hunter).

 - ARM cpuidle update including ARM32/ARM64 handling consolidation
   (Daniel Lezcano).

 - intel_idle update including support for the Silvermont Core in
   the Baytrail SOC and for the Airmont Core in the Cherrytrail and
   Braswell SOCs (Len Brown, Mathias Krause).

 - New cpufreq driver for Hisilicon ACPU (Leo Yan).

 - intel_pstate update including support for the Knights Landing
   chip (Dasaratharaman Chandramouli, Kristen Carlson Accardi).

 - QorIQ cpufreq driver update (Tang Yuantian, Arnd Bergmann).

 - powernv cpufreq driver update (Shilpasri G Bhat).

 - devfreq update including Tegra support changes (Tomeu Vizoso,
   MyungJoo Ham, Chanwoo Choi).

 - powercap RAPL (Running-Average Power Limit) driver update
   including support for Intel Broadwell server chips (Jacob Pan,
   Mathias Krause).

 - ACPI device enumeration update related to the handling of the
   special PRP0001 device ID allowing DT-style 'compatible' property
   to be used for ACPI device identification (Rafael J Wysocki).

 - ACPI EC driver update including limited _DEP support (Lan Tianyu,
   Lv Zheng).

 - ACPI backlight driver update including a new mechanism to allow
   native backlight handling to be forced on non-Windows 8 systems
   and a new quirk for Lenovo Ideapad Z570 (Aaron Lu, Hans de Goede).

 - New Windows Vista compatibility quirk for Sony VGN-SR19XN (Chen Yu).

 - Assorted ACPI fixes and cleanups (Aaron Lu, Martin Kepplinger,
   Masanari Iida, Mika Westerberg, Nan Li, Rafael J Wysocki).

 - Fixes related to suspend-to-idle for the iTCO watchdog driver and
   the ACPI core system suspend/resume code (Rafael J Wysocki, Chen Yu).

 - PM tracing support for the suspend phase of system suspend/resume
   transitions (Zhonghui Fu).

 - Configurable delay for the system suspend/resume testing facility
   (Brian Norris).

 - PNP subsystem cleanups (Peter Huewe, Rafael J Wysocki).

Thanks!


---------------

Aaron Lu (2):
      ACPI / scan: fix fixed event handler return value
      ACPI / video: Allow forcing native backlight on non win8 machines

Adrian Hunter (2):
      ACPI: Add acpi_device_uid() for convenience
      driver core: Add comments about returning array counts

Arnd Bergmann (1):
      cpufreq: fix qoriq uniprocessor build

Brian Norris (1):
      PM / sleep: add configurable delay for pm_test

Chanwoo Choi (1):
      PM / devfreq: event: Add const keyword for devfreq_event_ops structure

Chen Yu (2):
      ACPI / blacklist: Disable Vista compatibility for Sony VGN-SR19XN.
      ACPI / PM: Enable all wakeup GPEs in suspend-to-idle

Daniel Lezcano (8):
      ARM: cpuidle: Remove duplicate header inclusion
      ARM: cpuidle: Add a cpuidle ops structure to be used for DT
      ARM64: cpuidle: Replace cpu_suspend by the common ARM/ARM64 function
      ARM64: cpuidle: Rename cpu_init_idle to a common function name
      ARM64: cpuidle: Remove arm64 reference
      ARM: cpuidle: Enable the ARM64 driver for both ARM32/ARM64
      ARM: cpuidle: Register per cpuidle device
      ARM: cpuidle: Document the code

Dasaratharaman Chandramouli (1):
      intel_pstate: Knights Landing support

Hans de Goede (1):
      ACPI / video: Add force native backlight quirk for Lenovo Ideapad Z570

Jacob Pan (1):
      powercap / RAPL: add ID for Broadwell server

Kevin Hilman (1):
      MAINTAINERS: add entry for Generic PM domains (genpd)

Kristen Carlson Accardi (1):
      intel_pstate: remove MSR test

Lan Tianyu (1):
      ACPI / EC: Call acpi_walk_dep_device_list() after installing EC
opregion handler

Len Brown (2):
      intel_idle: Update support for Silvermont Core in Baytrail SOC
      intel_idle: Add support for the Airmont Core in the Cherrytrail
and Braswell SOCs

Leo Yan (1):
      cpufreq: hisilicon: add acpu driver

Lv Zheng (2):
      ACPI / EC: Cleanup logging/debugging splitter support.
      ACPI / EC: Add GPE reference counting debugging messages.

Martin Kepplinger (1):
      ACPI / battery: make warning greppable

Masanari Iida (1):
      ACPI/PMIC: Fix typo in MODULE_DESCRIPTION in intel_pmic_crc.c

Mathias Krause (2):
      powercap / RAPL: mark rapl_ids array as __initconst
      intel_idle: mark cpu id array as __initconst

Mika Westerberg (1):
      ACPI: Update GPIO documentation to mention _DSD

MyungJoo Ham (1):
      PM / devfreq: correct misleading comment

Nan Li (1):
      ACPI / sysfs: Treat the count field of counter_show() as unsigned

Peter Huewe (8):
      PNP: Add helper macro for pnp_register_driver boilerplate
      PNP: tpm/tpm_infineon: Use module_pnp_driver to register driver
      PNP: ata/pata_isapnp: Use module_pnp_driver to register driver
      PNP: ide/ide-pnp: Use module_pnp_driver to register driver
      PNP: media/rc: Use module_pnp_driver to register driver
      PNP: net/sb1000: Use module_pnp_driver to register driver
      PNP: platform/x86/apple-gmux: Use module_pnp_driver to register driver
      PNP: tty/serial/8250/8250_fintek: Use module_pnp_driver to register driver

Rafael J. Wysocki (17):
      PNP / ACPI: Use ACPI_COMPANION_SET() during initialization
      driver core / ACPI: Represent ACPI companions using fwnode_handle
      ACPI: Introduce has_acpi_companion()
      ACPI / sleep: Drop acpi_suspend() which is not used
      PNP: Convert pnp_lock into a mutex
      PNP: Avoid leaving unregistered device objects in lists
      driver core / PM: Add PM domain callbacks for device setup/cleanup
      driver core: property: Update fwnode_property_read_string_array()
      driver core: Implement device property accessors through fwnode ones
      PM / watchdog: iTCO: stop watchdog during system suspend
      device property: Make it possible to use secondary firmware nodes
      device property: Introduce firmware node type for platform data
      ACPI / scan: Generalize of_compatible matching
      ACPI / scan: Simplify acpi_match_device()
      ACPI / scan: Take the PRP0001 position in the list of IDs into account
      ACPI / scan: Rework modalias creation when "compatible" is present
      ACPI / scan: Fix NULL pointer dereference in acpi_companion_match()

Russell King (4):
      PM / Domains: Sync runtime PM status with genpd after probe
      PM / domains: quieten down generic pm domains
      PM / domains: factor out code to get the generic PM domain from
a struct device
      PM / domains: avoid potential oops in pm_genpd_remove_device()

Shilpasri G Bhat (1):
      cpufreq: powernv: Report cpu frequency throttling

Tang Yuantian (2):
      cpufreq: qoriq: Make the driver usable on all QorIQ platforms
      cpufreq: qoriq: rename the driver

Tomeu Vizoso (6):
      PM / devfreq: tegra: Update to v5 of the submitted patches
      PM / devfreq: tegra: Use clock rate constraints
      PM / devfreq: tegra: remove operating-points
      PM / devfreq: tegra: Set drvdata before enabling the irq
      PM / devfreq: tegra: Enable interrupts after resuming the devfreq monitor
      PM / devfreq: tegra: Register governor on module init

Zhonghui Fu (1):
      PM / sleep: add pm-trace support for suspending phase

---------------

 Documentation/acpi/enumeration.txt                 |  26 +-
 Documentation/kernel-parameters.txt                |   7 +
 Documentation/power/basic-pm-debugging.txt         |  10 +-
 MAINTAINERS                                        |   9 +
 arch/arm/include/asm/cpuidle.h                     |  23 +
 arch/arm/kernel/cpuidle.c                          | 133 +++++-
 arch/arm/mach-davinci/cpuidle.c                    |   1 -
 arch/arm/mach-imx/cpuidle-imx6q.c                  |   1 -
 arch/arm/mach-imx/cpuidle-imx6sl.c                 |   1 -
 arch/arm/mach-imx/cpuidle-imx6sx.c                 |   1 -
 arch/arm/mach-omap2/cpuidle44xx.c                  |   1 -
 arch/arm/mach-s3c64xx/cpuidle.c                    |   2 +-
 arch/arm/mach-tegra/cpuidle-tegra20.c              |   1 -
 arch/arm/mach-tegra/cpuidle-tegra30.c              |   1 -
 arch/arm64/configs/defconfig                       |   2 +-
 arch/arm64/include/asm/cpuidle.h                   |   9 +-
 arch/arm64/kernel/cpuidle.c                        |   2 +-
 .../x86/include/asm/{resume-trace.h => pm-trace.h} |  10 +-
 drivers/acpi/acpi_platform.c                       |   2 +-
 drivers/acpi/battery.c                             |   4 +-
 drivers/acpi/blacklist.c                           |   8 +
 drivers/acpi/dock.c                                |   2 +-
 drivers/acpi/ec.c                                  | 123 +++--
 drivers/acpi/glue.c                                |   4 +-
 drivers/acpi/pmic/intel_pmic_crc.c                 |   2 +-
 drivers/acpi/scan.c                                | 394 +++++++++-------
 drivers/acpi/sleep.c                               |  17 +-
 drivers/acpi/sleep.h                               |   2 -
 drivers/acpi/sysfs.c                               |   2 +-
 drivers/acpi/video.c                               |  36 +-
 drivers/acpi/video_detect.c                        |   8 -
 drivers/ata/pata_isapnp.c                          |  14 +-
 drivers/base/core.c                                |  51 +++
 drivers/base/dd.c                                  |  14 +
 drivers/base/platform.c                            |   2 +-
 drivers/base/power/domain.c                        |  70 ++-
 drivers/base/power/main.c                          |  20 +-
 drivers/base/power/trace.c                         |   6 +-
 drivers/base/property.c                            | 198 +++++---
 drivers/char/tpm/tpm_infineon.c                    |  13 +-
 drivers/cpufreq/Kconfig                            |   8 +
 drivers/cpufreq/Kconfig.arm                        |   9 +
 drivers/cpufreq/Kconfig.powerpc                    |   9 -
 drivers/cpufreq/Makefile                           |   3 +-
 drivers/cpufreq/hisi-acpu-cpufreq.c                |  42 ++
 drivers/cpufreq/intel_pstate.c                     |  45 +-
 drivers/cpufreq/powernv-cpufreq.c                  |  47 +-
 .../{ppc-corenet-cpufreq.c => qoriq-cpufreq.c}     | 163 ++++---
 drivers/cpuidle/Kconfig                            |   7 +-
 drivers/cpuidle/Kconfig.arm                        |  28 +-
 drivers/cpuidle/Kconfig.arm64                      |  13 -
 drivers/cpuidle/Makefile                           |   5 +-
 drivers/cpuidle/{cpuidle-arm64.c => cpuidle-arm.c} |  83 +++-
 drivers/cpuidle/cpuidle-at91.c                     |   1 -
 drivers/cpuidle/cpuidle-exynos.c                   |   1 -
 drivers/cpuidle/cpuidle-kirkwood.c                 |   1 -
 drivers/cpuidle/cpuidle-ux500.c                    |   1 -
 drivers/cpuidle/cpuidle-zynq.c                     |   1 -
 drivers/devfreq/devfreq.c                          |   1 -
 drivers/devfreq/event/exynos-ppmu.c                |   2 +-
 drivers/devfreq/tegra-devfreq.c                    | 509 ++++++++++++---------
 drivers/gpio/gpiolib.h                             |   2 +
 drivers/i2c/busses/i2c-designware-platdrv.c        |   4 +-
 drivers/i2c/i2c-core.c                             |   4 +-
 drivers/ide/ide-pnp.c                              |  14 +-
 drivers/idle/intel_idle.c                          |  68 ++-
 drivers/iommu/intel-iommu.c                        |   2 +-
 drivers/media/rc/ene_ir.c                          |  13 +-
 drivers/media/rc/fintek-cir.c                      |  13 +-
 drivers/media/rc/ite-cir.c                         |  13 +-
 drivers/media/rc/nuvoton-cir.c                     |  13 +-
 drivers/net/sb1000.c                               |  15 +-
 drivers/platform/x86/apple-gmux.c                  |  14 +-
 drivers/pnp/base.h                                 |   2 +-
 drivers/pnp/card.c                                 |  25 +-
 drivers/pnp/core.c                                 |  64 ++-
 drivers/pnp/driver.c                               |  10 +-
 drivers/pnp/pnpacpi/core.c                         |   5 +-
 drivers/powercap/intel_rapl.c                      |   3 +-
 drivers/tty/serial/8250/8250_fintek.c              |  13 +-
 drivers/watchdog/iTCO_wdt.c                        |  51 +++
 include/acpi/acpi_bus.h                            |   4 +-
 include/asm-generic/vmlinux.lds.h                  |   2 +
 include/linux/acpi.h                               |  15 +-
 include/linux/devfreq-event.h                      |   2 +-
 include/linux/device.h                             |  16 +-
 include/linux/fwnode.h                             |  27 ++
 include/linux/i2c.h                                |   4 +-
 include/linux/platform_device.h                    |   2 +-
 include/linux/{resume-trace.h => pm-trace.h}       |   9 +-
 include/linux/pm.h                                 |   8 +
 include/linux/pm_domain.h                          |   6 +-
 include/linux/pnp.h                                |  12 +
 include/linux/property.h                           |  44 +-
 kernel/power/main.c                                |   2 +-
 kernel/power/suspend.c                             |  13 +-
 96 files changed, 1797 insertions(+), 928 deletions(-)
