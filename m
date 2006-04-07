From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: swsusp: which page should be saved?
Date: Fri, 07 Apr 2006 11:46:01 +0800
Message-ID: <1144381561.16769.31.camel@sli10-desk.sh.intel.com>
References: <1142481207.26706.16.camel@sli10-desk.sh.intel.com>
	<20060315230846.GB2462@ucw.cz>
	<1142557935.26706.26.camel@sli10-desk.sh.intel.com>
	<20060317065937.GH2674@elf.ucw.cz>
	<1142907568.11430.16.camel@sli10-desk.sh.intel.com>
	<20060321094230.GM24523@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============71909798306682049=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060321094230.GM24523@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============71909798306682049==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2006-03-21 at 17:42 +0800, Pavel Machek wrote:
> Hi!
> 
> > > Ok, I guess it is okay to go in if it stays in -mm for long enough
> to  
> > > get a lot of testing. 
> > I'll do more tests and back to you. BTW, I wonder if BIOS already
> saved 
> > reserved memory (those doing communication with OS) in the
> 'platform' 
> > method of S4.
> 
> Yep, it should be safe. I bet it will break some obscure machine, but 
> it will probably fix some obscure machine, too... Just needs lots of
> testing.
> 
> > > > Anyway, skipping kernel text should be safe, isn't it? 
> > >  
> > > It probably is. But you need to save modules.  
> > I just consider the region from kernel start(1M) to the end of
> rodata. 
> > In my test, the region is about 4M memory. Just adding several lines
> to 
> > save 4M memory is worthy.
> 
> Well, few lines to save 4MB is nice. OTOH 4MB are saved in about 
> 100msec, and if it brings in hard-to-debug bug on obscure 
> machine... we did not win much.
> 
> > > And we do use some  
> > > self-modifying code these days, no? (Called runtime patching or  
> > > something like that.)  
> > Alternative instructions? The resume OS will do the same
> modification 
> > anyway.
> 
> Okay, hopefully.
> 
> > > Ouch and IIRC top-level pagedir or something  
> > > like that lives in kernel "text" -- it is in assembly and
> wrongly  
> > > placed. 
> > i386 does the right thing and put the pagedir in data segment.
> x86_64 
> > not, I think we could clean it up.
> 
> This probably should be done, first, and gotten past Andi.
We asked the question to (intel's) BIOS guys, and below is the result.
a. BIOS reserved region/hole - no save/restore
b. ACPI NVS - save/restore
c. 'ACPI Data' is a little tricky. After OS boots, os can reclaim this
region, so regard it as normal ram. But we are afraid Linux runtime
module loading might use this region somewhere, so we also mark this
region as save/restore. Anyway, this hasn't any side effect.
Hopefully all BIOSes follow this rule.

Pages (Reserved/ACPI NVS/ACPI Data) below
end_pfn(x86_64)/max_low_pfn(i386) will be saved/restored by S4
currently. We should mark 'Reserved' pages not saveable.
Pages (Reserved/ACPI NVS/ACPI Data) above end_pfn/max_low_pfn
will not be saved/restored by S4 currently. We should save the
'ACPI NVS/ACPI Data' pages in the highmem.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.17-rc1-root/arch/i386/kernel/setup.c   |  101 +++++++++++++++++++++
 linux-2.6.17-rc1-root/arch/x86_64/kernel/setup.c |   93 +++++++++++++++++++
 linux-2.6.17-rc1-root/include/linux/suspend.h    |    1 
 linux-2.6.17-rc1-root/kernel/power/snapshot.c    |  107 ++++++++++++++++++++++-
 linux-2.6.17-rc1-root/kernel/power/swsusp.c      |   20 +---
 5 files changed, 308 insertions(+), 14 deletions(-)

diff -puN arch/i386/kernel/setup.c~nosave_pages arch/i386/kernel/setup.c
--- linux-2.6.17-rc1/arch/i386/kernel/setup.c~nosave_pages	2006-04-04 15:10:42.000000000 +0800
+++ linux-2.6.17-rc1-root/arch/i386/kernel/setup.c	2006-04-06 09:40:02.000000000 +0800
@@ -48,6 +48,7 @@
 #include <linux/crash_dump.h>
 #include <linux/dmi.h>
 #include <linux/pfn.h>
+#include <linux/suspend.h>
 
 #include <video/edid.h>
 
@@ -1400,6 +1401,106 @@ static void set_mca_bus(int x)
 static void set_mca_bus(int x) { }
 #endif
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+static void __init mark_nosave_page_range(unsigned long start, unsigned long end)
+{
+	struct page *page;
+	while (start <= end) {
+		page = pfn_to_page(start);
+		SetPageNosave(page);
+		start ++;
+	}
+}
+
+static void __init e820_nosave_reserved_pages(void)
+{
+	int i;
+	unsigned long r_start = 0, r_end = 0;
+
+	/* Assume e820 map is sorted */
+	for (i = 0; i < e820.nr_map; i++) {
+		struct e820entry *ei = &e820.map[i];
+		unsigned long start, end;
+
+		start = PFN_DOWN(ei->addr);
+		end = PFN_UP(ei->addr + ei->size);
+		if (start >= end)
+			continue;
+		if (ei->type == E820_RESERVED)
+			continue;
+		r_end = start;
+		/*
+		 * Highmem 'Reserved' pages are marked as reserved, swsusp
+		 * will not save/restore them, so we ignore these pages here.
+		 */
+		if (r_end > max_low_pfn)
+			r_end = max_low_pfn;
+		if (r_end > r_start)
+			mark_nosave_page_range(r_start, r_end-1);
+		if (r_end >= max_low_pfn)
+			break;
+		r_start = end;
+	}
+}
+
+static void __init e820_save_acpi_pages(void)
+{
+	int i;
+
+	/* Assume e820 map is sorted */
+	for (i = 0; i < e820.nr_map; i++) {
+		struct e820entry *ei = &e820.map[i];
+		unsigned long start, end;
+
+		start = PFN_DOWN(ei->addr);
+		end = PFN_UP(ei->addr + ei->size);
+		if (start >= end)
+			continue;
+		if (ei->type != E820_ACPI && ei->type != E820_NVS)
+			continue;
+		/*
+		 * If the region is below max_low_pfn, it will be
+		 * saved/restored by swsusp follow 'RAM' type.
+		 */
+		if (start < max_low_pfn)
+			start = max_low_pfn;
+		/*
+		 * Highmem pages (ACPI NVS/Data) are reserved, but swsusp
+		 * highmem save/restore will not save/restore them. We marked
+		 * them as arch saveable pages here
+		 */
+		if (end > start)
+			swsusp_add_arch_pages(start, end - 1);
+	}
+}
+
+extern char __start_rodata, __end_rodata;
+/*
+ * kernel rodata - no save/restore
+ * BIOS reserved region/hole - no save/restore
+ * ACPI NVS - save/restore
+ * ACPI Data - save/restore
+ */
+static int __init mark_nosave_pages(void)
+{
+	unsigned long pfn_start, pfn_end;
+
+	/* BIOS reserved regions & holes */
+	e820_nosave_reserved_pages();
+
+	/* kernel rodata */
+	pfn_start = PFN_UP(virt_to_phys(&__start_rodata));
+	pfn_end = PFN_DOWN(virt_to_phys(&__end_rodata));
+	mark_nosave_page_range(pfn_start, pfn_end-1);
+
+	/* record ACPI Data/NVS as saveable */
+	e820_save_acpi_pages();
+
+	return 0;
+}
+core_initcall(mark_nosave_pages);
+#endif
+
 /*
  * Determine if we were loaded by an EFI loader.  If so, then we have also been
  * passed the efi memmap, systab, etc., so we should use these data structures
diff -puN arch/x86_64/kernel/setup.c~nosave_pages arch/x86_64/kernel/setup.c
--- linux-2.6.17-rc1/arch/x86_64/kernel/setup.c~nosave_pages	2006-04-04 15:10:42.000000000 +0800
+++ linux-2.6.17-rc1-root/arch/x86_64/kernel/setup.c	2006-04-06 09:40:03.000000000 +0800
@@ -47,6 +47,7 @@
 #include <linux/dmi.h>
 #include <linux/dma-mapping.h>
 #include <linux/ctype.h>
+#include <linux/suspend.h>
 
 #include <asm/mtrr.h>
 #include <asm/uaccess.h>
@@ -582,6 +583,98 @@ static void __init reserve_ebda_region(v
 		reserve_bootmem_generic(addr, PAGE_SIZE);
 }
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
+static void __init mark_nosave_page_range(unsigned long start, unsigned long end)
+{
+	struct page *page;
+	while (start <= end) {
+		page = pfn_to_page(start);
+		SetPageNosave(page);
+		start ++;
+	}
+}
+
+static void __init e820_nosave_reserved_pages(void)
+{
+	int i;
+	unsigned long r_start = 0, r_end = 0;
+
+	/* Assume e820 map is sorted */
+	for (i = 0; i < e820.nr_map; i++) {
+		struct e820entry *ei = &e820.map[i];
+		unsigned long start, end;
+
+		start = round_down(ei->addr, PAGE_SIZE);
+		end = round_up(ei->addr + ei->size, PAGE_SIZE);
+		if (start >= end)
+			continue;
+		if (ei->type == E820_RESERVED)
+			continue;
+		r_end = start>>PAGE_SHIFT;
+		/* swsusp ignores invalid pfn, ignore these pages here */
+		if (r_end > end_pfn)
+			r_end = end_pfn;
+		if (r_end > r_start)
+			mark_nosave_page_range(r_start, r_end-1);
+		if (r_end >= end_pfn)
+			break;
+		r_start = end>>PAGE_SHIFT;
+	}
+}
+
+static void __init e820_save_acpi_pages(void)
+{
+	int i;
+
+	/* Assume e820 map is sorted */
+	for (i = 0; i < e820.nr_map; i++) {
+		struct e820entry *ei = &e820.map[i];
+		unsigned long start, end;
+
+		start = round_down(ei->addr, PAGE_SIZE) >> PAGE_SHIFT;
+		end = round_up(ei->addr + ei->size, PAGE_SIZE) >> PAGE_SHIFT;
+		if (start >= end)
+			continue;
+		if (ei->type != E820_ACPI && ei->type != E820_NVS)
+			continue;
+		/*
+		 * If the region is below end_pfn, it will be
+		 * saved/restored by swsusp follow 'RAM' type.
+		 */
+		if (start < end_pfn)
+			start = end_pfn;
+		if (end > start)
+			swsusp_add_arch_pages(start, end - 1);
+	}
+}
+
+extern char __start_rodata, __end_rodata;
+/*
+ * kernel rodata - no save/restore
+ * BIOS reserved region/hole - no save/restore
+ * ACPI NVS - save/restore
+ * ACPI Data - save/restore
+ */
+static int __init mark_nosave_pages(void)
+{
+	unsigned long pfn_start, pfn_end;
+
+	/* BIOS reserved regions & holes */
+	e820_nosave_reserved_pages();
+
+	/* kernel rodata */
+	pfn_start = round_up(__pa_symbol(&__start_rodata), PAGE_SIZE) >> PAGE_SHIFT;
+	pfn_end = round_down(__pa_symbol(&__end_rodata), PAGE_SIZE) >> PAGE_SHIFT;
+	mark_nosave_page_range(pfn_start, pfn_end-1);
+
+	/* record ACPI Data/NVS as saveable */
+	e820_save_acpi_pages();
+
+	return 0;
+}
+core_initcall(mark_nosave_pages);
+#endif
+
 void __init setup_arch(char **cmdline_p)
 {
 	unsigned long kernel_end;
diff -puN kernel/power/snapshot.c~nosave_pages kernel/power/snapshot.c
--- linux-2.6.17-rc1/kernel/power/snapshot.c~nosave_pages	2006-04-04 15:10:42.000000000 +0800
+++ linux-2.6.17-rc1-root/kernel/power/snapshot.c	2006-04-05 14:56:56.000000000 +0800
@@ -39,6 +39,85 @@ static unsigned int nr_copy_pages;
 static unsigned int nr_meta_pages;
 static unsigned long *buffer;
 
+struct arch_savable_page {
+	unsigned long start_pfn;
+	unsigned long end_pfn;
+	struct arch_savable_page *next;
+	void *data[0];
+};
+static struct arch_savable_page * arch_pages;
+
+int swsusp_add_arch_pages(unsigned long start, unsigned long end)
+{
+	struct arch_savable_page *tmp;
+	unsigned int size;
+
+	end = end + 1;
+	size = sizeof(struct arch_savable_page) + sizeof(void *) * (end - start);
+	tmp = kzalloc(size, GFP_KERNEL);
+	if (!tmp)
+		return -ENOMEM;
+	tmp->start_pfn = start;
+	tmp->end_pfn = end;
+	tmp->next = arch_pages;
+	arch_pages = tmp;
+	return 0;
+}
+
+static unsigned int count_arch_pages(void)
+{
+	unsigned int count = 0;
+	struct arch_savable_page *tmp = arch_pages;
+	while (tmp) {
+		count += tmp->end_pfn - tmp->start_pfn;
+		tmp = tmp->next;
+	}
+	return count;
+}
+
+static int save_arch_mem(void)
+{
+	void *kaddr;
+	struct arch_savable_page *tmp = arch_pages;
+	int i;
+
+	pr_debug("swsusp: Saving arch specific memory");
+	while (tmp) {
+		for (i = 0; i < tmp->end_pfn - tmp->start_pfn; i++) {
+			tmp->data[i] = (void *)get_zeroed_page(GFP_ATOMIC);
+			if (!tmp->data[i])
+				return -ENOMEM;
+			/* arch pages might haven't a 'struct page' */
+			kaddr = kmap_atomic_pfn(tmp->start_pfn + i, KM_PTE0);
+			memcpy(tmp->data[i], kaddr, PAGE_SIZE);
+			kunmap_atomic(kaddr, KM_PTE0);
+		}
+		tmp = tmp->next;
+	}
+	return 0;
+}
+
+static int restore_arch_mem(void)
+{
+	void *kaddr;
+	struct arch_savable_page *tmp = arch_pages;
+	int i;
+
+	while (tmp) {
+		for (i = 0; i < tmp->end_pfn - tmp->start_pfn; i++) {
+			if (!tmp->data[i])
+				continue;
+			kaddr = kmap_atomic_pfn(tmp->start_pfn + i, KM_PTE0);
+			memcpy(kaddr, tmp->data[i], PAGE_SIZE);
+			kunmap_atomic(kaddr, KM_PTE0);
+			free_page((long)tmp->data[i]);
+			tmp->data[i] = NULL;
+		}
+		tmp = tmp->next;
+	}
+	return 0;
+}
+
 #ifdef CONFIG_HIGHMEM
 unsigned int count_highmem_pages(void)
 {
@@ -150,8 +229,35 @@ int restore_highmem(void)
 	}
 	return 0;
 }
+#else
+static unsigned int count_highmem_pages(void) {return 0;}
+static int save_highmem(void) {return 0;}
+static int restore_highmem(void) {return 0;}
 #endif
 
+unsigned int count_special_pages(void)
+{
+	return count_arch_pages() + count_highmem_pages();
+}
+
+int save_special_mem(void)
+{
+	int ret;
+	ret = save_arch_mem();
+	if (!ret)
+		ret = save_highmem();
+	return ret;
+}
+
+int restore_special_mem(void)
+{
+	int ret;
+	ret = restore_arch_mem();
+	if (!ret)
+		ret = restore_highmem();
+	return ret;
+}
+
 static int pfn_is_nosave(unsigned long pfn)
 {
 	unsigned long nosave_begin_pfn = __pa(&__nosave_begin) >> PAGE_SHIFT;
@@ -177,7 +283,6 @@ static int saveable(struct zone *zone, u
 		return 0;
 
 	page = pfn_to_page(pfn);
-	BUG_ON(PageReserved(page) && PageNosave(page));
 	if (PageNosave(page))
 		return 0;
 	if (PageReserved(page) && pfn_is_nosave(pfn))
diff -puN kernel/power/swsusp.c~nosave_pages kernel/power/swsusp.c
--- linux-2.6.17-rc1/kernel/power/swsusp.c~nosave_pages	2006-04-05 12:08:39.000000000 +0800
+++ linux-2.6.17-rc1-root/kernel/power/swsusp.c	2006-04-05 12:49:13.000000000 +0800
@@ -62,15 +62,9 @@ unsigned long image_size = 500 * 1024 * 
 
 int in_suspend __nosavedata = 0;
 
-#ifdef CONFIG_HIGHMEM
-unsigned int count_highmem_pages(void);
-int save_highmem(void);
-int restore_highmem(void);
-#else
-static int save_highmem(void) { return 0; }
-static int restore_highmem(void) { return 0; }
-static unsigned int count_highmem_pages(void) { return 0; }
-#endif
+unsigned int count_special_pages(void);
+int save_special_mem(void);
+int restore_special_mem(void);
 
 /**
  *	The following functions are used for tracing the allocated
@@ -186,7 +180,7 @@ int swsusp_shrink_memory(void)
 
 	printk("Shrinking memory...  ");
 	do {
-		size = 2 * count_highmem_pages();
+		size = 2 * count_special_pages();
 		size += size / 50 + count_data_pages();
 		size += (size + PBES_PER_PAGE - 1) / PBES_PER_PAGE +
 			PAGES_FOR_IO;
@@ -228,7 +222,7 @@ int swsusp_suspend(void)
 		goto Enable_irqs;
 	}
 
-	if ((error = save_highmem())) {
+	if ((error = save_special_mem())) {
 		printk(KERN_ERR "swsusp: Not enough free pages for highmem\n");
 		goto Restore_highmem;
 	}
@@ -239,7 +233,7 @@ int swsusp_suspend(void)
 	/* Restore control flow magically appears here */
 	restore_processor_state();
 Restore_highmem:
-	restore_highmem();
+	restore_special_mem();
 	device_power_up();
 Enable_irqs:
 	local_irq_enable();
@@ -265,7 +259,7 @@ int swsusp_resume(void)
 	 */
 	swsusp_free();
 	restore_processor_state();
-	restore_highmem();
+	restore_special_mem();
 	touch_softlockup_watchdog();
 	device_power_up();
 	local_irq_enable();
diff -puN include/linux/suspend.h~nosave_pages include/linux/suspend.h
--- linux-2.6.17-rc1/include/linux/suspend.h~nosave_pages	2006-04-05 14:45:18.000000000 +0800
+++ linux-2.6.17-rc1-root/include/linux/suspend.h	2006-04-05 14:49:07.000000000 +0800
@@ -72,6 +72,7 @@ struct saved_context;
 void __save_processor_state(struct saved_context *ctxt);
 void __restore_processor_state(struct saved_context *ctxt);
 unsigned long get_safe_page(gfp_t gfp_mask);
+int swsusp_add_arch_pages(unsigned long start, unsigned long end);
 
 /*
  * XXX: We try to keep some more pages free so that I/O operations succeed
_


--===============71909798306682049==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============71909798306682049==--
