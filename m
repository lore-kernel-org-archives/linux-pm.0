Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA27734F483;
	Wed, 13 May 2026 17:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692756; cv=none; b=dZywTxXLo+8rPyIjkn++hNwsTyEeifF2+O5K1Rnj/yAzpzKGFwxSd9LsfaUINBrsQhj3PgkOII1j3mG3fx4oFrI+zHGU8rjlHRgrRKMErB3tMPRx1PtGaaTAiA4xn3Y7TPdERK9pNwVjENqGBNuDTx/4EmncHwze+INBG2T0hHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692756; c=relaxed/simple;
	bh=a2m0H9bRkehtzq1C47bsY9lKLcn1BhGr/BABwJip2hU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BtpTJIVKJfYdmvzJllKWFTz3yO+crXjDNR4+vND7EiUxsdfFHIu+69Prp+HNwjRLT5EvmQZeRwk9ZdU+jea2xStxDhCgL3SBtZVFTMFaIBC45NSbheDamZnhUZBXXBozyr9+8y0mnGD0IYZREwBDXb4sG4DfjGKhJxAJkQbuKh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGJBov3y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGJBov3y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B24C19425;
	Wed, 13 May 2026 17:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778692755;
	bh=a2m0H9bRkehtzq1C47bsY9lKLcn1BhGr/BABwJip2hU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iGJBov3y/YQVckiqnx77E8+ICLFUz4bhqGcVM6VJaS/O6Yz03Ti1LQWVHcKH1fVFu
	 AtN57f+nCsK4WgzJ2b38M9JmXzTFElLiuh9CqGyG1HH/VXM7fEFFXmWe/duVezBZdC
	 8PGJhEoYNEHfkWfdsF/tcR8cMIhRZ9fBxmcn0h92TNSMhuWcftmrxwyIyujE2msDfu
	 uBHuVeQulmw985uYf2gBoVxu7bqvYxzGfbUBPzMeQ4xGLo5k317DmK+07AzEixx3ec
	 SMs9AijHSttEKjdOgoPiyoRXkB2VoXrrUg5v/ZG8JIFqDwpWTF9RPAqjNlPqhMcmtl
	 09CJNtLSeBiqg==
Message-ID: <4074a816-9e75-45a6-8141-25459bcc106b@kernel.org>
Date: Wed, 13 May 2026 19:19:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] mm/page_alloc: remove ifdefs from pindex helpers
Content-Language: en-US
To: Brendan Jackman <jackmanb@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Kairui Song <kasong@tencent.com>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>,
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260513-page_alloc-unmapped-prep-v1-0-dacdf5402be8@google.com>
 <20260513-page_alloc-unmapped-prep-v1-4-dacdf5402be8@google.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260513-page_alloc-unmapped-prep-v1-4-dacdf5402be8@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/13/26 14:35, Brendan Jackman wrote:
> The ifdefs are not technically needed here, everything used here is
> always defined.
> 
> Switching to IS_ENABLED() makes the code a bit less tiresome to read.
> 
> Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  mm/page_alloc.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 5d6144c8860ed10fd641184f389c4953465d5178..2985ad0ab1044bdfda8ccc7aaed2ded19b5ac7ed 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -650,19 +650,17 @@ static void bad_page(struct page *page, const char *reason)
>  
>  static inline unsigned int order_to_pindex(int migratetype, int order)
>  {
> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> +		bool movable = migratetype == MIGRATE_MOVABLE;
>  
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	bool movable;
> -	if (order > PAGE_ALLOC_COSTLY_ORDER) {
> -		VM_BUG_ON(!is_pmd_order(order));
> +		if (order > PAGE_ALLOC_COSTLY_ORDER) {
> +			VM_BUG_ON(!is_pmd_order(order));
>  
> -		movable = migratetype == MIGRATE_MOVABLE;
> -
> -		return NR_LOWORDER_PCP_LISTS + movable;
> +			return NR_LOWORDER_PCP_LISTS + movable;
> +		}
> +	} else {
> +		VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
>  	}
> -#else
> -	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
> -#endif

Uh yeah, VM_BUG_ONs are frowned upon now. But doing a VM_WARN_ON_ONCE here
makes little sense. There's no safe fallback if we end up here with a wrong
value. And it's all internal to page alloc so I'd just drop those checks
completely at this point.

>  	return (MIGRATE_PCPTYPES * order) + migratetype;
>  }
> @@ -671,12 +669,12 @@ static inline int pindex_to_order(unsigned int pindex)
>  {
>  	int order = pindex / MIGRATE_PCPTYPES;
>  
> -#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	if (pindex >= NR_LOWORDER_PCP_LISTS)
> -		order = HPAGE_PMD_ORDER;
> -#else
> -	VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
> -#endif
> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
> +		if (pindex >= NR_LOWORDER_PCP_LISTS)
> +			order = HPAGE_PMD_ORDER;
> +	} else {
> +		VM_BUG_ON(order > PAGE_ALLOC_COSTLY_ORDER);
> +	}
>  
>  	return order;
>  }
> 

