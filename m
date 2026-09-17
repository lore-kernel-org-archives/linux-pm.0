Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C34041D231;
	Thu, 17 Sep 2026 06:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789625255; cv=none; b=rqnGp2wobJT0Gthn0mogPbaI5j4r3vBQvflchXcrF2xVZxqEcQRhnFvgsxiuowg7fbkc7vrbbqiUz0wlVNSNMVyt9KvHOcNbU23CiUtNdi21q99ust3RLCASDZRj+WnNB8ygwhDnS2TuCd8kcfP396cLFLI2L5Y+FR98Q5tJAc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789625255; c=relaxed/simple;
	bh=QLjGg+Y3EUUlc61LuhHlZIpRrgiIRE3wUMIZhtLri2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GzglOJ0KG6f50VJexYacb+p1MPgu57krKvHGdE8/rXp0MnTXa9SPpeVZfVt2MWWI9PSpuKcUlGQ/euzqqHEQ/q9UzmkHOqMZJtRJz3bWdOwfidkboAIQgw0ucv9wNCxzl9EVhasWSvc9ddz9qV5XEL6AdG1w0xSvmRZtqTQHniU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tgvb/ymQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tgvb/ymQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256E41F00893;
	Thu, 17 Sep 2026 06:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789625253;
	bh=hTDScTOE8TQ4i6dhThN64lodtCizNRIyLxOaq3CiOvA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Tgvb/ymQ4uZxzlwsrt4zt6ZJ0/fykLPinMpgDdvhvxceX9F52Rf/TeKwk7n9hkJ/m
	 6Mze0ESvg53N9bgJSEK76Wx62sxfQ1xfakOmoxdjDO+9uvlkIHio3snOeGlbHNI4R+
	 JsXpzZPlutDvCjdeEzxV5pXh/zJSRw7Wooh7Ra8I+4jPEwfIjtFOG83VdYAac2uEhZ
	 JHIxzHVHt0zPi+6n4HdHpxa5ZpH6L+g5PsrlIVexBz8RFcGhePZEbc5aP0igBBieBs
	 O/LviJWcKFqQsBVjKPMc1i9C4vwLH/OgpIvoFynQl+MRJ+ljIBsmI2mfNUiwX2X1FO
	 k098b3Ccnej6Q==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Thu, 17 Sep 2026 09:07:07 +0300
Subject: [PATCH 5/5] hibernation: make hibernation unavailable when
 debug_pagealloc is on
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-hibernation-v1-5-7f7dfae3dbe0@kernel.org>
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

Back in 2008 when commit 8a235efad548a ("Hibernation: Handle
DEBUG_PAGEALLOC on x86") enabled coexistence of hibernation and
DEBUG_PAGEALLOC, the world was simpler, the combination was only supported
on x86 and a non-present page in the direct map meant that the page was
free and debug_pagealloc removed its mapping.

Nowadays there are more architectures with inconsistent views of how the
direct map should be managed, there are more debug mechanisms in MM that
can either drop a page from the direct map (e.g. KFENCE) or require that a
page must be mapped immediately after resume (e.g. init_on_free).

The latter constraint is particularly nasty, because enabling
debug_pagealloc and PAGE_POISON at the same time simply breaks resume:

  BUG: unable to handle page fault for address: ffff888000100000
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  PGD 4f0c067 P4D 4f0c067 PUD 4f0d067 PMD 4f0e067 PTE 800fffffffeff020
  Oops: Oops: 0002 [#1] SMP DEBUG_PAGEALLOC NOPTI
  CPU: 0 UID: 0 PID: 477 Comm: bash Not tainted 7.3.0-rc3-00090-g4a613f1d9124 #1 PREEMPT(full)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
  RIP: 0010:__kernel_poison_pages+0x45/0x70
  Code: 89 fa 48 c1 e6 06 48 01 fe 48 89 d1 48 2b 0d 9a ed 87 01 48 83 c2 40 48 c1 f9 06 48 c1 e1 0c 48 03 0d 97 ed 87 01 48 8d 79 08 <48> 89 01 48 83 e7 f8 48 89 81 f8 0f 00 00 48 29 f9 81 c1 00 10 00
  RSP: 0018:ffffc900017dfd78 EFLAGS: 00010086
  RAX: aaaaaaaaaaaaaaaa RBX: 0000000000000000 RCX: ffff888000100000
  RDX: ffffea0000004040 RSI: ffffea0000004040 RDI: ffff888000100008
  RBP: 0000000000000000 R08: ffff888130fcada0 R09: 00000000723e0de4
  R10: 0000000096ad9215 R11: 00000000db907bcf R12: 0000000000000005
  R13: 0000000000000005 R14: 0000000000000000 R15: 0000000000000000
  FS:  00007f8f2243e780(0000) GS:ffff8882e8e13000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffff888000100000 CR3: 0000000140679000 CR4: 0000000000750ef0
  PKRU: 55555554
  Call Trace:
   <TASK>
   clear_or_poison_free_pages+0xd1/0xe0
   hibernation_snapshot+0x548/0x5a0
   hibernate.cold+0xcb/0x321
   state_store+0xc3/0xd0
   kernfs_fop_write_iter+0x163/0x240
   vfs_write+0x21f/0x550
   ksys_write+0x70/0xf0
   do_syscall_64+0xb1/0x590
   ? __irq_exit_rcu+0x40/0x110
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  RIP: 0033:0x7f8f224d0687
  Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
  RSP: 002b:00007ffe7bbe0910 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
  RAX: ffffffffffffffda RBX: 00007f8f2243e780 RCX: 00007f8f224d0687
  RDX: 0000000000000005 RSI: 000055e3e53135d0 RDI: 0000000000000001
  RBP: 000055e3e53135d0 R08: 0000000000000000 R09: 0000000000000000
  R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000005
  R13: 00007f8f226295c0 R14: 00007f8f22626e80 R15: 0000000000000000
   </TASK>
  Modules linked in:
  CR2: ffff888000100000

It's possible to build a complex infrastructure involving a new page flag
and/or page_type to allow robust hibernation and restore with
debug_pagealloc enabled.

This infrastructure requires a proper detection whether it is safe to
temporarily remap a page to include it in the hibernation snapshot because
relying on kernel_page_present() is too permissive and may include pages
that were deliberately removed from the direct map for security reasons.

This complexity does not seem justified to deal with an esoteric use case
of hibernating a system that runs with debug_pagealloc enabled.

Make hibernation unavailable when debug_pagealloc is enabled and simplify
hibernate_{map,unmap}_page() that don't need to deal with debug_pagealloc
anymore.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 kernel/power/hibernate.c |  1 +
 kernel/power/snapshot.c  | 31 +++++--------------------------
 2 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 281ad49411481..37e41c08f4f36 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -110,6 +110,7 @@ bool hibernation_available(void)
 {
 	return nohibernate == 0 &&
 		!security_locked_down(LOCKDOWN_HIBERNATION) &&
+		!debug_pagealloc_enabled() &&
 		!secretmem_active() && !cxl_mem_active();
 }
 
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 6583b57722e25..baa4fc9e5ad6f 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -85,12 +85,7 @@ static inline int hibernate_map_page(struct page *page)
 	if (is_kfence_address(page_address(page)))
 		return kfence_force_mapping(page) ? 0 : -EFAULT;
 
-	if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
-		return set_direct_map_default_noflush(page, 1);
-	} else {
-		debug_pagealloc_map_pages(page, 1);
-		return 0;
-	}
+	return 0;
 }
 
 static inline int hibernate_unmap_page(struct page *page)
@@ -98,17 +93,6 @@ static inline int hibernate_unmap_page(struct page *page)
 	if (is_kfence_address(page_address(page)))
 		return kfence_restore_mapping(page) ? 0 : -EFAULT;
 
-	if (IS_ENABLED(CONFIG_ARCH_HAS_SET_DIRECT_MAP)) {
-		unsigned long addr = (unsigned long)page_address(page);
-		int ret  = set_direct_map_invalid_noflush(page, 1);
-
-		if (ret)
-			return ret;
-
-		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
-	} else {
-		debug_pagealloc_unmap_pages(page, 1);
-	}
 	return 0;
 }
 
@@ -1446,10 +1430,10 @@ static inline bool do_copy_page(long *dst, long *src)
 /*
  * safe_copy_page - Copy a page in a safe way.
  *
- * Check if the page we are going to copy is marked as present in the kernel
- * page tables. This always is the case if CONFIG_DEBUG_PAGEALLOC or
- * CONFIG_ARCH_HAS_SET_DIRECT_MAP is not set. In that case kernel_page_present()
- * always returns 'true'.
+ * Page could be not present in the kernel page tables. Try to map it before
+ * copiyng and unmap back as needed.
+ * If the kernel page table update fails, bail out with an error.
+ *
  * Sets @zeros_only to true if the page was entirely composed of zeros.
  *
  * Returns 0 on success, a negative error code on failure.
@@ -1458,11 +1442,6 @@ static int safe_copy_page(void *dst, struct page *s_page, bool *zeros_only)
 {
 	int err;
 
-	if (kernel_page_present(s_page)) {
-		*zeros_only = do_copy_page(dst, page_address(s_page));
-		return 0;
-	}
-
 	err = hibernate_map_page(s_page);
 	if (err)
 		return err;

-- 
2.53.0

