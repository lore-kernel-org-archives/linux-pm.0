From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v9 0/8] ARM generic idle states
Date: Fri,  5 Sep 2014 18:34:49 +0100
Message-ID: <1409938498-17984-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:54307 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754098AbaIERew (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Sep 2014 13:34:52 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Chander Kashyap <k.chander@samsung.com>, Geoff

This patch is v9 of a previous posting:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/283384=
.html

Patchset has been tested on:

- Juno ARM64 platform and Foundation v8 models (based on Trusted Firmware
  PSCI implementation available at [1])
  # Patches to enable idle states on Juno and Foundation models can be made
    available, current dts are not in the mainline kernel
- TC2
- Compile tested on Samsung Exynos

Patch for Exynos CPUidle code depends on patch [2].

[1] https://github.com/ARM-software/arm-trusted-firmware
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/274179.=
html

Changes in v9:

- Cosmetic changes to arm64 CPUidle driver (pr_err logs)
- Added acknowledgements
- Reordered the series by splitting arm64 and CPUidle specific bits

Changes in v8:

- Added idle states check on all cpus in the CPUidle driver mask
- Added missing DT nodes ref counting
- Added idle states node matching code to initialize CPUidle enter function
- Added code to fall back on cpu_possible_mask on NULL CPUidle driver cpuma=
sk

Changes in v7:

- Refactored arm64 cpu_suspend API to support retention states
- Readded static states tables for TC2 and Exynos CPUidle driver so that
  platforms with old dts files will still work as expected
- Slightly reworked the DT parsing API to return the number of parsed DT
  states
- Ported PSCI to the new cpu_suspend API, now supporting retention states
- Rebased against 3.16

Changes in v6:

- Added ARM64 CPU init idle to CPU operations
- Removed power-rank property; sorting depends on the cpu-idle-states phand=
le
  list order now
- Added local-timer-stop flag
- Removed useless TC2 and Exynos DT idle state entry-method bindings
- Removed RTSM dts update
- Updated PSCI suspend parameter and DT bindings
- Updated PSCI parsing code
- Rebased against 3.16-rc6

Changes in v5:

- Added power-rank property to implement state sorting, following a number
  of on/off list review comments
- Added timer retained bool property
- Ported TC2 big.LITTLE and Exynos drivers to DT initialization
- Renamed s/OF/dt/ throughout the patch
- Incorporated review comments and list discussions in the idle states
  bindings documents
- Rebased against 3.16-rc2

Changes in v4:

- States sorting using exit-latency
- Added cosmetic review comments
- Dropped RFC
- Rebased against 3.15

Changes in v3:

- Streamlined the idle states bindings and added them to the series
  http://www.spinics.net/lists/arm-kernel/msg316299.html
- Sorting states through min-residency+exit-latency
- Added debug strings formatting
- Reworded min-residency-us idle state property
- Removed power-domain properties from idle states waiting for code
  examples requiring them to be defined

Changes in v2:

- Moved OF parsing code to drivers/cpuidle
- Improved states detection and sorting through linked list
- Split code in generic and ARM64 specific bits
- Moved idle enter function into ARM64 idle driver
- Refactored PSCI idle states register function
- Renamed suspend operations and moved detection to ARM64 idle driver
- Changed the way CPUIDLE_FLAG_TIMER_STOP is handled
- Simplified idle state nodes parsing since according to the latest
  bindings idle state nodes are a flat list, not hierarchical anymore
- Used min-residency-us to sort the states, to be further discussed

Idle states on most ARM platforms can be characterized by a set of
parameters that are platform agnostic and describe the HW idle states
features. So far, CPU idle drivers for ARM platforms required the definitio=
n
of parameters through static tables, duplicating control data for different
platforms. Moreover, the lack of standardization on firmware interfaces
hampered any standardization effort, resulting in CPU idle drivers for ARM
platforms containing duplicated code and platform specific power down routi=
nes.

The introduction of the PSCI firmware interface, and more in general, well
defined suspend back-ends, allows the definition of generic idle states and
the respective kernel infrastructure to support them.

Building on top of DT idle states bindings, that standardize idle states
parameters and corresponding suspend back-ends, this patchset provides code
that parses DT idle states nodes and builds at run-time the control data
infrastructure required by the ARM CPU idle drivers.

Idle states define an entry method (eg PSCI), that requires the respective
ARM64 kernel back-end to be invoked to initialize idle states parameters, s=
o
that when the idle driver executes the back-end specific entry method a tab=
le
look-up can be carried out to retrieve the corresponding idle state paramet=
er.

On legacy ARM platforms the DT idle states are used to initialize states
data and the idle state compatible string allows to match the corresponding
idle state enter function and initialize the enter function pointer
accordingly.

Lorenzo Pieralisi (8):
  Documentation: arm: define DT idle states bindings
  arm64: kernel: refactor the CPU suspend API for retention states
  arm64: kernel: introduce cpu_init_idle CPU operation
  arm64: add PSCI CPU_SUSPEND based cpu_suspend support
  drivers: cpuidle: implement DT based idle states infrastructure
  drivers: cpuidle: CPU idle ARM64 driver
  drivers: cpuidle: initialize big.LITTLE driver through DT
  drivers: cpuidle: initialize Exynos driver through DT

 Documentation/devicetree/bindings/arm/cpus.txt     |   8 +
 .../devicetree/bindings/arm/idle-states.txt        | 679 +++++++++++++++++=
++++
 Documentation/devicetree/bindings/arm/psci.txt     |  14 +-
 arch/arm/boot/dts/exynos4210.dtsi                  |  11 +
 arch/arm/boot/dts/exynos5250.dtsi                  |  11 +
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts         |  23 +
 arch/arm64/include/asm/cpu_ops.h                   |   3 +
 arch/arm64/include/asm/cpuidle.h                   |  13 +
 arch/arm64/include/asm/suspend.h                   |   1 +
 arch/arm64/kernel/Makefile                         |   1 +
 arch/arm64/kernel/cpuidle.c                        |  31 +
 arch/arm64/kernel/psci.c                           | 104 ++++
 arch/arm64/kernel/sleep.S                          |  47 +-
 arch/arm64/kernel/suspend.c                        |  48 +-
 drivers/cpuidle/Kconfig                            |   8 +
 drivers/cpuidle/Kconfig.arm                        |   2 +
 drivers/cpuidle/Kconfig.arm64                      |  14 +
 drivers/cpuidle/Makefile                           |   5 +
 drivers/cpuidle/cpuidle-arm64.c                    | 133 ++++
 drivers/cpuidle/cpuidle-big_little.c               |  19 +
 drivers/cpuidle/cpuidle-exynos.c                   |  18 +-
 drivers/cpuidle/dt_idle_states.c                   | 213 +++++++
 drivers/cpuidle/dt_idle_states.h                   |   7 +
 23 files changed, 1379 insertions(+), 34 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/idle-states.txt
 create mode 100644 arch/arm64/include/asm/cpuidle.h
 create mode 100644 arch/arm64/kernel/cpuidle.c
 create mode 100644 drivers/cpuidle/Kconfig.arm64
 create mode 100644 drivers/cpuidle/cpuidle-arm64.c
 create mode 100644 drivers/cpuidle/dt_idle_states.c
 create mode 100644 drivers/cpuidle/dt_idle_states.h

--=20
1.9.1


