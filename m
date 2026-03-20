Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1483D0914
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774026206; cv=none; b=a/nipiTmcfXrpTU5amAwKeoJrBf2oGwYGFFq/hfaMJVpmgYZOsbIgIcF5G6vTrYfSUmfZMTpMOUd6jJsHYnqSA2jJpoTj0C3Zg5SdCVeiShG6kyVjJSFMH5Sr8bHhe22xDiE8hzwBq7LVPuoIB4iUfGO5Y2mA3s3qAIewW/yvyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774026206; c=relaxed/simple;
	bh=tOsfc8vGXSTckwD4O/zUMHNKk1lqXzlTXuZPqMotYA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EvU+DBWDuJFnjI+IFzBBKU5+NQxuWu2biPNOUAiZJ9f+/1jaXW53M5YuFOs0+aHGvhABrhXF0sWeUmxJF8LMm0dtbY+VBgPz88vwTq7HpdRXUl5JfR/6UX6bGIx9z0XBtI1NYWj8nsUUUqWgJPFhrws5XtopDoAYfIA00ndlTkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 21 Mar 2026 02:03:14 +0900
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
Subject: [PATCH v6 0/3] mm/swap, PM: hibernate: fix swapoff race and optimize swap
Date: Sat, 21 Mar 2026 02:03:10 +0900
Message-Id: <20260320170313.163386-1-youngjun.park@lge.com>
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
- Patch 3: Fixes a spurious WARNING in the uswsusp GFP mask restore path.
  (Found during uswsusp test)

Links:
RFC v1: https://lore.kernel.org/linux-mm/20260305202413.1888499-1-usama.arif@linux.dev/T/#m3693d45180f14f441b6951984f4b4bfd90ec0c9d
RFC v2: https://lore.kernel.org/linux-mm/20260306024608.1720991-1-youngjun.park@lge.com/
RFC v3: https://lore.kernel.org/linux-mm/20260312112511.3596781-1-youngjun.park@lge.com/
v4: https://lore.kernel.org/linux-mm/abv+rjgyArqZ2uym@yjaykim-PowerEdge-T330/T/#m924fa3e58d0f0da488300653163ee8db7e870e4a
v5: https://lore.kernel.org/linux-mm/ab0YEn+Fd41q6LM7@yjaykim-PowerEdge-T330/T/#m8409d470c68cb152b0849940759bff7d7806f397

Testing:
- Hibernate/resume via sysfs
  (echo reboot > /sys/power/disk && echo disk > /sys/power/state)
- Hibernate with suspend via sysfs
  (echo suspend > /sys/power/disk && echo disk > /sys/power/state)
- Hibernate/resume via uswsusp (suspend-utils s2disk/resume on QEMU)
  - Verified swap I/O works correctly after resume.
  - Verified swapoff succeeds after snapshot resume completes.
  - Verified pm_restore_gfp_mask() WARNING no longer triggers (Patch 3).
  - Verified SNAPSHOT_FREEZE followed by snapshot_release() does not
    trigger pm_restore_gfp_mask() WARNING (Patch 3).
- swapoff during active uswsusp session:
  - Verified swapoff returns -EBUSY while swap device is pinned (Patch 1).
  - Verified swapoff succeeds after uswsusp process terminates.

Changelog:
v5 -> v6:
 - Replaced get/put reference approach with SWP_HIBERNATION
   pinning to prevent swapoff, per Kairui's feedback.  Renamed helpers
   from get/find/put_hibernation_swap_type() to
   pin/find/unpin_hibernation_swap_type().
 - Removed swapoff waiting on hibernation reference.
   swapoff now returns -EBUSY immediately when the swap device is
   pinned.
 - Updated function comments per Kairui's review.
 - Updated commit message.
 - Fixed pm_restore_gfp_mask_safe() to use saved_gfp_count
   check instead of saved_gfp_mask, and hold system_transition_mutex
   for the check.  Addressed AI review finding that SNAPSHOT_FREEZE
   followed by snapshot_release() could still trigger the WARNING.

v4 -> v5:
 - Rebased onto v7.0-rc4 (Rafael J. Wysocki comment)
 - No functional changes. rebase conflict fix.

rfc v3 -> v4:
 - Introduced get/find/put_hibernation_swap_type() helpers per Kairui's
   feedback. find_ for lookup-only, get/put for reference management.
 - Switched to swap_type_to_info() and added type < 0 check per
   Kairui's suggestion.
 - Fixed get_hibernation_swap_type() return when ref == false (Reviewed by Kairui)
 - Made swapoff wait interruptible to prevent hang when uswsusp
   holds a swap reference.
 - Fixed spurious WARN_ON in pm_restore_gfp_mask() by introducing
   pm_restore_gfp_mask_safe() (Patch 3).
 - Updated commit messages and added comments for clarity.
 - Rebased onto latest mm-new tree.

rfc v2 -> rfc v3:
 - Split into 2 patches per Chris Li's feedback.
 - Simplified by not holding reference in normal hibernation path
   per Chris Li's suggestion.
 - Removed redundant SWP_WRITEOK check.
 - Rebased onto f543926f9d0c3f6dfb354adfe7fbaeedd1277c6b.

rfc v1 -> rfc v2:
 - Squashed into single patch per Usama Arif's feedback.

Youngjun Park (3):
  mm/swap, PM: hibernate: fix swapoff race in uswsusp by pinning swap
    device
  mm/swap: remove redundant swap device reference in alloc/free
  PM: hibernate: fix spurious GFP mask WARNING in uswsusp path

 include/linux/suspend.h |   1 +
 include/linux/swap.h    |   5 +-
 kernel/power/main.c     |  18 ++++
 kernel/power/swap.c     |   2 +-
 kernel/power/user.c     |  21 +++--
 mm/swapfile.c           | 178 +++++++++++++++++++++++++++++++---------
 6 files changed, 178 insertions(+), 47 deletions(-)


base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
-- 
2.34.1

