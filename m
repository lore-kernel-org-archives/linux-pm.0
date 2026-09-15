Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE2D339872
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 03:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442235; cv=none; b=NWt3UNjpOkxrZBupHpDjmqnBrGPFaCpu8HReG7iOHRW5U9tfrcRe5mfbPVaalFTrTzkhXIADKByfk5eM5FbsZ43C16+pmRh2BysNnykkEA38DcgWMmdYQiCEpPlUafSqu5+JYGyqxnUAkgAUY/tfiziYH2Udf3jXWFDQkM90Aw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442235; c=relaxed/simple;
	bh=pMqCB93UmlB8zK3uEqfY1HJPYZX5thwiFhBlsJhKkfM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Prez40g9xCi+C9LXUKHTfgCz15/bdDmjtWWd1ET3A8mT5ixYKWnDgPuzWLFbtIfPESG9/2uok5Mzwt08KOfxAF2QC9O7Kj83HpGmSrUfamdpYG8uj/H5Mn6MNgbe0tyjMuV0bpHB2PLPqkCggav1nWPj8MDC0+QzDYP+QZrUHIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 15 Sep 2026 12:17:04 +0900
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
Subject: [RFC PATCH 02/10] mm, swap: skip swap devices without a block device in hibernation lookups
Date: Tue, 15 Sep 2026 12:16:50 +0900
Message-Id: <20260915031658.1505680-3-youngjun.park@lge.com>
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

A swapfile on NFS or SMB3 has no block device, so claim_swapfile()
leaves si->bdev NULL.  __find_hibernation_swap_type() and
find_first_swap() dereference it without checking.

Hibernation cannot use such a device anyway.  Skip it.

Fixes: 21bd900572f3 ("mm: split swap_type_of")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Youngjun Park <youngjun.park@lge.com>
---
 mm/swapfile.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 592ca26a5c0b..655f2647472c 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2238,7 +2238,7 @@ static int __find_hibernation_swap_type(dev_t device, sector_t offset)
 	for (type = 0; type < nr_swapfiles; type++) {
 		struct swap_info_struct *sis = swap_info[type];
 
-		if (!(sis->flags & SWP_WRITEOK))
+		if (!(sis->flags & SWP_WRITEOK) || !sis->bdev)
 			continue;
 
 		if (device == sis->bdev->bd_dev) {
@@ -2425,7 +2425,7 @@ int find_first_swap(dev_t *device)
 	for (type = 0; type < nr_swapfiles; type++) {
 		struct swap_info_struct *sis = swap_info[type];
 
-		if (!(sis->flags & SWP_WRITEOK))
+		if (!(sis->flags & SWP_WRITEOK) || !sis->bdev)
 			continue;
 		*device = sis->bdev->bd_dev;
 		spin_unlock(&swap_lock);
-- 
2.48.1

