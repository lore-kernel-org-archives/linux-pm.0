From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Patch 2/2: Add compression support to swsusp.
Date: Mon, 06 Jul 2009 15:46:37 +1000
Message-ID: <4A518FBD.7050102__31326.6670833857$1246859298$gmane$org@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Rafael Wysocki <rjw@sisk.pl>, TuxOnIce-devel <tuxonice-devel@lists.tuxonice.net>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

>From 6fa7e053c9b37ffd3e329785bb37b96e4185f155 Mon Sep 17 00:00:00 2001
From: Nigel Cunningham <nigel@tuxonice.net>
Date: Mon, 6 Jul 2009 14:05:39 +1000
Subject: [PATCH] Hibernation: Add compression support.

Add support for compressing pages using the LZO cryptoapi algorithm.
Since this algorithm usually achieves approximately 60% compression,
allow ourselves to overcommit the available swap a little - assume
compression of at least 40% will be achieved when deciding if we
have enough swapspace available.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
---
 kernel/power/Kconfig     |   16 ++++++
 kernel/power/Makefile    |    1 +
 kernel/power/compress.c  |  125 ++++++++++++++++++++++++++++++++++++++++++++++
 kernel/power/hibernate.c |   12 ++++
 kernel/power/power.h     |   27 ++++++++++
 kernel/power/swap.c      |   10 +++-
 6 files changed, 189 insertions(+), 2 deletions(-)
 create mode 100644 kernel/power/compress.c

diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 72067cb..041e266 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -183,6 +183,22 @@ config PM_STD_PARTITION
 	  suspended image to. It will simply pick the first available swap 
 	  device.
 
+config HIBERNATION_COMPRESSION
+	bool "Compression support"
+	depends on HIBERNATION && CRYPTO
+	select CRYPTO_LZO
+	default y
+	---help---
+	  This option adds support for using cryptoapi LZO compression
+	  algorithm. Compression is particularly useful as it can
+	  more than double your hibernation speed (depending
+	  upon how well your image compresses).
+
+	  You probably want this, so say Y here.
+
+comment "No compression support available without Cryptoapi support."
+	depends on HIBERNATION && !CRYPTO
+
 config APM_EMULATION
 	tristate "Advanced Power Management Emulation"
 	depends on PM && SYS_SUPPORTS_APM_EMULATION
diff --git a/kernel/power/Makefile b/kernel/power/Makefile
index c3b81c3..c341a8e 100644
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -10,5 +10,6 @@ obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_PM_TEST_SUSPEND)	+= suspend_test.o
 obj-$(CONFIG_HIBERNATION)	+= swsusp.o hibernate.o snapshot.o swap.o user.o
 obj-$(CONFIG_HIBERNATION_NVS)	+= hibernate_nvs.o
+obj-${CONFIG_HIBERNATION_COMPRESSION} += compress.o
 
 obj-$(CONFIG_MAGIC_SYSRQ)	+= poweroff.o
diff --git a/kernel/power/compress.c b/kernel/power/compress.c
new file mode 100644
index 0000000..bb508e2
--- /dev/null
+++ b/kernel/power/compress.c
@@ -0,0 +1,125 @@
+/*
+ * kernel/power/compression.c
+ *
+ * Copyright (C) 2003-2009 Nigel Cunningham (nigel at tuxonice net)
+ *
+ * This file is released under the GPLv2.
+ *
+ * This file contains data compression routines for hibernation,
+ * using cryptoapi.
+ */
+
+#include <linux/vmalloc.h>
+#include <linux/crypto.h>
+
+static const char hibernate_compressor_name[32] = "lzo";
+
+static struct crypto_comp *transform;
+static unsigned int len;
+static char *output_buffer;
+
+/*
+ * hibernate_compress_cleanup
+ *
+ * Frees memory allocated for our labours.
+ */
+void hibernate_compress_cleanup(void)
+{
+	if (transform) {
+		crypto_free_comp(transform);
+		transform = NULL;
+	}
+
+	if (output_buffer) {
+		vfree(output_buffer);
+		output_buffer = NULL;
+	}
+}
+
+/*
+ * hibernate_crypto_prepare
+ *
+ * Prepare to do some work by allocating buffers and transforms.
+ */
+int hibernate_compress_prepare(void)
+{
+	transform = crypto_alloc_comp(hibernate_compressor_name, 0, 0);
+	if (IS_ERR(transform)) {
+		printk(KERN_INFO "Hibernation: Failed to initialise the "
+				"%s compression transform.\n",
+				hibernate_compressor_name);
+		transform = NULL;
+		return 1;
+	}
+
+	output_buffer = (char *) vmalloc_32(2 * PAGE_SIZE);
+
+	if (!output_buffer) {
+		printk(KERN_ERR "Failed to allocate a output buffer for "
+				"hibernation compression support.\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+
+/*
+ * hibernate_compress_write_page()
+ *
+ * Compress a page of data, buffering output and passing on filled
+ * pages to the next module in the pipeline.
+ *
+ * Buffer_page:	Pointer to a buffer of size PAGE_SIZE, containing
+ * data to be compressed.
+ *
+ * Returns:	0 on success. Otherwise the error is that returned by later
+ * 		modules, -ECHILD if we have a broken pipeline or -EIO if
+ * 		zlib errs.
+ */
+int hibernate_compress_page(void *buffer_page)
+{
+	int ret;
+
+	len = PAGE_SIZE;
+
+	ret = crypto_comp_compress(transform, buffer_page, PAGE_SIZE,
+			output_buffer, &len);
+
+	if (!ret && len < PAGE_SIZE) { /* some compression */
+		memcpy(buffer_page, output_buffer, len);
+		return len;
+	} else
+		return PAGE_SIZE;
+}
+
+/*
+ * hibernate_compress_read_page()
+ * @buffer_page: struct page *. Pointer to a buffer of size PAGE_SIZE.
+ *
+ * Retrieve data from later modules and decompress it until the input buffer
+ * is filled.
+ * Zero if successful. Error condition from me or from downstream on failure.
+ */
+int hibernate_decompress_page(char *buffer_start, unsigned int len)
+{
+	unsigned int outlen = PAGE_SIZE;
+	int ret;
+
+	/* Error or uncompressed data */
+	if (len == PAGE_SIZE)
+		return 0;
+
+	memcpy(output_buffer, buffer_start, len);
+	ret = crypto_comp_decompress(transform, output_buffer, len, buffer_start,
+			&outlen);
+	if (ret)
+		printk(KERN_ERR "Hibernation: Decompression returned %d.\n",
+				ret);
+	else if (outlen != PAGE_SIZE) {
+		printk(KERN_ERR "Decompression yielded %d bytes instead of "
+				"%ld.\n", outlen, PAGE_SIZE);
+		ret = -EIO;
+	}
+	return ret;
+}
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 81d2e74..238266d 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -550,6 +550,11 @@ int hibernate(void)
 	}
 
 	pm_prepare_console();
+
+	error = hibernate_compress_prepare();
+	if (error)
+		goto Exit;
+
 	error = pm_notifier_call_chain(PM_HIBERNATION_PREPARE);
 	if (error)
 		goto Exit;
@@ -599,6 +604,7 @@ int hibernate(void)
 	usermodehelper_enable();
  Exit:
 	pm_notifier_call_chain(PM_POST_HIBERNATION);
+	hibernate_compress_cleanup();
 	pm_restore_console();
 	atomic_inc(&snapshot_device_available);
  Unlock:
@@ -690,6 +696,11 @@ static int software_resume(void)
 	}
 
 	pm_prepare_console();
+
+	error = hibernate_compress_prepare();
+	if (error)
+		goto Finish;
+
 	error = pm_notifier_call_chain(PM_RESTORE_PREPARE);
 	if (error)
 		goto Finish;
@@ -723,6 +734,7 @@ static int software_resume(void)
 	usermodehelper_enable();
  Finish:
 	pm_notifier_call_chain(PM_POST_RESTORE);
+	hibernate_compress_cleanup();
 	pm_restore_console();
 	atomic_inc(&snapshot_device_available);
 	/* For success case, the suspend path will release the lock */
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 26d5a26..5e7813f 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -49,6 +49,33 @@ static inline char *check_image_kernel(struct swsusp_info *info)
 extern int hibernation_snapshot(int platform_mode);
 extern int hibernation_restore(int platform_mode);
 extern int hibernation_platform_enter(void);
+
+#ifdef CONFIG_HIBERNATION_COMPRESSION
+void hibernate_compress_cleanup(void);
+int hibernate_compress_prepare(void);
+int hibernate_compress_page(char *page);
+int hibernate_decompress_page(char *page, int size);
+#else
+static void hibernate_compress_cleanup(void)
+{
+}
+
+static int hibernate_compress_prepare(void)
+{
+	return 0;
+}
+
+static int hibernate_compress_page(void *buffer)
+{
+	return PAGE_SIZE;
+}
+
+static int hibernate_decompress_page(void *buffer, int size)
+{
+	return PAGE_SIZE;
+}
+
+#endif
 #endif
 
 extern int pfn_is_nosave(unsigned long);
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 260c622..22aa4d3 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -393,7 +393,7 @@ static int save_image(struct swap_map_handle *handle,
 	do {
 		ret = snapshot_read_next(snapshot, PAGE_SIZE);
 		if (ret > 0) {
-			int bytes = PAGE_SIZE;
+			int bytes = hibernate_compress_page(data_of(*snapshot));
 
 			/*
 			 * Write the size of the (possibly) compressed data and
@@ -430,6 +430,8 @@ static int save_image(struct swap_map_handle *handle,
  *
  *	Returns TRUE or FALSE after checking the total amount of swap
  *	space avaiable from the resume partition.
+ *
+ *	Assumes compression of at least 40% will be achieved.
  */
 
 static int enough_swap(unsigned int nr_pages)
@@ -437,7 +439,7 @@ static int enough_swap(unsigned int nr_pages)
 	unsigned int free_swap = count_swap_pages(root_swap, 1);
 
 	pr_debug("PM: Free swap pages: %u\n", free_swap);
-	return free_swap > (nr_pages + PAGES_FOR_IO) * 1.01;
+	return free_swap > (nr_pages + PAGES_FOR_IO) * .6;
 }
 
 /**
@@ -608,8 +610,12 @@ static int load_image(struct swap_map_handle *handle,
 				handle, &bio);
 		if (error)
 			break;
+
 		if (snapshot->sync_read)
 			error = wait_on_bio_chain(&bio);
+
+		error = hibernate_decompress_page(data_of(*snapshot), bytes);
+
 		if (error)
 			break;
 		if (!(nr_pages % m))
-- 
1.6.0.4
