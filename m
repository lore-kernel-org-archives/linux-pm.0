Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3703644C4
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930269; cv=none; b=s2QWFhDWjgHwIBTw3UoyhjXljLJHM+qyAgpvomeq7zXfn1CxWG/2i9CajanMq7XwxrpAeQaGe4kj3V/SchidJJsrKAOK94QlxvBKcIUAmc6oe6Kiuqgc61YS7/5x8MtKpIevZQRk1mo65wiAT8Lm7m6UhZqpeFbkb78UAiYN0Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930269; c=relaxed/simple;
	bh=H79aQjrNRz2zp7D81fKCIkl9h2JJZBU7ivgv3lKSPPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IWmH6ikjkXhaOhCZzFPV32C2xbuHj15p1wxVYp6n4arxOQjNzTinS/cEj0TIYo66VBN3MUdPbcX8/H0BU2cnYopz4wpmLY3+qWHo2qG3GL88UFUTqoLWluhBdIBr/wRGfziZBkPOvtfgWdGUsng0LMi79dH5T+CCGb+2IFNoEFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 19 Mar 2026 23:24:20 +0900
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
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v5 1/3] mm/swap, PM: hibernate: fix swapoff race in uswsusp by getting swap reference
Date: Thu, 19 Mar 2026 23:24:02 +0900
Message-Id: <20260319142404.3683019-2-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319142404.3683019-1-youngjun.park@lge.com>
References: <20260319142404.3683019-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hibernation via uswsusp (/dev/snapshot ioctls) has a race: between
setting the resume swap area and allocating a swap slot, user-space is
not yet frozen, so swapoff can run and cause an incorrect slot allocation.

Fix this by keeping swap_type_of() as a static helper that requires
swap_lock to be held, and introducing new interfaces that wrap it with
proper locking and reference management:

- get_hibernation_swap_type(): Lookup under swap_lock + acquire a swap
  device reference to block swapoff (used by uswsusp).
- find_hibernation_swap_type(): Lookup under swap_lock only, no
  reference. Used by the sysfs path where user-space is already frozen,
  making swapoff impossible.
- put_hibernation_swap_type(): Release the reference.

Because the reference is held via get_swap_device(), swapoff will block
at wait_for_completion_interruptible() until put_hibernation_swap_type()
releases it. The wait is interruptible, so swapoff can be cancelled by
a signal.

Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 include/linux/swap.h |  4 +-
 kernel/power/swap.c  |  2 +-
 kernel/power/user.c  | 15 ++++++--
 mm/swapfile.c        | 92 ++++++++++++++++++++++++++++++++++++--------
 4 files changed, 92 insertions(+), 21 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 62fc7499b408..4266356f928c 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -452,7 +452,9 @@ static inline long get_nr_swap_pages(void)
 
 extern void si_swapinfo(struct sysinfo *);
 extern int add_swap_count_continuation(swp_entry_t, gfp_t);
-int swap_type_of(dev_t device, sector_t offset);
+int get_hibernation_swap_type(dev_t device, sector_t offset);
+int find_hibernation_swap_type(dev_t device, sector_t offset);
+void put_hibernation_swap_type(int type);
 int find_first_swap(dev_t *device);
 extern unsigned int count_swap_pages(int, int);
 extern sector_t swapdev_block(int, pgoff_t);
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 2e64869bb5a0..cc4764149e8f 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -341,7 +341,7 @@ static int swsusp_swap_check(void)
 	 * This is called before saving the image.
 	 */
 	if (swsusp_resume_device)
-		res = swap_type_of(swsusp_resume_device, swsusp_resume_block);
+		res = find_hibernation_swap_type(swsusp_resume_device, swsusp_resume_block);
 	else
 		res = find_first_swap(&swsusp_resume_device);
 	if (res < 0)
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 4401cfe26e5c..3e41544b99d5 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -71,7 +71,7 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	memset(&data->handle, 0, sizeof(struct snapshot_handle));
 	if ((filp->f_flags & O_ACCMODE) == O_RDONLY) {
 		/* Hibernating.  The image device should be accessible. */
-		data->swap = swap_type_of(swsusp_resume_device, 0);
+		data->swap = get_hibernation_swap_type(swsusp_resume_device, 0);
 		data->mode = O_RDONLY;
 		data->free_bitmaps = false;
 		error = pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE, PM_POST_HIBERNATION);
@@ -90,8 +90,10 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 			data->free_bitmaps = !error;
 		}
 	}
-	if (error)
+	if (error) {
+		put_hibernation_swap_type(data->swap);
 		hibernate_release();
+	}
 
 	data->frozen = false;
 	data->ready = false;
@@ -115,6 +117,7 @@ static int snapshot_release(struct inode *inode, struct file *filp)
 	data = filp->private_data;
 	data->dev = 0;
 	free_all_swap_pages(data->swap);
+	put_hibernation_swap_type(data->swap);
 	if (data->frozen) {
 		pm_restore_gfp_mask();
 		free_basic_memory_bitmaps();
@@ -235,11 +238,17 @@ static int snapshot_set_swap_area(struct snapshot_data *data,
 		offset = swap_area.offset;
 	}
 
+	/*
+	 * Put the reference if a swap area was already
+	 * set by SNAPSHOT_SET_SWAP_AREA.
+	 */
+	put_hibernation_swap_type(data->swap);
+
 	/*
 	 * User space encodes device types as two-byte values,
 	 * so we need to recode them
 	 */
-	data->swap = swap_type_of(swdev, offset);
+	data->swap = get_hibernation_swap_type(swdev, offset);
 	if (data->swap < 0)
 		return swdev ? -ENODEV : -EINVAL;
 	data->dev = swdev;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 94af29d1de88..5069074ab11b 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -133,7 +133,7 @@ static DEFINE_PER_CPU(struct percpu_swap_cluster, percpu_swap_cluster) = {
 /* May return NULL on invalid type, caller must check for NULL return */
 static struct swap_info_struct *swap_type_to_info(int type)
 {
-	if (type >= MAX_SWAPFILES)
+	if (type < 0 || type >= MAX_SWAPFILES)
 		return NULL;
 	return READ_ONCE(swap_info[type]); /* rcu_dereference() */
 }
@@ -1972,22 +1972,15 @@ void swap_free_hibernation_slot(swp_entry_t entry)
 	put_swap_device(si);
 }
 
-/*
- * Find the swap type that corresponds to given device (if any).
- *
- * @offset - number of the PAGE_SIZE-sized block of the device, starting
- * from 0, in which the swap header is expected to be located.
- *
- * This is needed for the suspend to disk (aka swsusp).
- */
-int swap_type_of(dev_t device, sector_t offset)
+static int swap_type_of(dev_t device, sector_t offset)
 {
 	int type;
 
+	lockdep_assert_held(&swap_lock);
+
 	if (!device)
 		return -1;
 
-	spin_lock(&swap_lock);
 	for (type = 0; type < nr_swapfiles; type++) {
 		struct swap_info_struct *sis = swap_info[type];
 
@@ -1997,16 +1990,70 @@ int swap_type_of(dev_t device, sector_t offset)
 		if (device == sis->bdev->bd_dev) {
 			struct swap_extent *se = first_se(sis);
 
-			if (se->start_block == offset) {
-				spin_unlock(&swap_lock);
+			if (se->start_block == offset)
 				return type;
-			}
 		}
 	}
-	spin_unlock(&swap_lock);
 	return -ENODEV;
 }
 
+/*
+ * Finds the swap type and safely acquires a reference to the swap device
+ * to prevent race conditions with swapoff.
+ *
+ * This should be used in environments like uswsusp where a race condition
+ * exists between configuring the resume device and allocating a swap slot.
+ * For sysfs hibernation where user-space is frozen (making swapoff
+ * impossible), use find_hibernation_swap_type() instead.
+ *
+ * The caller must drop the reference using put_hibernation_swap_type().
+ */
+int get_hibernation_swap_type(dev_t device, sector_t offset)
+{
+	int type;
+	struct swap_info_struct *sis;
+
+	spin_lock(&swap_lock);
+	type = swap_type_of(device, offset);
+	sis = swap_type_to_info(type);
+	if (!sis || !get_swap_device_info(sis))
+		type = -1;
+
+	spin_unlock(&swap_lock);
+	return type;
+}
+
+/*
+ * Drops the reference to the swap device previously acquired by
+ * get_hibernation_swap_type().
+ */
+void put_hibernation_swap_type(int type)
+{
+	struct swap_info_struct *sis;
+
+	sis = swap_type_to_info(type);
+	if (!sis)
+		return;
+
+	put_swap_device(sis);
+}
+
+/*
+ * Simple lookup without acquiring a reference. Used by the sysfs
+ * hibernation path where user-space is already frozen, making
+ * swapoff impossible.
+ */
+int find_hibernation_swap_type(dev_t device, sector_t offset)
+{
+	int type;
+
+	spin_lock(&swap_lock);
+	type = swap_type_of(device, offset);
+	spin_unlock(&swap_lock);
+
+	return type;
+}
+
 int find_first_swap(dev_t *device)
 {
 	int type;
@@ -2837,10 +2884,23 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
 	 * spinlock) will be waited too.  This makes it easy to
 	 * prevent folio_test_swapcache() and the following swap cache
 	 * operations from racing with swapoff.
+	 *
+	 * Note: if a hibernation session is actively holding a swap
+	 * device reference, swapoff will block here until the reference
+	 * is released via put_hibernation_swap_type() or the wait is
+	 * interrupted by a signal.
 	 */
 	percpu_ref_kill(&p->users);
 	synchronize_rcu();
-	wait_for_completion(&p->comp);
+	err = wait_for_completion_interruptible(&p->comp);
+	if (err) {
+		percpu_ref_resurrect(&p->users);
+		synchronize_rcu();
+		reinit_completion(&p->comp);
+		reinsert_swap_info(p);
+		goto out_dput;
+	}
+
 
 	flush_work(&p->discard_work);
 	flush_work(&p->reclaim_work);
-- 
2.34.1

