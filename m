From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC][PATCH] ACPI / LPIT: Add LPIT table support
Date: Wed, 27 Sep 2017 19:30:00 -0700
Message-ID: <1506565800-63405-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, len.brown@kernel.org, linux-kernel@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Added functionality to read LPIT table, which provides:

- Sysfs interface to read residency counters via
/sys/devices/system/cpu/cpuidle/low_power_idle_cpu_residency_us
/sys/devices/system/cpu/cpuidle/low_power_idle_system_residency_us

Here the count "low_power_idle_cpu_residency_us" shows the time spent
by CPU package in low power state. This is read via MSR interface, which
points to MSR for PKG C10.

Here the count "low_power_idle_system_residency_us" show the count the
system was in low power state. This is read via MMIO interface. This
is mapped to SLP_S0 residency on modern Intel systems. This residency
is achieved only when CPU is in PKG C10 and all functional blocks are
in low power state.

It is possible that none of the above counters present or anyone of the
counter present or all counters present.

For example: On my Kabylake system both of the above counters present.

This counter can be read by tools like turbostat to display. Or it can
be used to debug, if the modern systems are reaching desired low power
state.

- Provides an interface to read residency counter memory address
This address can be used to get the base address of PMC memory mapped IO.
This is utilized by intel_pmc_core driver to print more debug information.

Link: http://www.uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/acpi/Kconfig     |   5 ++
 drivers/acpi/Makefile    |   1 +
 drivers/acpi/acpi_lpit.c | 162 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/scan.c      |   3 +
 include/acpi/acpi_lpit.h |  34 ++++++++++
 5 files changed, 205 insertions(+)
 create mode 100644 drivers/acpi/acpi_lpit.c
 create mode 100644 include/acpi/acpi_lpit.h

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 1ce52f8..443e39d 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -53,6 +53,7 @@ config ACPI_GENERIC_GSI
 
 config ACPI_SYSTEM_POWER_STATES_SUPPORT
 	bool
+	select ACPI_LPIT
 
 config ACPI_CCA_REQUIRED
 	bool
@@ -80,6 +81,10 @@ endif
 config ACPI_SPCR_TABLE
 	bool
 
+config ACPI_LPIT
+	bool
+	depends on X86
+
 config ACPI_SLEEP
 	bool
 	depends on SUSPEND || HIBERNATION
diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index 90265ab..6a19bd7 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -56,6 +56,7 @@ acpi-$(CONFIG_DEBUG_FS)		+= debugfs.o
 acpi-$(CONFIG_ACPI_NUMA)	+= numa.o
 acpi-$(CONFIG_ACPI_PROCFS_POWER) += cm_sbs.o
 acpi-y				+= acpi_lpat.o
+acpi-$(CONFIG_ACPI_LPIT)	+= acpi_lpit.o
 acpi-$(CONFIG_ACPI_GENERIC_GSI) += irq.o
 acpi-$(CONFIG_ACPI_WATCHDOG)	+= acpi_watchdog.o
 
diff --git a/drivers/acpi/acpi_lpit.c b/drivers/acpi/acpi_lpit.c
new file mode 100644
index 0000000..9920802
--- /dev/null
+++ b/drivers/acpi/acpi_lpit.c
@@ -0,0 +1,162 @@
+
+/*
+ * acpi_lpit.c - LPIT table processing functions
+ *
+ * Copyright (C) 2017 Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/cpu.h>
+#include <linux/acpi.h>
+#include <asm/msr.h>
+#include <asm/tsc.h>
+
+struct lpit_residency_info {
+	struct acpi_generic_address gaddr;
+	u64 frequency;
+	void __iomem *iomem_addr;
+};
+
+/* Storage for an memory mapped and FFH based entries */
+static struct lpit_residency_info residency_info_mem;
+static struct lpit_residency_info residency_info_ffh;
+
+static int lpit_read_residency_counter_us(u64 *counter, bool io_mem)
+{
+	int err;
+
+	if (io_mem) {
+		u32 count;
+
+		count = readl(residency_info_mem.iomem_addr);
+		*counter = div64_u64(count * 1000000ULL, residency_info_mem.frequency);
+		return 0;
+	}
+
+	err = rdmsrl_safe(residency_info_ffh.gaddr.address, counter);
+	if (!err) {
+		u64 mask = GENMASK_ULL(residency_info_ffh.gaddr.bit_offset +
+				       residency_info_ffh.gaddr. bit_width - 1,
+				       residency_info_ffh.gaddr.bit_offset);
+
+		*counter &= mask;
+		*counter >>= residency_info_ffh.gaddr.bit_offset;
+		*counter = div64_u64(*counter * 1000000ULL, residency_info_ffh.frequency);
+		return 0;
+	}
+
+	return -ENODATA;
+}
+
+static ssize_t low_power_idle_system_residency_us_show(struct device *dev,
+						       struct device_attribute *attr,
+						       char *buf)
+{
+	u64 counter;
+	int ret;
+
+	ret = lpit_read_residency_counter_us(&counter, true);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%llu\n", counter);
+}
+static DEVICE_ATTR_RO(low_power_idle_system_residency_us);
+
+static ssize_t low_power_idle_cpu_residency_us_show(struct device *dev,
+						    struct device_attribute *attr,
+						    char *buf)
+{
+	u64 counter;
+	int ret;
+
+	ret = lpit_read_residency_counter_us(&counter, false);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%llu\n", counter);
+}
+static DEVICE_ATTR_RO(low_power_idle_cpu_residency_us);
+
+int lpit_read_residency_count_address(u64 *address)
+{
+	if (!residency_info_mem.gaddr.address)
+		return -EINVAL;
+
+	*address = residency_info_mem.gaddr.address;
+
+	return 0;
+}
+
+static void lpit_update_residency(struct lpit_residency_info *info,
+				 struct acpi_lpit_native *lpit_native)
+{
+	info->frequency = lpit_native->counter_frequency ?
+				lpit_native->counter_frequency : tsc_khz * 1000;
+	if (!info->frequency)
+		info->frequency = 1;
+
+	info->gaddr = lpit_native->residency_counter;
+	if (info->gaddr.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+		info->iomem_addr = ioremap_nocache(info->gaddr.address,
+						   info->gaddr.bit_width / 8);
+		if (!info->iomem_addr)
+			return;
+
+		/* Silently fail, if cpuidle attribute group is not present */
+		sysfs_add_file_to_group(&cpu_subsys.dev_root->kobj,
+					&dev_attr_low_power_idle_system_residency_us.attr,
+					"cpuidle");
+	} else if (info->gaddr.space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) {
+		/* Silently fail, if cpuidle attribute group is not present */
+		sysfs_add_file_to_group(&cpu_subsys.dev_root->kobj,
+					&dev_attr_low_power_idle_cpu_residency_us.attr,
+					"cpuidle");
+	}
+}
+
+static void lpit_process(u64 begin, u64 end)
+{
+	while (begin + sizeof(struct acpi_lpit_native) < end) {
+		struct acpi_lpit_native *lpit_native = (struct acpi_lpit_native *)begin;
+
+		if (!lpit_native->header.type && !lpit_native->header.flags) {
+			if (lpit_native->residency_counter.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY &&
+			    !residency_info_mem.gaddr.address) {
+				lpit_update_residency(&residency_info_mem, lpit_native);
+			} else if (lpit_native->residency_counter.space_id == ACPI_ADR_SPACE_FIXED_HARDWARE &&
+				   !residency_info_ffh.gaddr.address) {
+				lpit_update_residency(&residency_info_ffh, lpit_native);
+			}
+		}
+		begin += lpit_native->header.length;
+	}
+}
+
+static void lpit_probe(void)
+{
+	acpi_status status;
+	u64 lpit_begin;
+	struct acpi_table_lpit *lpit;
+
+	status = acpi_get_table(ACPI_SIG_LPIT, 0, (struct acpi_table_header **)&lpit);
+
+	if (ACPI_FAILURE(status))
+		return;
+
+	lpit_begin = (u64)lpit + sizeof(*lpit);
+	lpit_process(lpit_begin, lpit_begin + lpit->header.length);
+}
+
+void acpi_init_lpit(void)
+{
+	lpit_probe();
+}
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 602f8ff..3f05d43 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -15,6 +15,8 @@
 #include <linux/dma-mapping.h>
 #include <linux/platform_data/x86/apple.h>
 
+#include <acpi/acpi_lpit.h>
+
 #include <asm/pgtable.h>
 
 #include "internal.h"
@@ -2122,6 +2124,7 @@ int __init acpi_scan_init(void)
 	acpi_int340x_thermal_init();
 	acpi_amba_init();
 	acpi_watchdog_init();
+	acpi_init_lpit();
 
 	acpi_scan_add_handler(&generic_device_handler);
 
diff --git a/include/acpi/acpi_lpit.h b/include/acpi/acpi_lpit.h
new file mode 100644
index 0000000..5d5285a
--- /dev/null
+++ b/include/acpi/acpi_lpit.h
@@ -0,0 +1,34 @@
+/*
+ * acpi_lpit.h - LPIT table processing functions interface
+ *
+ * Copyright (C) 2017 Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef ACPI_LPIT_H
+#define ACPI_LPIT_H
+
+#ifdef CONFIG_ACPI_LPIT
+
+void acpi_init_lpit(void);
+int lpit_read_residency_count_address(u64 *address);
+
+#else
+
+static inline void acpi_init_lpit(void) { }
+
+static inline int lpit_read_residency_count_address(u64 *address)
+{
+	return -EINVAL;
+}
+
+#endif
+#endif
-- 
2.7.5

