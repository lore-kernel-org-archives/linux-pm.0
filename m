From: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Subject: [PATCH 4/4] x86, acpi: Handle apic/x2apic entries in MADT in correct order
Date: Tue,  8 Sep 2015 13:08:00 +0200
Message-ID: <1441710480-17622-6-git-send-email-lukasz.anaczkowski@intel.com>
References: <20150827093738.GA21134@red-moon>
 <1441710480-17622-1-git-send-email-lukasz.anaczkowski@intel.com>
 <1441710480-17622-2-git-send-email-lukasz.anaczkowski@intel.com>
 <1441710480-17622-3-git-send-email-lukasz.anaczkowski@intel.com>
 <1441710480-17622-4-git-send-email-lukasz.anaczkowski@intel.com>
 <1441710480-17622-5-git-send-email-lukasz.anaczkowski@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:22674 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753367AbbIHLI5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 8 Sep 2015 07:08:57 -0400
In-Reply-To: <1441710480-17622-5-git-send-email-lukasz.anaczkowski@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: marc.zyngier@arm.com, lorenzo.pieralisi@arm.com, tomasz.nowicki@linaro.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jason@lakedaemon.net
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>, Yinghai Lu <yinghai@kernel.org>

ACPI specifies the following rules when listing APIC IDs:
(1) Boot processor is listed first
(2) For multi-threaded processors, BIOS should list the first logical
    processor of each of the individual multi-threaded processors in MADT
    before listing any of the second logical processors.
(3) APIC IDs < 0xFF should be listed in APIC subtable, APIC IDs >= 0xFF
    should be listed in X2APIC subtable

Because of above, when there's more than 0xFF logical CPUs, BIOS
interleaves APIC/X2APIC subtables.

Assuming, there's 72 cores, 72 hyper-threads each, 288 CPUs total,
listing is like this:

APIC (0,4,8, .., 252)
X2APIC (258,260,264, .. 284)
APIC (1,5,9,...,253)
X2APIC (259,261,265,...,285)
APIC (2,6,10,...,254)
X2APIC (260,262,266,..,286)
APIC (3,7,11,...,251)
X2APIC (255,261,262,266,..,287)

Now, before this patch, due to how ACPI MADT subtables were parsed (BSP
then X2APIC then APIC), kernel enumerated CPUs in reverted order (i.e.
high APIC IDs were getting low logical IDs, and low APIC IDs were
getting high logical IDs).
This is wrong for the following reasons:
() it's hard to predict how cores and threads are enumerated
() when it's hard to predict, s/w threads cannot be properly affinitized
   causing significant performance impact due to e.g. inproper cache
   sharing
() enumeration is inconsistent with how threads are enumerated on
   other Intel Xeon processors

To fix this, each APIC/X2APIC entry from MADT table needs to be
handled at the same time when processing them. Thus, adding
acpi_subtable_proc structure which stores
() ACPI table id
() handler that processes table
() counter how many items has been processed
and passing it to acpi_table_parse_entries().

Also, order in which MADT APIC/X2APIC handlers are passed is
reversed to achieve correct CPU enumeration.

In scenario when someone boots kernel with options 'maxcpus=72 nox2apic',
in result less cores may be booted, since some of the CPUs the kernel
will try to use will have APIC ID >= 0xFF. In such case, one
should not pass 'nox2apic'.

Disclimer: code parsing MADT APIC/X2APIC has not been touched since 2009,
when X2APIC support was initially added. I do not know why MADT parsing
code was added in the reversed order in the first place.
I guess it didn't matter at that time since nobody cared about cores
with APIC IDs >= 0xFF, right?

This patch is based on work of "Yinghai Lu <yinghai@kernel.org>"
previously published at https://lkml.org/lkml/2013/1/21/563,
thus putting Yinghai Lu as 'Signed-off-by', as well.

Signed-off-by: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de> (commit message)
---
 arch/x86/kernel/acpi/boot.c | 37 ++++++++++++++++++-------------------
 drivers/acpi/tables.c       |  3 ++-
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 21cb7a0..8e014d4 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -981,7 +981,8 @@ static int __init acpi_parse_madt_lapic_entries(void)
 {
 	int count;
 	int x2count = 0;
-	struct acpi_subtable_proc madt_proc[1];
+	int ret;
+	struct acpi_subtable_proc madt_proc[2];
 
 	if (!cpu_has_apic)
 		return -ENODEV;
@@ -1008,16 +1009,19 @@ static int __init acpi_parse_madt_lapic_entries(void)
 		memset(madt_proc, 0, sizeof(madt_proc));
 		madt_proc[0].id = ACPI_MADT_TYPE_LOCAL_X2APIC;
 		madt_proc[0].handler = acpi_parse_x2apic;
-		x2count = acpi_table_parse_entries_array(ACPI_SIG_MADT,
-						sizeof(struct acpi_table_madt),
-						madt_proc, ARRAY_SIZE(madt_proc), MAX_LOCAL_APIC);
-
-		memset(madt_proc, 0, sizeof(madt_proc));
-		madt_proc[0].id = ACPI_MADT_TYPE_LOCAL_APIC;
-		madt_proc[0].handler = acpi_parse_lapic;
-		count = acpi_table_parse_entries_array(ACPI_SIG_MADT,
+		madt_proc[1].id = ACPI_MADT_TYPE_LOCAL_APIC;
+		madt_proc[1].handler = acpi_parse_lapic;
+		ret = acpi_table_parse_entries_array(ACPI_SIG_MADT,
 				sizeof(struct acpi_table_madt),
 				madt_proc, ARRAY_SIZE(madt_proc), MAX_LOCAL_APIC);
+		if (ret < 0) {
+			printk(KERN_ERR PREFIX
+					"Error parsing LAPIC/X2APIC entries\n");
+			return ret;
+		}
+
+		x2count = madt_proc[0].count;
+		count = madt_proc[1].count;
 	}
 	if (!count && !x2count) {
 		printk(KERN_ERR PREFIX "No LAPIC entries present\n");
@@ -1032,21 +1036,16 @@ static int __init acpi_parse_madt_lapic_entries(void)
 	memset(madt_proc, 0, sizeof(madt_proc));
 	madt_proc[0].id = ACPI_MADT_TYPE_LOCAL_X2APIC_NMI;
 	madt_proc[0].handler = acpi_parse_x2apic_nmi;
-	count = acpi_table_parse_entries_array(ACPI_SIG_MADT,
+	madt_proc[1].id = ACPI_MADT_TYPE_LOCAL_APIC_NMI;
+	madt_proc[1].handler = acpi_parse_lapic_nmi;
+	ret = acpi_table_parse_entries_array(ACPI_SIG_MADT,
 			sizeof(struct acpi_table_madt),
 			madt_proc, ARRAY_SIZE(madt_proc), 0);
 
-	memset(madt_proc, 0, sizeof(madt_proc));
-	madt_proc[0].id = ACPI_MADT_TYPE_LOCAL_APIC_NMI;
-	madt_proc[0].handler = acpi_parse_lapic_nmi;
-	x2count = acpi_table_parse_entries_array(ACPI_SIG_MADT,
-			sizeof(struct acpi_table_madt),
-			madt_proc, ARRAY_SIZE(madt_proc), 0);
-
-	if (count < 0 || x2count < 0) {
+	if (ret < 0) {
 		printk(KERN_ERR PREFIX "Error parsing LAPIC NMI entry\n");
 		/* TBD: Cleanup to allow fallback to MPS */
-		return count;
+		return ret;
 	}
 	return 0;
 }
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index ececeac..bc23220 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -239,6 +239,7 @@ acpi_parse_entries(char *id, unsigned long table_size,
 	struct acpi_subtable_header *entry;
 	int count = 0;
 	unsigned long table_end;
+	int i;
 
 	if (acpi_disabled)
 		return -ENODEV;
@@ -269,7 +270,7 @@ acpi_parse_entries(char *id, unsigned long table_size,
 		for (i = 0; i < proc_num; i++) {
 			if (entry->type != proc[i].id)
 				continue;
-			if (!proc->handler || proc[i].handler(entry, table_end)) {
+			if (!proc->handler || proc[i].handler(entry, table_end))
 				return -EINVAL;
 
 			proc->count++;
-- 
1.8.3.1

