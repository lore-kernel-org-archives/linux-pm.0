Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5005D22F74A;
	Thu, 30 Apr 2026 05:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777527407; cv=none; b=V69saa/W+TtxQmld8jhIYzjnIzf9g/Y9s620Oyw8+1Pa8+xn6r1l4cpRoPMcV5PaRImOAuevueqOyoLfnnSZvDwSMzfrQbHi2N8lli46QcO7wIBKKEeQQqhPfqaT+AXcDaCamjt4b8hrCiOrGlxnADaPe/vaj9Dh3ZWLa9ncnHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777527407; c=relaxed/simple;
	bh=130YZ5RGilQ7QLErWWXJRZ1I1Fll9ez7IC+/6fIYIfM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q4IReUteStEOcwdSlIabAN75hhnuOSrKOEb4D2KG9P5nqtFApyl9UW9kk09m4GmEvYqHgKp+uQQf4hWvjE7JwLCDcYc7YZDcOJNbVB/vB4WMYbcdqiM+BhQplz6HNeUQhojdcnO4BXjUlfrfQ3ZrWVcDdvYnQNxuIrLYIaLNRrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=fM2lJBI9; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="fM2lJBI9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=sp5GufT6BTm6oIFyDELXrFsaG41lVEftDToN/7RuaGk=;
  b=fM2lJBI9Jw9rqeti8Ab63jIPBjaQWDy4RQXHPkAeJxnpoWJMRtdV303k
   u8kw7UBV7omEfH3yr/gdAfZgj3rgM6rLwVn4tVTsFDnCEcwptshVJo+rL
   bO1xa6k31+vJDfWKFn7Y5/T0LL8NhHELRqNfEW7sqOYLePAbI1DXjjTJt
   w=;
X-CSE-ConnectionGUID: KOnD0DBaSky6leyo4m+/8g==
X-CSE-MsgGUID: vqnK2y7/Txif+2UOxpE7LQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.23,207,1770591600"; 
   d="scan'208";a="274732026"
Received: from default-80-209-135-165.interdsl.co.uk (HELO hadrien) ([80.209.135.165])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2026 07:36:35 +0200
Date: Thu, 30 Apr 2026 06:36:34 +0100 (BST)
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
Message-ID: <11a3f8bc-de5-7355-ecf-71d53a836fc4@inria.fr>
References: <20260429153357.2350958-1-Julia.Lawall@inria.fr> <CAJZ5v0hVbda_ZjQ-j5t0MRCN9C6TUwN7dy-U89tm77DZDkdx8g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1319900312-1777527395=:3453"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1319900312-1777527395=:3453
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

OK, looking again at the formulas, I may be wrong about the calculation.
I was assuming that the division by N was at the end of the calculation of
the variance, but now that I am paying more attention, I see that it is
before the subtraction.  So maybe the formula is OK as is.

Thanks for the feedback.

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
--8323329-1319900312-1777527395=:3453--
