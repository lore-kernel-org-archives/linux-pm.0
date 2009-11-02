From: "Dasgupta, Romit" <romit@ti.com>
Subject: [PATCH 1/1] PM: Making bdi threads non-freezable
Date: Mon, 2 Nov 2009 16:33:42 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DE1EBC66__14971.8727138408$1257159897$gmane$org@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "rjw@sisk.pl" <rjw@sisk.pl>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Fixes the case when bdi threads are in the refrigerator but file system sync
can happen after this. This is possible in MMC when CONFIG_MMC_UNSAFE_RESUME is
not set.

Signed-off-by: Romit Dasgupta <romit@ti.com>
---
 
diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 9d5360c..661229d 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -956,7 +956,6 @@ int bdi_writeback_task(struct bdi_writeback *wb)
 
 		wait_jiffies = msecs_to_jiffies(dirty_writeback_interval * 10);
 		schedule_timeout_interruptible(wait_jiffies);
-		try_to_freeze();
 	}
 
 	return 0;
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 5a37e20..9383271 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -273,7 +273,6 @@ static void bdi_task_init(struct backing_dev_info *bdi,
 	spin_unlock(&bdi->wb_lock);
 
 	tsk->flags |= PF_FLUSHER | PF_SWAPWRITE;
-	set_freezable();
 
 	/*
 	 * Our parent may run at a different priority, just set us to normal
@@ -419,7 +418,6 @@ static int bdi_forker_task(void *ptr)
 			spin_unlock_bh(&bdi_lock);
 			wait = msecs_to_jiffies(dirty_writeback_interval * 10);
 			schedule_timeout(wait);
-			try_to_freeze();
 			continue;
 		}
