Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26AC344D8D;
	Mon,  5 Oct 2026 06:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791181520; cv=none; b=nEZbChIXdYVt+HhWPaFTCdZKtIJzYtFKQIzrFXMtnHrrKSYXbfISpxG/HVg3TXiTej15R0Qrs+gU8aPHlR0USRlyBFYoMGMzarx48ojneUw51brXW2aWOc05cTP1e19xANUAQ+p56rcHVpLYiZujdByncZ1ALMMn26oIyLZ3P2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791181520; c=relaxed/simple;
	bh=v+fvybV0/+yfra8LreljHiSZGvwZeO39Vcjx/G9a3s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=noVjDSzpTHFttv+GVSDwUzpF0k45/atIyPtIzTJEaZ9oNmdZ4PQ42hnj7nFH6NCLwaESrMz1TL9Qk6IREhq8HMS25Db6lXVtH7qmSntKHWz+BadkEl0d71dLaSKcx0HFo1ihqKpyuz1dv7YgkcIcgx21Q8TO7V0IuZeetpNBBl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WC8yMdGh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WC8yMdGh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EABC21F00898;
	Mon,  5 Oct 2026 06:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791181519;
	bh=f/zlpiMoTWnp2TT3RR9cs85xU8BueePHWB0lb+mC0Es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WC8yMdGh8BY0yST3jm9GM3ngxmYXHvY3i1vjlf5wzsvFreg3cOWx9l/NOXEAJwZCP
	 0nnWINkAhstherLgk6C7qNBHW9sOA41ot89M+XxnyUxAv9TeFJeSWSsuoe6UbvAiuM
	 uLF4EhhdK9GlIzdlkCvhXSqqmrtk5+ojcYPYi+tf2WjQFB5YUml0BuffwwlQWAf/Nc
	 HnsRWQcOj0Ew1tycfJbp1G3pvFkNrwJxbZlb/R90/N2l/ADv6Vws74JvH4y6eEisef
	 qZyVjYft7eu4NiiNiKQ8Er1Skzr3qihUaKIa5+twoMuzk9WDCPNji4rttf90ZyFpoG
	 OR0mCFzP6sdSg==
Date: Mon, 5 Oct 2026 06:25:16 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Andrew Pam <andrew@fastmailteam.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Sebastian Reichel <sre@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Matt DeVillier <matt.devillier@gmail.com>,
	chrome-platform@lists.linux.dev, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: cros_charge-control: restore EC state on
 resume
Message-ID: <asNCzKz90NZUc_cR@google.com>
References: <20261004225606.30577-1-andrew@fastmailteam.com>
 <asMlkcx5P3Qgolgh@google.com>
 <8fa29694-88cb-41b7-95d6-4d2cf9647d4a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fa29694-88cb-41b7-95d6-4d2cf9647d4a@app.fastmail.com>

On Mon, Oct 05, 2026 at 03:44:45PM +1100, Andrew Pam wrote:
> On Mon, 5 Oct 2026, at 15:20, Tzung-Bi Shih wrote:
> > On Mon, Oct 05, 2026 at 09:56:06AM +1100, Andrew Pam wrote:
> > > Nothing notices the reset. Commit 4fc88ba435da ("power: supply:
> > > cros_charge-control: adopt EC charge state on probe") made the driver
> > 
> > The commit 4fc88ba435da doesn't exist.
> 
> Thanks for the review. The patch is against Sebastian's power-supply for-next, where that is Matt's patch you reviewed, applied on 10 September:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/commit/?id=4fc88ba435da
> 
> It isn't in mainline or chrome-platform yet, so I have made that explicit in the v2 commit message.
> 
> > > initialise its cached state from the EC, but it does so only on probe,
> >                               ^^^^
> > To be precise, this should be "to".
> 
> Reworded in v2 as "made the driver adopt the EC's charge state, but only at probe".

Ah, I see.  I misunderstood because the commit wasn't in my local tree.
