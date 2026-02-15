Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546CB139D;
	Sun, 15 Feb 2026 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771182046; cv=none; b=bCYNTt/KK30WKylSsBqBqhfoy0i9YaFhu0KlzXrRuJge7MDoL9UUrGT9HT+7EBdj/+XG1K6nzTjBCtLqBktz+3RMQ46zHYobpF4EkRfq7IBGK/6MX5uVa6eu9kFpfsi2gqSpSW/1F2Eu3R5K2gHOzjjAXFOU+L6mrWOVEs75ipw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771182046; c=relaxed/simple;
	bh=wTK7vBuck4Wc7Ro9R5Mj7NtxqG8AwnxBtxe5boxsbpg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KB2AGm9/SlRc6sXctE1uHiRInheJSh+e0TMDBdq36xfoDnd/eoxxyJtGInXC6ZZSvkNjMsuXw4uPwtsBCu077PLVykUvcYTaauWnVXM8wLAqNnYyxuXpueimSnn4sqEuHUcS41Ed5WBWPrr3vOmyYCuUrbmH1ocUYS+KDIQkI+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yy5R6kes; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yy5R6kes"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1CC65C2BC9E;
	Sun, 15 Feb 2026 19:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771182046;
	bh=wTK7vBuck4Wc7Ro9R5Mj7NtxqG8AwnxBtxe5boxsbpg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Yy5R6kesqXoXrKVqGCGp5zq3jrg/VndrjGUBKAr8JT4PCjKGWdbKMERn2zxgL2idJ
	 yP1B81Yw5ciDuiv+2g/So47K/CKdDRWqf0ZGGFmXUEHXcrf+OzSb2gvAAt4TQeC4NP
	 I/WbY9lXtMfGrnEYlVhcYoqECKhBxBh3IE6SDkk+BXvl2iCXIb4FawMc8kalGsddXD
	 ClY3vsvesSt5C2yOpuhsxXlr8D55ngbl0X95ENihFBBDSHoBD9wJAqPE+W5sU0g3AE
	 5l5LF3zTmR75OezDvm6ghrqACFv6PbduaalVm1nY+oGuOTVjmb2yQiq2AqxoBeUDFv
	 RbnpOGQAryVqw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCC9E63F0D;
	Sun, 15 Feb 2026 19:00:46 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Mon, 16 Feb 2026 03:00:26 +0800
Subject: [PATCH v3 2/3] mm, swap: reduce indention for hibernate allocation
 helper
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-hibernate-perf-v3-2-74e025091145@tencent.com>
References: <20260216-hibernate-perf-v3-0-74e025091145@tencent.com>
In-Reply-To: <20260216-hibernate-perf-v3-0-74e025091145@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
 Carsten Grohmann <mail@carstengrohmann.de>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
 "open list:SUSPEND TO RAM" <linux-pm@vger.kernel.org>, 
 Carsten Grohmann <carstengrohmann@gmx.de>, Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771182044; l=2326;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=Er50BTm1CADsw8Sf6/HAwSuhm/4o2yVx7I3U3KWBPIc=;
 b=6R485nSU2o2bmlUPNO4K/iY50QRPl1rzZbPFloZdqJyaeo0dg917Z8y+N6oHRTJOmKCc6S34d
 Ve2gyLpXehHAoSL7/gdAVeYQ3DnjFmOPgzF2YvNccJWX9JFH6/o6w4w
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com

From: Kairui Song <kasong@tencent.com>

It doesn't have to check the device flag, as the allocator will also
check the device flag and refuse to allocate if the device is not
writable. This might cause a trivial waste of CPU cycles of hibernate
allocation raced with swapoff, but that is very unlikely to happen.
Removing the check on the common path should be more helpful.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 38 ++++++++++++++++++--------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 32e0e7545ab8..0d1b17c99221 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1936,27 +1936,25 @@ swp_entry_t swap_alloc_hibernation_slot(int type)
 
 	/* This is called for allocating swap entry, not cache */
 	if (get_swap_device_info(si)) {
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
+		/*
+		 * Try the local cluster first if it matches the device. If
+		 * not, try grab a new cluster and override local cluster.
+		 */
+		local_lock(&percpu_swap_cluster.lock);
+		pcp_si = this_cpu_read(percpu_swap_cluster.si[0]);
+		pcp_offset = this_cpu_read(percpu_swap_cluster.offset[0]);
+		if (pcp_si == si && pcp_offset) {
+			ci = swap_cluster_lock(si, pcp_offset);
+			if (cluster_is_usable(ci, 0))
+				offset = alloc_swap_scan_cluster(si, ci, NULL, pcp_offset);
+			else
+				swap_cluster_unlock(ci);
 		}
+		if (!offset)
+			offset = cluster_alloc_swap_entry(si, NULL);
+		local_unlock(&percpu_swap_cluster.lock);
+		if (offset)
+			entry = swp_entry(si->type, offset);
 		put_swap_device(si);
 	}
 fail:

-- 
2.52.0


