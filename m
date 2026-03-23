Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5F53B9D9F
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 16:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282112; cv=none; b=pNPaQFkdHeWEZIvv1txn5xaoEQclXzicV/E6VWMN1ew7Oa81SNtJypznyrGev+5IBjcEEw2HIOlc+sk+efSu4RszNcEpYRIcnLLjHOj9mE/DnxHCUgEbL38U86+zRxCT7V0BVcZzXi5p6Q6TMI+ddvfNcEZlrXlI+erQqbinsOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282112; c=relaxed/simple;
	bh=58UDlEsUqIyv5uMucWLbnEYkU0DG7+LHUZEfQ2e6YoE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jDjss6HLudWiE3r2HrCbbcFQz2OOht/ednW8sZuBeXaAUFPZO7EeoYJ5JQx8UvuEzopHwy2dkUOclUsrSj9dCT4/6wjRj2I+q2PrJqZlYxu6HQjHo8Y4FLhI/HiWuoNnarQvjbVqov4L3hgfo7vhaHYQgFgUNYVvGmSmsee6bf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 24 Mar 2026 01:08:24 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
From: Youngjun Park <youngjun.park@lge.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Pavel Machek <pavel@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Usama Arif <usama.arif@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v8 0/2] mm/swap, PM: hibernate: fix swapoff race in uswsusp by pinning swap device
Date: Tue, 24 Mar 2026 01:08:20 +0900
Message-Id: <20260323160822.1409904-1-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, in the uswsusp path, only the swap type value is retrieved at
lookup time without holding a reference. If swapoff races after the type
is acquired, subsequent slot allocations operate on a stale swap device.

Additionally, grabbing and releasing the swap device reference on every
slot allocation is inefficient across the entire hibernation swap path.

This patch series addresses these issues:
- Patch 1: Fixes the swapoff race in uswsusp by pinning the swap device
  from the point it is looked up until the session completes.
- Patch 2: Removes the overhead of per-slot reference counting in alloc/free
  paths and cleans up the redundant SWP_WRITEOK check.

Rebased onto mm-new per Andrew's suggestion [1]. The si->flags race
flagged by AI review in v7 (between SWP_HIBERNATION and cont_lock in
add_swap_count_continuation) and the proposed fixes discussed there
(atomic ops for si->flags, or serializing with swap_lock) are all moot
on mm-new since Kairui's series removed that code path entirely.
kernel/power/ changes are small, so Andrew proposed carrying everything
through mm-new.

Rafael, could you ack the PM-side changes?

Re-tested on mm-new (c51ea78c5466) with hibernate/resume cycles and
uswsusp paths. Also ran an additional round of AI review against the
rebased version, no new issues found.

[1] https://lore.kernel.org/linux-mm/20260322093038.25a7fd51f5d564b85815db7a@linux-foundation.org/

Links:
RFC v1: https://lore.kernel.org/linux-mm/20260305202413.1888499-1-usama.arif@linux.dev/T/#m3693d45180f14f441b6951984f4b4bfd90ec0c9d
RFC v2: https://lore.kernel.org/linux-mm/20260306024608.1720991-1-youngjun.park@lge.com/
RFC v3: https://lore.kernel.org/linux-mm/20260312112511.3596781-1-youngjun.park@lge.com/
v4: https://lore.kernel.org/linux-mm/abv+rjgyArqZ2uym@yjaykim-PowerEdge-T330/T/#m924fa3e58d0f0da488300653163ee8db7e870e4a
v5: https://lore.kernel.org/linux-mm/ab0YEn+Fd41q6LM7@yjaykim-PowerEdge-T330/T/#m8409d470c68cb152b0849940759bff7d7806f397
v6: https://lore.kernel.org/linux-mm/20260320182227.896f9ab62d62961b2caab5f7@linux-foundation.org/T/#m10ee3346cd8dcd052749105d9a8e2052dbf3bc80
v7: https://lore.kernel.org/linux-mm/ab/20260321103309.439265-1-youngjun.park@lge.com/

Testing:
- Hibernate/resume via sysfs
  (echo reboot > /sys/power/disk && echo disk > /sys/power/state)
- Hibernate with suspend via sysfs
  (echo suspend > /sys/power/disk && echo disk > /sys/power/state)
- Hibernate/resume via uswsusp (suspend-utils s2disk/resume on QEMU)
  - Verified swap I/O works correctly after resume.
  - Verified swapoff succeeds after snapshot resume completes.
- swapoff during active uswsusp session:
  - Verified swapoff returns -EBUSY while swap device is pinned (Patch 1).
  - Verified swapoff succeeds after uswsusp process terminates.

Changelog:
v7 -> v8:
 - Rebased onto mm-new per Andrew Morton's suggestion.
 - Clarified function comments (SWP_HIBERNATION pinning).
 - Re-tested and AI-reviewed on mm-new; no new issues found.

v6 -> v7:
 - Dropped Patch 3 (pm_restore_gfp_mask fix) from series as it has
   no dependency on Patches 1-2. Will be sent separately.
   (Rafael J. Wysocki feedback)

v5 -> v6:
 - Replaced get/put reference approach with SWP_HIBERNATION
   pinning to prevent swapoff, per Kairui's feedback.  Renamed helpers
   from get/find/put_hibernation_swap_type() to
   pin/find/unpin_hibernation_swap_type().
 - Renamed swap_type_of() to __find_hibernation_swap_type() since
   it is now an internal helper with no external callers.
 - Removed swapoff waiting on hibernation reference.
   swapoff now returns -EBUSY immediately when the swap device is
   pinned.
 - Updated function comments per Kairui's review.

v4 -> v5:
 - Rebased onto v7.0-rc4 (Rafael J. Wysocki comment)
 - No functional changes.

rfc v3 -> v4:
 - Introduced get/find/put_hibernation_swap_type() helpers per Kairui's
   feedback.
 - Switched to swap_type_to_info() and added type < 0 check.
 - Fixed get_hibernation_swap_type() return when ref == false.
 - Made swapoff wait interruptible to prevent hang when uswsusp
   holds a swap reference.

rfc v2 -> rfc v3:
 - Split into 2 patches per Chris Li's feedback.
 - Simplified by not holding reference in normal hibernation path.
 - Removed redundant SWP_WRITEOK check.

rfc v1 -> rfc v2:
 - Squashed into single patch per Usama Arif's feedback.

Youngjun Park (2):
  mm/swap, PM: hibernate: fix swapoff race in uswsusp by pinning swap
    device
  mm/swap: remove redundant swap device reference in alloc/free

 include/linux/swap.h |   5 +-
 kernel/power/swap.c  |   2 +-
 kernel/power/user.c  |  15 +++-
 mm/swapfile.c        | 203 +++++++++++++++++++++++++++++++++----------
 4 files changed, 172 insertions(+), 53 deletions(-)

base-commit: c51ea78c5466be89914cbfbe2618dea67026c2b1
-- 
2.34.1

