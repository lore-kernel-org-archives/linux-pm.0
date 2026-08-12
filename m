Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB08434E4F;
	Wed, 12 Aug 2026 11:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786534330; cv=none; b=FigUZkfACCrvHYmd79XUA/Snaue9ztsS9YRCKlHDeOItD3+49mxSrz5unc5rSXC0N0V06nqYOOZUqiNwcLmHwo3D/ykj+CegZz0Z/4h9uxd5EgDKMmcckGvg3dAFIQKDL/A1+cyuDyY/v4FfQsIf0A8Qe4MLalMLbnGrkhW7LlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786534330; c=relaxed/simple;
	bh=pgZ3A8z1X2zBEah+1/UswpM/3yqtaXm7qKlVSOEcOSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RRcVFGdY7mDm2nzKXwzdBAVy4p+nyayhYSVPxewb+9Wz42vlKjDg8sjc7I436n3mRGD8fvzncIyXeBDDBNb7I/ixV5haib9GxSPoUWtF83F5XkF/5zWXUDL9OcHQxJw9vcqT9vkOYEevNwIeUqv57n9zUa8GelaTSHTi1O6viFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=XH0P49UB; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="XH0P49UB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=4htJ1/xFwaN1y1KMCNJJaGIHrOCNBKMWJVo9cB+4IeM=; t=1786534328; x=1787743928; 
	b=XH0P49UB2kxmdVgjQt7wuFM2Td3ltt9VxQbveyYJhTCGnEVSgdHjrko2wlbLl9xhg/0gXzyq4XF
	jgdiGgQ/X3tn911o1ZgshfazUuahXNQmHWBtkTI++mYOzkkuBz81G/E49LpohH2VRF/PPjXt7N9vV
	LL++dJj9hjvD4hP1e0BdbOlMZc/bgHTNkfV/FNsXTJJF7fAeddk8BF2JgyD/7bBcB0vxUYb54zrWE
	oUkJC+N27YW5E+mzkRzYdPVqvxpVcACEKa46TnplxDlooX5iHAdhQlM2AbPOVtVngDE+VHTGNJXIu
	80+538Uko4+i0L+aj3ZuGMsLFTC7VH9uLYiA==;
Date: Wed, 12 Aug 2026 13:32:01 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Matti Vaittinen
 <matti.vaittinen@linux.dev>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Sebastian Reichel <sre@kernel.org>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Kalle Niemi
 <kaleposti@gmail.com>, Topi =?UTF-8?B?U29ua2Fqw6Rydmk=?=
 <sonkajarvi@hotmail.com>, Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
 Markus Laine <markus.laine@fi.rohmeurope.com>
Subject: Re: [PATCH 2/5] power: supply: bd71828: Fix current direction
Message-ID: <20260812133201.627dcc69@kemnade.info>
In-Reply-To: <1b08ee53-5adf-4de1-afdc-4419797142d8@gmail.com>
References: <cover.1786356145.git.mazziesaccount@gmail.com>
	<22c6816204b3f2a8b50df8171e384937822d195b.1786356145.git.mazziesaccount@gmail.com>
	<20260812101050.575c9bfb@kemnade.info>
	<anwsIK9ITpcDkZos@ashevche-desk.local>
	<20260812102536.63579b89@kemnade.info>
	<1b08ee53-5adf-4de1-afdc-4419797142d8@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 12:40:47 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 12/08/2026 11:25, Andreas Kemnade wrote:
> > On Wed, 12 Aug 2026 11:17:36 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >   
> >> On Wed, Aug 12, 2026 at 10:10:50AM +0200, Andreas Kemnade wrote:  
> >>> On Mon, 10 Aug 2026 13:09:07 +0300
> >>> Matti Vaittinen <matti.vaittinen@linux.dev> wrote:  
> >>
> >> ...
> >>  
> >>> That code is complicated. What about a generic 16bit non_2complemented sign
> >>> to 2-complemented sign function/macro. Such would have prevented the error
> >>> in the first places. So &vals[i] = signbit_to_2complement(be16_to_cpu(tmp_curr), 15) * pwr->curr_factor  
> >>
> >> Do you mean existing sign_extend32() from bitops.h?
> >>  
> > 
> > I don't think it does what is needed. Here we have
> > 
> > 0000 0000 0000 0001 -> 1
> > Usually we have
> > 
> > 1111 1111 1111 1111 -> -1
> > 
> > but here
> > 
> > 1000 0000 0000 0001 -> -1
> > 
> > If I do understand things correctly. I not find something useful
> > in bitops.h.
> >   
> 
> Thanks for the review and testing Andreas! We share the same 
> (mis?)understanding. ;)
> 
> I am not sure this is so widely used it'd warrant a generic macro. I am 
> afraid that if someone encountered similar design, he would not expect a 
> generic macro to exist. My gut feeling is that this is too marginal to 
> be widely useful. I am not against it though, if someone wants to 
> implement it.

here is the special case that the sign bit is detached from the rest
Bit6/14 is unused. The other problem would be the name of the macro.
Probably nothing more meaningful than the code.

> 
> What comes to complexity - I agree. The code is messy, but mostly 
> because of "clever hacks" done so values are in arrays indexed by loop.
>
Looking at it: The relationship between tmp and tmp_curr.
IMHO reading into an u8 array and doing get_unaligned_be16()
would be the best improvment of readablity. 

> I, however, would like to see a minimal backportable fix, and 
> potentially, larger clean-up which can then go in as a feature, without 
> any rush.
> 
Yes, that is a good point. 

Regards,
Andreas
