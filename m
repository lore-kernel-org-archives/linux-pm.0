Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DEB3D0914
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 17:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026209; cv=none; b=XKdlrL7CZUq9oRRclrWvQAMBJXW6Y+aP0qoIh2aYTDgC0MArz2kFWbZqd8PVp0Gcjr/WttdfptUso5iSqE+/DTvQTqSvqCM+wMuBu4oWReMlm5j1rGmATWDBjTRcyXBG+dd4h81eKu7aBO1CMg6QmEs9i0IkJKcomWcA8D2Piok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026209; c=relaxed/simple;
	bh=kshq6w3mHRMvwo7FX8lMXm1FwHcIGatSHrIg6NlSOXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=faU6LsnjQA3Cz9nHh21TZUjB6jSb+B4AFpA6yv/ZFzp0PKm6j0ukGv2Mu059SUBEcnZjWQXMz/SFsCh7/wVCAwj7n4YHvvXi2vTr2IuhgL8hNJo474C28fmaZVbTalBRxfmGNY1Q5pzkFQ1pUnJV66VQ9zfqjbIdP4PUPWYXNFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 21 Mar 2026 02:03:19 +0900
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
Subject: [PATCH v6 2/3] mm/swap: remove redundant swap device reference in alloc/free
Date: Sat, 21 Mar 2026 02:03:12 +0900
Message-Id: <20260320170313.163386-3-youngjun.park@lge.com>
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

In the previous commit, uswsusp was modified to pin the swap device
when the swap type is determined, ensuring the device remains valid
throughout the hibernation I/O path.

Therefore, it is no longer necessary to repeatedly get and put the swap
device reference for each swap slot allocation and free operation.

For hibernation via the sysfs interface, user-space tasks are frozen
before swap allocation begins, so swapoff cannot race with allocation.
After resume, tasks remain frozen while swap slots are freed, so
additional reference management is not required there either.

Remove the redundant swap device get/put operations from the
hibernation swap allocation and free paths.

Also remove the SWP_WRITEOK check before allocation, as the cluster
allocation logic already validates the swap device state.

Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 mm/swapfile.c | 43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index ac1574acade7..dd9631658808 100644
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
 
 static int __find_hibernation_swap_type(dev_t device, sector_t offset)
-- 
2.34.1

