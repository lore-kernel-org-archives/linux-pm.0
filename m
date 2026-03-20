Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D2D3D0920
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026205; cv=none; b=ChB8JHQftZ10dZTnq9IaiNamrqeLtuKYg8mbqN6SklMQWS6cOIHAKDwNRyPfT6kwiwtPnraoXQgsWLYIPqEOX85ZCtS6CDiLDmZuIdG3fUpTU81DCsC79nc9T/5s4HhHr+ce77NGKFWAA41dMZa1/9t+6iq6mbVOIJ+fR1eVPG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026205; c=relaxed/simple;
	bh=5LOCeO4tn7HdnP2h2j7RlmfzAkjNRQRUpGyy+cQvCzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=csQz2G0sErYYdQWj+DjmdBL/5n35N6Kvts1/7EOXno+EN37DWBPLThnmvQTbWXoIcfU3EwO/TgPBc82BBIgWx1BTREDB11U+aJN3U2rG91E4QFzpOWoMp77nffXuBCZY6MP/4JkAbFbqH3DOCCZMy7hL+yxo6Fd7zYDlObzOCsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 21 Mar 2026 02:03:21 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: rafael@kernel.org,
	akpm@linux-foundation.org
Cc: chrisl@kernel.org,
	kasong@tencent.com,
	pavel@kernel.org,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com,
	bhe@redhat.com,
	baohua@kernel.org,
	youngjun.park@lge.com,
	usama.arif@linux.dev,
	linux-pm@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v6 3/3] PM: hibernate: fix spurious GFP mask WARNING in uswsusp path
Date: Sat, 21 Mar 2026 02:03:13 +0900
Message-Id: <20260320170313.163386-4-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320170313.163386-1-youngjun.park@lge.com>
References: <20260320170313.163386-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 35e4a69b2003f ("PM: sleep: Allow pm_restrict_gfp_mask()
stacking") introduced refcount-based GFP mask management that warns
when pm_restore_gfp_mask() is called with saved_gfp_count == 0:

  WARNING: kernel/power/main.c:44 at pm_restore_gfp_mask+0xd7/0xf0
  CPU: 0 UID: 0 PID: 373 Comm: s2disk
  Call Trace:
   snapshot_ioctl+0x964/0xbd0
   __x64_sys_ioctl+0x724/0x1320
  ...

The uswsusp path calls pm_restore_gfp_mask() defensively in
SNAPSHOT_CREATE_IMAGE, SNAPSHOT_UNFREEZE, and snapshot_release(),
where the GFP mask may or may not be restricted depending on the
execution path.

Before the stacking change this was a silent no-op; it now triggers
a WARNING when saved_gfp_count is 0.

Introduce pm_restore_gfp_mask_safe(), which skips the call if
saved_gfp_count is 0. This avoids the warning without requiring
state tracking in snapshot_ioctl, which could otherwise leave the
GFP mask permanently restricted if mismanaged.

Fixes: 35e4a69b2003f ("PM: sleep: Allow pm_restrict_gfp_mask() stacking")
Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 include/linux/suspend.h |  1 +
 kernel/power/main.c     | 18 ++++++++++++++++++
 kernel/power/user.c     |  6 +++---
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index b02876f1ae38..7777931d88a5 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -454,6 +454,7 @@ extern void pm_report_hw_sleep_time(u64 t);
 extern void pm_report_max_hw_sleep(u64 t);
 void pm_restrict_gfp_mask(void);
 void pm_restore_gfp_mask(void);
+void pm_restore_gfp_mask_safe(void);
 
 #define pm_notifier(fn, pri) {				\
 	static struct notifier_block fn##_nb =			\
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 5f8c9e12eaec..90e9bd56a433 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -36,6 +36,24 @@
 static unsigned int saved_gfp_count;
 static gfp_t saved_gfp_mask;
 
+/**
+ * pm_restore_gfp_mask_safe - Conditionally restore the GFP mask
+ *
+ * Call pm_restore_gfp_mask() only if a GFP restriction is active.
+ *
+ * After GFP mask stacking was introduced, calling
+ * pm_restore_gfp_mask() without a matching restriction triggers a
+ * warning. Some hibernation paths invoke restore defensively, so this
+ * helper avoids spurious warnings when no restriction is in place.
+ */
+void pm_restore_gfp_mask_safe(void)
+{
+	WARN_ON(!mutex_is_locked(&system_transition_mutex));
+	if (!saved_gfp_count)
+		return;
+	pm_restore_gfp_mask();
+}
+
 void pm_restore_gfp_mask(void)
 {
 	WARN_ON(!mutex_is_locked(&system_transition_mutex));
diff --git a/kernel/power/user.c b/kernel/power/user.c
index aab9aece1009..88de4b76a9dc 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -119,7 +119,7 @@ static int snapshot_release(struct inode *inode, struct file *filp)
 	free_all_swap_pages(data->swap);
 	unpin_hibernation_swap_type(data->swap);
 	if (data->frozen) {
-		pm_restore_gfp_mask();
+		pm_restore_gfp_mask_safe();
 		free_basic_memory_bitmaps();
 		thaw_processes();
 	} else if (data->free_bitmaps) {
@@ -306,7 +306,7 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 	case SNAPSHOT_UNFREEZE:
 		if (!data->frozen || data->ready)
 			break;
-		pm_restore_gfp_mask();
+		pm_restore_gfp_mask_safe();
 		free_basic_memory_bitmaps();
 		data->free_bitmaps = false;
 		thaw_processes();
@@ -318,7 +318,7 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
 			error = -EPERM;
 			break;
 		}
-		pm_restore_gfp_mask();
+		pm_restore_gfp_mask_safe();
 		error = hibernation_snapshot(data->platform_support);
 		if (!error) {
 			error = put_user(in_suspend, (int __user *)arg);
-- 
2.34.1

