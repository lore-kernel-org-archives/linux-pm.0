From: Shaohua Li <shaohua.li@intel.com>
Subject: swsusp: which page should be saved?
Date: Thu, 16 Mar 2006 11:53:27 +0800
Message-ID: <1142481207.26706.16.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============46575140057986575=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linux-pm mailing list <linux-pm@lists.osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============46575140057986575==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I thought there was a discussion before, but I still saw many pages like
BIOS reserved are saved/restored in swsusp. Pages reserved by BIOS, not
used by OS and kernel text should be skipped in swsusp to me. Below
patch works in my test. Any thought?

Thanks,
Shaohua

---

 linux-2.6.15-root/arch/i386/kernel/setup.c |   78 +++++++++++++++++++++++++++++
 linux-2.6.15-root/kernel/power/snapshot.c  |    1 
 2 files changed, 78 insertions(+), 1 deletion(-)

diff -puN arch/i386/kernel/setup.c~nosave_pages arch/i386/kernel/setup.c
--- linux-2.6.15/arch/i386/kernel/setup.c~nosave_pages	2006-03-14 14:42:24.000000000 +0800
+++ linux-2.6.15-root/arch/i386/kernel/setup.c	2006-03-15 09:38:18.000000000 +0800
@@ -1483,6 +1483,83 @@ static void set_mca_bus(int x)
 static void set_mca_bus(int x) { }
 #endif
 
+extern char __end_rodata;
+static void __init mark_nosave_page_range(unsigned long start, unsigned long end)
+{
+	struct page *page;
+	while (start <= end) {
+		printk("%ld,", start);
+		page = pfn_to_page(start);
+		SetPageNosave(page);
+		start ++;
+	}
+}
+
+static int __init efi_mark_nosave_page(unsigned long start, unsigned long end,
+	void *arg)
+{
+	unsigned long start_pfn, end_pfn, last = *(unsigned long*)arg;
+
+	start_pfn = PFN_DOWN(start);
+	end_pfn = PFN_DOWN(end);
+	/* check max_low_pfn */
+	if (start_pfn >= max_low_pfn)
+		return 0;
+	if (end_pfn >= max_low_pfn)
+		end = max_low_pfn;
+	if (start_pfn > last)
+		mark_nosave_page_range(last, start_pfn - 1);
+	*(unsigned long*)arg = end;
+	return 0;
+}
+
+static void __init mark_nosave_pages(void)
+{
+	unsigned long pfn, pfn_end_rodata, last_pfn = 0;
+	int i;
+
+	/* Mark all BIOS reserved regions as nosave */
+	if (efi_enabled) {
+		efi_memmap_walk(efi_mark_nosave_page, &last_pfn);
+		return;
+	} else {
+		for (i = 0; i < e820.nr_map; i++) {
+			unsigned long start_pfn, end_pfn;
+			if (e820.map[i].type != E820_RAM)
+				continue;
+
+			start_pfn = PFN_DOWN(e820.map[i].addr);
+			if (start_pfn >= max_low_pfn)
+				break;
+			end_pfn = PFN_UP(e820.map[i].addr + e820.map[i].size);
+
+			if (end_pfn > max_low_pfn)
+				end_pfn = max_low_pfn;
+			if (end_pfn <= start_pfn)
+				continue;
+			if (start_pfn > last_pfn) {
+				start_pfn--;
+				mark_nosave_page_range(last_pfn, start_pfn);
+			}
+			last_pfn = end_pfn;
+		}
+	}
+
+	if (last_pfn < max_low_pfn)
+		mark_nosave_page_range(last_pfn, max_low_pfn);
+
+	/* kernel text */
+	pfn = PFN_UP(__pa(__KERNEL_START));
+	pfn_end_rodata = PFN_DOWN(__pa(&__end_rodata));
+	mark_nosave_page_range(pfn, pfn_end_rodata);
+
+	/* other pages kernel doesn't use (see setup_bootmem_allocator) */
+	mark_nosave_page_range(0, 0);
+#ifdef CONFIG_SMP
+	mark_nosave_page_range(PFN_DOWN(PAGE_SIZE), PFN_DOWN(PAGE_SIZE));
+#endif
+}
+
 /*
  * Determine if we were loaded by an EFI loader.  If so, then we have also been
  * passed the efi memmap, systab, etc., so we should use these data structures
@@ -1573,6 +1650,7 @@ void __init setup_arch(char **cmdline_p)
 	remapped_pgdat_init();
 	sparse_init();
 	zone_sizes_init();
+	mark_nosave_pages();
 
 	/*
 	 * NOTE: at this point the bootmem allocator is fully available.
diff -puN kernel/power/snapshot.c~nosave_pages kernel/power/snapshot.c
--- linux-2.6.15/kernel/power/snapshot.c~nosave_pages	2006-03-14 14:42:29.000000000 +0800
+++ linux-2.6.15-root/kernel/power/snapshot.c	2006-03-14 14:43:06.000000000 +0800
@@ -173,7 +173,6 @@ static int saveable(struct zone *zone, u
 		return 0;
 
 	page = pfn_to_page(pfn);
-	BUG_ON(PageReserved(page) && PageNosave(page));
 	if (PageNosave(page))
 		return 0;
 	if (PageReserved(page) && pfn_is_nosave(pfn))
_



--===============46575140057986575==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============46575140057986575==--
