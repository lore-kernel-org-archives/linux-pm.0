From: Jiri Slaby <jirislaby@gmail.com>
Subject: [PATCH 1/1] SWSUSP: fix blkdev refleaks
Date: Fri,  2 Oct 2009 18:12:46 +0200
Message-ID: <1254499966-4806-1-git-send-email-jirislaby__27632.1315941916$1254500037$gmane$org@gmail.com>
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
To: len.brown@intel.com
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

While cruising through the swsusp code I found few blkdev reference
leaks of resume_bdev.

swsusp_read: remove blkdev_put altogether. Some fail paths do
             not do that.
swsusp_check: make sure we always put a reference on fail paths
software_resume: all fail paths between swsusp_check and swsusp_read
                 omit swsusp_close. Add it in those cases. And since
                 swsusp_read doesn't drop the reference anymore, do
                 it here unconditionally.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/hibernate.c |   11 ++++++++---
 kernel/power/swap.c      |   10 ++++------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 04b3a83..04a9e90 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -693,21 +693,22 @@ static int software_resume(void)
 	/* The snapshot device should not be opened while we're running */
 	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
 		error = -EBUSY;
+		swsusp_close(FMODE_READ);
 		goto Unlock;
 	}
 
 	pm_prepare_console();
 	error = pm_notifier_call_chain(PM_RESTORE_PREPARE);
 	if (error)
-		goto Finish;
+		goto close_finish;
 
 	error = usermodehelper_disable();
 	if (error)
-		goto Finish;
+		goto close_finish;
 
 	error = create_basic_memory_bitmaps();
 	if (error)
-		goto Finish;
+		goto close_finish;
 
 	pr_debug("PM: Preparing processes for restore.\n");
 	error = prepare_processes();
@@ -719,6 +720,7 @@ static int software_resume(void)
 	pr_debug("PM: Reading hibernation image.\n");
 
 	error = swsusp_read(&flags);
+	swsusp_close(FMODE_READ);
 	if (!error)
 		hibernation_restore(flags & SF_PLATFORM_MODE);
 
@@ -737,6 +739,9 @@ static int software_resume(void)
 	mutex_unlock(&pm_mutex);
 	pr_debug("PM: Resume from disk failed.\n");
 	return error;
+close_finish:
+	swsusp_close(FMODE_READ);
+	goto Finish;
 }
 
 late_initcall(software_resume);
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index b101cdc..cccea0b 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -572,8 +572,6 @@ int swsusp_read(unsigned int *flags_p)
 		error = load_image(&handle, &snapshot, header->pages - 1);
 	release_swap_reader(&handle);
 
-	blkdev_put(resume_bdev, FMODE_READ);
-
 	if (!error)
 		pr_debug("PM: Image successfully loaded\n");
 	else
@@ -596,16 +594,16 @@ int swsusp_check(void)
 		error = bio_read_page(swsusp_resume_block,
 					swsusp_header, NULL);
 		if (error)
-			return error;
+			goto put;
 
 		if (!memcmp(SWSUSP_SIG, swsusp_header->sig, 10)) {
 			memcpy(swsusp_header->sig, swsusp_header->orig_sig, 10);
 			/* Reset swap signature now */
 			error = bio_write_page(swsusp_resume_block,
 						swsusp_header, NULL);
-		} else {
-			return -EINVAL;
-		}
+		} else
+			error = -EINVAL;
+put:
 		if (error)
 			blkdev_put(resume_bdev, FMODE_READ);
 		else
-- 
1.6.4.2
