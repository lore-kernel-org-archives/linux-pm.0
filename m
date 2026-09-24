Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC2C4A64CC;
	Thu, 24 Sep 2026 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265764; cv=none; b=ULixp0TvVCnSWmeFu2mInOJHOVpmbaiumX59hBujQuvbMXp2+181NoMosTBz0P7Udzc5SVNhnh9R1Ql5znw728LQONdaUSeeO/w8epgM2kB1RP0/SSuCXMExixbEurj/VL0hmAZ0euiY+XaUR1a6Ig0hpjgIPn3LTCkGaAbeYTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265764; c=relaxed/simple;
	bh=ZC7n+Wu/swBT9ZYEIkVtfiLJa+rbVEG83O5DVAMz1XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ai+uuqgMUleYGLgDMZQtymmI9eJIhOj9+rnd/iKxEeMwTSNdONE/6N8GbB8+J42OxvnahxfO+Z3MWcyrxl9sEcPH3CPuUx6ua+qeXodgi3HfQRzLII506fD9aH2OTnm4WftLzI9GYuCxgQheb52F1YaMGjSuviCopOdlhuWg12k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCVCgE0g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCVCgE0g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7769E1F00893;
	Thu, 24 Sep 2026 16:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790265762;
	bh=LTVNxkLpxxqWMqUQZ0iwgzz/ZL7tmFRV02wmYrTnaqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JCVCgE0gmJUzhASH+5rtu/5xRKwTuLgflc/WYMUQqRPPnF9eI+KOFeYkTO8Hj9Asu
	 lbIam1iYoMGzFAljxVrWwRbgIxINu4lshZrJIGGYrNa7OLMnEogLxR8YWuzOzCddZN
	 4rjqCo+1pd+4rkDWcIyXhh3/E0Ly+Hz2ffau6jPxiS9hnkwG1A/+v3o95vWGPGZ/9R
	 k449H4J9d3LUcEk72NCiYEiPVxoaoWNgviro55RD1GvOrIxfXrdSDJXKkQzOPTGyE8
	 4/Gk1eVUwiTQLWHPl9yE2MN2pRY8uPzQPcGVf/FHGn7+apyRqj7iMM151m4VIRGFJB
	 PlnDtnnDfHEeQ==
Date: Thu, 24 Sep 2026 19:02:35 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>, Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 4/5] hibernation, KFENCE: explicitly map/unmap KFENCE
 pages
Message-ID: <arVJm8CiLG6vpy9-@kernel.org>
References: <20260917-hibernation-v1-0-7f7dfae3dbe0@kernel.org>
 <20260917-hibernation-v1-4-7f7dfae3dbe0@kernel.org>
 <fec1931b-1173-4e14-b74a-7b3987a9b7bc@kernel.org>
 <arP0-maAEi5yeNnl@kernel.org>
 <d568a29b-5745-4214-96d3-1b635cd46c15@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d568a29b-5745-4214-96d3-1b635cd46c15@kernel.org>

On Thu, Sep 24, 2026 at 10:19:33AM +0200, David Hildenbrand (Arm) wrote:
> On 9/23/26 17:49, Mike Rapoport wrote:
> > On Wed, Sep 23, 2026 at 12:31:26PM +0200, David Hildenbrand (Arm) wrote:
> >> On 9/17/26 08:07, Mike Rapoport (Microsoft) wrote:
> >>> The pages protected by KFENCE are removed from the direct map.
> >>>
> >>> safe_copy_page() temporarily maps and unmaps them using set_direct_map
> >>> APIs, or, when the stars align, even using debug_pagealloc_map_pages().
> >>>
> >>> Neither of these APIs cares whether it is a KFENCE page and both blindly
> >>> perform the update of the kernel page table for any non-present page.
> >>
> >> Agreed, we should route this through the actual mechanism that modified the
> >> directmap in the first place.
> >>
> >>>
> >>> Ability to use debug_pagealloc_map_pages() to remap KFENCE pages when both
> >>> KFENCE and debug_pagealloc are enabled is an amusing coincidence.
> >>>
> >>> But with increasing appetite for using set_direct_map for hardening
> >>> purposes, it becomes too big of a hammer to enable saving any non-present
> >>> page in the hibernation image.
> >>>
> >>> Another gotcha is that loongarch that does not have a direct map at all
> >>> advertises ARCH_HAS_SET_DIRECT_MAP to allow coexistence of KFENCE and
> >>> hibernation.
> >>>
> >>> Extend KFENCE with a bitmap that tracks which pages are protected and
> >>> provide kfence_force_mapping() and kfence_restore_mapping() APIs that allow
> >>> forced mapping and unmapping of KFENCE pages.
> >>>
> >>> Use these APIs in hibernate_{map,unmap}_pages() for KFENCE pages.
> >>>
> >>> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> >>> ---
> >>>  include/linux/kfence.h  | 29 +++++++++++++++++++++++++++
> >>>  kernel/power/snapshot.c |  7 +++++++
> >>>  mm/kfence/core.c        | 52 +++++++++++++++++++++++++++++++++++++++++++++++--
> >>>  3 files changed, 86 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/include/linux/kfence.h b/include/linux/kfence.h
> >>> index e5822f6e7f279..33a126cb6d1b7 100644
> >>> --- a/include/linux/kfence.h
> >>> +++ b/include/linux/kfence.h
> >>> @@ -222,6 +222,32 @@ struct kmem_obj_info;
> >>>  bool __kfence_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab);
> >>>  #endif
> >>>  
> >>> +/**
> >>> + * kfence_force_mapping() - make sure a KFENCE page is mapped
> >>> + * @page: page to map
> >>> + *
> >>> + * Check whether @page is protected and map it if needed.
> >>> + *
> >>> + * Requires: is_kfence_address(page_address(page))
> >>> + *
> >>> + * Return:
> >>> + * * false - failed to map @page
> >>> + * * true - @page is mapped
> >>> + */
> >>> +bool kfence_force_mapping(struct page *page);
> >>> +
> >>> +/**
> >>> + * kfence_restore_mapping() - restore mapping of a KFENCE page
> >>
> >>
> >> The name is misleading. You are actually restoring that the page is
> >> unmapped/protected?
> >>
> >> 	kfence_force_mapping vs. kfence_restore_mapping
> >>
> >> is confusing.
> >>
> >> Can we find a better pair of function names that describe what is actually
> >> happening?
> >>
> >> Maybe something along the lines of
> >>
> >> 	kfence_prepare_copy_page
> >>
> >> 	kfence_finish_copy_page
> >>
> >> That rather expresses what the caller intends to do.
> > 
> > Naming is hard :-D
> > 
> > I feel that _copy_page() is to vague and adding hibernation there is to
> > mouthful :(
> 
> Yeah, I wouldn't mention hibernation.
> 
> 
> 
> > 
> > And these could be used outside of safe_copy_page() someday.
> > 
> > How about 
> > 
> > kfence_set_page_present()
> > kfence_set_page_default()
> 
> 
> Maybe spell out "direct_map" ?
> 
> kfence_set_direct_map_present()
> 
> kfence_set_direct_map_default()

They are not necessarily in direct map :)
loongarch does not have direct map, but still supports kfence
 
> But yeah, something along those lines is better.
> 
> -- 
> Cheers,
> 
> David

-- 
Sincerely yours,
Mike.
