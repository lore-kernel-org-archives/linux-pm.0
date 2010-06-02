From: Nigel Cunningham <nigel@tuxonice.net>
Subject: [PATCH 11/21] Hibernation: Partial page I/O support.
Date: Wed,  2 Jun 2010 22:19:10 +1000
Message-ID: <1275481160-31150-12-git-send-email-nigel__20712.2778789655$1275481840$gmane$org@tuxonice.net>
References: <1275481160-31150-1-git-send-email-nigel@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275481160-31150-1-git-send-email-nigel@tuxonice.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

Add functions that can be used for coalescing and splitting buffers
that are smaller than PAGE_SIZE. These functions provide no method
of determining where the boundaries of the smaller buffers are to
be found - that is the caller's problem.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
---
 kernel/power/block_io.c |   90 +++++++++++++++++++++++++++++++++++++++++++++++
 kernel/power/block_io.h |    4 ++
 2 files changed, 94 insertions(+), 0 deletions(-)

diff --git a/kernel/power/block_io.c b/kernel/power/block_io.c
index c449db2..0e57776 100644
--- a/kernel/power/block_io.c
+++ b/kernel/power/block_io.c
@@ -17,6 +17,11 @@
 
 static struct bio *bio_chain;
 
+static char *hib_ppio_buffer;
+static int hib_ppio_buffer_posn;
+int hib_prepare_buffer(void);
+void hib_free_buffer(void);
+
 /**
  *	submit - submit BIO request.
  *	@rw:	READ or WRITE.
@@ -301,3 +306,88 @@ int swap_read_page(void *buf, int sync)
 	}
 	return error;
 }
+
+/* Part Page I/O functions */
+static char *hib_ppio_buffer;
+static int hib_ppio_buffer_posn;
+
+int hib_prepare_buffer(void)
+{
+	hib_ppio_buffer = (char *)__get_free_page(__GFP_WAIT);
+	hib_ppio_buffer_posn = 0;
+	return hib_ppio_buffer ? 0 : -ENOMEM;
+}
+
+void hib_free_buffer(void)
+{
+	if (!hib_ppio_buffer)
+		return;
+
+	free_page((unsigned long) hib_ppio_buffer);
+	hib_ppio_buffer = NULL;
+}
+
+int hib_flush_write_buffer(void)
+{
+	return hib_ppio_buffer_posn ? swap_write_page(hib_ppio_buffer, 0) : 0;
+}
+
+int hib_write_buffer(char *buffer, int buffer_size)
+{
+	int bytes_left = buffer_size, result = 0;
+
+	while (bytes_left) {
+		char *from = buffer + buffer_size - bytes_left;
+		char *to = hib_ppio_buffer + hib_ppio_buffer_posn;
+		int capacity = PAGE_SIZE - hib_ppio_buffer_posn;
+
+		if (bytes_left <= capacity) {
+			memcpy(to, from, bytes_left);
+			hib_ppio_buffer_posn += bytes_left;
+			return 0;
+		}
+
+		/* Complete this page and start a new one */
+		memcpy(to, from, capacity);
+		bytes_left -= capacity;
+
+		result = swap_write_page(hib_ppio_buffer, 0);
+		if (result)
+			return result;
+
+		hib_ppio_buffer_posn = 0;
+	}
+
+	return 0;
+}
+
+int hib_read_buffer(char *buffer, int buffer_size)
+{
+	int bytes_left = buffer_size, result = 0;
+
+	while (bytes_left) {
+		char *to = buffer + buffer_size - bytes_left;
+		char *from = hib_ppio_buffer + hib_ppio_buffer_posn;
+		int capacity = PAGE_SIZE - hib_ppio_buffer_posn;
+
+		if (bytes_left <= capacity) {
+			memcpy(to, from, bytes_left);
+			hib_ppio_buffer_posn += bytes_left;
+			return 0;
+		}
+
+		/* Complete this page and start a new one */
+		memcpy(to, from, capacity);
+		bytes_left -= capacity;
+
+		result = swap_read_page(hib_ppio_buffer, 1);
+		if (result) {
+			printk("swap_read_page returned %d.\n", result);
+			return result;
+		}
+
+		hib_ppio_buffer_posn = 0;
+	}
+
+	return 0;
+}
diff --git a/kernel/power/block_io.h b/kernel/power/block_io.h
index 2f91d6d..ac378c5 100644
--- a/kernel/power/block_io.h
+++ b/kernel/power/block_io.h
@@ -21,3 +21,7 @@ int swap_write_page(void *buf, int sync);
 int get_swap_reader(unsigned int *flags_p, sector_t first_page);
 void release_swap_reader(void);
 int swap_read_page(void *buf, int sync);
+int hib_flush_write_buffer(void);
+
+int hib_write_buffer(char *buffer, int len);
+int hib_read_buffer(char *buffer, int len);
-- 
1.7.0.4
