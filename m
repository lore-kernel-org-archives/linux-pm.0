Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAFF2C027E
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 13:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773928125; cv=none; b=dYoHitEn0/V86Fm7dQVQUH5fMBeN+RA1X/B1vhf+TqBLh9MxvSvEoKEkDsahWVc+K8g1IMmbu3AhqBNoh+VezcJ1WmbpK56AVH/r4jygzHviKMg0PGv6/F+nIUVniGfdoQNcmY6ill2VGdyrey5jY5+2HViaSL/kEBcaY+JPL1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773928125; c=relaxed/simple;
	bh=sMNGFhivR+VJLs2QNUk4QBvUjy0Sk8vEshunn/JwTfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KoMPzLNWfWnP33mCrjg9Qw5TNIbVdFiOB+aWxK/Hpox1H3VsRTPxfjEFg5YaMkMGhs35U0lrSvXsln7PCDGdRTqThQkEc0rIAtaERXM6ENpBtg9psV4R9667kpTvIatYQbHRz9XUBIDQ+eYMF462FoU/WAvrelspvTeGw97DCYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 19 Mar 2026 22:48:30 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Thu, 19 Mar 2026 22:48:30 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, kasong@tencent.com,
	pavel@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com,
	bhe@redhat.com, baohua@kernel.org, usama.arif@linux.dev,
	linux-pm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 0/3] mm/swap, PM: hibernate: fix swapoff race and
 optimize swap
Message-ID: <abv+rjgyArqZ2uym@yjaykim-PowerEdge-T330>
References: <20260317181318.2517015-1-youngjun.park@lge.com>
 <CAJZ5v0iOh46gM9YVFnvN6bYcG5_kcqASqS+38brRg2BWAtOOzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0iOh46gM9YVFnvN6bYcG5_kcqASqS+38brRg2BWAtOOzw@mail.gmail.com>

On Thu, Mar 19, 2026 at 02:33:30PM +0100, Rafael J. Wysocki wrote:
> On Tue, Mar 17, 2026 at 7:13 PM Youngjun Park <youngjun.park@lge.com> wrote:
> >
> > Currently, in the uswsusp path, only the swap type value is retrieved at
> > lookup time without holding a reference. If swapoff races after the type
> > is acquired, subsequent slot allocations operate on a stale swap device.
> >
> > Additionally, grabbing and releasing the swap device reference on every
> > slot allocation is inefficient across the entire hibernation swap path.
> >
> > This patch series addresses these issues:
> > - Patch 1: Fixes the swapoff race in uswsusp by holding the swap device
> >   reference from the point the swap device is looked up.
> > - Patch 2: Removes the overhead of per-slot reference counting in alloc/free
> >   paths and cleans up the redundant SWP_WRITEOK check.
> > - Patch 3: Fixes a spurious WARNING in the uswsusp GFP mask restore path.
> >   (Founded during uswsusp test)
> >
> > Links:
> > RFC v1: https://lore.kernel.org/linux-mm/20260305202413.1888499-1-usama.arif@linux.dev/T/#m3693d45180f14f441b6951984f4b4bfd90ec0c9d
> > RFC v2: https://lore.kernel.org/linux-mm/20260306024608.1720991-1-youngjun.park@lge.com/
> > RFC v3: https://lore.kernel.org/linux-mm/20260312112511.3596781-1-youngjun.park@lge.com/
> >
> > Testing:
> > - Hibernate/resume via sysfs
> >   (echo reboot > /sys/power/disk && echo disk > /sys/power/state)
> > - Hibernate with suspend via sysfs
> >   (echo suspend > /sys/power/disk && echo disk > /sys/power/state)
> > - Hibernate/resume via uswsusp (suspend-utils s2disk/resume on QEMU)
> >   - Verified swap I/O works correctly after resume.
> >   - Verified swapoff succeeds after snapshot resume completes.
> >   - Verified pm_restore_gfp_mask() WARNING no longer triggers (Patch 3).
> > - swapoff during active uswsusp session:
> >   - Verified swapoff blocks while uswsusp holds swap reference.
> >   - Verified swapoff can be cancelled by signal (e.g. Ctrl+C).
> >   - Verified swapoff succeeds after uswsusp process terminates.
> >
> > Changelog:
> > rfc v3 -> v4:
> >  - Introduced get/find/put_hibernation_swap_type() helpers per Kairui's
> >    feedback. find_ for lookup-only, get/put for reference management.
> >  - Switched to swap_type_to_info() and added type < 0 check per
> >    Kairui's suggestion.
> >  - Fixed get_hibernation_swap_type() return when ref == false (Reviewd by Kairui)
> >  - Made swapoff wait interruptible to prevent hang when uswsusp
> >    holds a swap reference.
> >  - Fixed spurious WARN_ON in pm_restore_gfp_mask() by introducing
> >    pm_restore_gfp_mask_safe() (Patch 3).
> >  - Updated commit messages and added comments for clarity.
> >  - Rebased onto latest mm-new tree.
> >
> >  Note: Kairui suggested adding WARN on NULL in put_hibernation_swap_type(),
> >  but kept silent return instead, as type can legitimately be -1 when
> >  snapshot_open() fails to find a matching swap device. swap_type_to_info()
> >  returns NULL for type < 0, so the cleanup path stays simple.
> >
> > rfc v2 -> rfc v3:
> >  - Split into 2 patches per Chris Li's feedback.
> >  - Simplified by not holding reference in normal hibernation path
> >    per Chris Li's suggestion.
> >  - Removed redundant SWP_WRITEOK check.
> >  - Rebased onto f543926f9d0c3f6dfb354adfe7fbaeedd1277c6b.
> >
> > rfc v1 -> rfc v2:
> >  - Squashed into single patch per Usama Arif's feedback.
> >
> > Youngjun Park (3):
> >   mm/swap, PM: hibernate: fix swapoff race in uswsusp by getting swap
> >     reference
> >   mm/swap: remove redundant swap device reference in alloc/free
> >   PM: hibernate: fix spurious GFP mask WARNING in uswsusp path
> >
> >  include/linux/suspend.h |   1 +
> >  include/linux/swap.h    |   4 +-
> >  kernel/power/main.c     |   7 ++
> >  kernel/power/swap.c     |   2 +-
> >  kernel/power/user.c     |  19 +++--
> >  mm/swapfile.c           | 154 +++++++++++++++++++++++++++-------------
> >  6 files changed, 132 insertions(+), 55 deletions(-)
> >
> > --
> 
> Which kernel version does this series apply to?
> 
> It doesn't apply for me on top of 7.0-rc4, so please consider rebasing.

It is based on mm-new 
I will soon rebase on the top of 7.0-rc4 with build & test.

Best regards,
Youngjun Park


