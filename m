From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH -mm 2/2] Hibernation: Arbitrary boot kernel
	support on x86_64
Date: Mon, 27 Aug 2007 13:12:44 +0200
Message-ID: <200708271312.45437.linux-kernel-owner@vger.kernel.org>
References: <200708241206.57178.rjw@sisk.pl>
	<20070824162346.ec57f508.akpm@linux-foundation.org>
	<1188069225.9529.23.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1188069225.9529.23.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Andi Kleen <ak@suse.de>
List-Id: linux-pm@vger.kernel.org

[Sorry for the duplicate, but my mailer decided to mess up the CC list for an
unknown reason.]

On Saturday, 25 August 2007 21:13, Johannes Berg wrote:
> On Fri, 2007-08-24 at 16:23 -0700, Andrew Morton wrote:
> 
> > The preferred way of doing this is via Kconfig, please.  ie: add a
> > CONFIG_HIBERNATION_HEADER to arch/x86_64/Kconfig.
> 
> > It would be better to do something like this in (say) suspend.h:
> > 
> > #ifdef CONFIG_HIBERNATION_HEADER
> > extern int arch_hibernation_header_save(void *addr, unsigned int max_size);
> > extern int arch_hibernation_header_restore(void *addr);
> > #else
> > static inline int arch_hibernation_header_save(void *addr,
> 
> In fact, I guess we don't need to bother with this at all. The generic
> code for doing this (via the utsname based header) is tiny, so as far as
> I can tell it could just be made weak symbols (by this I mean
> init_header_complete() and check_image_kernel()), and then all the
> #ifdefs can just go.

Well, I don't like the "weak symbols" stuff, but I have managed to limit the
number of additional #ifdefs in snapshot.c to just one.

The "generic" patch is now the following:

---
From: Rafael J. Wysocki <rjw@sisk.pl>

Add the bits needed for supporting arbitrary boot kernels to the common
hibernation code.

To support arbitrary boot kernels, make it possible to replace the 'struct
new_utsname' and the kernel version in the hibernation image header by some
architecture specific data that will be used to verify if the image is valid
and to restore the image.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/power.h    |   20 +++++++++++++++++-
 kernel/power/snapshot.c |   53 +++++++++++++++++++++++++++++++-----------------
 2 files changed, 54 insertions(+), 19 deletions(-)

Index: linux-2.6.23-rc3/kernel/power/power.h
===================================================================
--- linux-2.6.23-rc3.orig/kernel/power/power.h	2007-08-23 23:13:34.000000000 +0200
+++ linux-2.6.23-rc3/kernel/power/power.h	2007-08-25 21:18:59.000000000 +0200
@@ -11,14 +11,32 @@ struct swsusp_info {
 	unsigned long		size;
 } __attribute__((aligned(PAGE_SIZE)));
 
+#ifdef CONFIG_HIBERNATION
+#ifdef CONFIG_ARCH_HIBERNATION_HEADER
+/* Maximum size of architecture specific data in a hibernation header */
+#define MAX_ARCH_HEADER_SIZE	(sizeof(struct new_utsname) + 4)
 
+extern int arch_hibernation_header_save(void *addr, unsigned int max_size);
+extern int arch_hibernation_header_restore(void *addr);
+
+static inline int init_header_complete(struct swsusp_info *info)
+{
+	return arch_hibernation_header_save(info, MAX_ARCH_HEADER_SIZE);
+}
+
+static inline char *check_image_kernel(struct swsusp_info *info)
+{
+	return arch_hibernation_header_restore(info) ?
+			"architecture specific data" : NULL;
+}
+#endif /* CONFIG_ARCH_HIBERNATION_HEADER */
 
-#ifdef CONFIG_HIBERNATION
 /*
  * Keep some memory free so that I/O operations can succeed without paging
  * [Might this be more than 4 MB?]
  */
 #define PAGES_FOR_IO	((4096 * 1024) >> PAGE_SHIFT)
+
 /*
  * Keep 1 MB of memory free so that device drivers can allocate some pages in
  * their .suspend() routines without breaking the suspend to disk.
Index: linux-2.6.23-rc3/kernel/power/snapshot.c
===================================================================
--- linux-2.6.23-rc3.orig/kernel/power/snapshot.c	2007-08-23 23:13:34.000000000 +0200
+++ linux-2.6.23-rc3/kernel/power/snapshot.c	2007-08-25 21:21:55.000000000 +0200
@@ -1239,17 +1239,39 @@ asmlinkage int swsusp_save(void)
 	return 0;
 }
 
-static void init_header(struct swsusp_info *info)
+#ifndef CONFIG_ARCH_HIBERNATION_HEADER
+static int init_header_complete(struct swsusp_info *info)
 {
-	memset(info, 0, sizeof(struct swsusp_info));
+	memcpy(&info->uts, init_utsname(), sizeof(struct new_utsname));
 	info->version_code = LINUX_VERSION_CODE;
+	return 0;
+}
+
+static char *check_image_kernel(struct swsusp_info *info)
+{
+	if (info->version_code != LINUX_VERSION_CODE)
+		return "kernel version";
+	if (strcmp(info->uts.sysname,init_utsname()->sysname))
+		return "system type";
+	if (strcmp(info->uts.release,init_utsname()->release))
+		return "kernel release";
+	if (strcmp(info->uts.version,init_utsname()->version))
+		return "version";
+	if (strcmp(info->uts.machine,init_utsname()->machine))
+		return "machine";
+	return NULL;
+}
+#endif /* CONFIG_ARCH_HIBERNATION_HEADER */
+
+static int init_header(struct swsusp_info *info)
+{
+	memset(info, 0, sizeof(struct swsusp_info));
 	info->num_physpages = num_physpages;
-	memcpy(&info->uts, init_utsname(), sizeof(struct new_utsname));
-	info->cpus = num_online_cpus();
 	info->image_pages = nr_copy_pages;
 	info->pages = nr_copy_pages + nr_meta_pages + 1;
 	info->size = info->pages;
 	info->size <<= PAGE_SHIFT;
+	return init_header_complete(info);
 }
 
 /**
@@ -1303,7 +1325,11 @@ int snapshot_read_next(struct snapshot_h
 			return -ENOMEM;
 	}
 	if (!handle->offset) {
-		init_header((struct swsusp_info *)buffer);
+		int error;
+
+		error = init_header((struct swsusp_info *)buffer);
+		if (error)
+			return error;
 		handle->buffer = buffer;
 		memory_bm_position_reset(&orig_bm);
 		memory_bm_position_reset(&copy_bm);
@@ -1394,22 +1420,13 @@ duplicate_memory_bitmap(struct memory_bi
 	}
 }
 
-static inline int check_header(struct swsusp_info *info)
+static int check_header(struct swsusp_info *info)
 {
-	char *reason = NULL;
+	char *reason;
 
-	if (info->version_code != LINUX_VERSION_CODE)
-		reason = "kernel version";
-	if (info->num_physpages != num_physpages)
+	reason = check_image_kernel(info);
+	if (!reason && info->num_physpages != num_physpages)
 		reason = "memory size";
-	if (strcmp(info->uts.sysname,init_utsname()->sysname))
-		reason = "system type";
-	if (strcmp(info->uts.release,init_utsname()->release))
-		reason = "kernel release";
-	if (strcmp(info->uts.version,init_utsname()->version))
-		reason = "version";
-	if (strcmp(info->uts.machine,init_utsname()->machine))
-		reason = "machine";
 	if (reason) {
 		printk(KERN_ERR "swsusp: Resume mismatch: %s\n", reason);
 		return -EPERM;
