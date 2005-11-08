From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC/RFT][PATCH 1/2] swsusp: introduce the swap map
	structure
Date: Wed, 9 Nov 2005 00:06:45 +0100
Message-ID: <200511090006.46077.rjw@sisk.pl>
References: <200511082355.43984.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============11244035148726539=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200511082355.43984.rjw@sisk.pl>
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
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============11244035148726539==
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch introduces the swap map structure that can be used by swsusp for
keeping tracks of data pages written to the swap.  The structure itself is
described in a comment within the patch.

The overall idea is to reduce the amount of metadata written to the swap
and to write and read the image pages sequentially, in a file-alike way.
This makes the swap-handling part of swsusp be fairly independent of its
snapshot-handling part and will hopefully allow us to completely
separate these two parts in the future.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 include/linux/suspend.h |    6 
 kernel/power/power.h    |   13 -
 kernel/power/snapshot.c |   31 +-
 kernel/power/swsusp.c   |  609 ++++++++++++++++++++++++++++++++++--------------
 4 files changed, 464 insertions(+), 195 deletions(-)

Index: linux-2.6.14-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.14-mm1.orig/kernel/power/swsusp.c	2005-11-07 22:58:02.000000000 +0100
+++ linux-2.6.14-mm1/kernel/power/swsusp.c	2005-11-08 22:21:48.000000000 +0100
@@ -33,6 +33,9 @@
  * Andreas Steinmetz <ast@domdv.de>:
  * Added encrypted suspend option
  *
+ * Rafael J. Wysocki <rjw@sisk.pl>
+ * Added the swap map data structure and reworked the handling of swap
+ *
  * More state savers are welcome. Especially for the scsi layer...
  *
  * For TODOs,FIXMEs also look in Documentation/power/swsusp.txt
@@ -87,18 +90,6 @@
 
 extern char resume_file[];
 
-/* Local variables that should not be affected by save */
-unsigned int nr_copy_pages __nosavedata = 0;
-
-/* Suspend pagedir is allocated before final copy, therefore it
-   must be freed after resume
-
-   Warning: this is even more evil than it seems. Pagedirs this file
-   talks about are completely different from page directories used by
-   MMU hardware.
- */
-suspend_pagedir_t *pagedir_nosave __nosavedata = NULL;
-
 #define SWSUSP_SIG	"S1SUSPEND"
 
 static struct swsusp_header {
@@ -188,12 +179,12 @@
 	crypto_free_tfm((struct crypto_tfm *)mem);
 }
 
-static __inline__ int crypto_write(struct pbe *p, void *mem)
+static __inline__ int crypto_write(unsigned long addr, swp_entry_t *entry, void *mem)
 {
 	int error = 0;
 	struct scatterlist src, dst;
 
-	src.page   = virt_to_page(p->address);
+	src.page   = virt_to_page((void *)addr);
 	src.offset = 0;
 	src.length = PAGE_SIZE;
 	dst.page   = virt_to_page((void *)&swsusp_header);
@@ -204,23 +195,22 @@
 					PAGE_SIZE);
 
 	if (!error)
-		error = write_page((unsigned long)&swsusp_header,
-				&(p->swap_address));
+		error = write_page((unsigned long)&swsusp_header, entry);
 	return error;
 }
 
-static __inline__ int crypto_read(struct pbe *p, void *mem)
+static __inline__ int crypto_read(unsigned long offset, void *buf, void *mem)
 {
 	int error = 0;
 	struct scatterlist src, dst;
 
-	error = bio_read_page(swp_offset(p->swap_address), (void *)p->address);
+	error = bio_read_page(offset, buf);
 	if (!error) {
 		src.offset = 0;
 		src.length = PAGE_SIZE;
 		dst.offset = 0;
 		dst.length = PAGE_SIZE;
-		src.page = dst.page = virt_to_page((void *)p->address);
+		src.page = dst.page = virt_to_page(buf);
 
 		error = crypto_cipher_decrypt((struct crypto_tfm *)mem, &dst,
 						&src, PAGE_SIZE);
@@ -237,14 +227,14 @@
 {
 }
 
-static __inline__ int crypto_write(struct pbe *p, void *mem)
+static __inline__ int crypto_write(unsigned long addr, swp_entry_t *entry, void *mem)
 {
-	return write_page(p->address, &(p->swap_address));
+	return write_page(addr, entry);
 }
 
-static __inline__ int crypto_read(struct pbe *p, void *mem)
+static __inline__ int crypto_read(unsigned long offset, void *buf, void *mem)
 {
-	return bio_read_page(swp_offset(p->swap_address), (void *)p->address);
+	return bio_read_page(offset, buf);
 }
 #endif
 
@@ -376,55 +366,220 @@
 }
 
 /**
- *	data_free - Free the swap entries used by the saved image.
+ *	Swap map-handling functions
+ *
+ *	The swap map is a data structure used for keeping track of each page
+ *	written to the swap.  It consists of many swp_map_page structures
+ *	that contain each an array of MAP_PAGE_SIZE swap entries.
+ *	These structures are linked together with the help of either the
+ *	.next (in memory) or the .next_swp (in swap) member.
  *
- *	Walk the list of used swap entries and free each one.
- *	This is only used for cleanup when suspend fails.
+ *	The swap map is created during suspend.  At that time we need to keep
+ *	it in memory, because we have to free all of the allocated swap
+ *	entries if an error occurs.  The memory needed is preallocated
+ *	so that we know in advance if there's enough of it.
+ *
+ *	The first swp_map_page structure is filled with the swap entries that
+ *	correspond to the first MAP_PAGE_SIZE data pages written to swap and
+ *	so on.  After the all of the data pages have been written, the order
+ *	of the swp_map_page structures in the map is reversed so that they
+ *	can be read from swap in the original order.  This causes the data
+ *	pages to be loaded in exactly the same order in which they have been
+ *	saved.
+ *
+ *	During resume we only need to use one swp_map_page structure
+ *	at a time, which means that we only need to use two memory pages for
+ *	reading the image - one for reading the swp_map_page structures
+ *	and the second for reading the data pages from swap.
  */
-static void data_free(void)
+
+#define MAP_PAGE_SIZE	((PAGE_SIZE - sizeof(swp_entry_t) - sizeof(void *)) \
+			/ sizeof(swp_entry_t))
+
+struct swp_map_page {
+	swp_entry_t		entries[MAP_PAGE_SIZE];
+	swp_entry_t		next_swp;
+	struct swp_map_page	*next;
+};
+
+static inline void free_swp_map(struct swp_map_page *swp_map)
 {
-	swp_entry_t entry;
-	struct pbe *p;
+	struct swp_map_page *swp;
 
-	for_each_pbe (p, pagedir_nosave) {
-		entry = p->swap_address;
-		if (entry.val)
-			swap_free(entry);
-		else
-			break;
+	while (swp_map) {
+		swp = swp_map->next;
+		free_page((unsigned long)swp_map);
+		swp_map = swp;
 	}
 }
 
+static struct swp_map_page *alloc_swp_map(unsigned int nr_pages)
+{
+	struct swp_map_page *swp_map, *swp;
+	unsigned n = 0;
+
+	if (!nr_pages)
+		return NULL;
+
+	pr_debug("alloc_swp_map(): nr_pages = %d\n", nr_pages);
+	swp_map = (struct swp_map_page *)get_zeroed_page(GFP_ATOMIC);
+	swp = swp_map;
+	for (n = MAP_PAGE_SIZE; n < nr_pages; n += MAP_PAGE_SIZE) {
+		swp->next = (struct swp_map_page *)get_zeroed_page(GFP_ATOMIC);
+		swp = swp->next;
+		if (!swp) {
+			free_swp_map(swp_map);
+			return NULL;
+		}
+	}
+	return swp_map;
+}
+
 /**
- *	data_write - Write saved image to swap.
- *
- *	Walk the list of pages in the image and sync each one to swap.
+ *	reverse_swp_map - reverse the order of pages in the swap map
+ *	@swp_map
  */
-static int data_write(void)
+
+static inline struct swp_map_page *reverse_swp_map(struct swp_map_page *swp_map)
 {
-	int error = 0, i = 0;
-	unsigned int mod = nr_copy_pages / 100;
-	struct pbe *p;
-	void *tfm;
+	struct swp_map_page *prev, *next;
 
-	if ((error = crypto_init(1, &tfm)))
-		return error;
+	prev = NULL;
+	while (swp_map) {
+		next = swp_map->next;
+		swp_map->next = prev;
+		prev = swp_map;
+		swp_map = next;
+	}
+	return prev;
+}
+
+/**
+ *	free_swp_map_entries - free the swap entries allocated to store
+ *	the swap map @swp_map (this is only called in case of an error)
+ */
 
-	if (!mod)
-		mod = 1;
+static inline void free_swp_map_entries(struct swp_map_page *swp_map)
+{
+	while (swp_map) {
+		if (swp_map->next_swp.val)
+			swap_free(swp_map->next_swp);
+		swp_map = swp_map->next;
+	}
+}
 
-	printk( "Writing data to swap (%d pages)...     ", nr_copy_pages );
-	for_each_pbe (p, pagedir_nosave) {
-		if (!(i%mod))
-			printk( "\b\b\b\b%3d%%", i / mod );
-		if ((error = crypto_write(p, tfm))) {
-			crypto_exit(tfm);
+/**
+ *	save_swp_map - save the swap map used for tracing the data pages
+ *	stored in the swap
+ */
+
+static int save_swp_map(struct swp_map_page *swp_map, swp_entry_t *start)
+{
+	swp_entry_t entry = (swp_entry_t){0};
+	int error;
+
+	while (swp_map) {
+		swp_map->next_swp = entry;
+		if ((error = write_page((unsigned long)swp_map, &entry)))
 			return error;
-		}
-		i++;
+		swp_map = swp_map->next;
 	}
-	printk("\b\b\b\bdone\n");
-	crypto_exit(tfm);
+	*start = entry;
+	return 0;
+}
+
+/**
+ *	free_image_entries - free the swap entries allocated to store
+ *	the image data pages (this is only called in case of an error)
+ */
+
+static inline void free_image_entries(struct swp_map_page *swp)
+{
+	unsigned k;
+
+	while (swp) {
+		for (k = 0; k < MAP_PAGE_SIZE; k++)
+			if (swp->entries[k].val)
+				swap_free(swp->entries[k]);
+		swp = swp->next;
+	}
+}
+
+/**
+ *	The swp_map_handle structure is used for handling the swap map in
+ *	a file-alike way
+ */
+
+struct swp_map_handle {
+	void			*tfm; /* Needed for the encryption */
+	struct swp_map_page	*cur;
+	unsigned int		k;
+};
+
+static inline void release_swp_map_writer(struct swp_map_handle *handle)
+{
+	crypto_exit(handle->tfm);
+	handle->cur = NULL;
+	handle->k = 0;
+}
+
+static inline int get_swp_map_writer(struct swp_map_handle *handle,
+                                     struct swp_map_page *map)
+{	int error;
+
+	error = crypto_init(1, &handle->tfm);
+	if (error)
+		return error;
+	handle->cur = map;
+	handle->k = 0;
+	return 0;
+}
+
+static inline int swp_map_write_page(struct swp_map_handle *handle,
+                                     unsigned long addr)
+{
+	int error;
+
+	error = crypto_write(addr, handle->cur->entries + handle->k,
+				handle->tfm);
+	if (error)
+		return error;
+	if (++handle->k >= MAP_PAGE_SIZE) {
+		handle->cur = handle->cur->next;
+		handle->k = 0;
+	}
+	return 0;
+}
+
+/**
+ *	save_image_data - save the data pages pointed to by the PBEs
+ *	from the list @pblist using the swap map handle @handle
+ *	(assume there are @nr_pages data pages to save)
+ */
+
+static int save_image_data(struct pbe *pblist,
+                           struct swp_map_handle *handle,
+                           unsigned int nr_pages)
+{
+	unsigned int m;
+	struct pbe *p;
+	int error = 0;
+
+	printk("Saving image data pages (%u pages) ...     ", nr_pages);
+	m = nr_pages / 100;
+	if (!m)
+		m = 1;
+	nr_pages = 0;
+	for_each_pbe (p, pblist) {
+		error = swp_map_write_page(handle, p->address);
+		if (error)
+			break;
+		if (!(nr_pages % m))
+			printk("\b\b\b\b%3d%%", nr_pages / m);
+		nr_pages++;
+	}
+	if (!error)
+		printk("\b\b\b\bdone\n");
 	return error;
 }
 
@@ -440,19 +595,20 @@
 	pr_debug(" swsusp: UTS Domain: %s\n",swsusp_info.uts.domainname);
 	pr_debug(" swsusp: CPUs: %d\n",swsusp_info.cpus);
 	pr_debug(" swsusp: Image: %ld Pages\n",swsusp_info.image_pages);
-	pr_debug(" swsusp: Pagedir: %ld Pages\n",swsusp_info.pagedir_pages);
+	pr_debug(" swsusp: Total: %ld Pages\n", swsusp_info.pages);
 }
 
-static void init_header(void)
+static void init_header(unsigned int nr_pages)
 {
 	memset(&swsusp_info, 0, sizeof(swsusp_info));
 	swsusp_info.version_code = LINUX_VERSION_CODE;
 	swsusp_info.num_physpages = num_physpages;
 	memcpy(&swsusp_info.uts, &system_utsname, sizeof(system_utsname));
 
-	swsusp_info.suspend_pagedir = pagedir_nosave;
 	swsusp_info.cpus = num_online_cpus();
-	swsusp_info.image_pages = nr_copy_pages;
+	swsusp_info.image_pages = nr_pages;
+	swsusp_info.pages = nr_pages +
+		((nr_pages * sizeof(long) + PAGE_SIZE - 1) >> PAGE_SHIFT);
 }
 
 static int close_swap(void)
@@ -471,39 +627,53 @@
 }
 
 /**
- *	free_pagedir_entries - Free pages used by the page directory.
- *
- *	This is used during suspend for error recovery.
+ *	pack_orig_addresses - the .orig_address fields of the PBEs from the
+ *	list starting at @pbe are stored in the array @buf[] (1 page)
  */
 
-static void free_pagedir_entries(void)
+static inline struct pbe *pack_orig_addresses(unsigned long *buf,
+                                              struct pbe *pbe)
 {
-	int i;
+	int j;
 
-	for (i = 0; i < swsusp_info.pagedir_pages; i++)
-		swap_free(swsusp_info.pagedir[i]);
+	for (j = 0; j < PAGE_SIZE / sizeof(long) && pbe; j++) {
+		buf[j] = pbe->orig_address;
+		pbe = pbe->next;
+	}
+	if (!pbe)
+		for (; j < PAGE_SIZE / sizeof(long); j++)
+			buf[j] = 0;
+	return pbe;
 }
 
-
 /**
- *	write_pagedir - Write the array of pages holding the page directory.
- *	@last:	Last swap entry we write (needed for header).
+ *	save_image_metadata - save the .orig_address fields of the PBEs
+ *	from the list @pblist using the swap map handle @handle
  */
 
-static int write_pagedir(void)
+static int save_image_metadata(struct pbe *pblist,
+                               struct swp_map_handle *handle)
 {
-	int error = 0;
+	unsigned long *buf;
 	unsigned int n = 0;
-	struct pbe *pbe;
+	struct pbe *p;
+	int error = 0;
 
-	printk( "Writing pagedir...");
-	for_each_pb_page (pbe, pagedir_nosave) {
-		if ((error = write_page((unsigned long)pbe, &swsusp_info.pagedir[n++])))
-			return error;
+	printk("Saving image metadata ... ");
+	buf = (unsigned long *)get_zeroed_page(GFP_ATOMIC);
+	if (!buf)
+		return -ENOMEM;
+	p = pblist;
+	while (p) {
+		p = pack_orig_addresses(buf, p);
+		error = swp_map_write_page(handle, (unsigned long)buf);
+		if (error)
+			break;
+		n++;
 	}
-
-	swsusp_info.pagedir_pages = n;
-	printk("done (%u pages)\n", n);
+	free_page((unsigned long)buf);
+	if (!error)
+		printk("done (%u pages saved)\n", n);
 	return error;
 }
 
@@ -529,34 +699,57 @@
 
 /**
  *	write_suspend_image - Write entire image and metadata.
- *
  */
 static int write_suspend_image(void)
 {
+	unsigned int nr_pages;
+	struct swp_map_page *swp_map;
+	struct swp_map_handle handle;
+	struct pbe *pblist;
 	int error;
 
-	if (!enough_swap(nr_copy_pages)) {
+	nr_pages = snapshot_nr_pages();
+	if (!enough_swap(nr_pages)) {
 		printk(KERN_ERR "swsusp: Not enough free swap\n");
 		return -ENOSPC;
 	}
 
-	init_header();
-	if ((error = data_write()))
-		goto FreeData;
-
-	if ((error = write_pagedir()))
-		goto FreePagedir;
+	init_header(nr_pages);
+	swp_map = alloc_swp_map(swsusp_info.pages);
+	if (!swp_map)
+		return -ENOMEM;
+	error = get_swp_map_writer(&handle, swp_map);
+	if (error)
+		goto Free_swp_map;
 
-	if ((error = close_swap()))
-		goto FreePagedir;
- Done:
+	pblist = snapshot_pblist();
+	error = save_image_metadata(pblist, &handle);
+	if (!error)
+		error = save_image_data(pblist, &handle, nr_pages);
+	if (error)
+		goto Free_image_entries;
+
+	swp_map = reverse_swp_map(swp_map);
+	error = save_swp_map(swp_map, &swsusp_info.start);
+	if (error)
+		goto Free_map_entries;
+
+	error = close_swap();
+	if (error)
+		goto Free_map_entries;
+
+Exit:
+	release_swp_map_writer(&handle);
+Free_swp_map:
+	free_swp_map(swp_map);
 	memset(key_iv, 0, MAXKEY+MAXIV);
 	return error;
- FreePagedir:
-	free_pagedir_entries();
- FreeData:
-	data_free();
-	goto Done;
+
+Free_map_entries:
+	free_swp_map_entries(swp_map);
+Free_image_entries:
+	free_image_entries(swp_map);
+	goto Exit;
 }
 
 /* It is important _NOT_ to umount filesystems at this point. We want
@@ -579,8 +772,6 @@
 	return error;
 }
 
-
-
 int swsusp_suspend(void)
 {
 	int error;
@@ -677,7 +868,6 @@
 	/* We assume both lists contain the same number of elements */
 	while (src) {
 		dst->orig_address = src->orig_address;
-		dst->swap_address = src->swap_address;
 		dst = dst->next;
 		src = src->next;
 	}
@@ -757,6 +947,67 @@
 	return submit(WRITE, page_off, page);
 }
 
+/**
+ *	The following functions allow us to read data using a swap map
+ *	in a file-alike way
+ */
+
+static inline void release_swp_map_reader(struct swp_map_handle *handle)
+{
+	crypto_exit(handle->tfm);
+	if (handle->cur)
+		free_page((unsigned long)handle->cur);
+	handle->cur = NULL;
+}
+
+static inline int get_swp_map_reader(struct swp_map_handle *handle,
+                                     swp_entry_t start)
+{
+	int error;
+
+	if (!swp_offset(start))
+		return -EINVAL;
+	error = crypto_init(0, &handle->tfm);
+	if (error)
+		return error;
+	handle->cur = (struct swp_map_page *)get_zeroed_page(GFP_ATOMIC);
+	if (!handle->cur) {
+		crypto_exit(handle->tfm);
+		return -ENOMEM;
+	}
+	error = bio_read_page(swp_offset(start), handle->cur);
+	if (error) {
+		release_swp_map_reader(handle);
+		return error;
+	}
+	handle->k = 0;
+	return 0;
+}
+
+static inline int swp_map_read_page(struct swp_map_handle *handle, void *buf)
+{
+	unsigned long offset;
+	int error;
+
+	if (!handle->cur)
+		return -EINVAL;
+	offset = swp_offset(handle->cur->entries[handle->k]);
+	if (!offset)
+		return -EINVAL;
+	error = crypto_read(offset, buf, handle->tfm);
+	if (error)
+		return error;
+	if (++handle->k >= MAP_PAGE_SIZE) {
+		handle->k = 0;
+		offset = swp_offset(handle->cur->next_swp);
+		if (!offset)
+			release_swp_map_reader(handle);
+		else
+			error = bio_read_page(offset, handle->cur);
+	}
+	return error;
+}
+
 /*
  * Sanity check if this image makes sense with this kernel/swap context
  * I really don't think that it's foolproof but more than nothing..
@@ -785,7 +1036,6 @@
 	return NULL;
 }
 
-
 static int check_header(void)
 {
 	const char *reason = NULL;
@@ -799,7 +1049,6 @@
 		printk(KERN_ERR "swsusp: Resume mismatch: %s\n",reason);
 		return -EPERM;
 	}
-	nr_copy_pages = swsusp_info.image_pages;
 	return error;
 }
 
@@ -828,81 +1077,88 @@
 }
 
 /**
- *	data_read - Read image pages from swap.
- *
- *	You do not need to check for overlaps, check_pagedir()
- *	already did that.
+ *	load_image_data - load the image data using the swap map handle
+ *	@handle and store them using the page backup list @pblist
+ *	(assume there are @nr_pages pages to load)
  */
 
-static int data_read(struct pbe *pblist)
+static int load_image_data(struct pbe *pblist,
+                           struct swp_map_handle *handle,
+                           unsigned int nr_pages)
 {
+	int error;
+	unsigned int m;
 	struct pbe *p;
-	int error = 0;
-	int i = 0;
-	int mod = swsusp_info.image_pages / 100;
-	void *tfm;
-
-	if ((error = crypto_init(0, &tfm)))
-		return error;
-
-	if (!mod)
-		mod = 1;
-
-	printk("swsusp: Reading image data (%lu pages):     ",
-			swsusp_info.image_pages);
 
-	for_each_pbe (p, pblist) {
-		if (!(i % mod))
-			printk("\b\b\b\b%3d%%", i / mod);
-
-		if ((error = crypto_read(p, tfm))) {
-			crypto_exit(tfm);
-			return error;
-		}
-
-		i++;
+	if (!pblist)
+		return -EINVAL;
+	printk("Loading image data pages (%u pages) ...     ", nr_pages);
+	m = nr_pages / 100;
+	if (!m)
+		m = 1;
+	nr_pages = 0;
+	p = pblist;
+	while (p) {
+		error = swp_map_read_page(handle, (void *)p->address);
+		if (error)
+			break;
+		p = p->next;
+		if (!(nr_pages % m))
+			printk("\b\b\b\b%3d%%", nr_pages / m);
+		nr_pages++;
 	}
-	printk("\b\b\b\bdone\n");
-	crypto_exit(tfm);
+	if (!error)
+		printk("\b\b\b\bdone\n");
 	return error;
 }
 
 /**
- *	read_pagedir - Read page backup list pages from swap
+ *	unpack_orig_addresses - copy the elements of @buf[] (1 page) to
+ *	the PBEs in the list starting at @pbe
  */
 
-static int read_pagedir(struct pbe *pblist)
+static inline struct pbe *unpack_orig_addresses(unsigned long *buf,
+                                                  struct pbe *pbe)
 {
-	struct pbe *pbpage, *p;
-	unsigned int i = 0;
-	int error;
+	int j;
 
-	if (!pblist)
-		return -EFAULT;
+	for (j = 0; j < PAGE_SIZE / sizeof(long) && pbe; j++) {
+		pbe->orig_address = buf[j];
+		pbe = pbe->next;
+	}
+	return pbe;
+}
 
-	printk("swsusp: Reading pagedir (%lu pages)\n",
-			swsusp_info.pagedir_pages);
+/**
+ *	load_image_metadata - load the image metadata using the swap map
+ *	handle @handle and put them into the PBEs in the list @pblist
+ */
 
-	for_each_pb_page (pbpage, pblist) {
-		unsigned long offset = swp_offset(swsusp_info.pagedir[i++]);
+static int load_image_metadata(struct pbe *pblist, struct swp_map_handle *handle)
+{
+	struct pbe *p;
+	unsigned long *buf;
+	unsigned int n = 0;
+	int error = 0;
 
-		error = -EFAULT;
-		if (offset) {
-			p = (pbpage + PB_PAGE_SKIP)->next;
-			error = bio_read_page(offset, (void *)pbpage);
-			(pbpage + PB_PAGE_SKIP)->next = p;
-		}
+	printk("Loading image metadata ... ");
+	buf = (unsigned long *)get_zeroed_page(GFP_ATOMIC);
+	if (!buf)
+		return -ENOMEM;
+	p = pblist;
+	while (p) {
+		error = swp_map_read_page(handle, buf);
 		if (error)
 			break;
+		p = unpack_orig_addresses(buf, p);
+		n++;
 	}
-
+	free_page((unsigned long)buf);
 	if (!error)
-		BUG_ON(i != swsusp_info.pagedir_pages);
-
+		printk("done (%u pages loaded)\n", n);
 	return error;
 }
 
-
 static int check_suspend_image(void)
 {
 	int error = 0;
@@ -919,31 +1175,36 @@
 static int read_suspend_image(void)
 {
 	int error = 0;
-	struct pbe *p;
+	struct pbe *p, *pblist;
+	struct swp_map_handle handle;
+	unsigned int nr_pages = swsusp_info.image_pages;
 
-	if (!(p = alloc_pagedir(nr_copy_pages, GFP_ATOMIC, 0)))
+	p = alloc_pagedir(nr_pages, GFP_ATOMIC, 0);
+	if (!p)
 		return -ENOMEM;
-
-	if ((error = read_pagedir(p)))
+	error = get_swp_map_reader(&handle, swsusp_info.start);
+	if (error)
+		/* The PBE list at p will be released by swsusp_free() */
 		return error;
-	create_pbe_list(p, nr_copy_pages);
-	mark_unsafe_pages(p);
-	pagedir_nosave = alloc_pagedir(nr_copy_pages, GFP_ATOMIC, 1);
-	if (pagedir_nosave) {
-		create_pbe_list(pagedir_nosave, nr_copy_pages);
-		copy_page_backup_list(pagedir_nosave, p);
-	}
-	free_pagedir(p);
-	if (!pagedir_nosave)
-		return -ENOMEM;
-
-	/* Allocate memory for the image and read the data from swap */
-
-	error = alloc_data_pages(pagedir_nosave, GFP_ATOMIC, 1);
-
-	if (!error)
-		error = data_read(pagedir_nosave);
+	error = load_image_metadata(p, &handle);
+	if (!error) {
+		mark_unsafe_pages(p);
+		pblist = alloc_pagedir(nr_pages, GFP_ATOMIC, 1);
+		if (pblist)
+			copy_page_backup_list(pblist, p);
+		free_pagedir(p);
+		if (!pblist)
+			error = -ENOMEM;
 
+		/* Allocate memory for the image and read the data from swap */
+		if (!error)
+			error = alloc_data_pages(pblist, GFP_ATOMIC, 1);
+		if (!error)
+			error = load_image_data(pblist, &handle, nr_pages);
+		if (!error)
+			snapshot_pblist_set(pblist);
+	}
+	release_swp_map_reader(&handle);
 	return error;
 }
 
Index: linux-2.6.14-mm1/kernel/power/power.h
===================================================================
--- linux-2.6.14-mm1.orig/kernel/power/power.h	2005-11-07 22:58:02.000000000 +0100
+++ linux-2.6.14-mm1/kernel/power/power.h	2005-11-08 22:21:23.000000000 +0100
@@ -9,19 +9,14 @@
 #define SUSPEND_CONSOLE	(MAX_NR_CONSOLES-1)
 #endif
 
-#define MAX_PBES	((PAGE_SIZE - sizeof(struct new_utsname) \
-			- 4 - 3*sizeof(unsigned long) - sizeof(int) \
-			- sizeof(void *)) / sizeof(swp_entry_t))
-
 struct swsusp_info {
 	struct new_utsname	uts;
 	u32			version_code;
 	unsigned long		num_physpages;
 	int			cpus;
 	unsigned long		image_pages;
-	unsigned long		pagedir_pages;
-	suspend_pagedir_t	* suspend_pagedir;
-	swp_entry_t		pagedir[MAX_PBES];
+	unsigned long		pages;
+	swp_entry_t		start;
 } __attribute__((aligned(PAGE_SIZE)));
 
 
@@ -67,6 +62,8 @@
 
 extern void free_pagedir(struct pbe *pblist);
 extern struct pbe *alloc_pagedir(unsigned nr_pages, gfp_t gfp_mask, int safe_needed);
-extern void create_pbe_list(struct pbe *pblist, unsigned nr_pages);
 extern void swsusp_free(void);
 extern int alloc_data_pages(struct pbe *pblist, gfp_t gfp_mask, int safe_needed);
+extern unsigned int snapshot_nr_pages(void);
+extern struct pbe *snapshot_pblist(void);
+extern void snapshot_pblist_set(struct pbe *pblist);
Index: linux-2.6.14-mm1/kernel/power/snapshot.c
===================================================================
--- linux-2.6.14-mm1.orig/kernel/power/snapshot.c	2005-11-07 22:58:02.000000000 +0100
+++ linux-2.6.14-mm1/kernel/power/snapshot.c	2005-11-08 22:21:23.000000000 +0100
@@ -33,6 +33,10 @@
 
 #include "power.h"
 
+struct pbe *pagedir_nosave = NULL;
+
+static unsigned int nr_copy_pages = 0;
+
 #ifdef CONFIG_HIGHMEM
 struct highmem_page {
 	char *data;
@@ -244,7 +248,7 @@
  *	of memory pages allocated with alloc_pagedir()
  */
 
-void create_pbe_list(struct pbe *pblist, unsigned int nr_pages)
+static inline void create_pbe_list(struct pbe *pblist, unsigned int nr_pages)
 {
 	struct pbe *pbpage, *p;
 	unsigned int num = PBES_PER_PAGE;
@@ -261,7 +265,6 @@
 			p->next = p + 1;
 		p->next = NULL;
 	}
-	pr_debug("create_pbe_list(): initialized %d PBEs\n", num);
 }
 
 /**
@@ -332,7 +335,8 @@
 	if (!pbe) { /* get_zeroed_page() failed */
 		free_pagedir(pblist);
 		pblist = NULL;
-        }
+        } else
+        	create_pbe_list(pblist, nr_pages);
 	return pblist;
 }
 
@@ -395,7 +399,6 @@
 		printk(KERN_ERR "suspend: Allocating pagedir failed.\n");
 		return NULL;
 	}
-	create_pbe_list(pblist, nr_pages);
 
 	if (alloc_data_pages(pblist, GFP_ATOMIC | __GFP_COLD, 0)) {
 		printk(KERN_ERR "suspend: Allocating image pages failed.\n");
@@ -421,10 +424,6 @@
 		 (nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE,
 		 PAGES_FOR_IO, nr_free_pages());
 
-	/* This is needed because of the fixed size of swsusp_info */
-	if (MAX_PBES < (nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE)
-		return -ENOSPC;
-
 	if (!enough_free_mem(nr_pages)) {
 		printk(KERN_ERR "swsusp: Not enough free memory\n");
 		return -ENOMEM;
@@ -451,3 +450,19 @@
 	printk("swsusp: critical section/: done (%d pages copied)\n", nr_pages);
 	return 0;
 }
+
+unsigned int snapshot_nr_pages(void)
+{
+	return nr_copy_pages;
+}
+
+struct pbe *snapshot_pblist(void)
+{
+	return pagedir_nosave;
+}
+
+void snapshot_pblist_set(struct pbe *pblist)
+{
+	pagedir_nosave = pblist;
+}
+
Index: linux-2.6.14-mm1/include/linux/suspend.h
===================================================================
--- linux-2.6.14-mm1.orig/include/linux/suspend.h	2005-11-07 22:16:07.000000000 +0100
+++ linux-2.6.14-mm1/include/linux/suspend.h	2005-11-08 22:21:23.000000000 +0100
@@ -14,11 +14,7 @@
 typedef struct pbe {
 	unsigned long address;		/* address of the copy */
 	unsigned long orig_address;	/* original address of page */
-	swp_entry_t swap_address;	
-
-	struct pbe *next;	/* also used as scratch space at
-				 * end of page (see link, diskpage)
-				 */
+	struct pbe *next;
 } suspend_pagedir_t;
 
 #define for_each_pbe(pbe, pblist) \


--===============11244035148726539==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============11244035148726539==--
