From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH][v6] PM / hibernate: Print the possible panic reason when
 resuming with inconsistent e820 map
Date: Thu, 25 Aug 2016 19:07:48 +0800
Message-ID: <20160825110748.GA22104@sharon>
References: <1445404900-29702-1-git-send-email-yu.c.chen@intel.com>
 <20160823094527.GG7276@linux-rxt1.site>
 <20160823100155.GA12738@sharon>
 <20160824013610.GA26119@linux-rxt1.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:39689 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757802AbcHYK7p (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Aug 2016 06:59:45 -0400
Content-Disposition: inline
In-Reply-To: <20160824013610.GA26119@linux-rxt1.site>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Aug 24, 2016 at 09:36:10AM +0800, joeyli wrote:
> > > What's the progress of this patch? Looks already have experts review it.
> > > Why this patch didn't accept?
> > This patch is a little overkilled, and I have saved another simpler
> > version to only check the md5 hash (as people suggested) for it. I can post it later.
> > 
> 
> I am happy to test and review it.
>
Here it is. As Rafael is on travel, it would be grateful
if you can give some advance on this, thanks!


On some platforms, there is occasional panic triggered when trying to
resume from hibernation, a typical panic looks like:

"BUG: unable to handle kernel paging request at ffff880085894000
IP: [<ffffffff810c5dc2>] load_image_lzo+0x8c2/0xe70"

This is because e820 map has been changed by BIOS across
hibernation, and one of the page frames from first kernel
is right located in second kernel's unmapped region, so panic
comes out when accessing unmapped kernel address.

In order to tell the user why this happened, we compare the two
e820 maps according to their md5 value. If these two e820 maps
are not the same, we will warn users of the possible e820 conflict
once the system goes into panic, for example:

BUG: unable to handle kernel paging request at ffff8800a9688000
IP: [<ffffffff810c5dc2>] load_image_lzo+0x8c2/0xe70
PM: Hibernation Caution! Panic might be caused by inconsistent e820 table.
PM: Please update your BIOS, or do not use hibernation on this machine.

Note: It is possible although BIOS has provided a consistent memory map,
but the e820_saved is not strictly the same across hibernation.
This is because in theory mptable might modify the e820_saved dynamically
during early stage, but that situation is quite rare and we don't
deal with that for now.

Suggested-by: Pavel Machek <pavel@ucw.cz>
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Lee, Chun-Yi <jlee@suse.com>
Cc: Borislav Petkov <bp@alien8.de>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v7:
 - Use md5 hash to compare the e820 map.
v6:
 - Fix some compiling errors reported by 0day/LKP, adjust
   Kconfig/variable namings.
v5:
 - Rewrite this patch to just warn user of the broken BIOS
   when panic.
v4:
 - Add __attribute__ ((unused)) for swsusp_page_is_valid,
   to eliminate the warnning of:
   'swsusp_page_is_valid' defined but not used
   on non-x86 platforms.

v3:
 - Adjust the logic to exclude the end_pfn boundary in pfn_mapped
   when invoking mark_valid_pages, because the end_pfn is not
   a mapped page frame, we should not regard it as a valid page.

   Move the sanity check of valid pages to a early stage in resuming
   process(moved to mark_unsafe_pages), in this way, we can avoid
   unnecessarily accessing these invalid pages in later stage(yes,
   move to the original position Joey once introduced in:
   Commit 84c91b7ae07c ("PM / hibernate: avoid unsafe pages in e820
   reserved regions")

   With v3 patch applied, I did 30 cycles on my problematic platform,
   no panic triggered anymore(50% reproducible before patched, by
   plugging/unplugging memory peripheral during hibernation), and it
   just warns of invalid pages.
   
v2:
 - According to Ingo's suggestion, rewrite this patch.

   New version just checks each page frame according to pfn_mapped array.
   So that we do not need to touch existing code related to
   E820_RESERVED_KERN. And this method can naturely guarantee
   that the system before/after hibernation do not need to be of
   the same memory size on x86_64.
---
 arch/x86/power/hibernate_64.c | 131 ++++++++++++++++++++++++++++++++++++++++++
 kernel/power/Kconfig          |   9 +++
 2 files changed, 140 insertions(+)

diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
index 9634557..56ab7f4 100644
--- a/arch/x86/power/hibernate_64.c
+++ b/arch/x86/power/hibernate_64.c
@@ -11,6 +11,10 @@
 #include <linux/gfp.h>
 #include <linux/smp.h>
 #include <linux/suspend.h>
+#include <linux/scatterlist.h>
+#include <linux/kdebug.h>
+
+#include <crypto/hash.h>
 
 #include <asm/init.h>
 #include <asm/proto.h>
@@ -186,6 +190,119 @@ struct restore_data_record {
 
 #define RESTORE_MAGIC	0x123456789ABCDEF0UL
 
+/* The resume kernel's e820 is conflict with the one in suspend kernel */
+static bool e820_conflict;
+
+#ifdef CONFIG_HIBERNATION_CHECK_E820
+#define MD5_HASH_SIZE 128
+
+/**
+ *	get_e820_md5 - calculate md5 according to struct e820map
+ *
+ *	@map: the e820 map to be calculated
+ *	@buf: the md5 result to be stored to
+ */
+static int get_e820_md5(struct e820map *map, void *buf)
+{
+	struct scatterlist sg;
+	struct crypto_ahash *tfm;
+	struct ahash_request *req;
+	int ret = 0;
+
+	tfm = crypto_alloc_ahash("md5", 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(tfm))
+		return -ENOMEM;
+
+	req = ahash_request_alloc(tfm, GFP_ATOMIC);
+	if (!req) {
+		ret = -ENOMEM;
+		goto free_ahash;
+	}
+
+	sg_init_one(&sg, (char *)map, sizeof(struct e820map));
+	ahash_request_set_callback(req, 0, NULL, NULL);
+	ahash_request_set_crypt(req, &sg, (char *)buf, sizeof(struct e820map));
+
+	if (crypto_ahash_digest(req))
+		ret = -EINVAL;
+
+	ahash_request_free(req);
+ free_ahash:
+	crypto_free_ahash(tfm);
+
+	return ret;
+}
+
+static int hibernation_e820_save(void *buf)
+{
+	int ret;
+	char result[MD5_HASH_SIZE] = {0};
+
+	ret = get_e820_md5(&e820_saved, result);
+	if (ret)
+		return ret;
+
+	memcpy((char *)buf, result, MD5_HASH_SIZE);
+
+	return 0;
+}
+
+static int hibernation_e820_check(void *buf)
+{
+	int ret;
+	char result[MD5_HASH_SIZE] = {0};
+
+	ret = get_e820_md5(&e820_saved, result);
+	if (ret)
+		return ret;
+
+	if (memcmp(result, buf, MD5_HASH_SIZE))
+		e820_conflict = true;
+
+	return 0;
+}
+
+#else
+static int hibernation_e820_save(void *buf)
+{
+	return 0;
+}
+
+static int hibernation_e820_check(void *buf)
+{
+	return 0;
+}
+#endif
+
+static int arch_hibernation_die_check(struct notifier_block *nb,
+				      unsigned long action,
+				      void *data)
+{
+	if (e820_conflict) {
+		pr_err("PM: Hibernation Caution! Panic might be caused by inconsistent e820 table.\n");
+		pr_err("PM: Please update your BIOS, or do not use hibernation on this machine.\n");
+	}
+
+	return 0;
+}
+
+static struct notifier_block hibernation_notifier = {
+	.notifier_call = arch_hibernation_die_check,
+};
+
+static int __init arch_init_hibernation(void)
+{
+	int retval;
+
+	retval = register_die_notifier(&hibernation_notifier);
+	if (retval)
+		return retval;
+
+	return 0;
+}
+
+late_initcall(arch_init_hibernation);
+
 /**
  *	arch_hibernation_header_save - populate the architecture specific part
  *		of a hibernation image header
@@ -201,6 +318,14 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 	rdr->jump_address_phys = __pa_symbol(&restore_registers);
 	rdr->cr3 = restore_cr3;
 	rdr->magic = RESTORE_MAGIC;
+
+	/*
+	 * A page has been allocated previously to store the hibernation
+	 * image header, so we can safely store the md5 result behind
+	 * struct restore_data_record, with size of 128 bytes.
+	 */
+	hibernation_e820_save(addr + sizeof(struct restore_data_record));
+
 	return 0;
 }
 
@@ -216,5 +341,11 @@ int arch_hibernation_header_restore(void *addr)
 	restore_jump_address = rdr->jump_address;
 	jump_address_phys = rdr->jump_address_phys;
 	restore_cr3 = rdr->cr3;
+
+	/*
+	 * Check if suspend e820 map is the same with the resume e820 map.
+	 */
+	hibernation_e820_check(addr + sizeof(struct restore_data_record));
+
 	return (rdr->magic == RESTORE_MAGIC) ? 0 : -EINVAL;
 }
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 68d3ebc..f0ba5e7 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -76,6 +76,15 @@ config HIBERNATION
 
 	  For more information take a look at <file:Documentation/power/swsusp.txt>.
 
+config HIBERNATION_CHECK_E820
+	bool "Check the consistence of e820 map across hibernation"
+	depends on ARCH_HIBERNATION_HEADER
+	---help---
+	  Check if the resume kernel has the same BIOS-provided
+	  e820 memory map as the one in suspend kernel(requested
+	  by ACPI spec), by comparing the md5 digest of the two e820
+	  regions.
+
 config ARCH_SAVE_PAGE_KEYS
 	bool
 
-- 
2.7.4

