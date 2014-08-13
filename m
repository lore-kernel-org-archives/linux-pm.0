From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH v7 0/8] ARM generic idle states
Date: Wed, 13 Aug 2014 16:51:59 +0100
Message-ID: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Charles Garcia Tobin <Charles.Garcia-Tobin-5wv7dgnIgG8@public.gmane.org>, Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Amit Kucheria <amit.kucheria-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Antti Miettinen <ananaza-X3B1VOXEql0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Capella <sebcape-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Chander Kashyap <k.chander-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Geoff
List-Id: linux-pm@vger.kernel.org

This patch is v7 of a previous posting:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/274248.html

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

On legacy ARM platforms, the DT idle states are just used to initialize
states data.

Lorenzo Pieralisi (8):
  arm64: kernel: refactor the CPU suspend API for retention states
  Documentation: arm: define DT idle states bindings
  drivers: cpuidle: implement DT based idle states infrastructure
  arm64: kernel: introduce cpu_init_idle CPU operation
  arm64: add PSCI CPU_SUSPEND based cpu_suspend support
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
 arch/arm64/kernel/cpuidle.c                        |  29 +
 arch/arm64/kernel/psci.c                           | 100 +++
 arch/arm64/kernel/sleep.S                          |  47 +-
 arch/arm64/kernel/suspend.c                        |  47 +-
 drivers/cpuidle/Kconfig                            |   8 +
 drivers/cpuidle/Kconfig.arm                        |   2 +
 drivers/cpuidle/Kconfig.arm64                      |  14 +
 drivers/cpuidle/Makefile                           |   5 +
 drivers/cpuidle/cpuidle-arm64.c                    | 131 ++++
 drivers/cpuidle/cpuidle-big_little.c               |  23 +-
 drivers/cpuidle/cpuidle-exynos.c                   |  27 +-
 drivers/cpuidle/dt_idle_states.c                   | 140 +++++
 drivers/cpuidle/dt_idle_states.h                   |   5 +
 23 files changed, 1305 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/idle-states.txt
 create mode 100644 arch/arm64/include/asm/cpuidle.h
 create mode 100644 arch/arm64/kernel/cpuidle.c
 create mode 100644 drivers/cpuidle/Kconfig.arm64
 create mode 100644 drivers/cpuidle/cpuidle-arm64.c
 create mode 100644 drivers/cpuidle/dt_idle_states.c
 create mode 100644 drivers/cpuidle/dt_idle_states.h

--=20
1.9.1


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
