Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BF635DA6B
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 14:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930266; cv=none; b=AbRurW481QduEzDp75ukyBJ7w/ozxK6diCd94Zimjgvui8YKYf1oXuHH+HmOngLbbfR0T83Vmd+bpZqG65Sq8sYkCOaCJem4rpGNNn673lOZGEj1ie2SOTa9iDDaKN/MLYWE12JQesX1azA9vbtulk5OLETuozuCHYE0flzVbX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930266; c=relaxed/simple;
	bh=zdSH+3A9vhcp+O5b472ey7UJYvOHEck6BxeMmVXsUq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LPRxibZ0nz56evEz0Lfvo46fkMecVDp0zJ/yVXo5pvzCLnPT8US5146s5Ten1Fak3XrbohXEquwySfAv+iJpIFHNQPNfgQlndS58B9ontcfW1l46EtFTXQyWLuTxSd8UB/SykandKnc34zE0fHkgDE8UW62oSwTwGe3Qtjn0zUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 19 Mar 2026 23:24:22 +0900
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
Subject: [PATCH v5 2/3] mm/swap: remove redundant swap device reference in alloc/free
Date: Thu, 19 Mar 2026 23:24:03 +0900
Message-Id: <20260319142404.3683019-3-youngjun.park@lge.com>
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

In the previous commit, uswsusp was modified to acquire the swap device
reference at the time of determining the swap type. As a result, it is
no longer necessary to repeatedly acquire and release the reference to
protect against swapoff every time a swap slot is allocated.

For hibernation via the sysfs interface, user-space processes are already
frozen, making swapoff inherently impossible. Thus, acquiring and
releasing the reference during allocation is unnecessary. Furthermore,
even after returning from suspend, processes are not yet thawed when
swap slots are freed, meaning reference management is not required at
that stage either.

Therefore, remove the redundant swap device reference acquire and release
operations from the hibernation swap allocation and free functions.

Additionally, remove the SWP_WRITEOK check before allocation. This check
is redundant because the cluster allocation logic already handles it.

Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 mm/swapfile.c | 43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 5069074ab11b..f1188743037a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1923,7 +1923,12 @@ void swap_put_entries_direct(swp_entry_t entry, int nr)
 }
 
 #ifdef CONFIG_HIBERNATION
-/* Allocate a slot for hibernation */
+/*
+ * Allocate a slot for hibernation.
+ *
+ * Note: The caller must ensure the swap device is stable, either by
+ * holding a reference or by freezing user-space before calling this.
+ */
 swp_entry_t swap_alloc_hibernation_slot(int type)
 {
 	struct swap_info_struct *si = swap_type_to_info(type);
@@ -1933,43 +1938,35 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
 	if (!si)
 		goto fail;
 
-	/* This is called for allocating swap entry, not cache */
-	if (get_swap_device_info(si)) {
-		if (si->flags & SWP_WRITEOK) {
-			/*
-			 * Grab the local lock to be compliant
-			 * with swap table allocation.
-			 */
-			local_lock(&percpu_swap_cluster.lock);
-			offset = cluster_alloc_swap_entry(si, NULL);
-			local_unlock(&percpu_swap_cluster.lock);
-			if (offset)
-				entry = swp_entry(si->type, offset);
-		}
-		put_swap_device(si);
-	}
+	/*
+	 * Grab the local lock to be compliant
+	 * with swap table allocation.
+	 */
+	local_lock(&percpu_swap_cluster.lock);
+	offset = cluster_alloc_swap_entry(si, NULL);
+	local_unlock(&percpu_swap_cluster.lock);
+	if (offset)
+		entry = swp_entry(si->type, offset);
 fail:
 	return entry;
 }
 
-/* Free a slot allocated by swap_alloc_hibernation_slot */
+/*
+ * Free a slot allocated by swap_alloc_hibernation_slot.
+ * As with allocation, the caller must ensure the swap device is stable.
+ */
 void swap_free_hibernation_slot(swp_entry_t entry)
 {
-	struct swap_info_struct *si;
+	struct swap_info_struct *si = __swap_entry_to_info(entry);
 	struct swap_cluster_info *ci;
 	pgoff_t offset = swp_offset(entry);
 
-	si = get_swap_device(entry);
-	if (WARN_ON(!si))
-		return;
-
 	ci = swap_cluster_lock(si, offset);
 	swap_put_entry_locked(si, ci, offset);
 	swap_cluster_unlock(ci);
 
 	/* In theory readahead might add it to the swap cache by accident */
 	__try_to_reclaim_swap(si, offset, TTRS_ANYWAY);
-	put_swap_device(si);
 }
 
 static int swap_type_of(dev_t device, sector_t offset)
-- 
2.34.1

