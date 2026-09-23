Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356AD53A3A5;
	Wed, 23 Sep 2026 15:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790177920; cv=none; b=iskhHHe2lgTI4gnEvCKIRXoFyGbHTNkA5WQDY7m/Oml5h4aH+lJmhq5GeTX/KAk7VMQVHqvYntVDXzpJYduNYno8aDq0mYqsA9nacc2o2s5Ly5WPxm9dUrxNhDKIcRzwgZUBWziB9Q0EfBCU9yhs4yBGNPe23mLZR0KdPF2JKgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790177920; c=relaxed/simple;
	bh=ToK0TNxC3oAnPP0HqGNewVc3O3yCJzRv01PvOvv1TMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sq1uFBWg2BefCaQITi6tAxUPy5w3SHKBBP6jy0eD6UQFQePGwRwcUWVxuB6TK8maYb6BEj0CY4SzHQVDySdd2jluCLxk8P06+LTfJnoqxarbC7wNwTF6Jx5Ovv4JhVTm4+Q/dgbi7Qn28Ca5XJ33qWvwgPYVDXce1zIXhtPSc1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIAz+p+G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIAz+p+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B381F000FF;
	Wed, 23 Sep 2026 15:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790177918;
	bh=WBvzheVxpsN1KuGNPAJdA0qsktLApMfKzycXl7Y5NAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZIAz+p+GcBovjWK/gG9i/D/MOXQ6OZFqKjDxy3MduFYI8wZ+szwC/H9/Z8emkXg4g
	 X+hanW4zo94iLmVClDyVPrxvOFngm6qm0TMVLJO6VA0DplqL1GsgHMUrgA48FverBk
	 3P0RJT7+fDPZFCKVGPMWQy3ILRtoC6Y1aAEBIDMBywNZ0fo6glmzFuzHCsTXVhnmhC
	 QjszwSyRaPkJkdm0ZxQqZIz2RqfYYb6/EkJJjXrCBTUN/HsmXeoZ+UeuZj+ziA7uSa
	 Vo8KDnAzq2ub3A0itwuFcxN+xydMHSeMo9ywhOlg/C4o2hQ5RPo28PPDOD+P8f+l7n
	 FIRYA5V3Ikouw==
Date: Wed, 23 Sep 2026 18:38:32 +0300
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
Subject: Re: [PATCH 2/5] hibernation: ensure secretmem pages don't reach a
 snapshot
Message-ID: <arPyeNHUkthT4Rlv@kernel.org>
References: <20260917-hibernation-v1-0-7f7dfae3dbe0@kernel.org>
 <20260917-hibernation-v1-2-7f7dfae3dbe0@kernel.org>
 <4ed926ae-9e9b-45d7-9ba3-a24431522bb2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ed926ae-9e9b-45d7-9ba3-a24431522bb2@kernel.org>

On Wed, Sep 23, 2026 at 12:10:52PM +0200, David Hildenbrand (Arm) wrote:
> On 9/17/26 08:07, Mike Rapoport (Microsoft) wrote:
> > hibernation_available() checks for active secretmem users, but a secretmem
> > file can be created after this check and its pages may get into the
> > hibernation snapshot although they should not.
> > 
> > Recheck secretmem state after userspace is frozen and abort hibernation if
> > secretmem is active.
> > 
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  kernel/power/hibernate.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> > index d2479c69d71a4..281ad49411481 100644
> > --- a/kernel/power/hibernate.c
> > +++ b/kernel/power/hibernate.c
> > @@ -412,6 +412,11 @@ int hibernation_snapshot(int platform_mode)
> >  	if (error)
> >  		goto Close;
> >  
> > +	if (secretmem_active()) {
> > +		error = -EBUSY;
> > +		goto Thaw;
> > +	}
> > +
> 
> Should we instead recheck hibernation_available() like we do at the beginning of
> hibernate() before freezing?

I'm not sure it's possible to hotplug cxl at that tiny window, but yeah,
checking hibernation_available() is cleaner.
 
> -- 
> Cheers,
> 
> David

-- 
Sincerely yours,
Mike.
