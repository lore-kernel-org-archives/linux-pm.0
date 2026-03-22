Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549A1257435
	for <linux-pm@vger.kernel.org>; Sun, 22 Mar 2026 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774175473; cv=none; b=htBQRrxEJ61ZrC6vU33zPZFT2KR/rgJA7+p8XbRWhbGRAgCSuDCzxyYIolz28BnmsuUxq9wX6wbpKzU+z15ThuzgHMy7PlUP9b08Ndxkb/U+9VZ8SyIPpUysNNnIXq4uLv7bpxT2iDHjt3bHZClwmL3KfZmwca0HMiRsT8H8mao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774175473; c=relaxed/simple;
	bh=g+o+GZspif7a3iwm2wR3HchsQf53Q/jtqi1FU188U3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pAvcdypjlxIAUKyBAiqLc4I2D3FeSaRUblwlKg6XcJnwcL+o+Tm8V9TCeP80jEtSB83Ll69nj71qA3ZoOKA5eK4YL0dCIVGYsVUclvXiByXkCuxSUzjFXGEGKPYCpgQ2Dd7yx34m7PJW4BkVWd9fyzj0166JVZr3d6GjbKoAiLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 22 Mar 2026 19:31:01 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Sun, 22 Mar 2026 19:31:01 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: rafael@kernel.org, chrisl@kernel.org, kasong@tencent.com,
	pavel@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, baohua@kernel.org, usama.arif@linux.dev,
	linux-pm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v7 0/2] mm/swap, PM: hibernate: fix swapoff race and
 optimize swap
Message-ID: <ab/E5SaSAlAKLCwD@yjaykim-PowerEdge-T330>
References: <20260321103309.439265-1-youngjun.park@lge.com>
 <20260321105921.19388b7acbc0f8d6036e29a7@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321105921.19388b7acbc0f8d6036e29a7@linux-foundation.org>

On Sat, Mar 21, 2026 at 10:59:21AM -0700, Andrew Morton wrote:
> On Sat, 21 Mar 2026 19:33:07 +0900 Youngjun Park <youngjun.park@lge.com> wrote:
> 
> > Apologies for the frequent revisions. Hopefully this version is close to final.
> > 
> > Currently, in the uswsusp path, only the swap type value is retrieved at
> > lookup time without holding a reference. If swapoff races after the type
> > is acquired, subsequent slot allocations operate on a stale swap device.
> > 
> > Additionally, grabbing and releasing the swap device reference on every
> > slot allocation is inefficient across the entire hibernation swap path.
> > 
> > This patch series addresses these issues:
> > - Patch 1: Fixes the swapoff race in uswsusp by pinning the swap device
> >   from the point it is looked up until the session completes.
> > - Patch 2: Removes the overhead of per-slot reference counting in alloc/free
> >   paths and cleans up the redundant SWP_WRITEOK check.
> > 
> > ...
> >
> > v6 -> v7:
> >  - Dropped Patch 3 (pm_restore_gfp_mask fix) from series as it has
> >    no dependency on Patches 1-2. Will be sent separately.
> >    (Rafael J. Wysocki feedback)
> >  - Andrew Morton's AI review 
> 
> Well.  Roman, Chris, Google and others.  I'm just a messenger ;)

> > findings applied only to Patch 3;
> >    Patches 1-2 are unchanged. (no problem on AI's review)
> 
> Seems that it changed its mind!
> 
> 	https://sashiko.dev/#/patchset/20260321103309.439265-1-youngjun.park@lge.com

Thank you Andrew. It seems sashiko has learned not to go easy
on me twice. :) Will address it.

On the v7.0-rc4 base, add_swap_count_continuation() modifies
si->flags (SWP_CONTINUED) under si->cont_lock without holding
swap_lock, so the non-atomic RMW race is a real concern.

Possible fixes (based on v7.0-rc4):

1. Grab cont_lock on the SWP_HIBERNATION set path, or grab
   swap_lock in add_swap_count_continuation(). This would
   serialize the race, but adds lock contention on a path
   that doesn't really need it.

2. Convert si->flags to atomic ops. This would be the correct
   fix, but is quite extensive and better suited as a separate
   effort.

However, on mm-new, Kairui's series [1] has removed
add_swap_count_continuation() and SWP_CONTINUED entirely, so
this race path no longer exists (verified by code inspection
and AI review on mm-new).

[1] https://lore.kernel.org/linux-mm/20260128-swap-table-p3-v2-9-fe0b67ef0215@tencent.com/

I based this series on v7.0-rc4 per Rafael's request since it
depends on PM-side changes. I'm not very familiar with how
cross-subsystem dependencies are typically coordinated -- if
rebasing onto mm-new is an option, the race goes away and the
PM-side changes could be picked up separately. Would that be
a reasonable approach? I'd appreciate any guidance on this.

On a side note -- the AI review is becoming genuinely useful.
It might be worth having it gate-check patches before they hit
the mailing list, rather than reviewing after the fact.

Best regards,
Youngjun Park
