Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A11A3F8E0F
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 18:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773771213; cv=none; b=hqFfI2R+ToXjvvskxEX0Vz6Invt5jkjt+34RaQfo8UauRNmfvw+dxXuo+lDoX1NddhyvwV8fq0xcJDfOvgDQ3UH9t+mU43bjB4fTH1sWZXjgwx1z3WS7wxK1ILQbFzj1YKekRsidmDt70fimS4QisyhF5VZH/a5yp2ytHpkMBNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773771213; c=relaxed/simple;
	bh=TJTW2Mf8G3sEV4bEuCCBlHWHOoqFFDz4IEaLwLIS8N8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kGSJpD1HCp84M+OtMsjv12yhghpeEPMriU4uRTuwaP/d6aB3UNpIZRJI2j/te+1rwuPg+6LVedODQantnAVCuiWdpntxOBt49js4CTerOZOH+rYcNZwq9R6UWLb31CvqcGDGxcewtr1YD5vVNlJEg0sIVhpeCX4CPFVTM6qc3XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 18 Mar 2026 03:13:24 +0900
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
Subject: [PATCH v4 2/3] mm/swap: remove redundant swap device reference in alloc/free
Date: Wed, 18 Mar 2026 03:13:17 +0900
Message-Id: <20260317181318.2517015-3-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317181318.2517015-1-youngjun.park@lge.com>
References: <20260317181318.2517015-1-youngjun.park@lge.com>
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
 mm/swapfile.c | 62 +++++++++++++++++++++++++--------------------------
 1 file changed, 30 insertions(+), 32 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 7baa0f270cff..73159535b085 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2078,7 +2078,12 @@ void swap_put_entries_direct(swp_entry_t entry, int nr)
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
 	struct swap_info_struct *pcp_si, *si = swap_type_to_info(type);
@@ -2089,46 +2094,40 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
 	if (!si)
 		goto fail;
 
-	/* This is called for allocating swap entry, not cache */
-	if (get_swap_device_info(si)) {
-		if (si->flags & SWP_WRITEOK) {
-			/*
-			 * Try the local cluster first if it matches the device. If
-			 * not, try grab a new cluster and override local cluster.
-			 */
-			local_lock(&percpu_swap_cluster.lock);
-			pcp_si = this_cpu_read(percpu_swap_cluster.si[0]);
-			pcp_offset = this_cpu_read(percpu_swap_cluster.offset[0]);
-			if (pcp_si == si && pcp_offset) {
-				ci = swap_cluster_lock(si, pcp_offset);
-				if (cluster_is_usable(ci, 0))
-					offset = alloc_swap_scan_cluster(si, ci, NULL, pcp_offset);
-				else
-					swap_cluster_unlock(ci);
-			}
-			if (!offset)
-				offset = cluster_alloc_swap_entry(si, NULL);
-			local_unlock(&percpu_swap_cluster.lock);
-			if (offset)
-				entry = swp_entry(si->type, offset);
-		}
-		put_swap_device(si);
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
 	}
+	if (!offset)
+		offset = cluster_alloc_swap_entry(si, NULL);
+	local_unlock(&percpu_swap_cluster.lock);
+	if (offset)
+		entry = swp_entry(si->type, offset);
+
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
 	__swap_cluster_put_entry(ci, offset % SWAPFILE_CLUSTER);
 	__swap_cluster_free_entries(si, ci, offset % SWAPFILE_CLUSTER, 1);
@@ -2136,7 +2135,6 @@ void swap_free_hibernation_slot(swp_entry_t entry)
 
 	/* In theory readahead might add it to the swap cache by accident */
 	__try_to_reclaim_swap(si, offset, TTRS_ANYWAY);
-	put_swap_device(si);
 }
 
 static int swap_type_of(dev_t device, sector_t offset)
-- 
2.34.1

