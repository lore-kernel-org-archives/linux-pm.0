From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [RFC 09/15] PM / Hibernate: user,
	implement user_ops writer
Date: Wed, 21 Apr 2010 23:22:07 +0200
Message-ID: <4BCF6C7F.7020807@gmail.com>
References: <1269361063-3341-1-git-send-email-jslaby@suse.cz>
	<201003302250.26105.rjw@sisk.pl> <4BB35F1C.4030100@gmail.com>
	<201003312229.18142.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010001010005020905070602"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201003312229.18142.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------010001010005020905070602
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

On 03/31/2010 10:29 PM, Rafael J. Wysocki wrote:
> On Wednesday 31 March 2010, Jiri Slaby wrote:
>> On 03/30/2010 10:50 PM, Rafael J. Wysocki wrote:
>>> So, I definitely would like to see numbers.
>>
>> With the patch attached, I get similar results for
>> uncompressed image -> user.c -> s2disk (compress+threads)
>> compressed image -> user.c -> s2disk (none of compress+threads)
>>
>> BUT note that there are differences in pages _copied_ in the "user.c ->
>> s2disk" phase. Compression was about 40 %. So in the former case 100000
>> pages went through and in the latter one only ~ 38000. So presumably
>> there will be savings if the pages are compressed in the kernel in the
>> save-image phase instead of in userspace.
>>
>> I'll test (after I hack that up) also the case of image compression when
>> saving the image and let you know.
>>
>> It was tested on a machine with openSUSE factory with init 5 with KDE 4.
>> The memory consumption was ~ 400M (100000 pages) after boot every time.
>> Hibernation lasted 12-13s in both cases.
> 
> So that's pretty much the same and I don't think feeding compressed images to
> s2disk is not worth the effort.  Let's assume s2disk will always receive a raw
> image (that will make it backwards compatible too).

Hi.

Yes, I did it solely for comparison purposes.

Now, with the patch attached (depending on either COMPRESS_IMAGE or
COMPRESS_IMAGE1 defined) I tried to compare compression while doing
atomic copy with compression done when image storage takes place. The
latter outperformed the former a bit. I did 8 measurements with the
setup same as above. The average for them is 9684.32 and 10855.07 stored
raw (uncompressed) pages per second. That is 4.5M/s more.

There is a sheet with the numbers at:
http://spreadsheets.google.com/ccc?key=0AvVn7xYA1DnodHFFYzg3Y2tpMUl5NFlURXRtR0xQdmc&hl=en

regards,
-- 
js

--------------010001010005020905070602
Content-Type: text/x-patch;
 name="compress-image.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="compress-image.patch"

---
 kernel/power/snapshot.c |   80 +++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index ea7bd50..d702953 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -39,6 +39,7 @@
 
 static void *lzo_buf;
 static void *page_buf;
+static void *chunk_buf;
 struct timeval hib_start_time;
 
 static int swsusp_page_is_free(struct page *);
@@ -1339,8 +1340,12 @@ int hibernate_preallocate_memory(void)
 		page_buf = (void *)__get_free_pages(GFP_KERNEL,
 				get_order(lzo1x_worst_compress(PAGE_SIZE)));
 
+	if (!chunk_buf)
+		chunk_buf = (void *)__get_free_page(GFP_KERNEL);
+
 	BUG_ON(!lzo_buf);
 	BUG_ON(!page_buf);
+	BUG_ON(!chunk_buf);
 
 	printk(KERN_INFO "PM: Preallocating image memory... ");
 	do_gettimeofday(&start);
@@ -2333,6 +2338,73 @@ static int snapshot_image_loaded(struct snapshot_handle *handle)
 			handle->cur < nr_meta_pages + nr_copy_pages);
 }
 
+static void wwwrite(struct bio **bio, const char *buffer, int buffer_size)
+{
+	static unsigned long dst_page_pos;
+	int bytes_left = buffer_size;
+
+	while (bytes_left) {
+		const char *from = buffer + buffer_size - bytes_left;
+		char *to = chunk_buf + dst_page_pos;
+		int capacity = PAGE_SIZE - dst_page_pos;
+		int n;
+
+//		printk("%s: to=%p from=%p\n", __func__, to, from);
+		if (bytes_left <= capacity) {
+			for (n = 0; n < bytes_left; n++)
+				to[n] = from[n];
+			dst_page_pos += bytes_left;
+			return;
+		}
+
+		/* Complete this page and start a new one */
+		for (n = 0; n < capacity; n++)
+			to[n] = from[n];
+		bytes_left -= capacity;
+
+		BUG_ON(hibernate_io_ops->write_page(chunk_buf, bio));
+
+		dst_page_pos = 0;
+	}
+}
+
+#define COMPRESS_IMAGE1 1
+
+/* This is needed, because copy_page and memcpy are not usable for copying
+ * task structs.
+ */
+static unsigned long do_write_page(struct bio **bio,
+		const unsigned char *src)
+{
+//	static int first = true;
+#if COMPRESS_IMAGE1
+	size_t dst_len;
+	int ret;
+
+//	printk("%s: %p\n", __func__, page_buf);
+	ret = lzo1x_1_compress(src, PAGE_SIZE, page_buf, &dst_len, lzo_buf);
+	if (ret < 0) {
+		printk(KERN_EMERG "%s: compress failed: ret=%d dst_len=%zu\n",
+				__func__, ret, dst_len);
+		BUG();
+	}
+
+	wwwrite(bio, (char *)&dst_len, sizeof(dst_len));
+	wwwrite(bio, page_buf, dst_len);
+
+	return sizeof(dst_len) + dst_len;
+#else
+	wwwrite(bio, src, PAGE_SIZE);
+	return PAGE_SIZE;
+#endif
+
+/*	if (first) {
+		print_hex_dump_bytes("O:", DUMP_PREFIX_OFFSET, src, PAGE_SIZE);
+		printk(KERN_DEBUG "len=%zu\n", dst_len);
+		print_hex_dump_bytes("N:", DUMP_PREFIX_OFFSET, dst, dst_len);
+		first = false;
+	}*/
+}
 /**
  *	save_image - save the suspend image data
  */
@@ -2340,6 +2412,7 @@ static int snapshot_image_loaded(struct snapshot_handle *handle)
 static int save_image(struct snapshot_handle *snapshot,
                       unsigned int nr_to_write)
 {
+	unsigned long whole = 0;
 	unsigned int m;
 	int ret;
 	int nr_pages;
@@ -2360,9 +2433,10 @@ static int save_image(struct snapshot_handle *snapshot,
 		ret = snapshot_read_next(snapshot);
 		if (ret <= 0)
 			break;
-		ret = hibernate_io_ops->write_page(data_of(*snapshot), &bio);
+		whole += do_write_page(&bio, data_of(*snapshot));
+/*		ret = hibernate_io_ops->write_page(data_of(*snapshot), &bio);
 		if (ret)
-			break;
+			break;*/
 		if (!(nr_pages % m))
 			printk(KERN_CONT "\b\b\b\b%3d%%", nr_pages / m);
 		nr_pages++;
@@ -2372,7 +2446,7 @@ static int save_image(struct snapshot_handle *snapshot,
 	if (!ret)
 		ret = err2;
 	if (!ret)
-		printk(KERN_CONT "\b\b\b\bdone\n");
+		printk(KERN_CONT "\b\b\b\bdone\n%lu of %d\n", DIV_ROUND_UP(whole, PAGE_SIZE), nr_pages);
 	else
 		printk(KERN_CONT "\n");
 	swsusp_show_speed(&start, &stop, nr_to_write, "Wrote");
-- 
1.7.0.3


--------------010001010005020905070602
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010001010005020905070602--
