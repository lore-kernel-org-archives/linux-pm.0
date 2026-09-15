Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F3D40096C
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 03:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442236; cv=none; b=d+ygrtDyi/UqkAYusLy7HKhYKk4NpeHN7k6bNmiW47T3i6TB425A67GAu9pk3RsgnKpMI3T2NcfzyQ8hiihN9dNcRDVIQDnyfWvS++FDGQovxQasWIIdezXqkNMsEQx2Wys2NCSvB29Jfntv9C1VUU62UbLH/DoBpELFIByvGvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442236; c=relaxed/simple;
	bh=ERPUWqCEnmDH/TqO5KSwzaB3t9iKDQhSMwnmByYszD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j8tzCx9yyX7P19OZCAndeSQx8y1UAmKTN57jTj4pbOQJE3nyTXkr914vLbWW2S8IZNVFYrOY3m1nCaNZxH5/IOR/KFScPFcb6dUxm70AZebkKZ8/2rqkt8Dw21gLbUsy9nY2UmgjJkQtd658vHx8EVLq5OwE1L5+GMWC+D8I/o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 15 Sep 2026 12:17:06 +0900
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
Subject: [RFC PATCH 04/10] mm, swap: skip swap cache reclaim while storage is suspended
Date: Tue, 15 Sep 2026 12:16:52 +0900
Message-Id: <20260915031658.1505680-5-youngjun.park@lge.com>
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

folio_swapcache_freeable() refuses every folio for as long as
pm_suspended_storage() holds, and that covers the whole window in which
the hibernation image is written.  Every reclaim attempt the allocator
makes there drops the cluster lock, looks the folio up, trylocks it and
gives up.  swap_reclaim_full_clusters() walks a whole cluster to do it.

Stop trying.  The allocator is left with the slots that are already
free, which is all reclaim could have given it anyway.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 mm/swapfile.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 07aefb782fbe..cf519c5569c4 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -903,7 +903,7 @@ static bool cluster_scan_range(struct swap_info_struct *si,
 		if (swp_tb_is_null(swp_tb))
 			continue;
 		if (swp_tb_is_folio(swp_tb) && !__swp_tb_get_count(swp_tb)) {
-			if (!vm_swap_full())
+			if (!vm_swap_full() || pm_suspended_storage())
 				return false;
 			*need_reclaim = true;
 			continue;
@@ -1050,6 +1050,10 @@ static void swap_reclaim_full_clusters(struct swap_info_struct *si, bool force)
 	unsigned long swp_tb;
 	int nr_reclaim;
 
+	/* Swap cache cannot be freed while storage is suspended. */
+	if (pm_suspended_storage())
+		return;
+
 	if (force)
 		to_scan = swap_usage_in_pages(si) / SWAPFILE_CLUSTER;
 
@@ -1315,7 +1319,7 @@ static void swap_range_alloc(struct swap_info_struct *si,
 			     unsigned int nr_entries)
 {
 	if (swap_usage_add(si, nr_entries)) {
-		if (vm_swap_full())
+		if (vm_swap_full() && !pm_suspended_storage())
 			schedule_work(&si->reclaim_work);
 	}
 	atomic_long_sub(nr_entries, &nr_swap_pages);
-- 
2.48.1

