From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH RFC 0/4] arm64: generic idle states
Date: Tue, 18 Mar 2014 10:20:24 +0000
Message-ID: <1395138028-19630-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:53981 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748AbaCRKTM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Mar 2014 06:19:12 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebastian.capella@linaro.org>, Tomasz Figa <t.figa@samsung.com>

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
infrastructure required by the generic ARM64 CPU idle driver, that just
becomes a container for idle states storage.

Idle states define an entry method (eg PSCI), that requires the respective
kernel back-end to be invoked to initialize idle states parameters, so that
when the idle driver executes the back-end specific entry method a table
look-up can be carried out to retrieve the corresponding idle state paramet=
er.

The idle states bindings can be extended with new back-ends; the idle
states parser must be updated accordingly so that the corresponding back
end initializer can be invoked at boot time for parameters initialization.

Patchset has been tested on AEM v8 models, on top of the bootwrapper PSCI C=
PU
SUSPEND implementation which provides simulated core power gating.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/233=
478.html

Lorenzo Pieralisi (4):
  arm64: kernel: implement DT based idle states infrastructure
  arm64: add PSCI CPU_SUSPEND based cpu_suspend support
  drivers: cpuidle: CPU idle ARM64 driver
  arm64: boot: dts: update rtsm aemv8 dts with PSCI and idle states

 arch/arm64/Kconfig                     |   4 +
 arch/arm64/boot/dts/rtsm_ve-aemv8a.dts |  50 ++++-
 arch/arm64/include/asm/idle_states.h   |  20 ++
 arch/arm64/include/asm/psci.h          |   6 +
 arch/arm64/kernel/Makefile             |   1 +
 arch/arm64/kernel/idle_states.c        | 398 +++++++++++++++++++++++++++++=
++++
 arch/arm64/kernel/psci.c               |  84 +++++++
 drivers/cpuidle/Kconfig                |   5 +
 drivers/cpuidle/Kconfig.arm64          |  13 ++
 drivers/cpuidle/Makefile               |   4 +
 drivers/cpuidle/cpuidle-arm64.c        |  41 ++++
 11 files changed, 618 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/include/asm/idle_states.h
 create mode 100644 arch/arm64/kernel/idle_states.c
 create mode 100644 drivers/cpuidle/Kconfig.arm64
 create mode 100644 drivers/cpuidle/cpuidle-arm64.c

--=20
1.8.4


