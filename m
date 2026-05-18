Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79042399015;
	Mon, 18 May 2026 21:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779140090; cv=pass; b=O8X1YaHQ5wHd6Qs05I29sxAA2jNGu06Krer1EwpS5pwH4vipH/uo85kNaWlvgQaGjyBLLpBCFjGgFDQoR4pwnpbzZBbzuih1M7wf9OrfOLmPoSXrfELGjPpj/IyBlBjLjbnzIc1A0+aFa0W5ecaVDEeDA/2UMBpfG+vUUhs+YoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779140090; c=relaxed/simple;
	bh=kvD6rg815k3b7dHq0o47SjLaZtiwIT1bbGujeKcGlwY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VcQGLeuHM4zjxsLAb8PzdoUYDWgE/rF798z8zGO0U97YBIIFzMDU9zj/3PvI4vJZRASnc2vizUJybrjWu5f2kHffX21CW6JgsqTiQNPWiSxwiEwjomhG365UfQxdawlnQxNNK38pS9wtoO3mDM+5e7dXhSh4TNvl+qxlWHNK+cQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=eBNRu4pL; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="eBNRu4pL"
ARC-Seal: i=1; a=rsa-sha256; t=1779140070; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hsGyQdUEtIr6+8J0ND/anpjaAqgoNavHQ+WO653qc9dY41ubr1SWElZBSfWR6xVD5aab7ZNIF6LlvI3kbIkP3DtFRyb+42y3XsBsRRIC1l/vfjERJ+485UAynqE+eLaII7kmmz7InLUgzNoZx8P9+yF5rq03QoBOPXImM/PWd5c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1779140070; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Z2LcsnJ9wGuLSHn1Ckrk/kL3XlzbAFNchftSNuzrRoY=; 
	b=CUZrLtZZnlRemzvA53zAL2ucDHfsoA2iV/1NA0uLZ9PwfObjIu5iUo8NR44+VyGZpQhVbCucYO32dvfhywl1+OufyT3SEF1rpx6hNQrIC9CDHOk+WTA8dNkOtxh94BLap7C8JJdzn8j52hwoqyHYLVaZEnTmwA4W4fJLJ9vghbo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1779140070;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=Z2LcsnJ9wGuLSHn1Ckrk/kL3XlzbAFNchftSNuzrRoY=;
	b=eBNRu4pLQXNIK1MRGBltmpLDWUIHIF6ohxBWz27xHtup2RLT0YU7oAuryuhvBYS+
	IhWtYzQsaKcEBe2+5IPA20xbvUbVKKoVV3g6NCqfgIGID0CNjNTVlVDH/S4/Nwr5AvV
	uG0pW0vfLXel9O6BVItTz41YTqKIPa5T1r6YfDeU=
Received: by mx.zohomail.com with SMTPS id 1779140067721328.6038740285327;
	Mon, 18 May 2026 14:34:27 -0700 (PDT)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Mon, 18 May 2026 17:34:24 -0400
Subject: [PATCH 3/3] PM: hibernate: Allow disabling zero page check in
 copy_data_pages()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260518-hibernation-decrease-time-in-copy-data-pages-v1-3-3998bdf90ee5@collabora.com>
References: <20260518-hibernation-decrease-time-in-copy-data-pages-v1-0-3998bdf90ee5@collabora.com>
In-Reply-To: <20260518-hibernation-decrease-time-in-copy-data-pages-v1-0-3998bdf90ee5@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>
Cc: Brian Geffon <bgeffon@google.com>, kernel@collabora.com, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.14.3
X-ZohoMailClient: External

The current implementation of copy_data_pages() has at its center
do_copy_page(), which copies data of all saveable pages in a loop one
long at a time, while checking whether the page is fully zero to allow
it to not be saved in the hibernation image.

As the comment above do_copy_page() mentions, this loop was used instead
of the more optimized copy_page() and memcpy() due to them depending on
fpu_begin()/fpu_end() (see [1] and commit 95018f7c94cb ("[PATCH] swsusp:
do not use memcpy for snapshotting memory")). However, since commit
c6dbd3e5e69c ("x86/mmx_32: Remove X86_USE_3DNOW"), this limitation no
longer holds, and it only affected x86-32 in the first place.

From testing it is clear that removing the zero page check and using
copy_page() makes it almost 3 times quicker:
- Current:
    PM: hibernation: Copied 4940240 kbytes in 11.33 seconds (436.03 MB/s)
- With just the zero check removed:
    PM: hibernation: Copied 4974664 kbytes in 9.03 seconds (550.90 MB/s)
- With the zero check removed and using copy_page() instead:
    PM: hibernation: Copied 6275216 kbytes in 3.96 seconds (1584.65 MB/s)

Given that copy_data_pages() runs inside a critical section where only
a single CPU is online and syscore is suspended, it should be kept as
short as possible to keep the system responsive.

While switching from the loop to copy_page() brings big speed
improvements, it also makes the zero page check much costlier since it
can no longer be done in the middle of the copy. In fact upon testing
adding the zero check alongside copy_page() made it slower than the
current code.

The following shows a rough comparison of a few more metrics between the
current code and when both copy_page() is used and the zero page check
is disabled:
- Total time to hibernate:
  - before: 13.77s
  - after: 14.13s
- Total time to resume:
  - before: 5.85s
  - after: 5.85s
- Total time in syscore_suspend():
  - before: 11.3s
  - after: 4.08s
- Total image size written to disk:
  - before: 4956296kB => 2606402kB compressed = 2.60MB
  - after: 6274608 => 2616624kB compressed = 2.61MB

As can be seen the total time to hibernate is roughly the same,
suggesting that the time saved with the more efficient copy_page() is
payed by having to compress more data (the zero pages). The time to
resume remains the same. And the hibernation image size is basically the
same, as the zero pages compress well (the case would be quite different
if compression is disabled). The big win here is that the time between
syscore_suspend() and syscore_resume() is much lower, meaning the system
will be more responsive throughout hibernation.

Expose a 'nozerocheck' module parameter to allow the zero page check to
be disabled and the faster copy_page() to be used, giving the option for
userspace to choose between a more responsive system and reducing the
disk usage particularly when compression is disabled.

Testing was done on the SteamDeck OLED.

[1] https://lore.kernel.org/all/1096877559.9064.45.camel@desktop.cunninghams/

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 kernel/power/snapshot.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 4f452baf31dc..00feac18faae 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -40,6 +40,9 @@
 
 #include "power.h"
 
+static bool nozerocheck;
+module_param(nozerocheck, bool, 0644);
+
 #if defined(CONFIG_STRICT_KERNEL_RWX) && defined(CONFIG_ARCH_HAS_SET_MEMORY)
 static bool hibernate_restore_protection;
 static bool hibernate_restore_protection_active;
@@ -1425,11 +1428,9 @@ static unsigned int count_data_pages(void)
 }
 
 /*
- * This is needed, because copy_page and memcpy are not usable for copying
- * task structs. Returns true if the page was filled with only zeros,
- * otherwise false.
+ * Returns true if the page was filled with only zeros, otherwise false.
  */
-static inline bool do_copy_page(long *dst, long *src)
+static inline bool do_copy_page_zerocheck(long *dst, long *src)
 {
 	long z = 0;
 	int n;
@@ -1441,6 +1442,12 @@ static inline bool do_copy_page(long *dst, long *src)
 	return !z;
 }
 
+static inline bool do_copy_page_nozerocheck(long *dst, long *src)
+{
+	copy_page(dst, src);
+	return false;
+}
+
 /**
  * safe_copy_page - Copy a page in a safe way.
  *
@@ -1450,7 +1457,8 @@ static inline bool do_copy_page(long *dst, long *src)
  * always returns 'true'. Returns true if the page was entirely composed of
  * zeros, otherwise it will return false.
  */
-static bool safe_copy_page(void *dst, struct page *s_page)
+static bool safe_copy_page(void *dst, struct page *s_page,
+			   bool (*do_copy_page)(long *dst, long *src))
 {
 	bool zeros_only;
 
@@ -1471,7 +1479,8 @@ static inline struct page *page_is_saveable(struct zone *zone, unsigned long pfn
 		saveable_highmem_page(zone, pfn) : saveable_page(zone, pfn);
 }
 
-static bool copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
+static bool copy_data_page(unsigned long dst_pfn, unsigned long src_pfn,
+			   bool (*do_copy_page)(long *dst, long *src))
 {
 	struct page *s_page, *d_page;
 	void *src, *dst;
@@ -1491,12 +1500,13 @@ static bool copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
 			 * The page pointed to by src may contain some kernel
 			 * data modified by kmap_atomic()
 			 */
-			zeros_only = safe_copy_page(buffer, s_page);
+			zeros_only = safe_copy_page(buffer, s_page, do_copy_page);
 			dst = kmap_local_page(d_page);
 			copy_page(dst, buffer);
 			kunmap_local(dst);
 		} else {
-			zeros_only = safe_copy_page(page_address(d_page), s_page);
+			zeros_only = safe_copy_page(page_address(d_page),
+						    s_page, do_copy_page);
 		}
 	}
 	return zeros_only;
@@ -1504,10 +1514,12 @@ static bool copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
 #else
 #define page_is_saveable(zone, pfn)	saveable_page(zone, pfn)
 
-static inline int copy_data_page(unsigned long dst_pfn, unsigned long src_pfn)
+static inline int
+copy_data_page(unsigned long dst_pfn, unsigned long src_pfn,
+	       bool (*do_copy_page)(long *dst, long *src))
 {
 	return safe_copy_page(page_address(pfn_to_page(dst_pfn)),
-				pfn_to_page(src_pfn));
+				pfn_to_page(src_pfn), do_copy_page);
 }
 #endif /* CONFIG_HIGHMEM */
 
@@ -1524,6 +1536,9 @@ static unsigned long copy_data_pages(struct memory_bitmap *copy_bm,
 	unsigned long copied_pages = 0;
 	struct zone *zone;
 	unsigned long pfn, copy_pfn;
+	bool (*do_copy_page)(long *dst, long *src);
+
+	do_copy_page = nozerocheck ? do_copy_page_nozerocheck : do_copy_page_zerocheck;
 
 	for_each_populated_zone(zone) {
 		unsigned long max_zone_pfn;
@@ -1541,7 +1556,7 @@ static unsigned long copy_data_pages(struct memory_bitmap *copy_bm,
 		pfn = memory_bm_next_pfn(orig_bm);
 		if (unlikely(pfn == BM_END_OF_MAP))
 			break;
-		if (copy_data_page(copy_pfn, pfn)) {
+		if (copy_data_page(copy_pfn, pfn, do_copy_page)) {
 			memory_bm_set_bit(zero_bm, pfn);
 			/* Use this copy_pfn for a page that is not full of zeros */
 			continue;

-- 
2.53.0

