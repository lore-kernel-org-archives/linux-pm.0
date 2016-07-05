From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / hibernate: Image data protection during restoration
Date: Tue, 05 Jul 2016 14:34:38 +0200
Message-ID: <2964021.nluHKyP5cW@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make it possible to protect all pages holding image data during
hibernate image restoration by marking them read-only (so as to
catch attempts to write to those pages after image data have been
stored in them).

This adds overhead to image restoration code (it may cause large
page mappings to be split as a result of page flags changes) and
the errors it protects against should never happen in theory, so
the feature is only active after passing hibernate=protect_image
to the command line of the restore kernel.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/kernel-parameters.txt |    3 +++
 kernel/power/hibernate.c            |    2 ++
 kernel/power/power.h                |    3 +++
 kernel/power/snapshot.c             |   30 ++++++++++++++++++++++++++++++
 4 files changed, 38 insertions(+)

Index: linux-pm/kernel/power/snapshot.c
===================================================================
--- linux-pm.orig/kernel/power/snapshot.c
+++ linux-pm/kernel/power/snapshot.c
@@ -38,6 +38,31 @@
 
 #include "power.h"
 
+bool hibernate_restore_protection;
+static bool hibernate_restore_protection_active;
+
+static inline void hibernate_restore_protection_begin(void)
+{
+	hibernate_restore_protection_active = hibernate_restore_protection;
+}
+
+static inline void hibernate_restore_protection_end(void)
+{
+	hibernate_restore_protection_active = false;
+}
+
+static inline void hibernate_restore_protect_page(void *page_address)
+{
+	if (hibernate_restore_protection_active)
+		set_memory_ro((unsigned long)page_address, 1);
+}
+
+static inline void hibernate_restore_unprotect_page(void *page_address)
+{
+	if (hibernate_restore_protection_active)
+		set_memory_rw((unsigned long)page_address, 1);
+}
+
 static int swsusp_page_is_free(struct page *);
 static void swsusp_set_page_forbidden(struct page *);
 static void swsusp_unset_page_forbidden(struct page *);
@@ -1407,6 +1432,7 @@ loop:
 
 		memory_bm_clear_current(forbidden_pages_map);
 		memory_bm_clear_current(free_pages_map);
+		hibernate_restore_unprotect_page(page_address(page));
 		__free_page(page);
 		goto loop;
 	}
@@ -1418,6 +1444,7 @@ out:
 	buffer = NULL;
 	alloc_normal = 0;
 	alloc_highmem = 0;
+	hibernate_restore_protection_end();
 }
 
 /* Helper functions used for the shrinking of memory. */
@@ -2532,6 +2559,7 @@ int snapshot_write_next(struct snapshot_
 		if (error)
 			return error;
 
+		hibernate_restore_protection_begin();
 	} else if (handle->cur <= nr_meta_pages + 1) {
 		error = unpack_orig_pfns(buffer, &copy_bm);
 		if (error)
@@ -2554,6 +2582,7 @@ int snapshot_write_next(struct snapshot_
 		copy_last_highmem_page();
 		/* Restore page key for data page (s390 only). */
 		page_key_write(handle->buffer);
+		hibernate_restore_protect_page(handle->buffer);
 		handle->buffer = get_buffer(&orig_bm, &ca);
 		if (IS_ERR(handle->buffer))
 			return PTR_ERR(handle->buffer);
@@ -2578,6 +2607,7 @@ void snapshot_write_finalize(struct snap
 	/* Restore page key for data page (s390 only). */
 	page_key_write(handle->buffer);
 	page_key_free();
+	hibernate_restore_protect_page(handle->buffer);
 	/* Do that only if we have loaded the image entirely */
 	if (handle->cur > 1 && handle->cur > nr_meta_pages + nr_copy_pages) {
 		memory_bm_recycle(&orig_bm);
Index: linux-pm/kernel/power/hibernate.c
===================================================================
--- linux-pm.orig/kernel/power/hibernate.c
+++ linux-pm/kernel/power/hibernate.c
@@ -1126,6 +1126,8 @@ static int __init hibernate_setup(char *
 	else if (!strncmp(str, "no", 2)) {
 		noresume = 1;
 		nohibernate = 1;
+	} else if (!strncmp(str, "protect_image", 13)) {
+		hibernate_restore_protection = true;
 	}
 	return 1;
 }
Index: linux-pm/kernel/power/power.h
===================================================================
--- linux-pm.orig/kernel/power/power.h
+++ linux-pm/kernel/power/power.h
@@ -59,6 +59,9 @@ extern int hibernation_snapshot(int plat
 extern int hibernation_restore(int platform_mode);
 extern int hibernation_platform_enter(void);
 
+/* kernel/power/snapshot.c */
+extern bool hibernate_restore_protection;
+
 #else /* !CONFIG_HIBERNATION */
 
 static inline void hibernate_reserved_size_init(void) {}
Index: linux-pm/Documentation/kernel-parameters.txt
===================================================================
--- linux-pm.orig/Documentation/kernel-parameters.txt
+++ linux-pm/Documentation/kernel-parameters.txt
@@ -3597,6 +3597,9 @@ bytes respectively. Such letter suffixes
 				present during boot.
 		nocompress	Don't compress/decompress hibernation images.
 		no		Disable hibernation and resume.
+		protect_image	Turn on image protection during restoration
+				(that will mark all pages holding image data
+				during restoration as read-only).
 
 	retain_initrd	[RAM] Keep initrd memory after extraction
 
