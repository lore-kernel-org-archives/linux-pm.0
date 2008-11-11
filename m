From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/2] Hibernate: Do not oops on resume if image
	data are incorrect
Date: Tue, 11 Nov 2008 21:32:44 +0100
Message-ID: <200811112132.45236.rjw__35679.5005304322$1226435516$gmane$org@sisk.pl>
References: <200811081356.13060.rjw@sisk.pl>
	<alpine.LFD.2.00.0811111300580.4480@localhost.localdomain>
	<200811112130.26074.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200811112130.26074.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Pavel Machek <pavel@suse.cz>, Andy Whitcroft <apw@shadowen.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: Hibernate: Do not oops on resume if image data are incorrect

During resume from hibernation using the userland interface image
data are being passed from the used space process to the kernel.
These data need not be valid, but currently the kernel sometimes
oopses if it gets invalid image data, which is wrong.  Make the
kernel return error codes to the user space in such cases.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>
---
 kernel/power/snapshot.c |   43 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 11 deletions(-)

Index: linux-2.6/kernel/power/snapshot.c
===================================================================
--- linux-2.6.orig/kernel/power/snapshot.c
+++ linux-2.6/kernel/power/snapshot.c
@@ -528,6 +528,14 @@ static int memory_bm_test_bit(struct mem
 	return test_bit(bit, addr);
 }
 
+static bool memory_bm_pfn_present(struct memory_bitmap *bm, unsigned long pfn)
+{
+	void *addr;
+	unsigned int bit;
+
+	return !memory_bm_find_bit(bm, pfn, &addr, &bit);
+}
+
 /**
  *	memory_bm_next_pfn - find the pfn that corresponds to the next set bit
  *	in the bitmap @bm.  If the pfn cannot be found, BM_END_OF_MAP is
@@ -1465,9 +1473,7 @@ load_header(struct swsusp_info *info)
  *	unpack_orig_pfns - for each element of @buf[] (1 page at a time) set
  *	the corresponding bit in the memory bitmap @bm
  */
-
-static inline void
-unpack_orig_pfns(unsigned long *buf, struct memory_bitmap *bm)
+static int unpack_orig_pfns(unsigned long *buf, struct memory_bitmap *bm)
 {
 	int j;
 
@@ -1475,8 +1481,13 @@ unpack_orig_pfns(unsigned long *buf, str
 		if (unlikely(buf[j] == BM_END_OF_MAP))
 			break;
 
-		memory_bm_set_bit(bm, buf[j]);
+		if (memory_bm_pfn_present(bm, buf[j]))
+			memory_bm_set_bit(bm, buf[j]);
+		else
+			return -EFAULT;
 	}
+
+	return 0;
 }
 
 /* List of "safe" pages that may be used to store data loaded from the suspend
@@ -1614,7 +1625,7 @@ get_highmem_page_buffer(struct page *pag
 	pbe = chain_alloc(ca, sizeof(struct highmem_pbe));
 	if (!pbe) {
 		swsusp_free();
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	}
 	pbe->orig_page = page;
 	if (safe_highmem_pages > 0) {
@@ -1683,7 +1694,7 @@ prepare_highmem_image(struct memory_bitm
 static inline void *
 get_highmem_page_buffer(struct page *page, struct chain_allocator *ca)
 {
-	return NULL;
+	return ERR_PTR(-EINVAL);
 }
 
 static inline void copy_last_highmem_page(void) {}
@@ -1794,8 +1805,13 @@ prepare_image(struct memory_bitmap *new_
 static void *get_buffer(struct memory_bitmap *bm, struct chain_allocator *ca)
 {
 	struct pbe *pbe;
-	struct page *page = pfn_to_page(memory_bm_next_pfn(bm));
+	struct page *page;
+	unsigned long pfn = memory_bm_next_pfn(bm);
 
+	if (pfn == BM_END_OF_MAP)
+		return ERR_PTR(-EFAULT);
+
+	page = pfn_to_page(pfn);
 	if (PageHighMem(page))
 		return get_highmem_page_buffer(page, ca);
 
@@ -1811,7 +1827,7 @@ static void *get_buffer(struct memory_bi
 	pbe = chain_alloc(ca, sizeof(struct pbe));
 	if (!pbe) {
 		swsusp_free();
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	}
 	pbe->orig_address = page_address(page);
 	pbe->address = safe_pages_list;
@@ -1874,7 +1890,10 @@ int snapshot_write_next(struct snapshot_
 				return error;
 
 		} else if (handle->prev <= nr_meta_pages) {
-			unpack_orig_pfns(buffer, &copy_bm);
+			error = unpack_orig_pfns(buffer, &copy_bm);
+			if (error)
+				return error;
+
 			if (handle->prev == nr_meta_pages) {
 				error = prepare_image(&orig_bm, &copy_bm);
 				if (error)
@@ -1885,12 +1904,14 @@ int snapshot_write_next(struct snapshot_
 				restore_pblist = NULL;
 				handle->buffer = get_buffer(&orig_bm, &ca);
 				handle->sync_read = 0;
-				if (!handle->buffer)
-					return -ENOMEM;
+				if (IS_ERR(handle->buffer))
+					return PTR_ERR(handle->buffer);
 			}
 		} else {
 			copy_last_highmem_page();
 			handle->buffer = get_buffer(&orig_bm, &ca);
+			if (IS_ERR(handle->buffer))
+				return PTR_ERR(handle->buffer);
 			if (handle->buffer != buffer)
 				handle->sync_read = 0;
 		}
