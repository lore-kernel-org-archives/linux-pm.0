From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v3 0/3] ARM: TC2 big.LITTLE CPU idle driver
Date: Wed,  7 Aug 2013 12:43:30 +0100
Message-ID: <1375875813-13358-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:33119 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756405Ab3HGLnm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Aug 2013 07:43:42 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>, Amit Kucheria <amit.kucheria@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Jon Medhurst <tixy@linaro.org>

This patch is v3 of a previous posting:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/189284.ht=
ml

v3 changes:

- dropped RFC tag
- updated exit_latency and target_residency values as per spec
- added C-state tables comments
- improved readability as per-reviews

v2 changes:

- removed duplicated idle statistics and irq enabling
- use MPIDR masks to compute cluster and cpu ids

This patch series provides the implementation of CPU idle driver for the TC=
2
ARM big.LITTLE SoC. It is based and dependent on Nico's branch

git://git.linaro.org/people/nico/linux mcpm+tc2

and relative pull request

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/185411.html

First two patches in the series simply implement a method to disable the
GIC CPU IF and add the respective call in the MCPM TC2 back-end. Details
are explained in the commit logs.

Patch 3 implements the TC2 CPU idle driver, that paves the way for a
generic ARM idle driver, MCPM based (but PSCI can be easily integrated
as well) for all upcoming big.LITTLE systems.

The CPU idle driver is built upon the multiple drivers CPU idle infrastruct=
ure
to define different target residencies for different clusters.

Current driver matches the DT compatible string defining a TC2 testchip cor=
e
tile, but in the future will be augmented with a proper match table to
match against all machines that can rely on this driver to implement CPU
idle capabilities.

This CPU idle driver integrates all existing PM kernel concepts recently
implemented for ARM, MCPM, CPU PM notifiers and cpu_suspend and lays the
foundation for a reference implementation of a generic CPU idle driver, sin=
ce
the driver as it stands is completely generic, C-states definition
notwithstanding.

C-state definition for the driver should be made dynamic so that the driver
can become completely generic and decoupled from static C-states definition=
.

The driver has been tested, obviously on the TC2 testchip, with different
Linux systems ranging from simple busybox to Android and Ubuntu rootfs,
through millions of C-state iterations randomly triggered by the
aforementioned root filesystem environments.

Comments and review very welcome.

With thanks,
Lorenzo

Lorenzo Pieralisi (2):
  ARM: vexpress: tc2: disable GIC CPU IF in tc2_pm_suspend
  cpuidle: big.LITTLE: vexpress-TC2 CPU idle driver

Nicolas Pitre (1):
  drivers: irq-chip: irq-gic: introduce gic_cpu_if_down()

 MAINTAINERS                          |   9 ++
 arch/arm/mach-vexpress/tc2_pm.c      |   2 +
 drivers/cpuidle/Kconfig              |  10 ++
 drivers/cpuidle/Makefile             |   1 +
 drivers/cpuidle/cpuidle-big_little.c | 210 +++++++++++++++++++++++++++++++=
++++
 drivers/irqchip/irq-gic.c            |   6 +
 include/linux/irqchip/arm-gic.h      |   1 +
 7 files changed, 239 insertions(+)
 create mode 100644 drivers/cpuidle/cpuidle-big_little.c

--=20
1.8.2.2


