From: Al Stone <ahs3@redhat.com>
Subject: [PATCH] Force cppc_cpufreq to report values in KHz to fix user space reporting
Date: Fri, 15 Apr 2016 16:16:34 -0600
Message-ID: <1460758594-1596-1-git-send-email-ahs3@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51652 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683AbcDOWQn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 15 Apr 2016 18:16:43 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh.kumar@linaro.org, rjw@rjwysocki.net
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, ahs3@redhat.com

When CPPC is being used by ACPI on arm64, user space tools such as
cpupower report CPU frequency values from sysfs that are incorrect.

What the driver was doing was reporting the values given by ACPI tables
in whatever scale was used to provide them.  However, the ACPI spec
defines the CPPC values as unitless abstract numbers.  Internal kernel
structures such as struct perf_cap, in contrast, expect these values
to be in KHz.  When these struct values get reported via sysfs, the
user space tools also assume they are in KHz, causing them to report
incorrect values (for example, reporting a CPU frequency of 1MHz when
it should be 1.8GHz).

While the investigation for a long term fix proceeds (several options
are being explored, some of which may require spec changes or other
much more invasive fixes), this patch forces the values read by CPPC
to be read in KHz, regardless of what they actually represent.

The downside is that this approach has some assumptions:

   (1) It relies on SMBIOS3 being used, *and* that the Max Frequency
   value for a processor is set to a non-zero value.

   (2) It assumes that all processors run at the same speed.  This
   patch retrieves the first CPU Max Frequency from a type 4 DMI
   record that it can find.  This may not be an issue, however, as a
   sampling of DMI data on x86 and arm64 indicates there is often only
   one such record regardless.

For arm64 servers, this may be sufficient, but it does rely on
firmware values being set correctly.  Hence, other approaches are
also being considered.

This has been tested on three arm64 servers, with and without DMI, with
and without CPPC support.

Signed-off-by: Al Stone <ahs3@redhat.com>
---
 drivers/acpi/cppc_acpi.c    | 61 +++++++++++++++++++++++++++++++++++++++++----
 drivers/cpufreq/Kconfig.arm |  1 +
 2 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 8adac69..049dced 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -40,6 +40,9 @@
 #include <linux/cpufreq.h>
 #include <linux/delay.h>
 #include <linux/ktime.h>
+#include <linux/dmi.h>
+
+#include <asm/unaligned.h>
 
 #include <acpi/cppc_acpi.h>
 /*
@@ -709,6 +712,47 @@ static int cpc_write(struct cpc_reg *reg, u64 val)
 	return ret_val;
 }
 
+static u64 cppc_dmi_khz;
+
+static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private)
+{
+	u16 *mhz = (u16 *)private;
+	const u8 *dmi_data = (const u8 *)dm;
+
+	if (dm->type == DMI_ENTRY_PROCESSOR && dm->length >= 48)
+		*mhz = (u16)get_unaligned((const u16 *)(dmi_data + 0x14));
+}
+
+
+static u64 cppc_get_dmi_khz(void)
+{
+	u16 mhz;
+
+	dmi_walk(cppc_find_dmi_mhz, &mhz);
+
+	/*
+	 * Real stupid fallback value, just in case there is no
+	 * actual value set.
+	 */
+	mhz = mhz ? mhz : 1;
+
+	return (1000 * mhz);
+}
+
+static u64 cppc_unitless_to_khz(u64 min, u64 max, u64 val)
+{
+	/*
+	 * The incoming val should be min <= val <= max.  Our
+	 * job is to convert that to KHz so it can be properly
+	 * reported to user space via cpufreq_policy.
+	 */
+
+	if (!cppc_dmi_khz)
+		cppc_dmi_khz = cppc_get_dmi_khz();
+
+	return ((val - min) * cppc_dmi_khz) / (max - min);
+}
+
 /**
  * cppc_get_perf_caps - Get a CPUs performance capabilities.
  * @cpunum: CPU from which to get capabilities info.
@@ -748,17 +792,24 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
 		}
 	}
 
+	/*
+	 * Since these values in perf_caps will be used in setting
+	 * up the cpufreq policy, they must always be stored in units
+	 * of KHz.  If they are not, user space tools will become very
+	 * confused since they assume these are in KHz when reading
+	 * sysfs.
+	 */
 	cpc_read(&highest_reg->cpc_entry.reg, &high);
-	perf_caps->highest_perf = high;
-
 	cpc_read(&lowest_reg->cpc_entry.reg, &low);
-	perf_caps->lowest_perf = low;
+
+	perf_caps->highest_perf = cppc_unitless_to_khz(low, high, high);
+	perf_caps->lowest_perf = cppc_unitless_to_khz(low, high, low);
 
 	cpc_read(&ref_perf->cpc_entry.reg, &ref);
-	perf_caps->reference_perf = ref;
+	perf_caps->reference_perf = cppc_unitless_to_khz(low, high, ref);
 
 	cpc_read(&nom_perf->cpc_entry.reg, &nom);
-	perf_caps->nominal_perf = nom;
+	perf_caps->nominal_perf = cppc_unitless_to_khz(low, high, nom);
 
 	if (!ref)
 		perf_caps->reference_perf = perf_caps->nominal_perf;
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 14b1f93..0573982 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -255,6 +255,7 @@ config ACPI_CPPC_CPUFREQ
 	tristate "CPUFreq driver based on the ACPI CPPC spec"
 	depends on ACPI
 	select ACPI_CPPC_LIB
+	select DMI
 	default n
 	help
 	  This adds a CPUFreq driver which uses CPPC methods
-- 
2.5.5

