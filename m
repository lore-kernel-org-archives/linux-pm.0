Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB993EB7E1
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938055; cv=none; b=tGhWlRpCByibBYUsEN9uKR4z3Zx3UavcERK4Vw1TVi/NOFamL4Qjh97w5HYgP4cUarwNDIloaWWeW/y3B3IAGohpd2A0u1Hlu0ki3WKDLHWGsNpxQIHi4OClTnHl+Cxf7DZ8CAL1vV1sDD2/2eVrkCh0QiOOVv2fnzLnregJ8H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938055; c=relaxed/simple;
	bh=qIByj4XV6PVuqjLtc4TRgUblsmab/R7fqnlGqrwGO74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAFuTSbMnUUKZGNJn95JfLeDzApCgtNwWKrizxARPb0GiJCJpKbqG4++W8tozsU1U/g78Y8SI29OVixX7cDwYHwuMaavt6mPzRyS2AthLf6MNLQR9T862UwOd778JBJKQJz7ccsmNkRJLFWp1ZidlY1MhqPCd2EwxNALtaIrzIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qgpx+Wrv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qgpx+Wrv"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ad9516a653so4957615ad.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 09:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773938048; x=1774542848; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5MgDUr28BswEKjkiFZqRWKfXqvNYWCmZwzQMS8MvJjQ=;
        b=Qgpx+Wrv0jLH7Ppupy0DemjtsxfOwH8RRgVaF3eY7woX1WH6rqpGogzEmujClGm/uU
         tUSHKMT4dh0ThXEp8ze+Y2IwCXOHwWAT+4NQ4G/qSVxRG5m5UZLMxNvnldolTFmNLiEQ
         Grv2pv/BgCNymP49odX3aYMCfDdQo0SFjkeY5YF2bDUbvJEzymOjDHPNQ2kZ2JyWryYP
         /6ha3pIT7fGk/YpsbO6JqrO1T9aAb6wdTYI1tFQvdueSLdHH4NTrF0eauYadPaYzD56Z
         /oGi8IfFSO6kwujiQhyBUgZP7Xz3SPSEa53qiAgDBlrTffwvNGfsvP8VbvxJvqCerBev
         4fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773938048; x=1774542848;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5MgDUr28BswEKjkiFZqRWKfXqvNYWCmZwzQMS8MvJjQ=;
        b=pVPqY5fsFovLzksBLQ9WhBI7CSRjN6TUHzpp9/TR/ZhfvEJi6GB1/RmDsIiX6M65hG
         l1kB61uE/ifSJnbw6pDTKvwL3ZO/qHw53HIrn8CO+MQA4jnoHPdvwhW1Nz5BsWTTbrVo
         I/7HkJwcWI/ujnZljpJYc+advPrZoRNcAI6A6fRJ4BHxabUabMdml7mzJ0Zz5Fc8tou4
         bo3HVQTC4t+g2GtcM8PIO40I5/N0cNTPeatocQEi3eMQ/xu6u14GyISzxcYNYdskAJZJ
         KeEeU8fOFkI0FIbkn8rqQED5w3OZ3XHIsYetdeBTFprnKf4Fk4fw7VWS8cNnYwyDMAl0
         NNRA==
X-Forwarded-Encrypted: i=1; AJvYcCXQduFubuv64D0iuRSjfFWGYPkbJkC0wc2VBezDFfsHb+2bbouEaQ9rngMdC6ZOqauhyE+0aLD6iw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnMJZ3tQXr6srNkUJLL2UMGix9YCKgKHJVIwDdKOtlPpMjdurt
	DgNrl0wAmpUkXsv/fQoUHu4obgSpndeceqaXEhBPTxjq1CMrHnmSFxU0
X-Gm-Gg: ATEYQzw9+fK/jp4Uql+3qQiHRa5ibU/uJ1gjg8ZHQFy5hAvoNKlxAjyqL4ZpcY7bxLI
	AZ/VdkL+npRllhjw2Mw3fbYI035/7p7gQYqJg/U7VXZyNhjK1SLxACwWGuiF6HK7CNHx54ml2Ww
	xOR0praMbN4I+/vzGjAr8avaKoH+/2r+2iHbhHAoUmCWyTQNET0s2hpiltCXaD0TPOdkQbELxRU
	iMpBgZv3F0fOdFFCNiK2nYORiN3awRERbfIHtyeLd5qqDGPY3fV4WV/wRin4crck421v9Z5ul//
	wFmBfdGhOSaIP0cOVupTMrOcKhnC7+oQZG2Gq27PNMja3A7MpT1yt9Aw2kYn7sgV/WQLDkRqZuk
	Ap7SQWZxKlbRSaUGWsRRrLT99uejF+HYEQQeBwH84lzbMMAF1nEDSKLHgvI4478MXzwS9Y+ZVOA
	4T5SgimC1YzUkjTAQ9ETM8bgODGP8ye49CdI1pdCJrBSTrSvW/bsWxTLZpTUE=
X-Received: by 2002:a17:903:41d2:b0:2ae:57e6:616c with SMTP id d9443c01a7336-2b06e2d6ef1mr78490245ad.3.1773938048301;
        Thu, 19 Mar 2026 09:34:08 -0700 (PDT)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e43074esm63732945ad.19.2026.03.19.09.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 09:34:07 -0700 (PDT)
Date: Fri, 20 Mar 2026 00:34:02 +0800
From: Kairui Song <ryncsn@gmail.com>
To: Youngjun Park <youngjun.park@lge.com>
Cc: rafael@kernel.org, akpm@linux-foundation.org, chrisl@kernel.org, 
	kasong@tencent.com, pavel@kernel.org, shikemeng@huaweicloud.com, nphamcs@gmail.com, 
	bhe@redhat.com, baohua@kernel.org, usama.arif@linux.dev, 
	linux-pm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 1/3] mm/swap, PM: hibernate: fix swapoff race in
 uswsusp by getting swap reference
Message-ID: <abp7aDgYLrxF3Me8@KASONG-MC4>
References: <20260317181318.2517015-1-youngjun.park@lge.com>
 <20260317181318.2517015-2-youngjun.park@lge.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317181318.2517015-2-youngjun.park@lge.com>

On Wed, Mar 18, 2026 at 03:13:16AM +0800, Youngjun Park wrote:
> Hibernation via uswsusp (/dev/snapshot ioctls) has a race: between
> setting the resume swap area and allocating a swap slot, user-space is
> not yet frozen, so swapoff can run and cause an incorrect slot allocation.
> 
> Fix this by keeping swap_type_of() as a static helper that requires
> swap_lock to be held, and introducing new interfaces that wrap it with
> proper locking and reference management:
> 
> - get_hibernation_swap_type(): Lookup under swap_lock + acquire a swap
>   device reference to block swapoff (used by uswsusp).
> - find_hibernation_swap_type(): Lookup under swap_lock only, no
>   reference. Used by the sysfs path where user-space is already frozen,
>   making swapoff impossible.
> - put_hibernation_swap_type(): Release the reference.
> 
> Because the reference is held via get_swap_device(), swapoff will block
> at wait_for_completion_interruptible() until put_hibernation_swap_type()
> releases it. The wait is interruptible, so swapoff can be cancelled by
> a signal.
> 
> Signed-off-by: Youngjun Park <youngjun.park@lge.com>
> ---
>  include/linux/swap.h |  4 +-
>  kernel/power/swap.c  |  2 +-
>  kernel/power/user.c  | 15 ++++++--
>  mm/swapfile.c        | 92 ++++++++++++++++++++++++++++++++++++--------
>  4 files changed, 92 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 7a09df6977a5..cf8cfdaf34a7 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -433,7 +433,9 @@ static inline long get_nr_swap_pages(void)
>  }
>  
>  extern void si_swapinfo(struct sysinfo *);
> -int swap_type_of(dev_t device, sector_t offset);
> +int get_hibernation_swap_type(dev_t device, sector_t offset);
> +int find_hibernation_swap_type(dev_t device, sector_t offset);
> +void put_hibernation_swap_type(int type);

Hi Youngjun,

Thanks! This set of API looks better that before.

>  
> -/*
> - * Find the swap type that corresponds to given device (if any).
> - *
> - * @offset - number of the PAGE_SIZE-sized block of the device, starting
> - * from 0, in which the swap header is expected to be located.
> - *
> - * This is needed for the suspend to disk (aka swsusp).
> - */
> -int swap_type_of(dev_t device, sector_t offset)
> +static int swap_type_of(dev_t device, sector_t offset)

Maybe rename it while at it, it's a internal helper now and
no one is using it.

>  {
>  	int type;
>  
> +	lockdep_assert_held(&swap_lock);
> +
>  	if (!device)
>  		return -1;
>  
> -	spin_lock(&swap_lock);
>  	for (type = 0; type < nr_swapfiles; type++) {
>  		struct swap_info_struct *sis = swap_info[type];
>  
> @@ -2164,16 +2157,70 @@ int swap_type_of(dev_t device, sector_t offset)
>  		if (device == sis->bdev->bd_dev) {
>  			struct swap_extent *se = first_se(sis);
>  
> -			if (se->start_block == offset) {
> -				spin_unlock(&swap_lock);
> +			if (se->start_block == offset)
>  				return type;
> -			}
>  		}
>  	}
> -	spin_unlock(&swap_lock);
>  	return -ENODEV;
>  }
>  
> +/*
> + * Finds the swap type and safely acquires a reference to the swap device
> + * to prevent race conditions with swapoff.
> + *
> + * This should be used in environments like uswsusp where a race condition
> + * exists between configuring the resume device and allocating a swap slot.
> + * For sysfs hibernation where user-space is frozen (making swapoff
> + * impossible), use find_hibernation_swap_type() instead.
> + *
> + * The caller must drop the reference using put_hibernation_swap_type().
> + */

You can follow the kernel doc format.

> +int get_hibernation_swap_type(dev_t device, sector_t offset)
> +{
> +	int type;
> +	struct swap_info_struct *sis;
> +
> +	spin_lock(&swap_lock);
> +	type = swap_type_of(device, offset);
> +	sis = swap_type_to_info(type);
> +	if (!sis || !get_swap_device_info(sis))
> +		type = -1;
> +
> +	spin_unlock(&swap_lock);
> +	return type;
> +}
> +
> +/*
> + * Drops the reference to the swap device previously acquired by
> + * get_hibernation_swap_type().
> + */
> +void put_hibernation_swap_type(int type)
> +{
> +	struct swap_info_struct *sis;
> +
> +	sis = swap_type_to_info(type);
> +	if (!sis)
> +		return;

I think it should never see sis == NULL here?

> +
> +	put_swap_device(sis);
> +}
> +
> +/*
> + * Simple lookup without acquiring a reference. Used by the sysfs
> + * hibernation path where user-space is already frozen, making
> + * swapoff impossible.
> + */
> +int find_hibernation_swap_type(dev_t device, sector_t offset)
> +{
> +	int type;
> +
> +	spin_lock(&swap_lock);
> +	type = swap_type_of(device, offset);
> +	spin_unlock(&swap_lock);
> +
> +	return type;
> +}
> +
>  int find_first_swap(dev_t *device)
>  {
>  	int type;
> @@ -2971,10 +3018,23 @@ SYSCALL_DEFINE1(swapoff, const char __user *, specialfile)
>  	 * spinlock) will be waited too.  This makes it easy to
>  	 * prevent folio_test_swapcache() and the following swap cache
>  	 * operations from racing with swapoff.
> +	 *
> +	 * Note: if a hibernation session is actively holding a swap
> +	 * device reference, swapoff will block here until the reference
> +	 * is released via put_hibernation_swap_type() or the wait is
> +	 * interrupted by a signal.

This looks really bad... It means swapoff will hung unless user send a
signal to stop it? How does that happen?

If hibernate may hold a reference without allocating any slot for a
long time, then maybe we better introduce a new si->flags bit to
indicate a device is used by hibernate, so swapoff can abort early
with a -EBUSY.

If hibernate only holds the swap device reference after it allocated
any slot, then we can avoid use a flag but use a hibernate type in
swap table instead:

diff --git a/mm/swap_table.h b/mm/swap_table.h
index 8415ffbe2b9c..025e004fc2e7 100644
--- a/mm/swap_table.h
+++ b/mm/swap_table.h
@@ -25,6 +25,7 @@ struct swap_table {
  * PFN:      | SWAP_COUNT |------ PFN -------|10| - Cached slot
  * Pointer:  |----------- Pointer ----------|100| - (Unused)
  * Bad:      |------------- 1 -------------|1000| - Bad slot
+ * Exclusive:|---- 0  ----| ------ 1 -----|10000| - Exclusive usage
  *
  * SWAP_COUNT is `SWP_TB_COUNT_BITS` long, each entry is an atomic long.
  *
@@ -46,6 +47,8 @@ struct swap_table {
  *   because only the lower three bits can be used as a marker for 8 bytes
  *   aligned pointers.
  *
+ * - Exclusive usage: e.g. for hibernation.
+ *
  * - Bad: Swap slot is reserved, protects swap header or holes on swap devices.
  */

Both readahead and swapoff (unuse scan) will abort upon seeing such slot,
we solve both readahead and swapoff issue together.

How do you think? We can use the flag idea first.

>  	 */
>  	percpu_ref_kill(&p->users);
>  	synchronize_rcu();
> -	wait_for_completion(&p->comp);
> +	err = wait_for_completion_interruptible(&p->comp);
> +	if (err) {
> +		percpu_ref_resurrect(&p->users);
> +		synchronize_rcu();

Do we need a synchronize_rcu here? It's required above because we are
releasing the resources so all RCU readers must exit from grace
period. But here we are aborting and not releasing anything so
there is no such need?

> +		reinit_completion(&p->comp);
> +		reinsert_swap_info(p);
> +		goto out_dput;
> +	}
> +
>  
>  	flush_work(&p->discard_work);
>  	flush_work(&p->reclaim_work);
> -- 
> 2.34.1
