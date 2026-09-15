Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BED53F8EB9
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 03:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442234; cv=none; b=kdU2anhliq+kpAQNM/EXoVmgdfDbs0QMls5+IbxzHjgSknz1ShVndEKV7zArHVscwF3wIZJgbnC1BWnYtC9GtrSWAqL+xeFe/vdvN9he1ZI2X5CoFdj20JK2InsysA/i3vvmsk6MAE9S2ZcrOWgTtCyr11+9wdB+lsEE+RCLJEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442234; c=relaxed/simple;
	bh=EroP4TZUPurCDiZDdfxGU/m3BqG+Ew+gdByx9YmvY7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pnkSp5NNgDaGRMoEdnMw6zBepWaP0Al0/e89ly5safiSDwa+iRFtOjN/K1NX7qWHz6Gau2Asgjnx3vI6oSf7rtG7movB28oXcbOmTQ39mRQmuWKx07boHVbGoImojj6B8IR9ipjF5pG1nTz4pvOvdtjKRE2DszbVU+s2e3VvPe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 15 Sep 2026 12:17:09 +0900
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
Subject: [RFC PATCH 10/10] mm, swap: hold swap space back for a hibernation image at swapon
Date: Tue, 15 Sep 2026 12:16:58 +0900
Message-Id: <20260915031658.1505680-11-youngjun.park@lge.com>
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

Hibernation takes whatever clusters are free when it runs, and an aged
device may have no long run of them.

At swapon, ask hibernation_reserve_pages() how much to hold back and set
aside that many empty clusters in a row.  Nothing uses the device yet,
so this needs no locking.  The run leaves si->pages and goes on no list,
so the allocator never sees it.  Hibernation hands it out whole, before
any other slot.  More than half of a device is refused.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 include/linux/swap.h |  2 ++
 mm/swap_hibernate.c  | 78 ++++++++++++++++++++++++++++++++++++++++----
 mm/swapfile.c        | 23 ++++++++++++-
 3 files changed, 95 insertions(+), 8 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 94c894c7ad9d..66d59828b327 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -249,6 +249,8 @@ struct swap_info_struct {
 					/* list of cluster that are fragmented or contented */
 	unsigned int pages;		/* total of usable pages of swap */
 	atomic_long_t inuse_pages;	/* number of those currently in use */
+	unsigned int hib_reserve_start;	/* clusters held back for hibernation */
+	unsigned int hib_reserve_nr;	/* how many, 0 for none */
 	struct swap_sequential_cluster *global_cluster; /* Use one global cluster for rotating device */
 	spinlock_t global_cluster_lock;	/* Serialize usage of global cluster */
 	struct rb_root swap_extent_root;/* root of the swap extent rbtree */
diff --git a/mm/swap_hibernate.c b/mm/swap_hibernate.c
index 23dc766f04cd..7475ae0966f3 100644
--- a/mm/swap_hibernate.c
+++ b/mm/swap_hibernate.c
@@ -5,10 +5,12 @@
  */
 
 /*
- * The image gets whole free clusters first, then single slots from the
- * allocator.  Clusters it does not use go back when the session ends.
+ * The image gets the run held at swapon first, then whole free clusters,
+ * then single slots from the allocator.  Free clusters it does not use go
+ * back when the session ends.
  */
 static struct swap_info_struct *hib_si;
+static unsigned int hib_reserve;	/* clusters held back, still to hand out */
 
 /* Free clusters set aside for the image, out of the allocator's reach. */
 static LIST_HEAD(hib_free_clusters);
@@ -38,6 +40,56 @@ static void hib_return_free_clusters(struct swap_info_struct *si)
 	spin_unlock(&si->lock);
 }
 
+static bool hib_cluster_reserved(struct swap_info_struct *si, unsigned int idx)
+{
+	return idx >= si->hib_reserve_start &&
+	       idx < si->hib_reserve_start + si->hib_reserve_nr;
+}
+
+/*
+ * Hold a run of empty clusters back for the image.  This runs at swapon
+ * before the device is in use, so it needs no lock.
+ *
+ * Return: the number of pages held, to be taken out of si->pages.
+ */
+static unsigned long hib_reserve_at_swapon(struct swap_info_struct *si,
+					   struct swap_cluster_info *cluster_info,
+					   unsigned long nr_clusters)
+{
+	unsigned long want, run = 0, i;
+
+	si->hib_reserve_start = 0;
+	si->hib_reserve_nr = 0;
+
+	if (!si->bdev)
+		return 0;
+	/* Swap files sharing a block device differ by their first block. */
+	want = DIV_ROUND_UP(hibernation_reserve_pages(si->bdev->bd_dev,
+						      first_se(si)->start_block),
+			    SWAPFILE_CLUSTER);
+	if (!want)
+		return 0;
+	if (want > nr_clusters / 2) {
+		pr_warn("swapon: %lu clusters for the hibernation image is more than half of the device\n",
+			want);
+		return 0;
+	}
+
+	for (i = 0; i < nr_clusters && run < want; i++)
+		run = cluster_info[i].count ? 0 : run + 1;
+	if (run < want) {
+		pr_warn("swapon: no run of %lu clusters for the hibernation image\n",
+			want);
+		return 0;
+	}
+
+	si->hib_reserve_start = i - want;
+	si->hib_reserve_nr = want;
+	pr_info("swapon: holding %lu clusters at %u back for the hibernation image\n",
+		want, si->hib_reserve_start);
+	return want * SWAPFILE_CLUSTER;
+}
+
 /*
  * Take a whole free cluster.  It gets no swap table, so cluster_is_usable()
  * keeps the allocator away from it.
@@ -130,6 +182,7 @@ static void hib_session_begin(struct swap_info_struct *si)
 	if (hib_si)
 		hib_return_free_clusters(hib_si);
 	hib_si = si;
+	hib_reserve = si->hib_reserve_nr;
 }
 
 static void hib_session_end(void)
@@ -189,6 +242,13 @@ swp_entry_t swap_alloc_hibernation_slot(unsigned int *nr)
 	if (WARN_ON_ONCE(!si))
 		return entry;
 
+	if (hib_reserve) {
+		*nr = hib_reserve * SWAPFILE_CLUSTER;
+		hib_reserve = 0;
+		return swp_entry(si->type,
+				 si->hib_reserve_start * SWAPFILE_CLUSTER);
+	}
+
 	len = hib_take_free(si, &start);
 	if (!len) {
 		start = hib_alloc_slot(si);
@@ -218,10 +278,13 @@ void swap_free_hibernation_slot(swp_entry_t entry, unsigned int nr)
 		ci_off = offset % SWAPFILE_CLUSTER;
 		count = min(nr, SWAPFILE_CLUSTER - ci_off);
 		ci = swap_cluster_lock(si, offset);
-		if (cluster_table_is_alloced(ci))
-			__swap_cluster_free_entries(si, ci, ci_off, count);
-		else
-			hib_put_cluster_slots(si, ci, ci_off, count);
+		/* A cluster held for the image is left as it is. */
+		if (!hib_cluster_reserved(si, cluster_index(si, ci))) {
+			if (cluster_table_is_alloced(ci))
+				__swap_cluster_free_entries(si, ci, ci_off, count);
+			else
+				hib_put_cluster_slots(si, ci, ci_off, count);
+		}
 		swap_cluster_unlock(ci);
 		offset += count;
 		nr -= count;
@@ -472,7 +535,8 @@ unsigned int count_swap_pages(int type, int free)
 
 		spin_lock(&sis->lock);
 		if (sis->flags & SWP_WRITEOK) {
-			n = sis->pages;
+			/* the run held back is there for the image */
+			n = sis->pages + sis->hib_reserve_nr * SWAPFILE_CLUSTER;
 			if (free)
 				n -= swap_usage_in_pages(sis);
 		}
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 98ed75708661..3b79cec6fd27 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2182,6 +2182,18 @@ void swap_put_entries_direct(swp_entry_t entry, int nr)
 
 #ifdef CONFIG_HIBERNATION
 #include "swap_hibernate.c"
+#else
+static unsigned long hib_reserve_at_swapon(struct swap_info_struct *si,
+					   struct swap_cluster_info *cluster_info,
+					   unsigned long nr_clusters)
+{
+	return 0;
+}
+
+static bool hib_cluster_reserved(struct swap_info_struct *si, unsigned int idx)
+{
+	return false;
+}
 #endif /* CONFIG_HIBERNATION */
 
 static inline int pte_same_as_swp(pte_t pte, pte_t swp_pte)
@@ -3379,6 +3391,13 @@ static int setup_swap_clusters_info(struct swap_info_struct *si,
 			goto err;
 	}
 
+	/*
+	 * Whatever is held back for a hibernation image leaves si->pages, so
+	 * that it is never advertised as swap, and it goes on no list below,
+	 * so that the allocator cannot find it.
+	 */
+	si->pages -= hib_reserve_at_swapon(si, cluster_info, nr_clusters);
+
 	INIT_LIST_HEAD(&si->free_clusters);
 	INIT_LIST_HEAD(&si->full_clusters);
 	INIT_LIST_HEAD(&si->discard_clusters);
@@ -3391,7 +3410,9 @@ static int setup_swap_clusters_info(struct swap_info_struct *si,
 	for (i = 0; i < nr_clusters; i++) {
 		struct swap_cluster_info *ci = &cluster_info[i];
 
-		if (ci->count) {
+		if (hib_cluster_reserved(si, i)) {
+			ci->flags = CLUSTER_FLAG_NONE;
+		} else if (ci->count) {
 			ci->flags = CLUSTER_FLAG_NONFULL;
 			list_add_tail(&ci->list, &si->nonfull_clusters[0]);
 		} else {
-- 
2.48.1

