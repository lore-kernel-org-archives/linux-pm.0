Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00ED3ADB94;
	Wed, 23 Sep 2026 15:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790178175; cv=none; b=lbWLAx+ZSiDILkUBGFGGKKirQZ2JcPAFH8cSB6aSGMLxFkVclHGB/sT5fwAN3BjWC65SOJC4LOTixHA84CKuoe3SmDOLiIUZzNWUazsF70FTg54Dm90dKf5LmqFrNsBSyGYZ/zGMEH5GDy4eKKGfH5yybSUzBxIOLd1jQhnXuMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790178175; c=relaxed/simple;
	bh=hRHP6Y2nLNPAGVgo4E3r2nfbvf1qUujdlwD+5QSSEsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upcuK8QwpV2UhbC0dgPD0VCIycBq8zKc2IN5K9gWatBQYPDb2gO/qt24VcdSIZmreGHiRkdbw7pcpPO0lTchVeC/e19NcL9+VYKEK/LtE+kxYngGvAwZ9YqZ3nVuA5JNqKXDMswj2rU9C+WK2gPN1PcNDu3D845EZ+3UqrYogM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1WVzvYS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1WVzvYS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21DB71F000FF;
	Wed, 23 Sep 2026 15:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790178174;
	bh=xphkqddDG35nFJUUbtMc1goiI0QNxJoZwZ8bkZ0ElbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i1WVzvYSaOYfd49odTZtOLwJB4iQITBY8XUEHEEQpD/kWRTktnbTJkZLDjXqGF0nf
	 bed3l3/hj4PNXTAYRUfC87gBnl+Ou/2V6U2Z06a4p+yIp32aU8PJepF9HHIQa+kN/G
	 6YkyGBytjw8PcWz0+cGVnCmGoxH1Ih3YLSRzMonWf4MZiN6Ixfz3sqIoKyZcmZ5S1m
	 EpnjtizqCMRHM+y4BLDJ+0DnanHh94QBNgq76UqxnY5daStbLnFCa3UfFDQIlp57K5
	 Xgjz+SZ1Tz1Lp1rxttFLMq95OEkmKTDC/Y0RYfRcd4nPWysiyPxN5F+hhQu8GxipAx
	 nkj6NUiUe/+Ww==
Date: Wed, 23 Sep 2026 18:42:48 +0300
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
Subject: Re: [PATCH 3/5] hibernate: handle potential errors in
 hibernate_{map,unmap}_page()
Message-ID: <arPzeJ7ZsdrXkzbF@kernel.org>
References: <20260917-hibernation-v1-0-7f7dfae3dbe0@kernel.org>
 <20260917-hibernation-v1-3-7f7dfae3dbe0@kernel.org>
 <5271866c-a334-453b-a95c-8bfbede1232b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5271866c-a334-453b-a95c-8bfbede1232b@kernel.org>

On Wed, Sep 23, 2026 at 12:13:39PM +0200, David Hildenbrand (Arm) wrote:
> On 9/17/26 08:07, Mike Rapoport (Microsoft) wrote:
> > When safe_copy_page() had to map/unmap pages only because of
> > debug_pagealloc() there could be no errors in the kernel page table
> > updates.
> > 
> > However, with the increasing desire to remove pages from the direct map
> > this assumption becomes a real stretch.
> 
> What's our general direction in that regard?
> 
> I'd assume we'd not want to modify the directmap from hibernation code and
> simply fail instead if we encounter that scenario.

First I want hibernation to only touch the memory that we know is safe to
remap, for now it's only kfence (the next patch), so no arbitrary direct
map changes there.

And if remapping fails, my take is that we should abort the hibernation.
 
> -- 
> Cheers,
> 
> David

-- 
Sincerely yours,
Mike.
