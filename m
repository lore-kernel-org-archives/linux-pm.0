Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5473E45C0B;
	Sun, 15 Feb 2026 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771182046; cv=none; b=XWefdkYSG8+zcSl1QL8Ic++7nyVzZALB/ka7YOeioDdG6SYr7lImYDeYZN0tNngAS1TqlAtn1YHcPq1gJjYBbG6K0tBztGHxQjMJi8V5JHAe04/EwSPH9Lxf9JjMfkMR5+KvV+s+BI+NI5nRFEXXIjt/PTxt/7hrmki0u5OT9Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771182046; c=relaxed/simple;
	bh=ijCT+Mg7d3790XUMIRWeaMLVEKai5+A/PxJRt61VFl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t8XbF2HRR2F4huQK6QI3XLQzdVpwYLm66nJ5wYfyei9oOtvST1RXSTB3o3apwiPgViCc5hEc6h+NOZVw9ZFH8zGa4eH2yGutegngg4WgqTPtcRyxghwSZU0wCXy1QFAmI6au1RJHfGsbq8tbXyaPizpTzqs3t8/8RizuhvtAvRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LShGTUaK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LShGTUaK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F206C19423;
	Sun, 15 Feb 2026 19:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771182046;
	bh=ijCT+Mg7d3790XUMIRWeaMLVEKai5+A/PxJRt61VFl4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LShGTUaKXyZSjrhS6kwYIBt9hwvtSZhKlGZ3HR5nedonqog3puYIOht/6vFCjqTal
	 plQBeXpP/93WLZBN6lsrIvrqsqhSuqp6SQgf4qRj8bi2hf1RRyEmrT5iPAQMW0KGqv
	 W32voWw9gmpyrIbRs62TdMAElqJ9DZa+0NLjrAw3cknSmdgbEQ/V4XgNUtfPK8Xwpz
	 B4i72hk0ZKsxsuql1hIdGObH7NMvKG6VVoCLpujon5PodgwPCBZbLM6TN3DrG/zQgo
	 oRd4N/sGgPQYeLP6fjRp6pbo4vp4ZKnPhvlZrTZrC7d9aieSMiTjd5hB7T3X4D+IEM
	 6m3Xjc0Rplf5Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6A4E63F0B;
	Sun, 15 Feb 2026 19:00:45 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Mon, 16 Feb 2026 03:00:25 +0800
Subject: [PATCH v3 1/3] mm, swap: speed up hibernation allocation and
 writeout
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-hibernate-perf-v3-1-74e025091145@tencent.com>
References: <20260216-hibernate-perf-v3-0-74e025091145@tencent.com>
In-Reply-To: <20260216-hibernate-perf-v3-0-74e025091145@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
 Carsten Grohmann <mail@carstengrohmann.de>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
 "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, 
 Carsten Grohmann <carstengrohmann@gmx.de>, Kairui Song <kasong@tencent.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771182044; l=2673;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=AP2Agry4RlYj89KzjPUleAMF+xnfApgEpjtkm4VqQJg=;
 b=oWPcjSUKtm8Q5thSWVCe+iAtBfoyhjpcOXkpVbNik48lhQotclHLHkRYpDUJ3lggMApH+ajKj
 ubJcoDilvf7DOAEJdCiVlTXLq6u98zsCp55n45Ahcmc5887iscwJsNb
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com

From: Kairui Song <kasong@tencent.com>

Since commit 0ff67f990bd4 ("mm, swap: remove swap slot cache"),
hibernation has been using the swap slot slow allocation path for
simplification, which turns out might cause regression for some
devices because the allocator now rotates clusters too often, leading to
slower allocation and more random distribution of data.

Fast allocation is not complex, so implement hibernation support as
well.

Test result with Samsung SSD 830 Series (SATA II, 3.0 Gbps) shows the
performance is several times better [1]:
6.19:               324 seconds
After this series:  35 seconds

Fixes: 0ff67f990bd4 ("mm, swap: remove swap slot cache")
Reported-by: Carsten Grohmann <mail@carstengrohmann.de>
Closes: https://lore.kernel.org/linux-mm/20260206121151.dea3633d1f0ded7bbf49c22e@linux-foundation.org/
Link: https://lore.kernel.org/linux-mm/8b4bdcfa-ce3f-4e23-839f-31367df7c18f@gmx.de/ [1]
Cc: stable@vger.kernel.org
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index c6863ff7152c..32e0e7545ab8 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1926,8 +1926,9 @@ void swap_put_entries_direct(swp_entry_t entry, int nr)
 /* Allocate a slot for hibernation */
 swp_entry_t swap_alloc_hibernation_slot(int type)
 {
-	struct swap_info_struct *si = swap_type_to_info(type);
-	unsigned long offset;
+	struct swap_info_struct *pcp_si, *si = swap_type_to_info(type);
+	unsigned long pcp_offset, offset = SWAP_ENTRY_INVALID;
+	struct swap_cluster_info *ci;
 	swp_entry_t entry = {0};
 
 	if (!si)
@@ -1937,11 +1938,21 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
 	if (get_swap_device_info(si)) {
 		if (si->flags & SWP_WRITEOK) {
 			/*
-			 * Grab the local lock to be compliant
-			 * with swap table allocation.
+			 * Try the local cluster first if it matches the device. If
+			 * not, try grab a new cluster and override local cluster.
 			 */
 			local_lock(&percpu_swap_cluster.lock);
-			offset = cluster_alloc_swap_entry(si, NULL);
+			pcp_si = this_cpu_read(percpu_swap_cluster.si[0]);
+			pcp_offset = this_cpu_read(percpu_swap_cluster.offset[0]);
+			if (pcp_si == si && pcp_offset) {
+				ci = swap_cluster_lock(si, pcp_offset);
+				if (cluster_is_usable(ci, 0))
+					offset = alloc_swap_scan_cluster(si, ci, NULL, pcp_offset);
+				else
+					swap_cluster_unlock(ci);
+			}
+			if (!offset)
+				offset = cluster_alloc_swap_entry(si, NULL);
 			local_unlock(&percpu_swap_cluster.lock);
 			if (offset)
 				entry = swp_entry(si->type, offset);

-- 
2.52.0


