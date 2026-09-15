Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A851A402B8C
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 03:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442236; cv=none; b=Ppx6n+aBSmLZhESRoxqML57vDQoFozf3IKnLIFKWNii6/lhLoKLNVx0L/PJY7bs5FlKGoIJdDiH+DZP29/tEAIaYlFKuiCPBsH8Ln+ksTq12VO9wo1BfxvU3HKPsLK1rkEgDFGi1PSPP997wrxnmFPR5c2eTpkp5Q3rorAizky8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442236; c=relaxed/simple;
	bh=sb2wokat7uqjbcdvIm78qSEAsBhA0XHqkmBYI+sS35A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HMhgruDxUhD4qTKkLDJYbJ+BqtyK0oPmM2OxcnHujaQuywq0N6lX9XoeDYActtiVHecVFB1WGDysfSI+u57QYBFXPmkSmmG3OXJ0QlDdgEMaKHvSaDR00lWhhyCbSghzNHXS2pJ0XvVKV+jQNajDkngK7CUqaNJhHgs3TLbtat0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 15 Sep 2026 12:17:07 +0900
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
Subject: [RFC PATCH 06/10] mm, swap: hand the image's free clusters out in disk order
Date: Tue, 15 Sep 2026 12:16:54 +0900
Message-Id: <20260915031658.1505680-7-youngjun.park@lge.com>
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

The clusters set aside for the image come off the free list in the order
they were freed, so on a device that has been in use the image is
written back and forth across it.

Sort them by cluster index once they are set aside, so the image is
written front to back.  A rotating disk then writes it and reads it back
without seeking back and forth.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 mm/swap_hibernate.c | 9 +++++++++
 mm/swapfile.c       | 1 +
 2 files changed, 10 insertions(+)

diff --git a/mm/swap_hibernate.c b/mm/swap_hibernate.c
index 3431443716d4..23dc766f04cd 100644
--- a/mm/swap_hibernate.c
+++ b/mm/swap_hibernate.c
@@ -13,11 +13,20 @@ static struct swap_info_struct *hib_si;
 /* Free clusters set aside for the image, out of the allocator's reach. */
 static LIST_HEAD(hib_free_clusters);
 
+static int hib_cluster_cmp(void *priv, const struct list_head *a,
+			   const struct list_head *b)
+{
+	return list_entry(a, struct swap_cluster_info, list) <
+	       list_entry(b, struct swap_cluster_info, list) ? -1 : 1;
+}
+
 static void hib_claim_free_clusters(struct swap_info_struct *si)
 {
 	spin_lock(&si->lock);
 	list_splice_tail_init(&si->free_clusters, &hib_free_clusters);
 	spin_unlock(&si->lock);
+
+	list_sort(NULL, &hib_free_clusters, hib_cluster_cmp);
 }
 
 static void hib_return_free_clusters(struct swap_info_struct *si)
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 86ed8c6adae7..98ed75708661 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -38,6 +38,7 @@
 #include <linux/swapfile.h>
 #include <linux/export.h>
 #include <linux/sort.h>
+#include <linux/list_sort.h>
 #include <linux/completion.h>
 #include <linux/suspend.h>
 #include <linux/zswap.h>
-- 
2.48.1

