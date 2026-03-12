Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616D93B6365
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 11:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314725; cv=none; b=mrBJ2qx75XqwrhaPAcRWk1XheBwLXHE1jnw1ZCg4D8wFzq9sNkcegZv5G52DCWQYpzZwhy8BV9fKE7e9cs//Ycr04EDvCmf4UAaACtZNwdGNO/6yRFYseiZVe5ZRcS3aEGXmMsi07uLDWrV14GtRycbfkJ/GUSiLxDHdHjej8Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314725; c=relaxed/simple;
	bh=e7FmwC3vUtQOJtO1io1aLsVcirfL4u47oqZf6ml43PA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RwC9bFpfzUO3BGaG40emxkFfX4l1OqhIxTfKIW3AHrdWwTqet4LtUZf8D9ykyRwFlG04s45YSeA2fQRfY7U4KeQ+v8PfoXjQV89+7aTTd0qtnb01xZUrBn9TIysRmixJSX30Dr+Rrg5CCawaf7E+oO+/CfnkiJIUw0JaTLid/YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 12 Mar 2026 20:25:13 +0900
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
Subject: [RESEND RFC PATCH v3 1/2] mm/swap, PM: hibernate: fix swapoff race in uswsusp by getting swap reference
Date: Thu, 12 Mar 2026 20:25:10 +0900
Message-Id: <20260312112511.3596781-2-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312112511.3596781-1-youngjun.park@lge.com>
References: <20260312112511.3596781-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hibernation can be triggered either via the sysfs interface or via the
uswsusp utility using /dev/snapshot ioctls.

In the case of uswsusp, the resume device is configured either by the
boot parameter during snapshot_open() or via the SNAPSHOT_SET_SWAP_AREA
ioctl. However, a race condition exists between setting this swap area
and actually allocating a swap slot via the SNAPSHOT_ALLOC_SWAP_PAGE
ioctl. For instance, if swapoff is executed and a different swap device
is enabled during this window, an incorrect swap slot might be allocated.

Hibernation via the sysfs interface does not suffer from this race
condition because user-space processes are frozen before proceeding,
making it impossible to execute swapoff.

To resolve this race in uswsusp, modify swap_type_of() to properly
acquire a reference to the swap device using get_swap_device().

Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 include/linux/swap.h |  3 ++-
 kernel/power/swap.c  |  2 +-
 kernel/power/user.c  | 11 ++++++++---
 mm/swapfile.c        | 28 +++++++++++++++++++++-------
 4 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 7a09df6977a5..ecf19a581fc7 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -433,8 +433,9 @@ static inline long get_nr_swap_pages(void)
 }
 
 extern void si_swapinfo(struct sysinfo *);
-int swap_type_of(dev_t device, sector_t offset);
+int swap_type_of(dev_t device, sector_t offset, bool ref);
 int find_first_swap(dev_t *device);
+void put_swap_device_by_type(int type);
 extern unsigned int count_swap_pages(int, int);
 extern sector_t swapdev_block(int, pgoff_t);
 extern int __swap_count(swp_entry_t entry);
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 2e64869bb5a0..3a477914a7c4 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -341,7 +341,7 @@ static int swsusp_swap_check(void)
 	 * This is called before saving the image.
 	 */
 	if (swsusp_resume_device)
-		res = swap_type_of(swsusp_resume_device, swsusp_resume_block);
+		res = swap_type_of(swsusp_resume_device, swsusp_resume_block, false);
 	else
 		res = find_first_swap(&swsusp_resume_device);
 	if (res < 0)
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 4401cfe26e5c..7ade4d0aa846 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -71,7 +71,7 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 	memset(&data->handle, 0, sizeof(struct snapshot_handle));
 	if ((filp->f_flags & O_ACCMODE) == O_RDONLY) {
 		/* Hibernating.  The image device should be accessible. */
-		data->swap = swap_type_of(swsusp_resume_device, 0);
+		data->swap = swap_type_of(swsusp_resume_device, 0, true);
 		data->mode = O_RDONLY;
 		data->free_bitmaps = false;
 		error = pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE, PM_POST_HIBERNATION);
@@ -90,8 +90,10 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 			data->free_bitmaps = !error;
 		}
 	}
-	if (error)
+	if (error) {
+		put_swap_device_by_type(data->swap);
 		hibernate_release();
+	}
 
 	data->frozen = false;
 	data->ready = false;
@@ -115,6 +117,7 @@ static int snapshot_release(struct inode *inode, struct file *filp)
 	data = filp->private_data;
 	data->dev = 0;
 	free_all_swap_pages(data->swap);
+	put_swap_device_by_type(data->swap);
 	if (data->frozen) {
 		pm_restore_gfp_mask();
 		free_basic_memory_bitmaps();
@@ -235,11 +238,13 @@ static int snapshot_set_swap_area(struct snapshot_data *data,
 		offset = swap_area.offset;
 	}
 
+	put_swap_device_by_type(data->swap);
+
 	/*
 	 * User space encodes device types as two-byte values,
 	 * so we need to recode them
 	 */
-	data->swap = swap_type_of(swdev, offset);
+	data->swap = swap_type_of(swdev, offset, true);
 	if (data->swap < 0)
 		return swdev ? -ENODEV : -EINVAL;
 	data->dev = swdev;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index d864866a35ea..5a3d5c1e1f81 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2149,7 +2149,7 @@ void swap_free_hibernation_slot(swp_entry_t entry)
  *
  * This is needed for the suspend to disk (aka swsusp).
  */
-int swap_type_of(dev_t device, sector_t offset)
+int swap_type_of(dev_t device, sector_t offset, bool ref)
 {
 	int type;
 
@@ -2163,13 +2163,16 @@ int swap_type_of(dev_t device, sector_t offset)
 		if (!(sis->flags & SWP_WRITEOK))
 			continue;
 
-		if (device == sis->bdev->bd_dev) {
-			struct swap_extent *se = first_se(sis);
+		if (device != sis->bdev->bd_dev)
+			continue;
 
-			if (se->start_block == offset) {
-				spin_unlock(&swap_lock);
-				return type;
-			}
+		struct swap_extent *se = first_se(sis);
+		if (se->start_block != offset)
+			continue;
+
+		if (ref && get_swap_device_info(sis)) {
+			spin_unlock(&swap_lock);
+			return type;
 		}
 	}
 	spin_unlock(&swap_lock);
@@ -2194,6 +2197,17 @@ int find_first_swap(dev_t *device)
 	return -ENODEV;
 }
 
+void put_swap_device_by_type(int type)
+{
+	struct swap_info_struct *sis;
+
+	if (type < 0 || type >= MAX_SWAPFILES)
+		return;
+
+	sis = swap_info[type];
+	put_swap_device(sis);
+}
+
 /*
  * Get the (PAGE_SIZE) block corresponding to given offset on the swapdev
  * corresponding to given index in swap_info (swap type).
-- 
2.34.1

