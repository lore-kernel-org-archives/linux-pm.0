From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH] drivers: cpuidle: rename ARM big.LITTLE driver config and makefile entries
Date: Fri, 13 Sep 2013 12:32:46 +0100
Message-ID: <1379071966-26757-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:41987 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755491Ab3IMLc4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Sep 2013 07:32:56 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>, Daniel Lezcano <daniel.lezcano@linaro.org>

Following the reorganization of CPU idle drivers configurations into an ARM
specific Kconfig, the existing idle drivers Kconfig entries were renamed an=
d
moved to the Kconfig.arm file. Makefile entries were updated accordingly.

This patch renames the entries in Kconfig.arm and makefile to make the newl=
y
added big.LITTLE CPUidle driver compliant with the new naming convention.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/cpuidle/Kconfig.arm | 2 +-
 drivers/cpuidle/Makefile    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 8e36603..ea0f045 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -27,7 +27,7 @@ config ARM_U8500_CPUIDLE
 =09help
 =09  Select this to enable cpuidle for ST-E u8500 processors
=20
-config CPU_IDLE_BIG_LITTLE
+config ARM_BIG_LITTLE_CPUIDLE
 =09bool "Support for ARM big.LITTLE processors"
 =09depends on ARCH_VEXPRESS_TC2_PM
 =09select ARM_CPU_SUSPEND
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index cea5ef5..3c693c2 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -11,4 +11,4 @@ obj-$(CONFIG_ARM_HIGHBANK_CPUIDLE)=09+=3D cpuidle-calxeda=
.o
 obj-$(CONFIG_ARM_KIRKWOOD_CPUIDLE)=09+=3D cpuidle-kirkwood.o
 obj-$(CONFIG_ARM_ZYNQ_CPUIDLE)=09=09+=3D cpuidle-zynq.o
 obj-$(CONFIG_ARM_U8500_CPUIDLE)         +=3D cpuidle-ux500.o
-obj-$(CONFIG_CPU_IDLE_BIG_LITTLE)=09+=3D cpuidle-big_little.o
+obj-$(CONFIG_ARM_BIG_LITTLE_CPUIDLE)=09+=3D cpuidle-big_little.o
--=20
1.8.2.2


