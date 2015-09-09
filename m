From: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Subject: [PATCH v4 2/2] x86, acpi: Handle apic/x2apic entries in MADT in correct order
Date: Wed,  9 Sep 2015 15:47:29 +0200
Message-ID: <1441806449-27481-4-git-send-email-lukasz.anaczkowski@intel.com>
References: <55F00E55.9080008@arm.com>
 <1441806449-27481-1-git-send-email-lukasz.anaczkowski@intel.com>
 <1441806449-27481-2-git-send-email-lukasz.anaczkowski@intel.com>
 <1441806449-27481-3-git-send-email-lukasz.anaczkowski@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:53423 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753563AbbIINrs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 9 Sep 2015 09:47:48 -0400
In-Reply-To: <1441806449-27481-3-git-send-email-lukasz.anaczkowski@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: marc.zyngier@arm.com, lorenzo.pieralisi@arm.com, tomasz.nowicki@linaro.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jason@lakedaemon.net
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>

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

So, order in which MADT APIC/X2APIC handlers are passed is
reverse and both handlers are passed to be called during same MADT
table to walk to achieve correct CPU enumeration.

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
previously published at https://lkml.org/lkml/2013/1/21/563

Here's the explanation why parsing interface needs to be changed
and why simpler approach will not work https://lkml.org/lkml/2015/9/7/285

Signed-off-by: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de> (commit message)
---
 arch/x86/kernel/acpi/boot.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index e49ee24..116e911 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -981,6 +981,8 @@ static int __init acpi_parse_madt_lapic_entries(void)
 {
 	int count;
 	int x2count = 0;
+	int ret;
+	struct acpi_subtable_proc madt_proc[2];
 
 	if (!cpu_has_apic)
 		return -ENODEV;
@@ -1004,10 +1006,22 @@ static int __init acpi_parse_madt_lapic_entries(void)
 				      acpi_parse_sapic, MAX_LOCAL_APIC);
 
 	if (!count) {
-		x2count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2APIC,
-					acpi_parse_x2apic, MAX_LOCAL_APIC);
-		count = acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC,
-					acpi_parse_lapic, MAX_LOCAL_APIC);
+		memset(madt_proc, 0, sizeof(madt_proc));
+		madt_proc[0].id = ACPI_MADT_TYPE_LOCAL_APIC;
+		madt_proc[0].handler = acpi_parse_lapic;
+		madt_proc[1].id = ACPI_MADT_TYPE_LOCAL_X2APIC;
+		madt_proc[1].handler = acpi_parse_x2apic;
+		ret = acpi_table_parse_entries_array(ACPI_SIG_MADT,
+				sizeof(struct acpi_table_madt),
+				madt_proc, ARRAY_SIZE(madt_proc), MAX_LOCAL_APIC);
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
-- 
1.8.3.1

