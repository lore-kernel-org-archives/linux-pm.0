From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH v8 4/8] arm64: kernel: introduce cpu_init_idle CPU operation
Date: Mon,  1 Sep 2014 16:28:40 +0100
Message-ID: <1409585324-3678-5-git-send-email-lorenzo.pieralisi@arm.com>
References: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:58844 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428AbaIAP2s (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 1 Sep 2014 11:28:48 -0400
In-Reply-To: <1409585324-3678-1-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Stephen Boyd <sboyd@codeaurora.org>, Kevin Hilman <khilman@linaro.org>, Sebastian Capella <sebcape@gmail.com>, Tomasz Figa <t.figa@samsung.com>, Mark Brown <broonie@kernel.org>, Paul Walmsley <paul@pwsan.com>, Chander Kashyap <k.chander@samsung.com>, Geoff

The CPUidle subsystem on ARM64 machines requires the idle states
implementation back-end to initialize idle states parameter upon
boot. This patch adds a hook in the CPU operations structure that
should be initialized by the CPU operations back-end in order to
provide a function that initializes cpu idle states.

This patch also adds the infrastructure to arm64 kernel required
to export the CPU operations based initialization interface, so
that drivers (ie CPUidle) can use it when they are initialized
at probe time.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/include/asm/cpu_ops.h |  3 +++
 arch/arm64/include/asm/cpuidle.h | 13 +++++++++++++
 arch/arm64/kernel/Makefile       |  1 +
 arch/arm64/kernel/cpuidle.c      | 31 +++++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+)
 create mode 100644 arch/arm64/include/asm/cpuidle.h
 create mode 100644 arch/arm64/kernel/cpuidle.c

diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cpu_=
ops.h
index d7b4b38..47dfa31 100644
--- a/arch/arm64/include/asm/cpu_ops.h
+++ b/arch/arm64/include/asm/cpu_ops.h
@@ -28,6 +28,8 @@ struct device_node;
  *=09=09enable-method property.
  * @cpu_init:=09Reads any data necessary for a specific enable-method from=
 the
  *=09=09devicetree, for a given cpu node and proposed logical id.
+ * @cpu_init_idle: Reads any data necessary to initialize CPU idle states =
from
+ *=09=09devicetree, for a given cpu node and proposed logical id.
  * @cpu_prepare: Early one-time preparation step for a cpu. If there is a
  *=09=09mechanism for doing so, tests whether it is possible to boot
  *=09=09the given CPU.
@@ -47,6 +49,7 @@ struct device_node;
 struct cpu_operations {
 =09const char=09*name;
 =09int=09=09(*cpu_init)(struct device_node *, unsigned int);
+=09int=09=09(*cpu_init_idle)(struct device_node *, unsigned int);
 =09int=09=09(*cpu_prepare)(unsigned int);
 =09int=09=09(*cpu_boot)(unsigned int);
 =09void=09=09(*cpu_postboot)(void);
diff --git a/arch/arm64/include/asm/cpuidle.h b/arch/arm64/include/asm/cpui=
dle.h
new file mode 100644
index 0000000..b52a993
--- /dev/null
+++ b/arch/arm64/include/asm/cpuidle.h
@@ -0,0 +1,13 @@
+#ifndef __ASM_CPUIDLE_H
+#define __ASM_CPUIDLE_H
+
+#ifdef CONFIG_CPU_IDLE
+extern int cpu_init_idle(unsigned int cpu);
+#else
+static inline int cpu_init_idle(unsigned int cpu)
+{
+=09return -EOPNOTSUPP;
+}
+#endif
+
+#endif
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 383d81d..be78980 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -27,6 +27,7 @@ arm64-obj-$(CONFIG_PERF_EVENTS)=09=09+=3D perf_regs.o
 arm64-obj-$(CONFIG_HW_PERF_EVENTS)=09+=3D perf_event.o
 arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)=09+=3D hw_breakpoint.o
 arm64-obj-$(CONFIG_ARM64_CPU_SUSPEND)=09+=3D sleep.o suspend.o
+arm64-obj-$(CONFIG_CPU_IDLE)=09=09+=3D cpuidle.o
 arm64-obj-$(CONFIG_JUMP_LABEL)=09=09+=3D jump_label.o
 arm64-obj-$(CONFIG_KGDB)=09=09+=3D kgdb.o
 arm64-obj-$(CONFIG_EFI)=09=09=09+=3D efi.o efi-stub.o efi-entry.o
diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
new file mode 100644
index 0000000..19d17f5
--- /dev/null
+++ b/arch/arm64/kernel/cpuidle.c
@@ -0,0 +1,31 @@
+/*
+ * ARM64 CPU idle arch support
+ *
+ * Copyright (C) 2014 ARM Ltd.
+ * Author: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+#include <asm/cpuidle.h>
+#include <asm/cpu_ops.h>
+
+int cpu_init_idle(unsigned int cpu)
+{
+=09int ret =3D -EOPNOTSUPP;
+=09struct device_node *cpu_node =3D of_cpu_device_node_get(cpu);
+
+=09if (!cpu_node)
+=09=09return -ENODEV;
+
+=09if (cpu_ops[cpu] && cpu_ops[cpu]->cpu_init_idle)
+=09=09ret =3D cpu_ops[cpu]->cpu_init_idle(cpu_node, cpu);
+
+=09of_node_put(cpu_node);
+=09return ret;
+}
--=20
1.9.1


