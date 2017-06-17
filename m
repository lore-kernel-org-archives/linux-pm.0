From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 2/2][RFC] PM / hibernate: Utilize the original e820 map for consistent check
Date: Sat, 17 Jun 2017 13:23:19 +0800
Message-ID: <59907321c46464ad07c98099aa8179c8bb246c81.1497675876.git.yu.c.chen@intel.com>
References: <cover.1497675876.git.yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:2737 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750815AbdFQFXN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 17 Jun 2017 01:23:13 -0400
In-Reply-To: <cover.1497675876.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Yu Chen <yu.c.chen@intel.com>, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Matt Fleming <matt@codeblueprint.co.uk>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>

Use the e820_table_ori instead of e820_table_firmware to check
the consistence of memory layout provided by BIOS, because the
e820_table_firmware might be modified by the kernel such as efi
boot stub. To be more specific, during bootup, the efi boot stub
might allocate memory via efi service for the PCI device
information structure, then e820_reserve_setup_data() reserved
these dynamically allocated structures(AKA, setup_data) in
e820_table_firmware accordingly, changing their attribute from
E820_TYPE_RAM to E820_TYPE_RESERVED_KERN. So e820_table_firmware
is not the original BIOS-provided memory layout anymore.

As a result, we might get false-positive report that the memory layout
is inconsistent across hibernation:

The suspend kernel:
[    0.000000] e820: update [mem 0x76671018-0x76679457] usable ==> usable

The resume kernel:
[    0.000000] e820: update [mem 0x7666f018-0x76677457] usable ==> usable
...
[   15.752088] PM: Using 3 thread(s) for decompression.
[   15.752088] PM: Loading and decompressing image data (471870 pages)...
[   15.764971] Hibernate inconsistent memory map detected!
[   15.770833] PM: Image mismatch: architecture specific data

Actually it is safe to restore these pages because E820_TYPE_RAM and
E820_TYPE_RESERVED_KERN are treated the same during hibernation.

Reported-by: James Ren <james.ren@intel.com>
Reported-by: "Mejia, Leonidas A" <leonidas.a.mejia@intel.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/power/hibernate_64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
index a6e21fe..4bf087d 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -250,7 +250,7 @@ static int get_e820_md5(struct e820_table *table, void *buf)
 
 static void hibernation_e820_save(void *buf)
 {
-	get_e820_md5(e820_table_firmware, buf);
+	get_e820_md5(e820_table_ori, buf);
 }
 
 static bool hibernation_e820_mismatch(void *buf)
@@ -263,7 +263,7 @@ static bool hibernation_e820_mismatch(void *buf)
 	if (!memcmp(result, buf, MD5_DIGEST_SIZE))
 		return false;
 
-	ret = get_e820_md5(e820_table_firmware, result);
+	ret = get_e820_md5(e820_table_ori, result);
 	if (ret)
 		return true;
 
-- 
2.7.4
