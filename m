Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269F93A382D;
	Wed, 29 Apr 2026 21:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497509; cv=none; b=FsiZ1EgciECHO6DK3C8CHO7Q59Eqf+Sgxhzczp9hplma/Ibmo2XTN7r/kq8VDFmgGtp5fHyX9tMQN1gMrHgyuDYV6DEhz/G8wGgJTFS9xJleFSdulD6a1c5RyK/2/r5hsxa4ZU9p++tcsTHJbsRqKQ65hIkMQc5VRv000PdrWdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497509; c=relaxed/simple;
	bh=+Zoa5fWSAnJ+ICqNbcHOzXk9P0t+8/+omdy3Xl66DJo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=lAzZ1FDtfuAYwhpvlFoMWCHNtR9znEdloux4zEIyI+Z3SBbIaMka1ayRLR8mSxYmVr9cOeh1rq/al4QzdclrbhbOPxThs+QshN9mj6EmwMZ892SfPlZtC+E6oTBO/bbV1SWMZZW2PYUcLsTA0KdTsaXDGnPhyVil+ERNvsk6BD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=pAjjUnAc; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="pAjjUnAc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uPX3kDTl6ZZxuziu834VSUYY6cPdVQdQ9nEU9mi1qNM=;
  b=pAjjUnAcp2/GlU9skP/Uwy9vZvFZMqa2Y1izJK9Kq76T3CWtDYVxHptG
   hSk433WQrS22fMAf3rzrZ2PuBMzCyPEtjOkq2naOW6+iWy4hRnwMa2AyP
   X1vNSv9drIYxzo/xCUQTbhCDLpwtcg4vQJQbgbWdhYiTTMSyQGLmt0AG1
   U=;
X-CSE-ConnectionGUID: vxrgS5nxQguyQYyfaSRnhA==
X-CSE-MsgGUID: iBFc9tVmQLuueLz1OtTsDg==
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.23,206,1770591600"; 
   d="scan'208";a="145376762"
Received: from default-80-209-135-165.interdsl.co.uk (HELO hadrien) ([80.209.135.165])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 23:18:24 +0200
Date: Wed, 29 Apr 2026 22:18:22 +0100 (BST)
From: Julia Lawall <julia.lawall@inria.fr>
To: "Rafael J. Wysocki" <rafael@kernel.org>
cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
    Aboorva Devarajan <aboorvad@linux.ibm.com>, 
    kernel-janitors@vger.kernel.org, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuidle: menu: correct variance calculation
In-Reply-To: <CAJZ5v0hVbda_ZjQ-j5t0MRCN9C6TUwN7dy-U89tm77DZDkdx8g@mail.gmail.com>
Message-ID: <c5fc3d94-ae4e-5879-bacd-645ed26f2cc0@inria.fr>
References: <20260429153357.2350958-1-Julia.Lawall@inria.fr> <CAJZ5v0hVbda_ZjQ-j5t0MRCN9C6TUwN7dy-U89tm77DZDkdx8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-256966742-1777497503=:4434"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-256966742-1777497503=:4434
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 29 Apr 2026, Rafael J. Wysocki wrote:

> On Wed, Apr 29, 2026 at 5:35 PM Julia Lawall <Julia.Lawall@inria.fr> wrote:
> >
> > Commit 13982929fb08 ("cpuidle: menu: Use one loop for average and
> > variance computations") simplified the numerator of the variance
> > calculation to:
> >
> > sum of squares of idle times - (average idle time)^2
> >
> > This computes a value that is typically too big.  The formula should be
> >
> > sum of squares of idle times - (sum of idle times * average idle time)
>
> I'm not sure why.
>
> According to Wikipedia Var(X) = E[X^2] - E[X]^2:
>
> https://en.wikipedia.org/wiki/Variance

Suppose you have 10 10 10 10 10 10 10 10 10
The sum of the squares is 800.
The average is 10.
The square of the average is 100.
So the current formula gives 800 - 100 = 700 as the numerator.  It is
supposed to be 0.

800 - (80 * 10) = 0

I took the formula from the same page but in the discrete random variable
section, in the sentence:

The variance of a collection of n {\displaystyle n} equally likely values
can be written as ...

julia

>
> > On a small number of tests I didn't find any significant performance
> > change.  Likewise, the original patch was tested by various people and
> > was presumably not observed to cause any problem.  My impression is
> > that this is because the actual variance is almost always quite high
> > (greater than the threshold of 400 used by get_typical_interval), so
> > having a value that is even higher than it should be doesn't matter.
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> > Fixes: 13982929fb08 ("cpuidle: menu: Use one loop for average and variance computations")
> >
> > ---
> >
> >  drivers/cpuidle/governors/menu.c |   14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> > index 64d6f7a1c776..8cbd70cafe89 100644
> > --- a/drivers/cpuidle/governors/menu.c
> > +++ b/drivers/cpuidle/governors/menu.c
> > @@ -117,14 +117,14 @@ static unsigned int get_typical_interval(struct menu_device *data)
> >  {
> >         s64 value, min_thresh = -1, max_thresh = UINT_MAX;
> >         unsigned int max, min, divisor;
> > -       u64 avg, variance, avg_sq;
> > +       u64 avg, variance, sum;
> >         int i;
> >
> >  again:
> >         /* Compute the average and variance of past intervals. */
> >         max = 0;
> >         min = UINT_MAX;
> > -       avg = 0;
> > +       sum = 0;
> >         variance = 0;
> >         divisor = 0;
> >         for (i = 0; i < INTERVALS; i++) {
> > @@ -138,7 +138,7 @@ static unsigned int get_typical_interval(struct menu_device *data)
> >
> >                 divisor++;
> >
> > -               avg += value;
> > +               sum += value;
> >                 variance += value * value;
> >
> >                 if (value > max)
> > @@ -151,17 +151,17 @@ static unsigned int get_typical_interval(struct menu_device *data)
> >         if (!max)
> >                 return UINT_MAX;
> >
> > +       avg = sum;
> >         if (divisor == INTERVALS) {
> >                 avg >>= INTERVAL_SHIFT;
> > +               variance = variance - (sum * avg);
> >                 variance >>= INTERVAL_SHIFT;
> >         } else {
> >                 do_div(avg, divisor);
> > +               variance = variance - (sum * avg);
> >                 do_div(variance, divisor);
> >         }
> >
> > -       avg_sq = avg * avg;
> > -       variance -= avg_sq;
> > -
> >         /*
> >          * The typical interval is obtained when standard deviation is
> >          * small (stddev <= 20 us, variance <= 400 us^2) or standard
> > @@ -175,7 +175,7 @@ static unsigned int get_typical_interval(struct menu_device *data)
> >          * Use this result only if there is no timer to wake us up sooner.
> >          */
> >         if (likely(variance <= U64_MAX/36)) {
> > -               if ((avg_sq > variance * 36 && divisor * 4 >= INTERVALS * 3) ||
> > +               if ((avg * avg > variance * 36 && divisor * 4 >= INTERVALS * 3) ||
> >                     variance <= 400)
> >                         return avg;
> >         }
> >
>
--8323329-256966742-1777497503=:4434--
