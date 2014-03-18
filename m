From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH RFC 3/4] drivers: cpuidle: CPU idle ARM64 driver
Date: Tue, 18 Mar 2014 10:20:27 +0000
Message-ID: <1395138028-19630-4-git-send-email-lorenzo.pieralisi@arm.com>
References: <1395138028-19630-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:54473 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780AbaCRKTS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Mar 2014 06:19:18 -0400
In-Reply-To: <1395138028-19630-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebastian.capella@linaro.org>, Tomasz Figa <t.figa@samsung.com>

This patch implements a generic CPU idle driver for ARM64 machines.

It relies on the ARM idle states infrastructure to initialize idle
states count and respective parameters. Current code assumes the driver
is managing idle states on all possible CPUs but can be easily
generalized to support heterogenous systems and build cpumasks at
runtime using MIDRs or DT cpu nodes compatible properties.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/cpuidle/Kconfig         |  5 +++++
 drivers/cpuidle/Kconfig.arm64   | 13 +++++++++++++
 drivers/cpuidle/Makefile        |  4 ++++
 drivers/cpuidle/cpuidle-arm64.c | 41 +++++++++++++++++++++++++++++++++++++=
++++
 4 files changed, 63 insertions(+)
 create mode 100644 drivers/cpuidle/Kconfig.arm64
 create mode 100644 drivers/cpuidle/cpuidle-arm64.c

diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index f04e25f..9b3f613 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -35,6 +35,11 @@ depends on ARM
 source "drivers/cpuidle/Kconfig.arm"
 endmenu
=20
+menu "ARM64 CPU Idle Drivers"
+depends on ARM64
+source "drivers/cpuidle/Kconfig.arm64"
+endmenu
+
 menu "POWERPC CPU Idle Drivers"
 depends on PPC
 source "drivers/cpuidle/Kconfig.powerpc"
diff --git a/drivers/cpuidle/Kconfig.arm64 b/drivers/cpuidle/Kconfig.arm64
new file mode 100644
index 0000000..42af83a
--- /dev/null
+++ b/drivers/cpuidle/Kconfig.arm64
@@ -0,0 +1,13 @@
+#
+# ARM64 CPU Idle drivers
+#
+
+config ARM64_CPUIDLE
+=09bool "Generic ARM64 CPU idle Driver"
+=09select ARM64_IDLE_STATES
+=09help
+=09  Select this to enable generic cpuidle driver for ARM v8.
+=09  It provides a generic idle driver whose idle states are configured
+=09  at run-time through DT nodes. Idle protocol backends are initialized
+=09  by the device tree parsing code on matching the entry method for
+=09  the respective protocol.
diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
index f71ae1b..4051b37 100644
--- a/drivers/cpuidle/Makefile
+++ b/drivers/cpuidle/Makefile
@@ -15,6 +15,10 @@ obj-$(CONFIG_ARM_U8500_CPUIDLE)         +=3D cpuidle-ux5=
00.o
 obj-$(CONFIG_ARM_AT91_CPUIDLE)          +=3D cpuidle-at91.o
=20
 ##########################################################################=
#####
+# ARM64 drivers
+obj-$(CONFIG_ARM64_CPUIDLE)=09=09+=3D cpuidle-arm64.o
+
+##########################################################################=
#####
 # POWERPC drivers
 obj-$(CONFIG_PSERIES_CPUIDLE)=09=09+=3D cpuidle-pseries.o
 obj-$(CONFIG_POWERNV_CPUIDLE)=09=09+=3D cpuidle-powernv.o
diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm6=
4.c
new file mode 100644
index 0000000..08ffe16
--- /dev/null
+++ b/drivers/cpuidle/cpuidle-arm64.c
@@ -0,0 +1,41 @@
+/*
+ * ARM64 generic CPU idle driver.
+ *
+ * Copyright (C) 2014 ARM Ltd.
+ * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/cpuidle.h>
+#include <linux/cpumask.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+
+#include <asm/idle_states.h>
+
+struct cpuidle_driver arm64_idle_driver =3D {
+=09.name =3D "arm64_idle",
+=09.owner =3D THIS_MODULE,
+};
+
+/*
+ * arm64_idle_init
+ *
+ * Registers the arm specific cpuidle driver with the cpuidle
+ * framework. It relies on core code to parse the idle states
+ * and initialize them in the driver accordingly.
+ */
+static int __init arm64_idle_init(void)
+{
+=09int ret;
+
+=09arm64_idle_driver.cpumask =3D (struct cpumask *) cpu_possible_mask;
+=09ret =3D arm_init_idle_driver(&arm64_idle_driver);
+=09if (ret)
+=09=09return ret;
+=09return cpuidle_register(&arm64_idle_driver, NULL);
+}
+device_initcall(arm64_idle_init);
--=20
1.8.4


