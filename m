From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 1/3] x86: Kill E820_RESERVED_KERN
Date: Thu, 27 Aug 2015 15:05:57 +0800
Message-ID: <e42b3c4d96adcb68d8437a28573a81ee5f6bddb4.1440640658.git.yu.c.chen@intel.com>
References: <cover.1440640658.git.yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55901 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751563AbbH0HCp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 27 Aug 2015 03:02:45 -0400
In-Reply-To: <cover.1440640658.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: tglx@linutronix.de, mingo@redhat.com, rjw@rjwysocki.net, pavel@ucw.cz, hpa@zytor.com
Cc: len.brown@intel.com, yinghai@kernel.org, joeyli.kernel@gmail.com, rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

From: Yinghai Lu <yinghai@kernel.org>

Sometimes E820_RESERVED_KERN causes hibernation failor when resuming:
https://bugzilla.kernel.org/show_bug.cgi?id=96111
This is because E820_RESERVED_KERN sometimes cause the regions in e820
table not page aligned, then bootup process will misjudgment the
non-page-aligned space as "hole" space and adds them to nosave region
list, then hibernation resuming process will treat these regions as
invalid thus the resuming process terminates, which causes the failor.
So we need to remove the impact of E820_RESERVED_KERN on hibernation.

Actually we do not need to touch e820 map at all, and we can kill
E820_RESERVED_KERN safely because:

1.E820_RESERVED_KERN was once introduced to do early allocation for
setup_data when we were using original early_res with e820 map.
Now we are using memblock to do early resource reservation/allocation, and
setup_data is reserved in memblock early already.

2.For kexec path, kexec generates setup_data (now kexec-tool creates
SETUP_EFI and SETUP_E820_EXT), and passes pointer to second kernel,
and second kernel reserves setup_data by its own without using e820 map.

This makes the code simpler, and at same time will fix the bug in
hibernation we mentioned before: E820_RAM and E820_RESERVED_KERN
ranges are continuous and boundary is not page aligned, which can
not be handled by hibernation.

Link: https://bugzilla.opensuse.org/show_bug.cgi?id=913885
Link: https://bugzilla.kernel.org/show_bug.cgi?id=96111
Reported-by: "Lee, Chun-Yi" <jlee@suse.com>
Tested-by: "Lee, Chun-Yi" <jlee@suse.com>
Reported-by: "Tian, Ye" <yex.tian@intel.com>
Tested-by: "Tian, Ye" <yex.tian@intel.com>
Cc: "Lee, Chun-Yi" <jlee@suse.com>
Cc: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Richard L Maliszewski <richard.l.maliszewski@intel.com>
Cc: Gang Wei <gang.wei@intel.com>
Cc: Shane Wang <shane.wang@intel.com>
Cc: tboot-devel@lists.sourceforge.net
Cc: stable@vger.kernel.org
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/include/uapi/asm/e820.h |  8 --------
 arch/x86/kernel/e820.c           |  6 ++----
 arch/x86/kernel/setup.c          | 25 -------------------------
 arch/x86/kernel/tboot.c          |  3 +--
 arch/x86/mm/init_64.c            | 11 ++++-------
 5 files changed, 7 insertions(+), 46 deletions(-)

diff --git a/arch/x86/include/uapi/asm/e820.h b/arch/x86/include/uapi/asm/e820.h
index 0f457e6..a9216a1 100644
--- a/arch/x86/include/uapi/asm/e820.h
+++ b/arch/x86/include/uapi/asm/e820.h
@@ -45,14 +45,6 @@
  */
 #define E820_PRAM	12
 
-/*
- * reserved RAM used by kernel itself
- * if CONFIG_INTEL_TXT is enabled, memory of this type will be
- * included in the S3 integrity calculation and so should not include
- * any memory that BIOS might alter over the S3 transition
- */
-#define E820_RESERVED_KERN        128
-
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
 struct e820entry {
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index a102564..2770069 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -134,7 +134,6 @@ static void __init e820_print_type(u32 type)
 {
 	switch (type) {
 	case E820_RAM:
-	case E820_RESERVED_KERN:
 		printk(KERN_CONT "usable");
 		break;
 	case E820_RESERVED:
@@ -693,7 +692,7 @@ void __init e820_mark_nosave_regions(unsigned long limit_pfn)
 
 		pfn = PFN_DOWN(ei->addr + ei->size);
 
-		if (ei->type != E820_RAM && ei->type != E820_RESERVED_KERN)
+		if (ei->type != E820_RAM)
 			register_nosave_region(PFN_UP(ei->addr), pfn);
 
 		if (pfn >= limit_pfn)
@@ -914,7 +913,6 @@ void __init finish_e820_parsing(void)
 static inline const char *e820_type_to_string(int e820_type)
 {
 	switch (e820_type) {
-	case E820_RESERVED_KERN:
 	case E820_RAM:	return "System RAM";
 	case E820_ACPI:	return "ACPI Tables";
 	case E820_NVS:	return "ACPI Non-volatile Storage";
@@ -1111,7 +1109,7 @@ void __init memblock_x86_fill(void)
 		if (end != (resource_size_t)end)
 			continue;
 
-		if (ei->type != E820_RAM && ei->type != E820_RESERVED_KERN)
+		if (ei->type != E820_RAM)
 			continue;
 
 		memblock_add(ei->addr, ei->size);
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 80f874b..2ee40ef 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -457,29 +457,6 @@ static void __init parse_setup_data(void)
 	}
 }
 
-static void __init e820_reserve_setup_data(void)
-{
-	struct setup_data *data;
-	u64 pa_data;
-
-	pa_data = boot_params.hdr.setup_data;
-	if (!pa_data)
-		return;
-
-	while (pa_data) {
-		data = early_memremap(pa_data, sizeof(*data));
-		e820_update_range(pa_data, sizeof(*data)+data->len,
-			 E820_RAM, E820_RESERVED_KERN);
-		pa_data = data->next;
-		early_memunmap(data, sizeof(*data));
-	}
-
-	sanitize_e820_map(e820.map, ARRAY_SIZE(e820.map), &e820.nr_map);
-	memcpy(&e820_saved, &e820, sizeof(struct e820map));
-	printk(KERN_INFO "extended physical RAM map:\n");
-	e820_print_map("reserve setup_data");
-}
-
 static void __init memblock_x86_reserve_range_setup_data(void)
 {
 	struct setup_data *data;
@@ -1018,8 +995,6 @@ void __init setup_arch(char **cmdline_p)
 		early_dump_pci_devices();
 #endif
 
-	/* update the e820_saved too */
-	e820_reserve_setup_data();
 	finish_e820_parsing();
 
 	if (efi_enabled(EFI_BOOT))
diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 91a4496..3c2752a 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -195,8 +195,7 @@ static int tboot_setup_sleep(void)
 	tboot->num_mac_regions = 0;
 
 	for (i = 0; i < e820.nr_map; i++) {
-		if ((e820.map[i].type != E820_RAM)
-		 && (e820.map[i].type != E820_RESERVED_KERN))
+		if (e820.map[i].type != E820_RAM)
 			continue;
 
 		add_mac_region(e820.map[i].addr, e820.map[i].size);
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 3fba623..bd302a9 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -412,8 +412,7 @@ phys_pte_init(pte_t *pte_page, unsigned long addr, unsigned long end,
 		next = (addr & PAGE_MASK) + PAGE_SIZE;
 		if (addr >= end) {
 			if (!after_bootmem &&
-			    !e820_any_mapped(addr & PAGE_MASK, next, E820_RAM) &&
-			    !e820_any_mapped(addr & PAGE_MASK, next, E820_RESERVED_KERN))
+			    !e820_any_mapped(addr & PAGE_MASK, next, E820_RAM))
 				set_pte(pte, __pte(0));
 			continue;
 		}
@@ -459,9 +458,8 @@ phys_pmd_init(pmd_t *pmd_page, unsigned long address, unsigned long end,
 
 		next = (address & PMD_MASK) + PMD_SIZE;
 		if (address >= end) {
-			if (!after_bootmem &&
-			    !e820_any_mapped(address & PMD_MASK, next, E820_RAM) &&
-			    !e820_any_mapped(address & PMD_MASK, next, E820_RESERVED_KERN))
+			if (!after_bootmem && !e820_any_mapped(
+					address & PMD_MASK, next, E820_RAM))
 				set_pmd(pmd, __pmd(0));
 			continue;
 		}
@@ -534,8 +532,7 @@ phys_pud_init(pud_t *pud_page, unsigned long addr, unsigned long end,
 		next = (addr & PUD_MASK) + PUD_SIZE;
 		if (addr >= end) {
 			if (!after_bootmem &&
-			    !e820_any_mapped(addr & PUD_MASK, next, E820_RAM) &&
-			    !e820_any_mapped(addr & PUD_MASK, next, E820_RESERVED_KERN))
+			    !e820_any_mapped(addr & PUD_MASK, next, E820_RAM))
 				set_pud(pud, __pud(0));
 			continue;
 		}
-- 
1.8.4.2

