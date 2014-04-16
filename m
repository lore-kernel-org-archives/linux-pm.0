From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH RFC v2 0/4] ARM generic idle states
Date: Wed, 16 Apr 2014 16:44:50 +0100
Message-ID: <1397663094-28027-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:43440 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161615AbaDPPnO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Apr 2014 11:43:14 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebastian.capella@linaro.org>, Tomasz Figa <t.figa@samsung.com>

This patchset is v2 of a previous posting:

http://www.spinics.net/lists/arm-kernel/msg316263.html

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

Building on top of DT idle states bindings[1], that standardize idle states
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

On legacy ARM platforms, the OF idle states are just used to initialize
states data.

The idle states bindings can be extended with new back-ends; the ARM64 CPUi=
dle
driver must be updated accordingly so that the corresponding back
end initializer can be invoked at boot time for parameters initialization.

Patchset has been tested on AEM v8 models, on top of bootwrapper PSCI CPU
SUSPEND implementation which provides simulated core power gating.

[1] http://www.spinics.net/lists/arm-kernel/msg316299.html

Lorenzo Pieralisi (4):
  drivers: cpuidle: implement OF based idle states infrastructure
  arm64: add PSCI CPU_SUSPEND based cpu_suspend support
  drivers: cpuidle: CPU idle ARM64 driver
  arm64: boot: dts: update rtsm aemv8 dts with PSCI and idle states

 arch/arm64/boot/dts/rtsm_ve-aemv8a.dts |  49 +++++-
 arch/arm64/include/asm/psci.h          |   4 +
 arch/arm64/kernel/psci.c               | 102 ++++++++++++
 drivers/cpuidle/Kconfig                |  14 ++
 drivers/cpuidle/Kconfig.arm64          |  13 ++
 drivers/cpuidle/Makefile               |   5 +
 drivers/cpuidle/cpuidle-arm64.c        | 159 +++++++++++++++++++
 drivers/cpuidle/of_idle_states.c       | 274 +++++++++++++++++++++++++++++=
++++
 drivers/cpuidle/of_idle_states.h       |   8 +
 9 files changed, 620 insertions(+), 8 deletions(-)
 create mode 100644 drivers/cpuidle/Kconfig.arm64
 create mode 100644 drivers/cpuidle/cpuidle-arm64.c
 create mode 100644 drivers/cpuidle/of_idle_states.c
 create mode 100644 drivers/cpuidle/of_idle_states.h

--=20
1.8.4


