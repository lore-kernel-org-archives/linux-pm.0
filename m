Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B89448BB5;
	Wed, 23 Sep 2026 09:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790155615; cv=none; b=sA2QEHf7zMw41Wc48WSdACIR5rlCcAdJ5kyG4YtVsxN6+1POijKjI/H0zQZ6/N0no0Cw/rgIRm5n4SJBnXkYzsLCgXSYH+dFncqhsTJ0/JGykI1XQzq2hDYklcejDMetUCDPLcoPFwrr6L9vl20FEa5vYgmj2vBO0V1qbLRAey4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790155615; c=relaxed/simple;
	bh=nKbPxja1vg+PuojebKm64hqmxpf7kqP7LLgyjdwiGc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCIDBjWX+PgprK5yi8FPo00HA4lMKbtePiG4Fm8yX5zIikp5uUcvq/Ya00kwwzuAktsktBnqMAQKgMzRHQqrfwanxcza1b6pz792fB1/6ynayh9y74iRT9lpU54N1MC1fxCL54LTfJrmpMfS48nvYpkx+6dkf8RJqOHJSo7wSzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOsnn8bN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOsnn8bN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0FB1F000FF;
	Wed, 23 Sep 2026 09:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790155614;
	bh=iS6fZqy0nasmuWNUZomY4SexpmabOMbtDPlLHAiTgRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aOsnn8bNahb0daEN6DM4xyL/Vuys+FDKBc6UWtuWf8qiGD29Wd4kh4+H+qOBscR9d
	 I5SQbKnZlHTrUREpEndnAAXAGa35nWjMGuyx9nZt0w0LXAB7Jl1aoXwokuo1ErAbuG
	 5McDt8SGzmhKUxDPUlHLFxwN80jiYyJNuDOpKgcAQeYlrIeHSlJcaNfQxJFuRM2kP4
	 biSdQiHFNzVU9/rllWk4K3eZHWjyqsYfNp9/AkRtQNjSJYKrTvwPQF0/dOFd6U+1wd
	 F4my6bqcV6+xhABvQP7U64+mgTCk9QXZLN+3vW8wPN1f1S2zMVvMktRoobzN+6/Hwk
	 7E/F1E13i7dBA==
Date: Wed, 23 Sep 2026 12:26:46 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Potapenko <glider@google.com>,
	David Hildenbrand <david@kernel.org>,
	Marco Elver <elver@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Dmitry Vyukov <dvyukov@google.com>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/5] hibernation: make safe_copy_page more robust and
 remove debug_pagealloc support
Message-ID: <arObVuHDoloyEOpa@kernel.org>
References: <20260917-hibernation-v1-0-7f7dfae3dbe0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-hibernation-v1-0-7f7dfae3dbe0@kernel.org>

gentle ping

On Thu, Sep 17, 2026 at 09:07:02AM +0300, Mike Rapoport (Microsoft) wrote:
> When hibernation creates a memory image, it uses set_direct_map() APIs to
> temporarily map pages that are marked as not present in the kernel page
> tables.
> 
> Initially, this was intended to support debug_pagealloc along with
> hibernation on x86.
> 
> With the increasing desire to use set_direct_map APIs for hardening
> features and with their inconsistent implementations across architectures,
> using kernel_page_present() + set_direct_map_valid_noflush() to save
> non-present pages in the hibernation image is not very safe, to say the
> least.
> 
> Worse, some combinations of debug features, such as debug_pagealloc and
> PAGE_POISON cause a crash during restore.
> 
> Keeping debug_pagealloc compatible with hibernation requires a complex
> infrastructure for tracking free unmapped pages with a page flag/page type,
> verifying that it is actually a free page that hibernate_map_page() tries
> to remap and making sure there are no stale or failed page table updates.
> With init_on_{alloc,free} and/or PAGE_POISON on top, this also requires the
> ability to map and initialize these free pages on restore.
> 
> This complexity does not seem justified for a somewhat niche debugging
> scenario.
> 
> Instead of a complex fix to support hibernation with debug_pagealloc, make
> sure that copy_data_pages() and its helpers properly handle errors that may
> happen during page table updates, explicitly enable saving of KFENCE pages
> and disallow hibernation when debug_pagealloc is enabled.
> 
> ---
> Mike Rapoport (Microsoft) (5):
>       hibernation: make swsusp_page helpers static
>       hibernation: ensure secretmem pages don't reach a snapshot
>       hibernate: handle potential errors in hibernate_{map,unmap}_page()
>       hibernation, KFENCE: explicitly map/unmap KFENCE pages
>       hibernation: make hibernation unavailable when debug_pagealloc is on
> 
>  include/linux/kfence.h   |  29 ++++++++++
>  include/linux/suspend.h  |   6 ---
>  kernel/power/hibernate.c |   6 +++
>  kernel/power/snapshot.c  | 137 +++++++++++++++++++++++++----------------------
>  mm/kfence/core.c         |  52 +++++++++++++++++-
>  5 files changed, 159 insertions(+), 71 deletions(-)
> ---
> base-commit: 0820e2e85e8aafde66256c567ad37a5b15708d4d
> change-id: 20260916-hibernation-7603b86eb981
> 
> --
> Sincerely yours,
> Mike.
> 

-- 
Sincerely yours,
Mike.
