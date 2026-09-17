Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F473B1EC0;
	Thu, 17 Sep 2026 06:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789625251; cv=none; b=qMG/rgbCL/V0ahcNHamMdy19WtW7RtohSlVIjmAEtvRRA0J43/D76L+tCY8xgPVLv42J5LMnqjv0yJ74AkRJTLRLn49h9V5h62Jsbgt+wRTMyNiGzor/TJzJ4BFAHOLxf1BEJcUR4TsxV/xxrWAd5c1pIRfapHuazwi5+CMH5HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789625251; c=relaxed/simple;
	bh=P6PUFpEezTXQyaWBIEtDNvZZzaChNobcfZ+Ac9hEUvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cY2nQqxSa9DsBwcugKvAAoZLfPGL+DOYVlvTvO70q39qZ9PmWw2K04ANP0SiIztEGzEtw2vNO82ak+uSbGvuiFDrzX1qUJGon9Nw1cs19BBkESkTHsI9EblhIa4LGZAtHcP0L01JgwgX49hovAuwqcwar4m1G0NifzK7EhJ/A+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JyWS//Ir; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JyWS//Ir"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2571F000FF;
	Thu, 17 Sep 2026 06:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789625249;
	bh=gqaGXeiI19JmMrfZJKzFwEIp/5Qj6q2YW8WHfV2wLwo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JyWS//IrL4Aw7bFXomKjFolUgbIPHsZouDWnic5S+aTpPokzfuKgOWPTKof8kMzf4
	 ORUeYQ7na9GxLBhUgaS+QgFavTWYFpX9op1wkO371fVcu4TQB37YANueMbWoCS3a6P
	 4GaCJnXwuJRDcjIGL1Vgu+a09rYWHkz9cEJeKR8+50Jzg5GrQ848QBQVWuHm5hZT7F
	 ErKPWyG7fMgo5Kj/NLgWhk9CRjoNVnq/glGzRCwnl+Wmj//5qEETRXIw2qdXzFNwkc
	 JS3S0SAQC2GrQwKYZfkxkXqgQQolwcnUoslsEEN60If1un8fD41lNUq+qgIiSZzihh
	 nUSPmRA2Mb7Ag==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 17 Sep 2026 09:07:06 +0300
Subject: [PATCH 4/5] hibernation, KFENCE: explicitly map/unmap KFENCE pages
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-hibernation-v1-4-7f7dfae3dbe0@kernel.org>
References: <20260917-hibernation-v1-0-7f7dfae3dbe0@kernel.org>
In-Reply-To: <20260917-hibernation-v1-0-7f7dfae3dbe0@kernel.org>
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
provide kfence_force_mapping() and kfence_restore_mapping() APIs that allow
forced mapping and unmapping of KFENCE pages.

Use these APIs in hibernate_{map,unmap}_pages() for KFENCE pages.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/kfence.h  | 29 +++++++++++++++++++++++++++
 kernel/power/snapshot.c |  7 +++++++
 mm/kfence/core.c        | 52 +++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/include/linux/kfence.h b/include/linux/kfence.h
index e5822f6e7f279..33a126cb6d1b7 100644
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
+ * kfence_restore_mapping() - restore mapping of a KFENCE page
+ * @page: page to restore mapping
+ *
+ * Requires: is_kfence_address(page_address(page))
+ *
+ * Return:
+ * * false - failed to restore mapping of the @page
+ * * true - succeeded to restore mapping of the @page
+ */
+bool kfence_restore_mapping(struct page *page);
+
 #else /* CONFIG_KFENCE */
 
 #define kfence_sample_interval	(0)
@@ -241,6 +267,9 @@ static inline bool __must_check kfence_handle_page_fault(unsigned long addr, boo
 	return false;
 }
 
+static inline bool kfence_force_mapping(struct page *page) { return true; }
+static inline bool kfence_restore_mapping(struct page *page) { return true; }
+
 #ifdef CONFIG_PRINTK
 struct kmem_obj_info;
 static inline bool __kfence_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 52ef0599c2076..6583b57722e25 100644
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
+		return kfence_restore_mapping(page) ? 0 : -EFAULT;
+
 	if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
 		unsigned long addr = (unsigned long)page_address(page);
 		int ret  = set_direct_map_invalid_noflush(page, 1);
diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 90925c646c4c2..666e8991d1fed 100644
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
+bool kfence_restore_mapping(struct page *page)
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

