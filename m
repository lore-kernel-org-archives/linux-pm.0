From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 04/12] powerpc: mark pages that dont exist as
	Nosave
Date: Wed, 07 Feb 2007 13:45:40 +0100
Message-ID: <20070207124611.630390000@sipsolutions.net>
References: <20070207124536.963531000@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline; filename=powerpc-mark-nonram-nosave.patch
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linuxppc-dev@ozlabs.org
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On some powerpc architectures (notably 64-bit powermac) there is a memory
hole, for example on powermacs between 2G and 4G. Since we use the flat
memory model regardless, these pages must be marked as Nosave (for suspend
to disk.)

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Rafael J. Wysocki <rjw@sisk.pl>

---
This replaces swsusp-dont-copy-pages-that-arent-ram.patch and works just as
well, except that it doesn't modify the generic code.

Tested on powerbook and powermac.

--- linux-2.6-git.orig/arch/powerpc/mm/mem.c	2007-02-07 02:55:03.319884289 =
+0100
+++ linux-2.6-git/arch/powerpc/mm/mem.c	2007-02-07 02:55:30.496884289 +0100
@@ -284,6 +284,27 @@ void __init do_init_bootmem(void)
 	init_bootmem_done =3D 1;
 }
 =

+/* mark lowmem pages that don't exist as nosave, highmem
+ * pages always exist but aren't treated as RAM pages */
+static int __init mark_nonram_nosave(void)
+{
+	struct zone *zone;
+	unsigned long pfn, max_zone_pfn;
+
+	for_each_zone(zone) {
+		if (is_highmem(zone))
+			continue;
+
+		max_zone_pfn =3D zone->zone_start_pfn + zone->spanned_pages;
+
+		for (pfn =3D zone->zone_start_pfn; pfn < max_zone_pfn; pfn++)
+			if (!page_is_ram(pfn))
+				SetPageNosave(pfn_to_page(pfn));
+	}
+
+	return 0;
+}
+
 /*
  * paging_init() sets up the page tables - in fact we've already done this.
  */
@@ -315,6 +336,8 @@ void __init paging_init(void)
 	max_zone_pfns[ZONE_DMA] =3D top_of_ram >> PAGE_SHIFT;
 #endif
 	free_area_init_nodes(max_zone_pfns);
+
+	mark_nonram_nosave();
 }
 #endif /* ! CONFIG_NEED_MULTIPLE_NODES */
 =


--
