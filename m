From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] Hibernation: Fix mark_nosave_pages()
Date: Wed, 12 Mar 2008 00:34:57 +0100
Message-ID: <200803120034.58615.rjw__2150.56328238479$1205278691$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Len,

The following patch fixes http://bugzilla.kernel.org/show_bug.cgi?id=9966 .

Although the problem has been there for quite some time (since before 2.6.22,
apparently), it would be good to have in 2.6.25, because it may fix booting
problems on the affected systems.

Please note that it doesn't modify the code behavior on the systems which are
not affected by bug #9966 .

Thanks,
Rafael


---
From: Rafael J. Wysocki <rjw@sisk.pl>

There is a problem in the hibernation code that triggers on some NUMA
systems on which pfn_valid() returns 'true' for some PFNs that don't
belong to any zone.  Namely, there is a BUG_ON() in
memory_bm_find_bit() that triggers for PFNs not belonging to any
zone and passing the pfn_valid() test.  On the affected systems it
triggers when we mark PFNs reported by the platform as not saveable,
because the PFNs in question belong to a region mapped directly using
iorepam() (i.e. the ACPI data area) and they pass the pfn_valid()
test.

Modify memory_bm_find_bit() so that it returns an error if given PFN
doesn't belong to any zone instead of crashing the kernel and ignore
the result returned by it in mark_nosave_pages(), while marking the
"nosave" memory regions.

This doesn't affect the hibernation functionality, as we won't touch
the PFNs in question anyway.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/snapshot.c |   41 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

Index: linux-2.6/kernel/power/snapshot.c
===================================================================
--- linux-2.6.orig/kernel/power/snapshot.c
+++ linux-2.6/kernel/power/snapshot.c
@@ -447,7 +447,7 @@ static void memory_bm_free(struct memory
  *	of @bm->cur_zone_bm are updated.
  */
 
-static void memory_bm_find_bit(struct memory_bitmap *bm, unsigned long pfn,
+static int memory_bm_find_bit(struct memory_bitmap *bm, unsigned long pfn,
 				void **addr, unsigned int *bit_nr)
 {
 	struct zone_bitmap *zone_bm;
@@ -461,7 +461,8 @@ static void memory_bm_find_bit(struct me
 		while (pfn < zone_bm->start_pfn || pfn >= zone_bm->end_pfn) {
 			zone_bm = zone_bm->next;
 
-			BUG_ON(!zone_bm);
+			if (!zone_bm)
+				return -EFAULT;
 		}
 		bm->cur.zone_bm = zone_bm;
 	}
@@ -479,23 +480,40 @@ static void memory_bm_find_bit(struct me
 	pfn -= bb->start_pfn;
 	*bit_nr = pfn % BM_BITS_PER_CHUNK;
 	*addr = bb->data + pfn / BM_BITS_PER_CHUNK;
+	return 0;
 }
 
 static void memory_bm_set_bit(struct memory_bitmap *bm, unsigned long pfn)
 {
 	void *addr;
 	unsigned int bit;
+	int error;
 
-	memory_bm_find_bit(bm, pfn, &addr, &bit);
+	error = memory_bm_find_bit(bm, pfn, &addr, &bit);
+	BUG_ON(error);
 	set_bit(bit, addr);
 }
 
+static int mem_bm_set_bit_check(struct memory_bitmap *bm, unsigned long pfn)
+{
+	void *addr;
+	unsigned int bit;
+	int error;
+
+	error = memory_bm_find_bit(bm, pfn, &addr, &bit);
+	if (!error)
+		set_bit(bit, addr);
+	return error;
+}
+
 static void memory_bm_clear_bit(struct memory_bitmap *bm, unsigned long pfn)
 {
 	void *addr;
 	unsigned int bit;
+	int error;
 
-	memory_bm_find_bit(bm, pfn, &addr, &bit);
+	error = memory_bm_find_bit(bm, pfn, &addr, &bit);
+	BUG_ON(error);
 	clear_bit(bit, addr);
 }
 
@@ -503,8 +521,10 @@ static int memory_bm_test_bit(struct mem
 {
 	void *addr;
 	unsigned int bit;
+	int error;
 
-	memory_bm_find_bit(bm, pfn, &addr, &bit);
+	error = memory_bm_find_bit(bm, pfn, &addr, &bit);
+	BUG_ON(error);
 	return test_bit(bit, addr);
 }
 
@@ -709,8 +729,15 @@ static void mark_nosave_pages(struct mem
 				region->end_pfn << PAGE_SHIFT);
 
 		for (pfn = region->start_pfn; pfn < region->end_pfn; pfn++)
-			if (pfn_valid(pfn))
-				memory_bm_set_bit(bm, pfn);
+			if (pfn_valid(pfn)) {
+				/*
+				 * It is safe to ignore the result of
+				 * mem_bm_set_bit_check() here, since we won't
+				 * touch the PFNs for which the error is
+				 * returned anyway.
+				 */
+				mem_bm_set_bit_check(bm, pfn);
+			}
 	}
 }
 
