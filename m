From: Bojan Smojver <bojan@rexursive.com>
Subject: [PATCH 2/2] PM: Compress hibernation image with LZO
Date: Tue, 10 Aug 2010 12:29:49 +1000
Message-ID: <1281407389.2618.53.camel@shrek.rexursive.com>
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
To: Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Please queue for merge in 2.6.36.
---------------------

Given that hibernation image is compressed, we need the data here and
now in order to decompress it, so a flag to read synchronously is
redundant (i.e. we always read synchronously).

Signed-off-by: Bojan Smojver <bojan@rexursive.com>
---

 kernel/power/power.h    |    4 ----
 kernel/power/snapshot.c |    5 -----
 2 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/kernel/power/power.h b/kernel/power/power.h
index 006270f..a760cf8 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -103,10 +103,6 @@ struct snapshot_handle {
 	void		*buffer;	/* address of the block to read from
 					 * or write to
 					 */
-	int		sync_read;	/* Set to one to notify the caller of
-					 * snapshot_write_next() that it may
-					 * need to call wait_on_bio_chain()
-					 */
 };
 
 /* This macro returns the address from/to which the caller of
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 25ce010..f24ee24 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -2135,8 +2135,6 @@ int snapshot_write_next(struct snapshot_handle *handle)
 	if (handle->cur > 1 && handle->cur > nr_meta_pages + nr_copy_pages)
 		return 0;
 
-	handle->sync_read = 1;
-
 	if (!handle->cur) {
 		if (!buffer)
 			/* This makes the buffer be freed by swsusp_free() */
@@ -2169,7 +2167,6 @@ int snapshot_write_next(struct snapshot_handle *handle)
 			memory_bm_position_reset(&orig_bm);
 			restore_pblist = NULL;
 			handle->buffer = get_buffer(&orig_bm, &ca);
-			handle->sync_read = 0;
 			if (IS_ERR(handle->buffer))
 				return PTR_ERR(handle->buffer);
 		}
@@ -2178,8 +2175,6 @@ int snapshot_write_next(struct snapshot_handle *handle)
 		handle->buffer = get_buffer(&orig_bm, &ca);
 		if (IS_ERR(handle->buffer))
 			return PTR_ERR(handle->buffer);
-		if (handle->buffer != buffer)
-			handle->sync_read = 0;
 	}
 	handle->cur++;
 	return PAGE_SIZE;


-- 
Bojan
