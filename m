Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0913F482D
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 03:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442235; cv=none; b=SJ/7B5hsdFiLWc4cpGg1YwYZHFVUAvCYPwo2qXvDZLU3c+d02YGgIfcqfjwkIn+4737C1IqApNiY4ZqUJEQYND7q6EbfI8Czzi6QmKwyaA/LmNpSe5qzX4lXeM0GpTyMEA2Mxa8/6487vvHNkBNjm8SxkQePaAkb6W5U7HHCRRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442235; c=relaxed/simple;
	bh=oOJVkSGTGyjAHYT4me0f0QaUSk3J8GiXiRFtVNtLg/c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dHY3p0L5qLkv9kePAQu63CQxUFfcS+5YdIl7NUh6nXKnq+vVUvlc11cN581Gc5GAqxwFGAj9KsDq5U1aAsp/y5Bsl/A5K+VuVnpUDyZnp+frsTIeH8AP2zjqNU5D9TOtJr3pNPl1hjVqotCn49UFPj/fVr80jCDLbSqQy+PgS8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 15 Sep 2026 12:17:05 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Chris Li <chrisl@kernel.org>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-mm@kvack.org,
	linux-pm@vger.kernel.org,
	her0gyugyu@gmail.com,
	youngjun.park@lge.com,
	taejoon.song@lge.com
Subject: [RFC PATCH 03/10] mm, swap: move hibernation swap code to mm/swap_hibernate.c
Date: Tue, 15 Sep 2026 12:16:51 +0900
Message-Id: <20260915031658.1505680-4-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260915031658.1505680-1-youngjun.park@lge.com>
References: <20260915031658.1505680-1-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hibernation parts of mm/swapfile.c are mixed in with the allocator.
Move them to their own file so they are easier to read and maintain.

The file is #included from swapfile.c, so the allocator's data
structures stay private.

No functional change.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 MAINTAINERS         |   1 +
 mm/swap_hibernate.c | 316 ++++++++++++++++++++++++++++++++++++++++++++
 mm/swapfile.c       | 311 +------------------------------------------
 3 files changed, 318 insertions(+), 310 deletions(-)
 create mode 100644 mm/swap_hibernate.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e4412c3d8d45..8273f220ae90 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17408,6 +17408,7 @@ F:	include/linux/swapfile.h
 F:	include/linux/swapops.h
 F:	mm/page_io.c
 F:	mm/swap.h
+F:	mm/swap_hibernate.c
 F:	mm/swap_table.h
 F:	mm/swap_state.c
 F:	mm/swapfile.c
diff --git a/mm/swap_hibernate.c b/mm/swap_hibernate.c
new file mode 100644
index 000000000000..45359b664f46
--- /dev/null
+++ b/mm/swap_hibernate.c
@@ -0,0 +1,316 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Hibernation support for swap.  Included by mm/swapfile.c so that it can
+ * use the allocator's static helpers.
+ */
+
+/**
+ * swap_alloc_hibernation_slot() - Allocate a swap slot for hibernation.
+ * @type: swap device type index to allocate from.
+ *
+ * The caller must ensure the swap device is stable, either by pinning
+ * it (SWP_HIBERNATION) or by freezing user-space.
+ *
+ * Return: a valid swp_entry_t on success, or an empty entry (val == 0)
+ * on failure.
+ */
+swp_entry_t swap_alloc_hibernation_slot(int type)
+{
+	struct swap_info_struct *pcp_si, *si = swap_type_to_info(type);
+	unsigned long pcp_offset, offset = SWAP_ENTRY_INVALID;
+	struct swap_cluster_info *ci;
+	swp_entry_t entry = {0};
+
+	if (!si)
+		goto fail;
+
+	/*
+	 * Try the local cluster first if it matches the device. If
+	 * not, try grab a new cluster and override local cluster.
+	 */
+	local_lock(&percpu_swap_cluster.lock);
+	pcp_si = this_cpu_read(percpu_swap_cluster.si[0]);
+	pcp_offset = this_cpu_read(percpu_swap_cluster.offset[0]);
+	if (pcp_si == si && pcp_offset) {
+		ci = swap_cluster_lock(si, pcp_offset);
+		if (cluster_is_usable(ci, 0))
+			offset = alloc_swap_scan_cluster(si, ci, NULL, pcp_offset);
+		else
+			swap_cluster_unlock(ci);
+	}
+	if (!offset)
+		offset = cluster_alloc_swap_entry(si, NULL);
+	local_unlock(&percpu_swap_cluster.lock);
+	if (offset)
+		entry = swp_entry(si->type, offset);
+
+fail:
+	return entry;
+}
+
+/**
+ * swap_free_hibernation_slot() - Free a swap slot allocated for hibernation.
+ * @entry: swap entry to free.
+ *
+ * The caller must ensure the swap device is stable.
+ */
+void swap_free_hibernation_slot(swp_entry_t entry)
+{
+	struct swap_info_struct *si = __swap_entry_to_info(entry);
+	struct swap_cluster_info *ci;
+	pgoff_t offset = swp_offset(entry);
+
+	ci = swap_cluster_lock(si, offset);
+	__swap_cluster_free_entries(si, ci, offset % SWAPFILE_CLUSTER, 1);
+	swap_cluster_unlock(ci);
+}
+
+static int __find_hibernation_swap_type(dev_t device, sector_t offset)
+{
+	int type;
+
+	lockdep_assert_held(&swap_lock);
+
+	if (!device)
+		return -EINVAL;
+
+	for (type = 0; type < nr_swapfiles; type++) {
+		struct swap_info_struct *sis = swap_info[type];
+
+		if (!(sis->flags & SWP_WRITEOK) || !sis->bdev)
+			continue;
+
+		if (device == sis->bdev->bd_dev) {
+			struct swap_extent *se = first_se(sis);
+
+			if (se->start_block == offset)
+				return type;
+		}
+	}
+	return -ENODEV;
+}
+
+/**
+ * pin_hibernation_swap_type - Pin the swap device for hibernation
+ * @device: Block device containing the resume image
+ * @offset: Offset identifying the swap area
+ *
+ * Locate the swap device for @device/@offset and mark it as pinned
+ * for hibernation. While pinned, swapoff() is prevented.
+ *
+ * Only one uswsusp context may pin a swap device at a time.
+ * If already pinned, this function returns -EBUSY.
+ *
+ * Return:
+ * >= 0 on success (swap type).
+ * -EINVAL if @device is invalid.
+ * -ENODEV if the swap device is not found.
+ * -EBUSY if the device is already pinned for hibernation.
+ */
+int pin_hibernation_swap_type(dev_t device, sector_t offset)
+{
+	int type;
+	struct swap_info_struct *si;
+
+	spin_lock(&swap_lock);
+
+	type = __find_hibernation_swap_type(device, offset);
+	if (type < 0) {
+		spin_unlock(&swap_lock);
+		return type;
+	}
+
+	si = swap_type_to_info(type);
+	if (WARN_ON_ONCE(!si)) {
+		spin_unlock(&swap_lock);
+		return -ENODEV;
+	}
+
+	/*
+	 * hibernate_acquire() prevents concurrent hibernation sessions.
+	 * This check additionally guards against double-pinning within
+	 * the same session.
+	 */
+	if (WARN_ON_ONCE(si->flags & SWP_HIBERNATION)) {
+		spin_unlock(&swap_lock);
+		return -EBUSY;
+	}
+
+	si->flags |= SWP_HIBERNATION;
+
+	spin_unlock(&swap_lock);
+	return type;
+}
+
+/**
+ * repin_hibernation_swap_type - Atomically replace the hibernation pin
+ * @old_type: Swap type currently pinned (or < 0 if none).
+ * @device:   Block device of the new resume image.
+ * @offset:   Offset identifying the new swap area.
+ *
+ * Look up the swap device for @device/@offset and atomically transfer
+ * the SWP_HIBERNATION pin from @old_type (if valid) to the new device,
+ * all under a single swap_lock critical section. This closes the
+ * swapoff() window that exists when callers unpin and re-pin in two
+ * separate operations.
+ *
+ * If the new device cannot be located, the existing pin on @old_type
+ * is preserved and an error is returned. If @old_type already refers
+ * to the same swap_info_struct as the new lookup, no flag changes are
+ * made and @old_type is returned.
+ *
+ * Return:
+ * >= 0 on success (new swap type).
+ * -EINVAL if @device is invalid.
+ * -ENODEV if the swap device is not found.
+ * -EBUSY  if the new device is already pinned by another context.
+ */
+int repin_hibernation_swap_type(int old_type, dev_t device, sector_t offset)
+{
+	struct swap_info_struct *old_si, *new_si;
+	int new_type;
+
+	spin_lock(&swap_lock);
+
+	new_type = __find_hibernation_swap_type(device, offset);
+	if (new_type < 0) {
+		spin_unlock(&swap_lock);
+		return new_type;
+	}
+
+	new_si = swap_type_to_info(new_type);
+	if (WARN_ON_ONCE(!new_si)) {
+		spin_unlock(&swap_lock);
+		return -ENODEV;
+	}
+
+	old_si = swap_type_to_info(old_type);
+	if (new_si == old_si) {
+		spin_unlock(&swap_lock);
+		return new_type;
+	}
+
+	if (WARN_ON_ONCE(new_si->flags & SWP_HIBERNATION)) {
+		spin_unlock(&swap_lock);
+		return -EBUSY;
+	}
+
+	if (old_si)
+		old_si->flags &= ~SWP_HIBERNATION;
+	new_si->flags |= SWP_HIBERNATION;
+
+	spin_unlock(&swap_lock);
+	return new_type;
+}
+
+/**
+ * unpin_hibernation_swap_type - Unpin the swap device for hibernation
+ * @type: Swap type previously returned by pin_hibernation_swap_type()
+ *
+ * Clear the hibernation pin on the given swap device, allowing
+ * swapoff() to proceed normally.
+ *
+ * If @type does not refer to a valid swap device, this function
+ * does nothing.
+ */
+void unpin_hibernation_swap_type(int type)
+{
+	struct swap_info_struct *si;
+
+	spin_lock(&swap_lock);
+	si = swap_type_to_info(type);
+	if (!si) {
+		spin_unlock(&swap_lock);
+		return;
+	}
+	si->flags &= ~SWP_HIBERNATION;
+	spin_unlock(&swap_lock);
+}
+
+/**
+ * find_hibernation_swap_type - Find swap type for hibernation
+ * @device: Block device containing the resume image
+ * @offset: Offset within the device identifying the swap area
+ *
+ * Locate the swap device corresponding to @device and @offset.
+ *
+ * Unlike pin_hibernation_swap_type(), this function only performs a
+ * lookup and does not mark the swap device as pinned for hibernation.
+ *
+ * This is safe in the sysfs-based hibernation path where user space
+ * is already frozen and swapoff() cannot run concurrently.
+ *
+ * Return:
+ * A non-negative swap type on success.
+ * -EINVAL if @device is invalid.
+ * -ENODEV if no matching swap device is found.
+ */
+int find_hibernation_swap_type(dev_t device, sector_t offset)
+{
+	int type;
+
+	spin_lock(&swap_lock);
+	type = __find_hibernation_swap_type(device, offset);
+	spin_unlock(&swap_lock);
+
+	return type;
+}
+
+int find_first_swap(dev_t *device)
+{
+	int type;
+
+	spin_lock(&swap_lock);
+	for (type = 0; type < nr_swapfiles; type++) {
+		struct swap_info_struct *sis = swap_info[type];
+
+		if (!(sis->flags & SWP_WRITEOK) || !sis->bdev)
+			continue;
+		*device = sis->bdev->bd_dev;
+		spin_unlock(&swap_lock);
+		return type;
+	}
+	spin_unlock(&swap_lock);
+	return -ENODEV;
+}
+
+/*
+ * Get the (PAGE_SIZE) block corresponding to given offset on the swapdev
+ * corresponding to given index in swap_info (swap type).
+ */
+sector_t swapdev_block(int type, pgoff_t offset)
+{
+	struct swap_info_struct *si = swap_type_to_info(type);
+	struct swap_extent *se;
+
+	if (!si || !(si->flags & SWP_WRITEOK))
+		return 0;
+	se = offset_to_swap_extent(si, offset);
+	return se->start_block + (offset - se->start_page);
+}
+
+/*
+ * Return either the total number of swap pages of given type, or the number
+ * of free pages of that type (depending on @free)
+ *
+ * This is needed for software suspend
+ */
+unsigned int count_swap_pages(int type, int free)
+{
+	unsigned int n = 0;
+
+	spin_lock(&swap_lock);
+	if ((unsigned int)type < nr_swapfiles) {
+		struct swap_info_struct *sis = swap_info[type];
+
+		spin_lock(&sis->lock);
+		if (sis->flags & SWP_WRITEOK) {
+			n = sis->pages;
+			if (free)
+				n -= swap_usage_in_pages(sis);
+		}
+		spin_unlock(&sis->lock);
+	}
+	spin_unlock(&swap_lock);
+	return n;
+}
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 655f2647472c..07aefb782fbe 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2165,316 +2165,7 @@ void swap_put_entries_direct(swp_entry_t entry, int nr)
 }
 
 #ifdef CONFIG_HIBERNATION
-/**
- * swap_alloc_hibernation_slot() - Allocate a swap slot for hibernation.
- * @type: swap device type index to allocate from.
- *
- * The caller must ensure the swap device is stable, either by pinning
- * it (SWP_HIBERNATION) or by freezing user-space.
- *
- * Return: a valid swp_entry_t on success, or an empty entry (val == 0)
- * on failure.
- */
-swp_entry_t swap_alloc_hibernation_slot(int type)
-{
-	struct swap_info_struct *pcp_si, *si = swap_type_to_info(type);
-	unsigned long pcp_offset, offset = SWAP_ENTRY_INVALID;
-	struct swap_cluster_info *ci;
-	swp_entry_t entry = {0};
-
-	if (!si)
-		goto fail;
-
-	/*
-	 * Try the local cluster first if it matches the device. If
-	 * not, try grab a new cluster and override local cluster.
-	 */
-	local_lock(&percpu_swap_cluster.lock);
-	pcp_si = this_cpu_read(percpu_swap_cluster.si[0]);
-	pcp_offset = this_cpu_read(percpu_swap_cluster.offset[0]);
-	if (pcp_si == si && pcp_offset) {
-		ci = swap_cluster_lock(si, pcp_offset);
-		if (cluster_is_usable(ci, 0))
-			offset = alloc_swap_scan_cluster(si, ci, NULL, pcp_offset);
-		else
-			swap_cluster_unlock(ci);
-	}
-	if (!offset)
-		offset = cluster_alloc_swap_entry(si, NULL);
-	local_unlock(&percpu_swap_cluster.lock);
-	if (offset)
-		entry = swp_entry(si->type, offset);
-
-fail:
-	return entry;
-}
-
-/**
- * swap_free_hibernation_slot() - Free a swap slot allocated for hibernation.
- * @entry: swap entry to free.
- *
- * The caller must ensure the swap device is stable.
- */
-void swap_free_hibernation_slot(swp_entry_t entry)
-{
-	struct swap_info_struct *si = __swap_entry_to_info(entry);
-	struct swap_cluster_info *ci;
-	pgoff_t offset = swp_offset(entry);
-
-	ci = swap_cluster_lock(si, offset);
-	__swap_cluster_free_entries(si, ci, offset % SWAPFILE_CLUSTER, 1);
-	swap_cluster_unlock(ci);
-}
-
-static int __find_hibernation_swap_type(dev_t device, sector_t offset)
-{
-	int type;
-
-	lockdep_assert_held(&swap_lock);
-
-	if (!device)
-		return -EINVAL;
-
-	for (type = 0; type < nr_swapfiles; type++) {
-		struct swap_info_struct *sis = swap_info[type];
-
-		if (!(sis->flags & SWP_WRITEOK) || !sis->bdev)
-			continue;
-
-		if (device == sis->bdev->bd_dev) {
-			struct swap_extent *se = first_se(sis);
-
-			if (se->start_block == offset)
-				return type;
-		}
-	}
-	return -ENODEV;
-}
-
-/**
- * pin_hibernation_swap_type - Pin the swap device for hibernation
- * @device: Block device containing the resume image
- * @offset: Offset identifying the swap area
- *
- * Locate the swap device for @device/@offset and mark it as pinned
- * for hibernation. While pinned, swapoff() is prevented.
- *
- * Only one uswsusp context may pin a swap device at a time.
- * If already pinned, this function returns -EBUSY.
- *
- * Return:
- * >= 0 on success (swap type).
- * -EINVAL if @device is invalid.
- * -ENODEV if the swap device is not found.
- * -EBUSY if the device is already pinned for hibernation.
- */
-int pin_hibernation_swap_type(dev_t device, sector_t offset)
-{
-	int type;
-	struct swap_info_struct *si;
-
-	spin_lock(&swap_lock);
-
-	type = __find_hibernation_swap_type(device, offset);
-	if (type < 0) {
-		spin_unlock(&swap_lock);
-		return type;
-	}
-
-	si = swap_type_to_info(type);
-	if (WARN_ON_ONCE(!si)) {
-		spin_unlock(&swap_lock);
-		return -ENODEV;
-	}
-
-	/*
-	 * hibernate_acquire() prevents concurrent hibernation sessions.
-	 * This check additionally guards against double-pinning within
-	 * the same session.
-	 */
-	if (WARN_ON_ONCE(si->flags & SWP_HIBERNATION)) {
-		spin_unlock(&swap_lock);
-		return -EBUSY;
-	}
-
-	si->flags |= SWP_HIBERNATION;
-
-	spin_unlock(&swap_lock);
-	return type;
-}
-
-/**
- * repin_hibernation_swap_type - Atomically replace the hibernation pin
- * @old_type: Swap type currently pinned (or < 0 if none).
- * @device:   Block device of the new resume image.
- * @offset:   Offset identifying the new swap area.
- *
- * Look up the swap device for @device/@offset and atomically transfer
- * the SWP_HIBERNATION pin from @old_type (if valid) to the new device,
- * all under a single swap_lock critical section. This closes the
- * swapoff() window that exists when callers unpin and re-pin in two
- * separate operations.
- *
- * If the new device cannot be located, the existing pin on @old_type
- * is preserved and an error is returned. If @old_type already refers
- * to the same swap_info_struct as the new lookup, no flag changes are
- * made and @old_type is returned.
- *
- * Return:
- * >= 0 on success (new swap type).
- * -EINVAL if @device is invalid.
- * -ENODEV if the swap device is not found.
- * -EBUSY  if the new device is already pinned by another context.
- */
-int repin_hibernation_swap_type(int old_type, dev_t device, sector_t offset)
-{
-	struct swap_info_struct *old_si, *new_si;
-	int new_type;
-
-	spin_lock(&swap_lock);
-
-	new_type = __find_hibernation_swap_type(device, offset);
-	if (new_type < 0) {
-		spin_unlock(&swap_lock);
-		return new_type;
-	}
-
-	new_si = swap_type_to_info(new_type);
-	if (WARN_ON_ONCE(!new_si)) {
-		spin_unlock(&swap_lock);
-		return -ENODEV;
-	}
-
-	old_si = swap_type_to_info(old_type);
-	if (new_si == old_si) {
-		spin_unlock(&swap_lock);
-		return new_type;
-	}
-
-	if (WARN_ON_ONCE(new_si->flags & SWP_HIBERNATION)) {
-		spin_unlock(&swap_lock);
-		return -EBUSY;
-	}
-
-	if (old_si)
-		old_si->flags &= ~SWP_HIBERNATION;
-	new_si->flags |= SWP_HIBERNATION;
-
-	spin_unlock(&swap_lock);
-	return new_type;
-}
-
-/**
- * unpin_hibernation_swap_type - Unpin the swap device for hibernation
- * @type: Swap type previously returned by pin_hibernation_swap_type()
- *
- * Clear the hibernation pin on the given swap device, allowing
- * swapoff() to proceed normally.
- *
- * If @type does not refer to a valid swap device, this function
- * does nothing.
- */
-void unpin_hibernation_swap_type(int type)
-{
-	struct swap_info_struct *si;
-
-	spin_lock(&swap_lock);
-	si = swap_type_to_info(type);
-	if (!si) {
-		spin_unlock(&swap_lock);
-		return;
-	}
-	si->flags &= ~SWP_HIBERNATION;
-	spin_unlock(&swap_lock);
-}
-
-/**
- * find_hibernation_swap_type - Find swap type for hibernation
- * @device: Block device containing the resume image
- * @offset: Offset within the device identifying the swap area
- *
- * Locate the swap device corresponding to @device and @offset.
- *
- * Unlike pin_hibernation_swap_type(), this function only performs a
- * lookup and does not mark the swap device as pinned for hibernation.
- *
- * This is safe in the sysfs-based hibernation path where user space
- * is already frozen and swapoff() cannot run concurrently.
- *
- * Return:
- * A non-negative swap type on success.
- * -EINVAL if @device is invalid.
- * -ENODEV if no matching swap device is found.
- */
-int find_hibernation_swap_type(dev_t device, sector_t offset)
-{
-	int type;
-
-	spin_lock(&swap_lock);
-	type = __find_hibernation_swap_type(device, offset);
-	spin_unlock(&swap_lock);
-
-	return type;
-}
-
-int find_first_swap(dev_t *device)
-{
-	int type;
-
-	spin_lock(&swap_lock);
-	for (type = 0; type < nr_swapfiles; type++) {
-		struct swap_info_struct *sis = swap_info[type];
-
-		if (!(sis->flags & SWP_WRITEOK) || !sis->bdev)
-			continue;
-		*device = sis->bdev->bd_dev;
-		spin_unlock(&swap_lock);
-		return type;
-	}
-	spin_unlock(&swap_lock);
-	return -ENODEV;
-}
-
-/*
- * Get the (PAGE_SIZE) block corresponding to given offset on the swapdev
- * corresponding to given index in swap_info (swap type).
- */
-sector_t swapdev_block(int type, pgoff_t offset)
-{
-	struct swap_info_struct *si = swap_type_to_info(type);
-	struct swap_extent *se;
-
-	if (!si || !(si->flags & SWP_WRITEOK))
-		return 0;
-	se = offset_to_swap_extent(si, offset);
-	return se->start_block + (offset - se->start_page);
-}
-
-/*
- * Return either the total number of swap pages of given type, or the number
- * of free pages of that type (depending on @free)
- *
- * This is needed for software suspend
- */
-unsigned int count_swap_pages(int type, int free)
-{
-	unsigned int n = 0;
-
-	spin_lock(&swap_lock);
-	if ((unsigned int)type < nr_swapfiles) {
-		struct swap_info_struct *sis = swap_info[type];
-
-		spin_lock(&sis->lock);
-		if (sis->flags & SWP_WRITEOK) {
-			n = sis->pages;
-			if (free)
-				n -= swap_usage_in_pages(sis);
-		}
-		spin_unlock(&sis->lock);
-	}
-	spin_unlock(&swap_lock);
-	return n;
-}
+#include "swap_hibernate.c"
 #endif /* CONFIG_HIBERNATION */
 
 static inline int pte_same_as_swp(pte_t pte, pte_t swp_pte)
-- 
2.48.1

