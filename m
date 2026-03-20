Received: from lgeamrelo03.lge.com (lgeamrelo03.lge.com [156.147.51.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300A13624DB
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 07:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773993594; cv=none; b=XMm06VUN/0+NEhmvhOQGnkTKP+OslomqlflgGREXprzlqJ8FMHrOQ9xyGbM2t3SxXZJ6ofdBNxgc3t6PW6F6Nx4zpEacKMxrFTi0myb3sxusGa/iFCaUiJkzJdnCFUThTVQYOOTDlymKSLxYrJ9l5+Dp5OwPb6cNJ4ogBX8o/Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773993594; c=relaxed/simple;
	bh=k0qXDDnLEgIgZSKSmd+mgEO14PagWmduoA+fGNci6IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYxb3Yk9zwhz/eZiGZGRxk9Qhw4fX+jKuEdpJLl1sRIOira3aN4jPYcurEQ+q4Xdv0XDCFpax+aCAgaIeaunAuQQRP/2txrJyaBZHFN84hX1Irl7TJBmbKkxqwuI0DUk3Hs6VfhF9m7eF1kTsDvOgPQwsAQRTVoyulUcml70kn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.102 with ESMTP; 20 Mar 2026 16:59:43 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Fri, 20 Mar 2026 16:59:43 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: rafael@kernel.org, akpm@linux-foundation.org, chrisl@kernel.org,
	kasong@tencent.com, pavel@kernel.org, shikemeng@huaweicloud.com,
	nphamcs@gmail.com, bhe@redhat.com, baohua@kernel.org,
	usama.arif@linux.dev, linux-pm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 1/3] mm/swap, PM: hibernate: fix swapoff race in
 uswsusp by getting swap reference
Message-ID: <abz+b8MwnqO0ZOeL@yjaykim-PowerEdge-T330>
References: <20260317181318.2517015-1-youngjun.park@lge.com>
 <20260317181318.2517015-2-youngjun.park@lge.com>
 <abp7aDgYLrxF3Me8@KASONG-MC4>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <abp7aDgYLrxF3Me8@KASONG-MC4>

On Fri, Mar 20, 2026 at 12:34:02AM +0800, Kairui Song wrote:
> On Wed, Mar 18, 2026 at 03:13:16AM +0800, Youngjun Park wrote:
 
> Hi Youngjun,
> 
> Thanks! This set of API looks better that before.

Hello Kairui! :)

> >  
> > -/*
> > - * Find the swap type that corresponds to given device (if any).
> > - *
> > - * @offset - number of the PAGE_SIZE-sized block of the device, starting
> > - * from 0, in which the swap header is expected to be located.
> > - *
> > - * This is needed for the suspend to disk (aka swsusp).
> > - */
> > -int swap_type_of(dev_t device, sector_t offset)
> > +static int swap_type_of(dev_t device, sector_t offset)
> 
> Maybe rename it while at it, it's a internal helper now and
> no one is using it.

I will change!

> > +/*
> > + * Finds the swap type and safely acquires a reference to the swap device
> > + * to prevent race conditions with swapoff.
> > + *
> > + * This should be used in environments like uswsusp where a race condition
> > + * exists between configuring the resume device and allocating a swap slot.
> > + * For sysfs hibernation where user-space is frozen (making swapoff
> > + * impossible), use find_hibernation_swap_type() instead.
> > + *
> > + * The caller must drop the reference using put_hibernation_swap_type().
> > + */
> 
> You can follow the kernel doc format.

I will convert this to proper kernel-doc format as well. Thanks.

> > +int get_hibernation_swap_type(dev_t device, sector_t offset)
> > +{
> > +	int type;
> > +	struct swap_info_struct *sis;
> > +
> > +	spin_lock(&swap_lock);
> > +	type = swap_type_of(device, offset);
> > +	sis = swap_type_to_info(type);
> > +	if (!sis || !get_swap_device_info(sis))
> > +		type = -1;
> > +
> > +	spin_unlock(&swap_lock);
> > +	return type;
> > +}
> > +
> > +/*
> > + * Drops the reference to the swap device previously acquired by
> > + * get_hibernation_swap_type().
> > + */
> > +void put_hibernation_swap_type(int type)
> > +{
> > +	struct swap_info_struct *sis;
> > +
> > +	sis = swap_type_to_info(type);
> > +	if (!sis)
> > +		return;
> 
> I think it should never see sis == NULL here?

It can happen in the following cases:
1. The snapshot device is not configured at open time (i.e. no resume=
   parameter and userspace intends to configure it later via ioctl).
2. The process exits or snapshot_release() is called with type = -1.

Although callers would normally check `type >= 0`, this helper
already handles invalid types defensively, so an extra check at the
call site is not strictly necessary.

> This looks really bad... It means swapoff will hung unless user send a
> signal to stop it? How does that happen?
> 
> If hibernate may hold a reference without allocating any slot for a
> long time, then maybe we better introduce a new si->flags bit to
> indicate a device is used by hibernate, so swapoff can abort early
> with a -EBUSY.
> 
> If hibernate only holds the swap device reference after it allocated
> any slot, then we can avoid use a flag but use a hibernate type in
> swap table instead:
> 
> diff --git a/mm/swap_table.h b/mm/swap_table.h
> index 8415ffbe2b9c..025e004fc2e7 100644
> --- a/mm/swap_table.h
> +++ b/mm/swap_table.h
> @@ -25,6 +25,7 @@ struct swap_table {
>   * PFN:      | SWAP_COUNT |------ PFN -------|10| - Cached slot
>   * Pointer:  |----------- Pointer ----------|100| - (Unused)
>   * Bad:      |------------- 1 -------------|1000| - Bad slot
> + * Exclusive:|---- 0  ----| ------ 1 -----|10000| - Exclusive usage
>   *
>   * SWAP_COUNT is `SWP_TB_COUNT_BITS` long, each entry is an atomic long.
>   *
> @@ -46,6 +47,8 @@ struct swap_table {
>   *   because only the lower three bits can be used as a marker for 8 bytes
>   *   aligned pointers.
>   *
> + * - Exclusive usage: e.g. for hibernation.
> + *
>   * - Bad: Swap slot is reserved, protects swap header or holes on swap devices.
>   */
> 
> Both readahead and swapoff (unuse scan) will abort upon seeing such slot,
> we solve both readahead and swapoff issue together.
> 
> How do you think? We can use the flag idea first.

That makes sense. I also considered the pinning flag approach (and
mentioned my previously rejected strategy in response to Andrew’s
question).

Based on your feedback, I’m now convinced that introducing a dedicated
SWP_HIBERNATION pinning flag in `si->flags` is the right direction. It
makes the interaction with swapoff explicit and avoids long waits or
implicit dependency on slot allocation timing.

In the future, this pinning flag could potentially be reused in other
swap paths if we ever need to distinguish hibernation-specific
allocations. (this part is just imagination)

Regarding the swap table “exclusive bit” idea: I don’t think it fits
well here because there is a window between selecting the swap device
type and actually allocating a swap slot. During that gap, the user
context may change, so encoding exclusivity at the slot level would not
fully cover the race.

So I will proceed with the pinning flag approach !

> >  	 */
> >  	percpu_ref_kill(&p->users);
> >  	synchronize_rcu();
> > -	wait_for_completion(&p->comp);
> > +	err = wait_for_completion_interruptible(&p->comp);
> > +	if (err) {
> > +		percpu_ref_resurrect(&p->users);
> > +		synchronize_rcu();
> 
> Do we need a synchronize_rcu here? It's required above because we are
> releasing the resources so all RCU readers must exit from grace
> period. But here we are aborting and not releasing anything so
> there is no such need?

This strategy has been dropped with the introduction of the
SWP_HIBERNATION pinning flag.

For clarification: the `synchronize_rcu()` here was intended to wait for
the final percpu_ref callback, since that callback runs in RCU context.
However, as you pointed out, since we are aborting rather than releasing
resources, that extra grace period is likely unnecessary.

I will update the patch accordingly and include additional testing
results.

Thanks again for the valuable review.

Best regards,
Youngjun
