From: Marc Titinger <mtitinger@baylibre.com>
Subject: [RFC v3 6/7] arm64: PM /Domains: Initialize CPU-domains from DT.
Date: Tue, 27 Oct 2015 18:40:55 +0100
Message-ID: <1445967656-28292-7-git-send-email-mtitinger+renesas@baylibre.com>
References: <1445967656-28292-1-git-send-email-mtitinger+renesas@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967656-28292-1-git-send-email-mtitinger+renesas@baylibre.com>
In-Reply-To: <20151019205825.GA82426@linaro.org>
References: <20151019205825.GA82426@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lina.iyer@linaro.org
Cc: rjw@rjwysocki.net, khilman@kernel.org, ahaslam@baylibre.com, bcousson@baylibre.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Marc Titinger <mtitinger@baylibre.com>, Marc Titinger <mtitinger+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

From: Marc Titinger <mtitinger@baylibre.com>

Signed-off-by: Marc Titinger <mtitinger+renesas@baylibre.com>
---
 arch/arm64/kernel/Makefile     |  1 +
 arch/arm64/kernel/cpu_domain.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+)
 create mode 100644 arch/arm64/kernel/cpu_domain.c

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 1b6bda2..5f8b59f 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -46,6 +46,7 @@ arm64-obj-$(CONFIG_EFI)			+= efi.o $(stub-obj)
 arm64-obj-$(CONFIG_PCI)			+= pci.o
 arm64-obj-$(CONFIG_ARMV8_DEPRECATED)	+= armv8_deprecated.o
 arm64-obj-$(CONFIG_ACPI)		+= acpi.o
+arm64-obj-$(CONFIG_PM_GENERIC_DOMAINS)	+= cpu_domain.o
 
 obj-y					+= $(arm64-obj-y) vdso/
 obj-m					+= $(arm64-obj-m)
diff --git a/arch/arm64/kernel/cpu_domain.c b/arch/arm64/kernel/cpu_domain.c
new file mode 100644
index 0000000..06a3949
--- /dev/null
+++ b/arch/arm64/kernel/cpu_domain.c
@@ -0,0 +1,19 @@
+/*
+ * Copyright (c) 2015, Linaro Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#include <linux/cpu-pd.h>
+
+static int __init arm64_cpu_pd_init(void)
+{
+	return of_cpu_pd_init("arm,cpu-pd");
+}
+device_initcall(arm64_cpu_pd_init);
-- 
1.9.1
