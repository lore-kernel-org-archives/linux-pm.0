Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB4137E2F8
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 18:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777487535; cv=none; b=X6J/5KznGuZ6M2WKq3lbbOomEy1pBpmvjp85IDG/jh6Hzr+KXvSLK3/kMHuPpq7dHjwgE9SYwUo/amPZpjF7oTWVLGjCSBopdr+lGtaZLUBMZXdX+Q7IY2JrQi1VORfgPQf0BIlmu4xgXAIEZb+/DBxy0pJg83mK9tJp26dBTMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777487535; c=relaxed/simple;
	bh=NPS0uVesQbn/96xKibYJPo5XwkQG6pblbbNdvUnxBhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7R4qn//sNxeXTbE23oNXBjPAk1TaGrUx8IuJGx55kgV0JZs93Rd8HxSDAvge9nw5T33did6hfKjbwlCBjmfgRreIHWQWcc0OKjqUy2Idjrqln5SNNyep92t8pEGfRGQlcNjfpoLAdN3gStNxKXiHMDLaHiYlF9C2Eo4IKtr4EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoZXOuk7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoZXOuk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DF9C2BCF4
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 18:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777487535;
	bh=NPS0uVesQbn/96xKibYJPo5XwkQG6pblbbNdvUnxBhc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=AoZXOuk76SIdMWINXIg3wBi6eN0oDRLO4heduFEO7kIVx94DkHa4rmBiBTTFJTXHI
	 VIMiRQ1zwKq0kODFP7/fxSP9jQl1MQMcKoKrKsXbhEVG5TwLv5j1NFuO6NYdkLIagp
	 2El/sIEnrDHbppX7ZK96VIJaRWn52Q7BjL6GLhUdo0j1pDlYN5VYg9irOosIy7hXO+
	 ewPc8edwpO/MtnrurGTvzggUxHx/S1onhTULVBCPPxW4TD8Qf0fAlV8dffZLTj1sb0
	 r1LbaZ02arp421D7lQuEAGnfgM9brKH7srYga4jZV+S3gH5wFQPRbHHjMSnm7jQwMi
	 tMgmVAbZxVRag==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59e5aa4ca41so43051e87.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 11:32:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/Z7CRkM+C2C4itI7Y3I4ILhgguIYc7Nu4IPwYnk4+SqSuL8TAQCRaNhjcaoq3kXFUwyCGISy4lBw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2IxXXAbzRiPYFfj6xIL1Sg8zHPNsDilm4K7+XsyxlQlDBLdGG
	kXjBchnTCImYUcVoiQxjjqzIcoPXSS2UIZXRXzTQ2GdhhOQVkd8YwmQCPxhBy+TnvDgSi1s+TLW
	jJRjKsa6AqXbf4kZXFhLS6sqNvRDHi5Q=
X-Received: by 2002:a05:6512:138e:b0:5a4:992:e8b2 with SMTP id
 2adb3069b0e04-5a746626b07mr3110254e87.21.1777487533395; Wed, 29 Apr 2026
 11:32:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429153357.2350958-1-Julia.Lawall@inria.fr>
In-Reply-To: <20260429153357.2350958-1-Julia.Lawall@inria.fr>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 29 Apr 2026 20:32:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hVbda_ZjQ-j5t0MRCN9C6TUwN7dy-U89tm77DZDkdx8g@mail.gmail.com>
X-Gm-Features: AVHnY4IaAGfEUO98E_JqT-1cimRgs-_mC-SsSfwpHZEL5BDngfwrNlLowPjL6lg
Message-ID: <CAJZ5v0hVbda_ZjQ-j5t0MRCN9C6TUwN7dy-U89tm77DZDkdx8g@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: menu: correct variance calculation
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>, kernel-janitors@vger.kernel.org, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Christian Loehle <christian.loehle@arm.com>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 5:35=E2=80=AFPM Julia Lawall <Julia.Lawall@inria.fr=
> wrote:
>
> Commit 13982929fb08 ("cpuidle: menu: Use one loop for average and
> variance computations") simplified the numerator of the variance
> calculation to:
>
> sum of squares of idle times - (average idle time)^2
>
> This computes a value that is typically too big.  The formula should be
>
> sum of squares of idle times - (sum of idle times * average idle time)

I'm not sure why.

According to Wikipedia Var(X) =3D E[X^2] - E[X]^2:

https://en.wikipedia.org/wiki/Variance

> On a small number of tests I didn't find any significant performance
> change.  Likewise, the original patch was tested by various people and
> was presumably not observed to cause any problem.  My impression is
> that this is because the actual variance is almost always quite high
> (greater than the threshold of 400 used by get_typical_interval), so
> having a value that is even higher than it should be doesn't matter.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> Fixes: 13982929fb08 ("cpuidle: menu: Use one loop for average and varianc=
e computations")
>
> ---
>
>  drivers/cpuidle/governors/menu.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors=
/menu.c
> index 64d6f7a1c776..8cbd70cafe89 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -117,14 +117,14 @@ static unsigned int get_typical_interval(struct men=
u_device *data)
>  {
>         s64 value, min_thresh =3D -1, max_thresh =3D UINT_MAX;
>         unsigned int max, min, divisor;
> -       u64 avg, variance, avg_sq;
> +       u64 avg, variance, sum;
>         int i;
>
>  again:
>         /* Compute the average and variance of past intervals. */
>         max =3D 0;
>         min =3D UINT_MAX;
> -       avg =3D 0;
> +       sum =3D 0;
>         variance =3D 0;
>         divisor =3D 0;
>         for (i =3D 0; i < INTERVALS; i++) {
> @@ -138,7 +138,7 @@ static unsigned int get_typical_interval(struct menu_=
device *data)
>
>                 divisor++;
>
> -               avg +=3D value;
> +               sum +=3D value;
>                 variance +=3D value * value;
>
>                 if (value > max)
> @@ -151,17 +151,17 @@ static unsigned int get_typical_interval(struct men=
u_device *data)
>         if (!max)
>                 return UINT_MAX;
>
> +       avg =3D sum;
>         if (divisor =3D=3D INTERVALS) {
>                 avg >>=3D INTERVAL_SHIFT;
> +               variance =3D variance - (sum * avg);
>                 variance >>=3D INTERVAL_SHIFT;
>         } else {
>                 do_div(avg, divisor);
> +               variance =3D variance - (sum * avg);
>                 do_div(variance, divisor);
>         }
>
> -       avg_sq =3D avg * avg;
> -       variance -=3D avg_sq;
> -
>         /*
>          * The typical interval is obtained when standard deviation is
>          * small (stddev <=3D 20 us, variance <=3D 400 us^2) or standard
> @@ -175,7 +175,7 @@ static unsigned int get_typical_interval(struct menu_=
device *data)
>          * Use this result only if there is no timer to wake us up sooner=
.
>          */
>         if (likely(variance <=3D U64_MAX/36)) {
> -               if ((avg_sq > variance * 36 && divisor * 4 >=3D INTERVALS=
 * 3) ||
> +               if ((avg * avg > variance * 36 && divisor * 4 >=3D INTERV=
ALS * 3) ||
>                     variance <=3D 400)
>                         return avg;
>         }
>
