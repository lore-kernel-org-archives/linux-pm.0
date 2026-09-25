Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD21A355057;
	Fri, 25 Sep 2026 09:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790328794; cv=none; b=DlaHU4VZlNPonQ/u/sSRNSKsG4sp5dEneVOD2Gb+A2sVrzp/WzHUch8p8QTt4H7Hn+zT+RUV1Dty0B6UVkgXfGtfuwgDNiPDM9lM6EEJ3PRzgrztpAAd+dJsLvq3+oFi0SWB1fzms6klkin+xgP8wpTb2KFgeen30im91Q0zsZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790328794; c=relaxed/simple;
	bh=rldZgUs+sGJNpukuIiIrdnNc8r1Bc8fd86+IFRuQsVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTqaXnKVDY+yA8LogT7C28OaI/U2tHg5Ky81bTXDiSgMapYyVIz5p/mI/kIQPUYFk2N9kDB4Kvpe+3nbWCKbhW50dwRkLFzL20rMobmxICnPbqutg4d1IwhhUJM0NhxuUCBWwgRxxx6jpSbiqMgzruQRnf8+Uxhl8pc360OjJdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMIVa0BQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMIVa0BQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D231F000FF;
	Fri, 25 Sep 2026 09:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790328793;
	bh=zc9n3mJqDMHT63RHHVZQRnyrWAkJ65jwuxAucGKRt8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nMIVa0BQ18T14JZR4xL9yjqjrPrEX6NpiZ4+6BZJys6GSNo5xl2WmCChPao2jVEIQ
	 jfzbNthAkqojRoRFWj8OIisDLwJKu93jq7ZvFZk9/HuT1pGLId6pg7zYGPGvZEMSco
	 rF01ycq7yBYtgtW9v42VWsXA1GXSTN3tazX8ZhrWn5k4LwGaBT9czRGHFvduLIDxSk
	 jcWV6bRCYd7gFHL4T+HaABcjhJAh8uXt778MyFjuJm17vAPBmd/zhJB0lkOFqBcryy
	 qjxKUZX8Zef3dE5xRk88qPloiyRonEEMoqzqBF0l+ac0e9PcnrLIVx6Rp+T7LgXVlR
	 y+NUjR5s8nnbg==
Date: Fri, 25 Sep 2026 12:33:07 +0300
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
Message-ID: <arY_058nsjb_Ie1l@kernel.org>
References: <20260917-hibernation-v1-0-7f7dfae3dbe0@kernel.org>
 <20260917-hibernation-v1-4-7f7dfae3dbe0@kernel.org>
 <fec1931b-1173-4e14-b74a-7b3987a9b7bc@kernel.org>
 <arP0-maAEi5yeNnl@kernel.org>
 <d568a29b-5745-4214-96d3-1b635cd46c15@kernel.org>
 <arVJm8CiLG6vpy9-@kernel.org>
 <c01aa1e3-f2cd-4b28-8e6a-8e8a1c36c641@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c01aa1e3-f2cd-4b28-8e6a-8e8a1c36c641@kernel.org>

On Thu, Sep 24, 2026 at 08:49:13PM +0200, David Hildenbrand (Arm) wrote:
> On 9/24/26 18:02, Mike Rapoport wrote:
> > On Thu, Sep 24, 2026 at 10:19:33AM +0200, David Hildenbrand (Arm) wrote:
> >> On 9/23/26 17:49, Mike Rapoport wrote:
> >>>
> >>> Naming is hard :-D
> >>>
> >>> I feel that _copy_page() is to vague and adding hibernation there is to
> >>> mouthful :(
> >>
> >> Yeah, I wouldn't mention hibernation.
> >>
> >>
> >>
> >>>
> >>> And these could be used outside of safe_copy_page() someday.
> >>>
> >>> How about 
> >>>
> >>> kfence_set_page_present()
> >>> kfence_set_page_default()
> >>
> >>
> >> Maybe spell out "direct_map" ?
> >>
> >> kfence_set_direct_map_present()
> >>
> >> kfence_set_direct_map_default()
> > 
> > They are not necessarily in direct map :)
> > loongarch does not have direct map, but still supports kfence
> 
> Ugh :D
> 
> But where are the pages mapped/unmapped then?

loongarch remaps them into vmalloc address space and sets page->virtual for
page_address() to work.
 
> (I know, I should read your doc patch)
> 
> -- 
> Cheers,
> 
> David

-- 
Sincerely yours,
Mike.
