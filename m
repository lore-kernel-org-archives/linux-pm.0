Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC5739060C;
	Sat, 26 Sep 2026 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790414816; cv=none; b=COp+vivap65XvZo/KVfeIj1WDVXYpJbnMn5VRiXdL1YLnrmItbFPh60rN2WpQ0WKlPksBGoAEh6U0I+GCsq13SNcrpBBMr7ICIuMVUF0AIM7nyLEqOkbjYzPBHC7Ng7kuEbFR3dXoekOu8A32G/C/zRLEBAGOiKWSY2hcI+hUlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790414816; c=relaxed/simple;
	bh=VFH9Xfb7nRASCoAcg748W8suCX76wLeHhKKb1IYUWqM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FSM7/w13sMIh3qrfVsuS2oizCWWYp1MD1Bas3lmHG25djy75Et6ip9R20EGiHA7r8teyOyejbcrYN3D/8BewhaNx8YDp4bBIQep129f/PVMD+eouyv2wfZGGWmB08rufECVxlp9f4S8hwsasciYjmDXACVmqbg5/Jlkik83RNU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ot1JG7uA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ot1JG7uA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CA21F00893;
	Sat, 26 Sep 2026 09:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790414815;
	bh=eV84FIWl/nzRxlwPhoVqnWJO2Z3uN9aWosu8vZ1OKII=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ot1JG7uAEJRhW6v2Qwk04AMXnxVxrYCaSmAMfXnv2bKPpKm8Ip2GpOBFlvKsGloxO
	 ND1XdE8rL2JgosT/JamxHnT+bk/YGYjMaW9BnwhqPMinJ0D5hyMjLB3HYjgoTezdd4
	 6DlKAcy16ogcTPjAYFxIJXE3vC4ar5EprlmAqQn2i286DzXlgCIQ+b7wdPcHqZZA3m
	 3BwgD0FdiJLSJzMIHWuRpNyC/hkoFDqMens1SU2HJo+wQ0o0EYnxCbhH+Ci4M9IdUJ
	 m3LWSxCck6QkYxxTVuE6mB3tqB4LX+cFF3tqc+PI8gkxSVsNhDX0HDTe5CDkkqmCpZ
	 fxmEGNwG2Lv0Q==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Sat, 26 Sep 2026 12:26:30 +0300
Subject: [PATCH v2 1/5] hibernation: make swsusp_page helpers static
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-hibernation-v2-1-235f69f3ab2a@kernel.org>
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

Since commit 31a1b9d7fe768 ("mm: page_alloc: move mark_free_page() into
snapshot.c") several helpers that set, clear and query free and forbidden
page status are only used inside kernel/power/snapshot.c

Make them static and add necessary forward declarations near the existing
declarations of similar helpers.

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/suspend.h |  6 ------
 kernel/power/snapshot.c | 15 +++++++++------
 2 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index b02876f1ae38..b3435c5ef63f 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -381,9 +381,6 @@ struct platform_hibernation_ops {
 #ifdef CONFIG_HIBERNATION
 /* kernel/power/snapshot.c */
 extern void register_nosave_region(unsigned long b, unsigned long e);
-extern int swsusp_page_is_forbidden(struct page *);
-extern void swsusp_set_page_free(struct page *);
-extern void swsusp_unset_page_free(struct page *);
 extern unsigned long get_safe_page(gfp_t gfp_mask);
 extern asmlinkage int swsusp_arch_suspend(void);
 extern asmlinkage int swsusp_arch_resume(void);
@@ -404,9 +401,6 @@ int arch_hibernation_header_restore(void *addr);
 
 #else /* CONFIG_HIBERNATION */
 static inline void register_nosave_region(unsigned long b, unsigned long e) {}
-static inline int swsusp_page_is_forbidden(struct page *p) { return 0; }
-static inline void swsusp_set_page_free(struct page *p) {}
-static inline void swsusp_unset_page_free(struct page *p) {}
 
 static inline void hibernation_set_ops(const struct platform_hibernation_ops *ops) {}
 static inline int hibernate(void) { return -ENOSYS; }
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index d5dba0e50b2e..e732bf6389e4 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -112,9 +112,12 @@ static inline void hibernate_unmap_page(struct page *page)
 	}
 }
 
-static int swsusp_page_is_free(struct page *);
-static void swsusp_set_page_forbidden(struct page *);
-static void swsusp_unset_page_forbidden(struct page *);
+static int swsusp_page_is_free(struct page *page);
+static void swsusp_set_page_free(struct page *page);
+static void swsusp_unset_page_free(struct page *page);
+static int swsusp_page_is_forbidden(struct page *page);
+static void swsusp_set_page_forbidden(struct page *page);
+static void swsusp_unset_page_forbidden(struct page *page);
 
 /*
  * Number of bytes to reserve for memory allocations made by device drivers
@@ -1036,7 +1039,7 @@ static struct memory_bitmap *free_pages_map;
  * corresponding bits in forbidden_pages_map and free_pages_map simultaneously
  */
 
-void swsusp_set_page_free(struct page *page)
+static void swsusp_set_page_free(struct page *page)
 {
 	if (free_pages_map)
 		memory_bm_set_bit(free_pages_map, page_to_pfn(page));
@@ -1048,7 +1051,7 @@ static int swsusp_page_is_free(struct page *page)
 		memory_bm_test_bit(free_pages_map, page_to_pfn(page)) : 0;
 }
 
-void swsusp_unset_page_free(struct page *page)
+static void swsusp_unset_page_free(struct page *page)
 {
 	if (free_pages_map)
 		memory_bm_clear_bit(free_pages_map, page_to_pfn(page));
@@ -1060,7 +1063,7 @@ static void swsusp_set_page_forbidden(struct page *page)
 		memory_bm_set_bit(forbidden_pages_map, page_to_pfn(page));
 }
 
-int swsusp_page_is_forbidden(struct page *page)
+static int swsusp_page_is_forbidden(struct page *page)
 {
 	return forbidden_pages_map ?
 		memory_bm_test_bit(forbidden_pages_map, page_to_pfn(page)) : 0;

-- 
2.53.0

