Received: from lgeamrelo07.lge.com (lgeamrelo07.lge.com [156.147.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2875E30595B
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.147.51.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356495; cv=none; b=dmRgFbbPx+dHuBHV0vUmYjj9pmQqs8qvXhIJxtDNgg3XhdXcvdFIGYMy+/nWsrN/fM8YEKTwtikr1OZ8nqszEite4JIp9r7FmiWxlDhJcFlJbbBQIr/o5Yz3xtG2NE5RD5m3HaED+flJkrSShLVHl+Kc24lkCwvyNdjoaSlgRvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356495; c=relaxed/simple;
	bh=wcz8g7Gg0gU/vPrdLchml9QC1fPay4JV6uKOqBpj2Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvK8aliMPvmuV+NRUcUS16DLTLXr4c5AY0dZQgKxGEyLDBaAuaNZ6yaAclpA1ONmuJUpdxb7m/PUPePelidky1X3gNIgLCUtImAW3cvovN1/Tg26LL1K/NoVkbVPD9q6wrgfcc7GegqGcM/Y7wYXzDRX4Bf9yURDg8xCfz/CLWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com; spf=pass smtp.mailfrom=lge.com; arc=none smtp.client-ip=156.147.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lge.com
Received: from unknown (HELO yjaykim-PowerEdge-T330) (10.177.112.156)
	by 156.147.51.103 with ESMTP; 24 Mar 2026 21:48:04 +0900
X-Original-SENDERIP: 10.177.112.156
X-Original-MAILFROM: youngjun.park@lge.com
Date: Tue, 24 Mar 2026 21:48:04 +0900
From: YoungJun Park <youngjun.park@lge.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Pavel Machek <pavel@kernel.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>,
	linux-pm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 1/2] mm/swap, PM: hibernate: fix swapoff race in
 uswsusp by pinning swap device
Message-ID: <acKIBGjQDZrMQXjF@yjaykim-PowerEdge-T330>
References: <20260323160822.1409904-1-youngjun.park@lge.com>
 <20260323160822.1409904-2-youngjun.park@lge.com>
 <acH_svpUwaNtFeJN@KASONG-MC4>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acH_svpUwaNtFeJN@KASONG-MC4>

On Tue, Mar 24, 2026 at 01:53:33PM +0800, Kairui Song wrote:
> On Tue, Mar 24, 2026 at 01:08:21AM +0800, Youngjun Park wrote:
> > Hibernation via uswsusp (/dev/snapshot ioctls) has a race window:
> > after selecting the resume swap area but before user space is frozen,
> > swapoff may run and invalidate the selected swap device.
> > 
> > Fix this by pinning the swap device with SWP_HIBERNATION while it is
> > in use.  The pin is exclusive, which is sufficient since
> > hibernate_acquire() already prevents concurrent hibernation sessions.
> > 
> > The kernel swsusp path (sysfs-based hibernate/resume) uses
> > find_hibernation_swap_type() which is not affected by the pin.  It
> > freezes user space before touching swap, so swapoff cannot race.
> > 
> > Introduce dedicated helpers:
> > - pin_hibernation_swap_type(): Look up and pin the swap device.
> >   Used by the uswsusp path.
> > - find_hibernation_swap_type(): Lookup without pinning.
> >   Used by the kernel swsusp path.
> > - unpin_hibernation_swap_type(): Clear the hibernation pin.
> 
> Looks good to me, thanks!
> 
> Reviewed-by: Kairui Song <kasong@tencent.com>

Thanks for the review, Kairui, and for all your feedback throughout
the revisions!

> Just one trivial nit picks below.

> > +/**
> > + * unpin_hibernation_swap_type - Unpin the swap device for hibernation
> > + * @type: Swap type previously returned by pin_hibernation_swap_type()
> > + *
> > + * Clear the hibernation pin on the given swap device, allowing
> > + * swapoff() to proceed normally.
> > + *
> > + * If @type does not refer to a valid swap device, this function
> > + * does nothing.
> > + */
> > +void unpin_hibernation_swap_type(int type)
> > +{
> > +	struct swap_info_struct *si;
> > +
> > +	spin_lock(&swap_lock);
> > +	si = swap_type_to_info(type);
> > +	if (!si) {
> > +		spin_unlock(&swap_lock);
> > +		return;
> > +	}
> > +	si->flags &= ~SWP_HIBERNATION;
> 
> Will the code will be simpler if you just:
> 
> if (si)
> 	si->flags &= ~SWP_HIBERNATION;
> 
> Just personal taste, free feel to ignore.

Noted on the style preference. I'll keep it in mind. :D

> And as you mentioned this is on top of swap table p3 so you based
> it on mm-new - but isn't p3 already in mm-unstable? Maybe we can
> have it there? Not sure how much conflict are there with PM.
> 
> The code and design looks OK.

Regarding the base branch. Andrew is already aware of the
potential conflicts in linux-next, and we've discussed possibly
parking this for the next cycle depending on Rafael's input.
So I think we can keep it as-is for now and see how things go!

Best regards,
Youngjun Park
