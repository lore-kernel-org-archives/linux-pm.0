From: Zhang Rui <rui.zhang@intel.com>
Subject: [GIT PULL] Thermal Management updates for 3.20-rc1 #1
Date: Thu, 19 Feb 2015 21:48:21 +0800
Message-ID: <1424353701.2885.17.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, "Zhang, Rui" <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi, Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

to receive Thermal Management changes for 3.20-rc1 with top-most commit
31908f45a583e8f21db37f402b6e8d5739945afd:

  Thermal/int340x_thermal: remove unused uuids. (2015-02-06 16:36:49
+0800)

on top of commit ec6f34e5b552fb0a52e6aae1a5afbbb1605cc6cc:

  Linux 3.19-rc5 (2015-01-18 18:02:20 +1200)

Specifics:

- Abstract the code and introduce helper functions for all int340x
thermal drivers. From: Srinivas Pandruvada.

- Reorganize the ACPI LPAT table support code so that it can be shared
for both ACPI PMIC driver and int340x thermal driver.

- Add support for Braswell in intel_soc_dts thermal driver.

- a couple of small fixes/cleanups for step_wise governor and int340x
thermal driver.

thanks,
rui

The following changes since commit
ec6f34e5b552fb0a52e6aae1a5afbbb1605cc6cc:

  Linux 3.19-rc5 (2015-01-18 18:02:20 +1200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git next

for you to fetch changes up to 31908f45a583e8f21db37f402b6e8d5739945afd:

  Thermal/int340x_thermal: remove unused uuids. (2015-02-06 16:36:49
+0800)

----------------------------------------------------------------
Brian Norris (1):
      thermal: step_wise: spelling fixes

Lad, Prabhakar (1):
      thermal: int340x: fix sparse warning

Srinivas Pandruvada (9):
      Thermal/int340x: Add common thermal zone handler
      Thermal/int340x/int3402: Use int340x thermal API
      Thermal/int340x/int3403: Use int340x thermal API
      Thermal/int340x/processor_thermal: Add thermal zone support
      Thermal/int340x/int3402: Provide notification support
      thermal: Intel SoC DTS: Add Braswell support
      ACPI / LPAT: Common table processing functions
      ACPI / PMIC: Use common LPAT table handling functions
      Thermal/int340x: LPAT conversion for temperature

Zhang Rui (2):
      Merge branches 'intel-dts-soc-thermal' and 'int340x-enhancement'
of .git into next
      Thermal/int340x_thermal: remove unused uuids.

 drivers/acpi/Makefile                              |   1 +
 drivers/acpi/acpi_lpat.c                           | 161 ++++++++++++
 drivers/acpi/pmic/intel_pmic.c                     | 133 ++--------
 drivers/thermal/int340x_thermal/Makefile           |   1 +
 drivers/thermal/int340x_thermal/int3400_thermal.c  |   4 -
 drivers/thermal/int340x_thermal/int3402_thermal.c  | 208
+++-------------
 drivers/thermal/int340x_thermal/int3403_thermal.c  | 208
+---------------
 .../thermal/int340x_thermal/int340x_thermal_zone.c | 276
+++++++++++++++++++++
 .../thermal/int340x_thermal/int340x_thermal_zone.h |  68 +++++
 .../int340x_thermal/processor_thermal_device.c     |  92 ++++++-
 drivers/thermal/intel_soc_dts_thermal.c            |  46 ++--
 drivers/thermal/step_wise.c                        |   4 +-
 include/acpi/acpi_lpat.h                           |  65 +++++
 13 files changed, 760 insertions(+), 507 deletions(-)
 create mode 100644 drivers/acpi/acpi_lpat.c
 create mode 100644
drivers/thermal/int340x_thermal/int340x_thermal_zone.c
 create mode 100644
drivers/thermal/int340x_thermal/int340x_thermal_zone.h
 create mode 100644 include/acpi/acpi_lpat.h


