Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3309743CEEF;
	Wed, 13 May 2026 14:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778683464; cv=none; b=ILIXjWwuXYLVyemYuFBAOL6alF1q63FUSy8BPP83eZdLsLr7BntpB/6vFMxElduljTj4u1EldoNww8Mn7UsLMn/LwrtmK/J18FkamLYOwIm/PG4NR/byDt6cFq5zItYcI/AubcVVW9l18Va3qWokaI+YJ9rzcA0FeFpRIQw97Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778683464; c=relaxed/simple;
	bh=ig7qEY61qWpO2qqxgUl9QTZ5VrdTBw85h6pXPckbh/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cheE9GDpXIo+sCXKUOgaqKuHRP8id/L0gdcu9wUKNtYq1PRaH2kAY57Gd3FWsKKCOSHfXjgORi25gi7R4CEzAbUM3zUfwPJbQXMWO+3p0ziMGkCDVCh+hIvc2tex9e57tP6joa4oxx8E2peUHZS0GhB6gtLv1ZO8uRoNleqFK5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0NFZoao; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0NFZoao"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00750C19425;
	Wed, 13 May 2026 14:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778683463;
	bh=ig7qEY61qWpO2qqxgUl9QTZ5VrdTBw85h6pXPckbh/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h0NFZoaoDh7fQdlc79oCfhVnXSN8TcLjFKXCH0qOYZtKtmxbwhWEdcXJjBhmTE2Zh
	 KSdaZwyh3Rsnk/b14AMd/XavhYhWeV02x38FFxIM2xQOZLXj8/VcMm6Yterb8B7o5y
	 uhWgyP2i3xEXrwfLLmiPxUrKajn34WJqy529q3Lbzg44AxEwCNByiZlTPl4RJJ9Exw
	 nzQiEqRv/LJ4NAwdsQvmOxOmBb5kub03GMIi8lGXp8jFMcFY9qVNAP633a11TBWy8n
	 1Vs1lQYKWio8VdJgVEOJhTrkoUryhTEsegcqfRXzg2QHvyji7eN3JiFwMZX/CgVxhA
	 Wr48RWKY/YRNA==
Date: Wed, 13 May 2026 17:44:13 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/4] mm: introduce for_each_free_list()
Message-ID: <agSOPdfyEi1jCBvA@kernel.org>
References: <20260513-page_alloc-unmapped-prep-v1-0-dacdf5402be8@google.com>
 <20260513-page_alloc-unmapped-prep-v1-1-dacdf5402be8@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513-page_alloc-unmapped-prep-v1-1-dacdf5402be8@google.com>

On Wed, May 13, 2026 at 12:35:13PM +0000, Brendan Jackman wrote:
> There are a couple of places that iterate over the freelists with
> awareness of the data structures' layout.
> 
> It seems ideally, code outside of mm should not be aware of the page
> allocator's freelists at all. But, this patch just doesn't hide them
> completely, it's just a meek incremental step in that direction: provide
> a macro to iterate over it without needing to be aware of the actual
> struct fields.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  include/linux/mmzone.h  |  9 ++++++---
>  kernel/power/snapshot.c |  8 ++++----

looks scary what it does with zones and pages :/

>  mm/mm_init.c            | 11 +++++++----

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

>  3 files changed, 17 insertions(+), 11 deletions(-)

-- 
Sincerely yours,
Mike.
