Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79575273F9
	for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 12:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773489822; cv=none; b=MoYuSkbrJMe361douKAU5wYkvIvrJUHMw7GDjO13J06G8dGU7gMWrzTHH+xdpx5ZYjOBWFu0F1GW82W5P41sKBo6i2GbsITRU/F4NRhIJO/WOBcgD9NkXL5czMGBXs3oMn/WgwVJOukfM+Gq5Ph8sYJ8bsDIMAQC9i0Ij9zs2g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773489822; c=relaxed/simple;
	bh=j6y2ArRUFz8a1GlT5Ct9kugX1+DT5KThsUa3nR24WQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A/4iSFgGNea7AknQk++NzPU5awNNe7Oes2jO/kQ5UV8bRL07PRd9ABNwy33EUMCmVMsn5pbTAueqHmBdFRtFBgIaU5ccpFFcMvg0IIxwN4M/XyL1XhpgJJLef3LJgL7QqmhqKbOyyTeLDrylKmoz2qrrJ66WXGovEbWFuSCDZW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 14 Mar 2026 20:48:28 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Sat, 14 Mar 2026 20:48:28 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: rafael@kernel.org, akpm@linux-foundation.org, chrisl@kernel.org,
	kasong@tencent.com, pavel@kernel.org, shikemeng@huaweicloud.com,
	nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org,
	usama.arif@linux.dev, linux-pm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RESEND RFC PATCH v3 1/2] mm/swap, PM: hibernate: fix swapoff
 race in uswsusp by getting swap reference
Message-ID: <abVLDJq/mn5tFkfe@yjaykim-PowerEdge-T330>
References: <20260312112511.3596781-1-youngjun.park@lge.com>
 <20260312112511.3596781-2-youngjun.park@lge.com>
 <abQMiv6Y4WEKTLng@KASONG-MC4>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abQMiv6Y4WEKTLng@KASONG-MC4>

> Hi, YoungJun
>
> Nice work! Thanks for improving the swap part of hibernation.

Hello Kairui :D

> Some comments below:
>
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 7a09df6977a5..ecf19a581fc7 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -433,8 +433,9 @@ static inline long get_nr_swap_pages(void)
> >  }
> >
> >  extern void si_swapinfo(struct sysinfo *);
> > -int swap_type_of(dev_t device, sector_t offset);
> > +int swap_type_of(dev_t device, sector_t offset, bool ref);
> >  int find_first_swap(dev_t *device);
> > +void put_swap_device_by_type(int type);
> >  extern unsigned int count_swap_pages(int, int);
> >  extern sector_t swapdev_block(int, pgoff_t);
> >  extern int __swap_count(swp_entry_t entry);
>
> I think the `ref` parameter here is really confusing. Maybe at
> lease add some comment that some caller will block swapoff so
> no ref needed.
>
> Or could we use a new helper to grab the device? Or better, is
> it possible to grab the swap device then keep allocating it,
> instead of check the device every time from hibernation side?
>
> The combination of swap_type_of & put_swap_device_by_type call
> pair really doesn't look good.

Initially, I considered making the function grab the reference
by default and renaming it accordingly to better reflect its
role in acquiring a swap device for hibernation.

However, based on Chris Li's earlier review, this approach
would require adding a significant amount of error-handling
code to release the reference in the regular (non-uswsusp)
hibernation path. After further consideration, I concluded
that the regular hibernation path genuinely does not need the
reference, since user-space processes are already frozen.

So I will either introduce a separate helper function for
grabbing the reference or add comments to clarify the
distinction. I will also improve the naming of the put
function to make the pairing more intuitive.

> > diff --git a/kernel/power/user.c b/kernel/power/user.c
> > index 4401cfe26e5c..7ade4d0aa846 100644
> > --- a/kernel/power/user.c
> > +++ b/kernel/power/user.c
> > @@ -235,11 +238,13 @@ static int snapshot_set_swap_area(
> >             offset = swap_area.offset;
> >     }
> >
> > +   put_swap_device_by_type(data->swap);
> > +
> >     /*
> >      * User space encodes device types as two-byte values,
> >      * so we need to recode them
> >      */
> > -   data->swap = swap_type_of(swdev, offset);
> > +   data->swap = swap_type_of(swdev, offset, true);
>
> For example this put_swap_device_by_type followed by
> swap_type_of looks very strange. I guess here you only want to
> get the swap type without increasing the ref.

The put here is needed because the SNAPSHOT_SET_SWAP_AREA ioctl
can be called more than once. If the swap type changes between
calls, we need to release the reference from the previous one.
That said, if the type remains the same, there is no need to
call swap_type_of again. I think this part needs some
refinement.

> > +           if (ref && get_swap_device_info(sis)) {
> > +                   spin_unlock(&swap_lock);
> > +                   return type;
>
> This part seems wrong, if ref == false, it never returns a
> usable type value.

Oops, you are right. It should be something like:

	if (ref && !get_swap_device_info(sis))
		continue;

	spin_unlock(&swap_lock);
	return type;

> > +   if (type < 0 || type >= MAX_SWAPFILES)
> > +           return;
>
> Maybe we better have a WARN if type is invalid? Caller should
> never do that IMO.

Agreed, will add that.

> > +   sis = swap_info[type];
>
> We have __swap_type_to_info and swap_type_to_info since reading
> swap_info have some RCU context implications (see comment in
> __swap_type_to_info) and these helpers have better debug checks
> too.
>
> Maybe you can just use swap_type_to_info and add a check for
> type < 0 in swap_type_to_info, and WARN on NULL in
> put_swap_device_by_type. How do you think?

Thank you for the review. I will switch to swap_type_to_info
and add the WARN as you suggested in the next revision.

Best regards,
Youngjun Park
