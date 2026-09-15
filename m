Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE20B3DFC8A
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 03:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789442235; cv=none; b=nHfC70n2TlRB+60ZLYzoXRTjlXtWo56sg220M1uuwuS/ufWILV33Ea9n18+HtMYa4WMkwD3Yl2zb531DelwDI/cKJzL3TzmC8iBat7kd0GeZmUiUrtq//16uZI/X8qg/TWVwZQsLtF7NunfbFdES4+/HDhciq9XYVu/jr5DYIOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789442235; c=relaxed/simple;
	bh=ziRl0L1J/z5R4bsH7gRbYffCcNXrgpvVJUCghl2A2Tw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A/yNBAO942j6DJDqjNPKXyOOcbw7sB8yOyUWBV5mPJK8m+dCAIQ6kWGexLaRVcDNiXJnkGE5DpIZT5Mfilq5ZSWqYr9ZSknFmq8ylIxGnBlyBt3FJYSTAjnsMhw4c1wBMwp8IOG3zJljbCEvEHhqMKe2Sp7AGPHdzwwG5mK1J+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330.lge.net) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 15 Sep 2026 12:17:03 +0900
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
Subject: [RFC PATCH 00/10] mm/swap, PM: hibernate: improve image slot allocation and I/O
Date: Tue, 15 Sep 2026 12:16:48 +0900
Message-Id: <20260915031658.1505680-1-youngjun.park@lge.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series improves how hibernation allocates swap slots for its
image.  It starts from a few observations about what happens while
the image is written.  With them the allocator can hand the image
contiguous runs, the image I/O can be batched per run, and
hibernation gets faster. Contiguous I/O pattern is friendly to flash device also.

Slot allocation matters for hibernation speed.  After commit
0ff67f990bd4 ("mm, swap: remove swap slot cache") in v6.15, writing
the image was about ten times slower on some SSDs [1], until
commit 396f57b57200 ("mm, swap: speed up hibernation allocation and
writeout") fixed it in v7.1.

Note
 - I was responsible for the observation and design, 
 while receiving substantial support from LLMs throughout the series.
-  Submitting this patch to confirm whether this work is progressing or not.

Observations
============

1. While the image is written, swap can only hand out slots that are
   already free.  Swap cache cannot be reclaimed to make more.

   folio_swapcache_freeable() refuses every folio while storage is
   suspended.  The image may already hold a folio as clean swap cache.
   If its slot were freed and reused for the image, the resumed kernel
   could later drop that folio and read it back from the slot, now
   with the wrong data.

   Storage is suspended before the image is written, so every
   allocation for the image falls in that window.

     hibernate()
       freeze_processes()                user space is frozen
       hibernation_snapshot()
         freeze_kernel_threads()         kswapd is frozen
         hibernate_preallocate_memory()  may swap out to shrink memory
         pm_restrict_gfp_mask()          storage is suspended from here
         create_image()                  the snapshot is taken
       swsusp_write()                    image slots are allocated here
       power_down()

   uswsusp can send SNAPSHOT_ALLOC_SWAP_PAGE before storage is
   suspended, but s2disk sends it only after SNAPSHOT_CREATE_IMAGE [2].
   An early request is still served by the normal allocator.

   So the image does not need to walk the nonfull and frag clusters.
   It can take the free clusters first and use the others only when
   those run out.

2. Image slots are not freed and reused while the image is written.
   And whatever the allocator changes during the write is gone at
   resume, because the resumed kernel is the snapshot.

   With observation 1, once the image owns a free cluster it can use
   all of it.  Nothing has to be recorded per slot, neither in the
   swap table nor as a memcg id.

3. User space and kswapd do not swap out while the image is written,
   and allocations from the page allocator cannot start swap I/O.
   What is left is rare.  DAMON pageout and the memcg high work can
   still reach swap(This is all I found. anything else?), 
   and both were seen running in that window.

   So the allocator can favor the image then.  Other users take slots
   from the nonfull and frag clusters and leave the free clusters to
   the image.

With these the allocator gets simpler and faster, and batching the
image read and write becomes easy.

What the series does
====================

  1-2    fixes, a slot leak after a failed test_resume and a NULL
         dereference for a swapfile with no block device (some bug fix)
  3      move the hibernation code to mm/swap_hibernate.c (refactor)
  4      skip swap cache reclaim while storage is suspended (optimization)
  5-6    hand the image whole free clusters, in disk order (exploit contiguous space)
  7-8    write and read the image one bio per run (batch I/O)
  9-10   optional reservation at swapon, hibernate=reserve (assure contiguous space)

Based on mm-new (383fc05d4650) with patches 2 to 4 of [3] under it.
Patch 1 of [3] is in mm-new as 10d9012e83ef.

Note.  [3] gives hibernation slots their own swap table entry, keeps
readahead off them, and frees them by offset alone.  The single slot
path of patch 5 builds on that.

Results
=======

Setup
  - qemu, 12G RAM, 4 CPUs, no KVM.  Times only compare against each
    other.
  - swap on virtio-blk as a non-rotational device
  - image 5.0G, written with hibernate=nocompress
  - 3 reps of two hibernations each.  Times are medians of the 4 to 6
    samples per cell that no host load hit.
  - base is patch 3 and allocates as mm-new does, allocator is
    patch 6, allocator + bio is patch 8

Rows.  runs is how many contiguous stretches of the device the image
ends up in.  bios is how many bios the kernel allocates and submits to
write it.  In both cases the image fits in free clusters, so the
fallback to nonfull and frag clusters is not measured.  Percentages
are against base.

Shuffled free list.  A device that has been in use, emptied.
  - 6G swap, 5.4G of 2M tmpfs files swapped out, then all removed in
    random order
  - every cluster is free, the free list is in free order, not in
    disk order

                        base       allocator   allocator + bio
  write, s             10.60     9.32 (-12%)       7.94 (-25%)
  read, s               9.15     8.92  (-3%)       8.10 (-11%)
  runs                  3560               1                 1
  bios                 1.30M           1.30M             12.7K

Holes in nonfull clusters.  What taking free clusters first buys.
  - 12G swap, one 4G file swapped out, every other 64K of it freed
  - 2G of 64K holes in 2048 clusters, 8G of free clusters
  - mm-new fills the holes first, the series takes the free clusters

                        base       allocator   allocator + bio
  write, s             10.69    10.07  (-6%)       8.81 (-18%)
  read, s              12.21    10.89 (-11%)       9.78 (-20%)
  runs                 31899               1                 1
  bios                 1.30M           1.30M             12.8K

Summary against base
  - the allocator cuts write time by 6 to 12%
  - allocator + bio cuts write time by 18 to 25% and read time by
    11 to 20%

These are VM numbers without compression.  Compression, the default,
and real hardware are still to be checked.

Next steps
==========

Things to keep working on after this RFC.  Comments are welcome.

1. Dropping swap cache before hibernation starts, so more slots are
   free.  This series does not do that.

2. Whether the reservation in patches 9 and 10 is worth keeping.  It
   makes sure the image gets contiguous slots when swap has room to
   spare.

3. A block device of its own for hibernation instead of swap.  Not
   taken for now.  Sharing one device keeps the spare space useful, the
   existing infrastructure stays, and the ideas above give much the same
   effect.

4. Whether the extent tree can go.  A normal hibernation never walks
   it, the swap state comes back as it was at the snapshot.  It is only
   walked to free the slots after an error or a wake from hybrid sleep.
   With the slots marked in the swap table [3] and taken as whole
   clusters, a free could find them without it.

5. Whether SNAPSHOT_ALLOC_SWAP_PAGE should refuse a request made before
   storage is suspended.  Such a request gets single slots from the
   normal allocator today, and s2disk only asks after
   SNAPSHOT_CREATE_IMAGE anyway.

6. Two cases are not measured yet.  A device with both a shuffled free
   list and partly used clusters.  An image bigger than the free
   clusters, so part of it comes from nonfull and frag clusters.

[1] https://lore.kernel.org/linux-mm/20260206121151.dea3633d1f0ded7bbf49c22e@linux-foundation.org/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-utils.git
[3] https://lore.kernel.org/linux-mm/20260811132209.2862708-1-youngjun.park@lge.com/

Youngjun Park (10):
  PM: hibernate: give the image's swap slots back when test_resume fails
  mm, swap: skip swap devices without a block device in hibernation
    lookups
  mm, swap: move hibernation swap code to mm/swap_hibernate.c
  mm, swap: skip swap cache reclaim while storage is suspended
  mm, swap: hand the hibernation image whole free clusters
  mm, swap: hand the image's free clusters out in disk order
  PM: hibernate: build one bio per contiguous run of the image
  PM: hibernate: read the image back a run at a time
  PM: hibernate: tell swap how much space an image needs
  mm, swap: hold swap space back for a hibernation image at swapon

 .../admin-guide/kernel-parameters.txt         |   8 +
 MAINTAINERS                                   |   1 +
 include/linux/suspend.h                       |   3 +
 include/linux/swap.h                          |  11 +-
 kernel/power/hibernate.c                      |  32 +-
 kernel/power/power.h                          |   1 +
 kernel/power/swap.c                           | 172 +++++-
 mm/swap_hibernate.c                           | 547 ++++++++++++++++++
 mm/swapfile.c                                 | 344 ++---------
 9 files changed, 783 insertions(+), 336 deletions(-)
 create mode 100644 mm/swap_hibernate.c

base-commit: 383fc05d4650b021f3c17e36a145106dcc61a294
-- 
2.48.1
