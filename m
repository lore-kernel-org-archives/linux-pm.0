Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1759F3A5E7D;
	Sat, 26 Sep 2026 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790414828; cv=none; b=LTBH3FRKLzFoTmbcoo8G+cbTOykQXWyCThZsHZeuGhGZP92U55uw/+DjCTdiB+ekXprtwjqdzbZAnAE9iHv/nM6DrMQa0HlXzt6Ceix98Ak8rH5SF+oA1+q/WfUm3X2ZTymd7MVMuaVXesJTCX7vTrr4ny9gmHcORvQvBW/BX8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790414828; c=relaxed/simple;
	bh=eDJ2xGLseICB2OIMZg6BDbWz4o/OfjKLRcurj6/sh44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fpU1+pw4qcpwD1lqEe7me+zG7IXGBaaUlx86/nR0QPBYjStXETahwjP5WAtqyOWpUqyQWdb2JwYvOKQLtvgSUqa4CUCtH10z+t8/KXmn/koQkoW7fzyyArjJO879YFedtj5sKZFutemVFix64aXBmXsfoVaAGOUDfchtZNcQFiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQVpbDss; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQVpbDss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D2E1F000FF;
	Sat, 26 Sep 2026 09:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790414825;
	bh=YEJQRz+PZpjd7EEfpHkXpr1TFlTMOaEy6JT/LYG7xqI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TQVpbDss65o82QZ9gLihyPBneYMPLl2K9tc1FYEgXspiCXpLqrNmIIzldj+fz1/J4
	 p/C5/geP3hI3O/1zEUO7MAPTBHUmmERLFK6xFKrUdZF4ik5v1esI2dbX3xSAn1FXfG
	 aSnVbqa+cB2KL9hitVXW7Kyd2Lv43XpwfRF+EYbkcXrTpwBgoTbaX2N2oIDJYiagWV
	 Fys+0WkZtf9Gw8/nR/wVJDGEQCCDK4l2CzqaLdY5HHAVavSuoXUz6yNZvtMDOwz/yB
	 p1mFX1J3FUOZBS2csu3IHAkAy4kgpxHkIE03Cj9F49hJrFafe4RcEbFUxIGLaDL32E
	 mN48EaHSDOSkw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sat, 26 Sep 2026 12:26:33 +0300
Subject: [PATCH v2 4/5] hibernation, KFENCE: explicitly map/unmap KFENCE
 pages
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-hibernation-v2-4-235f69f3ab2a@kernel.org>
References: <20260926-hibernation-v2-0-235f69f3ab2a@kernel.org>
In-Reply-To: <20260926-hibernation-v2-0-235f69f3ab2a@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Alexander Potapenko <glider@google.com>, 
 David Hildenbrand <david@kernel.org>, Marco Elver <elver@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dmitry Vyukov <dvyukov@google.com>, Len Brown <lenb@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.16.1-dev

The pages protected by KFENCE are removed from the direct map.

safe_copy_page() temporarily maps and unmaps them using set_direct_map
APIs, or, when the stars align, even using debug_pagealloc_map_pages().

Neither of these APIs cares whether it is a KFENCE page and both blindly
perform the update of the kernel page table for any non-present page.

Ability to use debug_pagealloc_map_pages() to remap KFENCE pages when both
KFENCE and debug_pagealloc are enabled is an amusing coincidence.

But with increasing appetite for using set_direct_map for hardening
purposes, it becomes too big of a hammer to enable saving any non-present
page in the hibernation image.

Another gotcha is that loongarch that does not have a direct map at all
advertises ARCH_HAS_SET_DIRECT_MAP to allow coexistence of KFENCE and
hibernation.

Extend KFENCE with a bitmap that tracks which pages are protected and
provide kfence_force_mapping() and kfence_reset_mapping() APIs that allow
forced mapping and unmapping of KFENCE pages.

Use these APIs in hibernate_{map,unmap}_pages() for KFENCE pages.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/kfence.h  | 29 +++++++++++++++++++++++++++
 kernel/power/snapshot.c |  7 +++++++
 mm/kfence/core.c        | 52 +++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/include/linux/kfence.h b/include/linux/kfence.h
index e5822f6e7f27..7531bd000e3c 100644
--- a/include/linux/kfence.h
+++ b/include/linux/kfence.h
@@ -222,6 +222,32 @@ struct kmem_obj_info;
 bool __kfence_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab);
 #endif
 
+/**
+ * kfence_force_mapping() - make sure a KFENCE page is mapped
+ * @page: page to map
+ *
+ * Check whether @page is protected and map it if needed.
+ *
+ * Requires: is_kfence_address(page_address(page))
+ *
+ * Return:
+ * * false - failed to map @page
+ * * true - @page is mapped
+ */
+bool kfence_force_mapping(struct page *page);
+
+/**
+ * kfence_reset_mapping() - reset a forced mapping of a KFENCE page
+ * @page: page to restore mapping
+ *
+ * Requires: is_kfence_address(page_address(page))
+ *
+ * Return:
+ * * false - failed to reset mapping of the @page
+ * * true - succeeded to reset mapping of the @page
+ */
+bool kfence_reset_mapping(struct page *page);
+
 #else /* CONFIG_KFENCE */
 
 #define kfence_sample_interval	(0)
@@ -241,6 +267,9 @@ static inline bool __must_check kfence_handle_page_fault(unsigned long addr, boo
 	return false;
 }
 
+static inline bool kfence_force_mapping(struct page *page) { return true; }
+static inline bool kfence_reset_mapping(struct page *page) { return true; }
+
 #ifdef CONFIG_PRINTK
 struct kmem_obj_info;
 static inline bool __kfence_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 52ef0599c207..6868d6155daa 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -31,6 +31,7 @@
 #include <linux/compiler.h>
 #include <linux/ktime.h>
 #include <linux/set_memory.h>
+#include <linux/kfence.h>
 
 #include <linux/uaccess.h>
 #include <asm/mmu_context.h>
@@ -81,6 +82,9 @@ static inline int hibernate_restore_unprotect_page(void *page_address) {return 0
 
 static inline int hibernate_map_page(struct page *page)
 {
+	if (is_kfence_address(page_address(page)))
+		return kfence_force_mapping(page) ? 0 : -EFAULT;
+
 	if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
 		return set_direct_map_default_noflush(page, 1);
 	} else {
@@ -91,6 +95,9 @@ static inline int hibernate_map_page(struct page *page)
 
 static inline int hibernate_unmap_page(struct page *page)
 {
+	if (is_kfence_address(page_address(page)))
+		return kfence_reset_mapping(page) ? 0 : -EFAULT;
+
 	if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
 		unsigned long addr = (unsigned long)page_address(page);
 		int ret  = set_direct_map_invalid_noflush(page, 1);
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 90925c646c4c..cc79f8cdb206 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) "kfence: " fmt
 
 #include <linux/atomic.h>
+#include <linux/bitmap.h>
 #include <linux/bug.h>
 #include <linux/debugfs.h>
 #include <linux/hash.h>
@@ -123,6 +124,9 @@ module_param_named(check_on_panic, kfence_check_on_panic, bool, 0444);
 char *__kfence_pool __read_mostly;
 EXPORT_SYMBOL(__kfence_pool); /* Export for test modules. */
 
+/* keep track of protected pages */
+static DECLARE_BITMAP(kfence_protected_pages, KFENCE_POOL_SIZE / PAGE_SIZE);
+
 /*
  * Per-object metadata, with one-to-one mapping of object metadata to
  * backing pages (in __kfence_pool).
@@ -249,14 +253,36 @@ static bool alloc_covered_contains(u32 alloc_stack_hash)
 	return true;
 }
 
+static bool __kfence_protect(unsigned long addr, bool protect)
+{
+	unsigned long page_addr = ALIGN_DOWN(addr, PAGE_SIZE);
+	unsigned long pool_addr = (unsigned long)__kfence_pool;
+	unsigned long index = (page_addr - pool_addr) >> PAGE_SHIFT;
+	bool state;
+
+	assign_bit(index, kfence_protected_pages, protect);
+
+	/*
+	 * Reapply protection if the desired state changed while updating
+	 * the page table.
+	 */
+	do {
+		state = test_bit(index, kfence_protected_pages);
+		if (!kfence_protect_page(page_addr, state))
+			return false;
+	} while (state != test_bit(index, kfence_protected_pages));
+
+	return true;
+}
+
 static bool kfence_protect(unsigned long addr)
 {
-	return !KFENCE_WARN_ON(!kfence_protect_page(ALIGN_DOWN(addr, PAGE_SIZE), true));
+	return !KFENCE_WARN_ON(!__kfence_protect(addr, true));
 }
 
 static bool kfence_unprotect(unsigned long addr)
 {
-	return !KFENCE_WARN_ON(!kfence_protect_page(ALIGN_DOWN(addr, PAGE_SIZE), false));
+	return !KFENCE_WARN_ON(!__kfence_protect(addr, false));
 }
 
 static inline unsigned long metadata_to_pageaddr(const struct kfence_metadata *meta)
@@ -1335,3 +1361,25 @@ bool kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs
 
 	return kfence_unprotect(addr); /* Unprotect and let access proceed. */
 }
+
+bool kfence_force_mapping(struct page *page)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+	unsigned long index = (addr - (unsigned long)__kfence_pool) >> PAGE_SHIFT;
+
+	if (!test_bit(index, kfence_protected_pages))
+		return true;
+
+	return kfence_protect_page(addr, false);
+}
+
+bool kfence_reset_mapping(struct page *page)
+{
+	unsigned long addr = (unsigned long)page_address(page);
+	unsigned long index = (addr - (unsigned long)__kfence_pool) >> PAGE_SHIFT;
+
+	if (!test_bit(index, kfence_protected_pages))
+		return true;
+
+	return kfence_protect_page(addr, true);
+}

-- 
2.53.0

