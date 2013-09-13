From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v2] drivers: cpuidle: rename ARM big.LITTLE driver config and makefile entries
Date: Fri, 13 Sep 2013 16:38:41 +0100
Message-ID: <1379086721-5242-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:54418 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756564Ab3IMPiu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2013 11:38:50 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>, Daniel Lezcano <daniel.lezcano@linaro.org>

Following the reorganization of CPU idle drivers configurations into an ARM
specific Kconfig, the existing idle drivers Kconfig entries were renamed an=
d
moved to the Kconfig.arm file. Makefile entries were updated accordingly.

This patch renames the entries in Kconfig.arm and makefile to make the newl=
y
added big.LITTLE CPUidle driver compliant with the new naming convention.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Kevin Hilman <khilman@linaro.org>
---
 drivers/cpuidle/Kconfig.arm | 22 +++++++++++-----------
 drivers/cpuidle/Makefile    |  2 +-
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 8e36603..6a7e6f2 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -2,6 +2,17 @@
 # ARM CPU Idle drivers
 #
=20
+config ARM_BIG_LITTLE_CPUIDLE
+=09bool "Support for ARM big.LITTLE processors"
+=09depends on ARCH_VEXPRESS_TC2_PM
+=09select ARM_CPU_SUSPEND
+=09select CPU_IDLE_MULTIPLE_DRIVERS
+=09help
+=09  Select this option to enable CPU idle driver for big.LITTLE based
+=09  ARM systems. Driver manages CPUs coordination through MCPM and
+=09  define different C-states for little and big cores through the
+=09  multiple CPU idle drivers infrastructure.
+
 config ARM_HIGHBANK_CPUIDLE
 =09bool "CPU Idle Driver for Calxeda processors"
 =09depends on ARCH_HIGHBANK
@@ -26,14 +37,3 @@ config ARM_U8500_CPUIDLE
 =09depends on ARCH_U8500
 =09help
 =09  Select this to enable cpuidle for ST-E u8500 processors
-
-config CPU_IDLE_BIG_LITTLE
-=09bool "Support for ARM big.LITTLE processors"
-=09depends on ARCH_VEXPRESS_TC2_PM
-=09select ARM_CPU_SUSPEND
-=09select CPU_IDLE_MULTIPLE_DRIVERS
-=09help
-=09  Select this option to enable CPU idle driver for big.LITTLE based
-=09  ARM systems. Driver manages CPUs coordination through MCPM and
-=09  define different C-states for little and big cores through the
-=09  multiple CPU idle drivers infrastructure.
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index cea5ef5..d08bd40 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -7,8 +7,8 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) +=3D coupled.o
=20
 ##########################################################################=
########
 # ARM SoC drivers
+obj-$(CONFIG_ARM_BIG_LITTLE_CPUIDLE)=09+=3D cpuidle-big_little.o
 obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE)=09+=3D cpuidle-calxeda.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)=09+=3D cpuidle-kirkwood.o
 obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)=09=09+=3D cpuidle-zynq.o
 obj-$(CONFIG_ARM_U8500_CPUIDLE)         +=3D cpuidle-ux500.o
-obj-$(CONFIG_CPU_IDLE_BIG_LITTLE)=09+=3D cpuidle-big_little.o
--=20
1.8.2.2


