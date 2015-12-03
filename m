From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 09/10] PM / Hibernate: Publish pages restored in-place
 to arch code
Date: Thu, 3 Dec 2015 12:09:25 +0000
Message-ID: <20151203120925.GA2220@red-moon>
References: <1448559168-8363-1-git-send-email-james.morse@arm.com>
 <1448559168-8363-10-git-send-email-james.morse@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:48571 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854AbbLCMIT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 3 Dec 2015 07:08:19 -0500
Content-Disposition: inline
In-Reply-To: <1448559168-8363-10-git-send-email-james.morse@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: James Morse <james.morse@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Will Deacon <will.deacon@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Kang <kkang@intrinsyc.com>, Geoff Levand <geoff@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, AKASHI Takahiro <takahiro.akashi@linaro.org>, wangfei <w.f@huawei.com>, Marc Zyngier <marc.zyngier@arm.com>

On Thu, Nov 26, 2015 at 05:32:47PM +0000, James Morse wrote:

[...]

> @@ -2427,25 +2434,31 @@ static void *get_buffer(struct memory_bitmap *bm, struct chain_allocator *ca)
>  	if (PageHighMem(page))
>  		return get_highmem_page_buffer(page, ca);

I know it is not a problem for arm64, but you should export the
"restored" highmem pages list too because arch code may need to use
it for the same reasons this patch was implemented.

> -	if (swsusp_page_is_forbidden(page) && swsusp_page_is_free(page))
> -		/* We have allocated the "original" page frame and we can
> -		 * use it directly to store the loaded page.
> -		 */
> -		return page_address(page);
> -
> -	/* The "original" page frame has not been allocated and we have to
> -	 * use a "safe" page frame to store the loaded page.
> -	 */
>  	pbe = chain_alloc(ca, sizeof(struct pbe));
>  	if (!pbe) {
>  		swsusp_free();
>  		return ERR_PTR(-ENOMEM);
>  	}
> -	pbe->orig_address = page_address(page);
> -	pbe->address = safe_pages_list;
> -	safe_pages_list = safe_pages_list->next;
> -	pbe->next = restore_pblist;
> -	restore_pblist = pbe;
> +
> +	if (swsusp_page_is_forbidden(page) && swsusp_page_is_free(page)) {
> +		/* We have allocated the "original" page frame and we can
> +		 * use it directly to store the loaded page.
> +		 */
> +		pbe->orig_address = NULL;
> +		pbe->address = page_address(page);
> +		pbe->next = restored_inplace_pblist;
> +		restored_inplace_pblist = pbe;
> +	} else {
> +		/* The "original" page frame has not been allocated and we
> +		 * have to use a "safe" page frame to store the loaded page.
> +		 */
> +		pbe->orig_address = page_address(page);
> +		pbe->address = safe_pages_list;
> +		safe_pages_list = safe_pages_list->next;
> +		pbe->next = restore_pblist;
> +		restore_pblist = pbe;
> +	}

This makes sense to me, more so given that the pbe data is already
pre-allocated regardless in prepare_image() (ie it should not change
the current behaviour apart from calling chain_alloc() for every page we
are restoring), you are just adding a pointer to stash that information,
hence, if it is ok for Pavel and Rafael I think this patch can be considered
for merging.

Feedback appreciated.

Thanks,
Lorenzo

> +
>  	return pbe->address;
>  }
>  
> @@ -2513,6 +2526,7 @@ int snapshot_write_next(struct snapshot_handle *handle)
>  			chain_init(&ca, GFP_ATOMIC, PG_SAFE);
>  			memory_bm_position_reset(&orig_bm);
>  			restore_pblist = NULL;
> +			restored_inplace_pblist = NULL;
>  			handle->buffer = get_buffer(&orig_bm, &ca);
>  			handle->sync_read = 0;
>  			if (IS_ERR(handle->buffer))
> -- 
> 2.6.2
> 
