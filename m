From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PM / Hibernate: Reduce autotuned default image
	size
Date: Tue, 15 Mar 2011 00:42:23 +0100
Message-ID: <201103150042.23288.rjw__48313.994651153$1300146246$gmane$org@sisk.pl>
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
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The hibernate image size autotuning mechanism sets the default
image size to 5/2 of the total system RAM, but it is reported
that on some systems device drivers allocate substantial
amounts of memory during suspend and the creation of the image
fails as a result (too little memory is preallocated).

Modify the autotuning mechanism to use 1/3 instead of 2/5 of RAM
as the default image size, which is reported to be sufficient for
the affected systems.

References: https://bugzilla.kernel.org/show_bug.cgi?id=30482
Reported-and-tested-by: Martin Steigerwald <Martin@Lichtvoll.de>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/snapshot.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6/kernel/power/snapshot.c
===================================================================
--- linux-2.6.orig/kernel/power/snapshot.c
+++ linux-2.6/kernel/power/snapshot.c
@@ -42,15 +42,15 @@ static void swsusp_unset_page_forbidden(
 
 /*
  * Preferred image size in bytes (tunable via /sys/power/image_size).
- * When it is set to N, swsusp will do its best to ensure the image
- * size will not exceed N bytes, but if that is impossible, it will
- * try to create the smallest image possible.
+ * When it is set to N, the image creating code will do its best to
+ * ensure the image size will not exceed N bytes, but if that is
+ * impossible, it will try to create the smallest image possible.
  */
 unsigned long image_size;
 
 void __init hibernate_image_size_init(void)
 {
-	image_size = ((totalram_pages * 2) / 5) * PAGE_SIZE;
+	image_size = (totalram_pages / 3) * PAGE_SIZE;
 }
 
 /* List of PBEs needed for restoring the pages that were allocated before
