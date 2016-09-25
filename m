From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][v11] PM / hibernate: Verify the consistent of e820 memory map by md5 digest
Date: Sun, 25 Sep 2016 12:17:57 +0800
Message-ID: <1474777077-19535-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>
List-Id: linux-pm@vger.kernel.org

On some platforms, there is occasional panic triggered when trying to
resume from hibernation, a typical panic looks like:

"BUG: unable to handle kernel paging request at ffff880085894000
IP: [<ffffffff810c5dc2>] load_image_lzo+0x8c2/0xe70"

Investigation carried out by Lee Chun-Yi shows that this is because
e820 map has been changed by BIOS across hibernation, and one
of the page frames from suspend kernel is right located in restore
kernel's unmapped region, so panic comes out when accessing unmapped
kernel address.

In order to expose this issue earlier, the md5 hash of e820 map
is passed from suspend kernel to restore kernel, and the restore
kernel will terminate the resume process once it finds the md5
hash are not the same.

As the format of image header has been modified, the magic number
should also be adjusted as kernels with the same RESTORE_MAGIC have
to use the same header format and interpret all of the fields in
it in the same way.

If the suspend kernel is built without md5 support, and the restore
kernel has md5 support, then the latter will bypass the check process.
Vice versa the restore kernel will bypass the check if it does not
support md5 operation.

Note:
1. Without this patch applied, it is possible that BIOS has
   provided an inconsistent memory map, but the resume kernel is still
   able to restore the image anyway(e.g, E820_RAM region is the superset
   of the previous one), although the system might be unstable. So this
   patch tries to treat any inconsistent e820 as illegal.

2. Another case is, this patch replies on comparing the e820_saved, but
   currently the e820_save might not be strictly the same across
   hibernation, even if BIOS has provided consistent e820 map - In
   theory mptable might modify the BIOS-provided e820_saved dynamically
   in early_reserve_e820_mpc_new, which would allocate a buffer from
   E820_RAM, and marks it from E820_RAM to E820_RESERVED).
   This is a potential and rare case we need to deal with in OS in
   the future.

Suggested-by: Pavel Machek <pavel@ucw.cz>
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Lee Chun-Yi <jlee@suse.com>
Cc: Borislav Petkov <bp@alien8.de>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v11:
 - Remove the extra local variable e820_mismatch.
v10:
 - Remove the newly introduced Boolean flag and check
   the existence of md5 hash by comparing it with zero.
   If the suspend kernel is built without md5 support,
   and the restore kernel has md5 support, then the latter
   will bypass the check process. Vice versa the restore
   kernel will bypass the check if it does not support md5
   operation even if the suspend kernel has one.
v9:
 - Only do the md5 check when CONFIG_CRYPTO_MD5 is built in.
   Change the image head magic number.
   Remove CONFIG_HIBERNATION_CHECK_E820 and make the md5 check
   mandatory.
   Introduce e820_digest_available to indicate whether we should
   check the md5 hash.
   And some other modifications.
v8:
 - Panic the system once the e820 is found to be inconsistent
   during resume.
   Fix the md5 hash len from 128 bytes to 16 bytes.
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
 arch/x86/power/hibernate_64.c | 92 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 90 insertions(+), 2 deletions(-)

diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
index 9634557..d81b1af 100644
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
@@ -177,14 +181,88 @@ int pfn_is_nosave(unsigned long pfn)
 	return (pfn >= nosave_begin_pfn) && (pfn < nosave_end_pfn);
 }
 
+#define MD5_DIGEST_SIZE 16
+
 struct restore_data_record {
 	unsigned long jump_address;
 	unsigned long jump_address_phys;
 	unsigned long cr3;
 	unsigned long magic;
+	u8 e820_digest[MD5_DIGEST_SIZE];
 };
 
-#define RESTORE_MAGIC	0x123456789ABCDEF0UL
+#define RESTORE_MAGIC	0x23456789ABCDEF01UL
+
+#if IS_BUILTIN(CONFIG_CRYPTO_MD5)
+/**
+ * get_e820_md5 - calculate md5 according to given e820 map
+ *
+ * @map: the e820 map to be calculated
+ * @buf: the md5 result to be stored to
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
+	req = ahash_request_alloc(tfm, GFP_KERNEL);
+	if (!req) {
+		ret = -ENOMEM;
+		goto free_ahash;
+	}
+
+	sg_init_one(&sg, (u8 *)map, sizeof(struct e820map));
+	ahash_request_set_callback(req, 0, NULL, NULL);
+	ahash_request_set_crypt(req, &sg, buf, sizeof(struct e820map));
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
+static void hibernation_e820_save(void *buf)
+{
+	get_e820_md5(&e820_saved, buf);
+}
+
+static bool hibernation_e820_mismatch(void *buf)
+{
+	int ret;
+	u8 result[MD5_DIGEST_SIZE];
+
+	memset(result, 0, MD5_DIGEST_SIZE);
+	/* If there is no digest in suspend kernel, let it go. */
+	if (!memcmp(result, buf, MD5_DIGEST_SIZE))
+		return false;
+
+	ret = get_e820_md5(&e820_saved, result);
+	if (ret)
+		return true;
+
+	return memcmp(result, buf, MD5_DIGEST_SIZE) ? true : false;
+}
+#else
+static void hibernation_e820_save(void *buf)
+{
+}
+
+static bool hibernation_e820_mismatch(void *buf)
+{
+	/* If md5 is not builtin for restore kernel, let it go. */
+	return false;
+}
+#endif
 
 /**
  *	arch_hibernation_header_save - populate the architecture specific part
@@ -201,6 +279,9 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 	rdr->jump_address_phys = __pa_symbol(&restore_registers);
 	rdr->cr3 = restore_cr3;
 	rdr->magic = RESTORE_MAGIC;
+
+	hibernation_e820_save(rdr->e820_digest);
+
 	return 0;
 }
 
@@ -216,5 +297,12 @@ int arch_hibernation_header_restore(void *addr)
 	restore_jump_address = rdr->jump_address;
 	jump_address_phys = rdr->jump_address_phys;
 	restore_cr3 = rdr->cr3;
-	return (rdr->magic == RESTORE_MAGIC) ? 0 : -EINVAL;
+
+	if (rdr->magic != RESTORE_MAGIC)
+		return -EINVAL;
+
+	if (hibernation_e820_mismatch(rdr->e820_digest))
+		return -ENODEV;
+
+	return 0;
 }
-- 
2.7.4
