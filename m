Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F6737474B
	for <linux-pm@vger.kernel.org>; Fri,  1 May 2026 22:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777673745; cv=none; b=WGHWANvtMvv6E9cXwzlKGwtlxIhB9Xi0H9v7a/r91Aqc4QuQGEscXHFXosMQpjr53oSAIe1mj2buvpppyAdaPfQAvcS11wAaQyDqyw/4/VWyDOnFXIADO1tNfo4/grZlR//4NS59PvpOuiJh94Rp65LEH6UwmOX+NBOhPyhAqyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777673745; c=relaxed/simple;
	bh=QiP3Jk8ulmlDRUtbJClBJEovYq4nt/YoNtDXAK2cIyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KV0klhg5+E7P/HvDPb+B8n59Wf+2oJedDd14I5TkrwofeYZeC4UslvwaAAIJ7ZLRmET3InjWlr6+9o7+Hu+6iaDit64v6isyQHCD9zTSkjdp2cRuTHi9iCis2zVkFq0TLUd2q1hHfWBbyIfcejUYTDTqH3KrQjEfBkwCf/HCDV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 2 May 2026 07:00:39 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Sat, 2 May 2026 07:00:39 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: David Carlier <devnexen@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	charsyam@gmail.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] mm/swap, PM: hibernate: atomically replace hibernation
 pin
Message-ID: <afUih+XwGTHsR0HY@yjaykim-PowerEdge-T330>
References: <20260430195651.287659-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430195651.287659-1-devnexen@gmail.com>

On Thu, Apr 30, 2026 at 08:56:51PM +0100, David Carlier wrote:
> snapshot_set_swap_area() unpins the previously selected swap device
> and pins the new one in two separate swap_lock critical sections.
> In the gap between them, swapoff() observes SWP_HIBERNATION cleared,
> bypasses the guard, and tears down the device, reopening the race
> the SWP_HIBERNATION pin was meant to close. The window is reachable
> on any SNAPSHOT_SET_SWAP_AREA call after the snapshot device is
> opened for hibernation, and on any retry after the resume path's
> first selection.
> 
> Add repin_hibernation_swap_type(), which looks up the new device,
> clears the old SWP_HIBERNATION flag and sets the new one under a
> single swap_lock acquisition. The same-device case is short-
> circuited so userspace can re-select the same swap area without
> tripping WARN_ON_ONCE and -EBUSY. Switch snapshot_set_swap_area()
> to the new helper.
> 
> A failed lookup now preserves the previous pin instead of dropping
> it, so a bad SNAPSHOT_SET_SWAP_AREA leaves the prior selection
> intact. The open and release paths keep using
> pin_hibernation_swap_type() and unpin_hibernation_swap_type().
> 
> The race was identified during AI-assisted review of the
> SWP_HIBERNATION pinning series.
> 
> Fixes: 8e6e0d845823 ("mm/swap, PM: hibernate: fix swapoff race in uswsusp by pinning swap device")
> Assisted-by: Codex (gpt-5-codex)
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  include/linux/swap.h |  2 ++
>  kernel/power/user.c  | 17 ++++--------
>  mm/swapfile.c        | 61 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 68 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 1930f81e6be4..213ecb627a39 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -436,6 +436,8 @@ static inline long get_nr_swap_pages(void)
>  extern void si_swapinfo(struct sysinfo *);
>  extern int pin_hibernation_swap_type(dev_t device, sector_t offset);
>  extern void unpin_hibernation_swap_type(int type);
> +extern int repin_hibernation_swap_type(int old_type, dev_t device,
> +                                       sector_t offset);
>  extern int find_hibernation_swap_type(dev_t device, sector_t offset);
>  int find_first_swap(dev_t *device);
>  extern unsigned int count_swap_pages(int, int);
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index d0fcfba7ac23..6e4f40e49319 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -218,6 +218,7 @@ static int snapshot_set_swap_area(struct snapshot_data *data,
>  {
>  	sector_t offset;
>  	dev_t swdev;
> +	int new_type;
>  
>  	if (swsusp_swap_in_use())
>  		return -EPERM;
> @@ -238,19 +239,11 @@ static int snapshot_set_swap_area(struct snapshot_data *data,
>  		offset = swap_area.offset;
>  	}
>  
> -	/*
> -	 * Unpin the swap device if a swap area was already
> -	 * set by SNAPSHOT_SET_SWAP_AREA.
> -	 */
> -	unpin_hibernation_swap_type(data->swap);
> +	new_type = repin_hibernation_swap_type(data->swap, swdev, offset);
> +	if (new_type < 0)
> +		return new_type;
>  
> -	/*
> -	 * User space encodes device types as two-byte values,
> -	 * so we need to recode them
> -	 */
> -	data->swap = pin_hibernation_swap_type(swdev, offset);
> -	if (data->swap < 0)
> -		return swdev ? -ENODEV : -EINVAL;
> +	data->swap = new_type;
>  	data->dev = swdev;
>  	return 0;
>  }
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index c7e173b93e11..4840fd40f36f 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2219,6 +2219,67 @@ int pin_hibernation_swap_type(dev_t device, sector_t offset)
>  	return type;
>  }
>  
> +/**
> + * repin_hibernation_swap_type - Atomically replace the hibernation pin
> + * @old_type: Swap type currently pinned (or < 0 if none).
> + * @device:   Block device of the new resume image.
> + * @offset:   Offset identifying the new swap area.
> + *
> + * Look up the swap device for @device/@offset and atomically transfer
> + * the SWP_HIBERNATION pin from @old_type (if valid) to the new device,
> + * all under a single swap_lock critical section. This closes the
> + * swapoff() window that exists when callers unpin and re-pin in two
> + * separate operations.
> + *
> + * If the new device cannot be located, the existing pin on @old_type
> + * is preserved and an error is returned. If @old_type already refers
> + * to the same swap_info_struct as the new lookup, no flag changes are
> + * made and @old_type is returned.
> + *
> + * Return:
> + * >= 0 on success (new swap type).
> + * -EINVAL if @device is invalid.
> + * -ENODEV if the swap device is not found.
> + * -EBUSY  if the new device is already pinned by another context.
> + */
> +int repin_hibernation_swap_type(int old_type, dev_t device, sector_t offset)
> +{
> +	struct swap_info_struct *old_si, *new_si;
> +	int new_type;
> +
> +	spin_lock(&swap_lock);
> +
> +	new_type = __find_hibernation_swap_type(device, offset);
> +	if (new_type < 0) {
> +		spin_unlock(&swap_lock);
> +		return new_type;
> +	}
> +
> +	new_si = swap_type_to_info(new_type);
> +	if (WARN_ON_ONCE(!new_si)) {
> +		spin_unlock(&swap_lock);
> +		return -ENODEV;
> +	}
> +
> +	old_si = swap_type_to_info(old_type);
> +	if (new_si == old_si) {
> +		spin_unlock(&swap_lock);
> +		return new_type;
> +	}
> +
> +	if (WARN_ON_ONCE(new_si->flags & SWP_HIBERNATION)) {
> +		spin_unlock(&swap_lock);
> +		return -EBUSY;
> +	}
> +
> +	if (old_si)
> +		old_si->flags &= ~SWP_HIBERNATION;
> +	new_si->flags |= SWP_HIBERNATION;
> +
> +	spin_unlock(&swap_lock);
> +	return new_type;
> +}
> +
>  /**
>   * unpin_hibernation_swap_type - Unpin the swap device for hibernation
>   * @type: Swap type previously returned by pin_hibernation_swap_type()
> -- 
> 2.53.0

I also caught up on this thread late due to travel.
Sorry.

Hello David Carlier,

It looks like the same issue and approach was raised previously:
https://lore.kernel.org/all/20260414143200.1267932-1-charsyam@gmail.com/#t
(+CC DaeMyung)

I had suggested improving the fix by reusing the existing APIs
rather than adding a new one. v2 was posted along those lines:
https://lore.kernel.org/all/20260414164937.1363887-1-charsyam@gmail.com/

To restate the points from that earlier review.

1. I think it is acceptable to release the existing pin when the
   new set operation fails. there is no significant side effect
   (see the earlier review for details).

2. If we still want to fix it, reusing the existing APIs seems
   preferable to adding a new one.

Chris, Andrew - please take the prior thread into account during review. 

Thanks,
Youngjun Park
