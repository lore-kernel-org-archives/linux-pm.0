From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 20/21] cpuidle: don't calculate time-diff if entered_state
 == 0
Date: Thu, 26 Sep 2013 00:38:50 +0200
Message-ID: <524365FA.4090108@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org> <acd1cc837f969a50582d2b25a73c5e247f40f843.1379779777.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:41582 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab3IYWix (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2013 18:38:53 -0400
Received: by mail-wi0-f179.google.com with SMTP id hm2so364191wib.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2013 15:38:52 -0700 (PDT)
In-Reply-To: <acd1cc837f969a50582d2b25a73c5e247f40f843.1379779777.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/22/2013 03:21 AM, Viresh Kumar wrote:
> If entered_state =3D=3D 0, we don't need to set dev->last_residency t=
o 'diff' as we
> will be setting it to zero without using its new value.

I don't get it, can you elaborate. We can be a long time in this state
(eg. if the prediction is false).

> And so move calculation of diff also inside the "if" statement.
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpuidle/cpuidle.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index bf80236..cb81689 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -77,23 +77,22 @@ int cpuidle_enter_state(struct cpuidle_device *de=
v, struct cpuidle_driver *drv,
> =20
>  	struct cpuidle_state *target_state =3D &drv->states[index];
>  	ktime_t time_start, time_end;
> -	s64 diff;
> =20
>  	time_start =3D ktime_get();
> =20
>  	entered_state =3D target_state->enter(dev, drv, index);
> =20
> -	time_end =3D ktime_get();
> +	if (entered_state >=3D 0) {
> +		s64 diff;
> =20
> -	local_irq_enable();
> +		time_end =3D ktime_get();
> +		diff =3D ktime_to_us(ktime_sub(time_end, time_start));
> =20
> -	diff =3D ktime_to_us(ktime_sub(time_end, time_start));
> -	if (diff > INT_MAX)
> -		diff =3D INT_MAX;
> +		if (diff > INT_MAX)
> +			diff =3D INT_MAX;
> =20
> -	dev->last_residency =3D (int) diff;
> +		dev->last_residency =3D (int) diff;
> =20
> -	if (entered_state >=3D 0) {
>  		/* Update cpuidle counters */
>  		/* This can be moved to within driver enter routine
>  		 * but that results in multiple copies of same code.
> @@ -104,6 +103,8 @@ int cpuidle_enter_state(struct cpuidle_device *de=
v, struct cpuidle_driver *drv,
>  		dev->last_residency =3D 0;
>  	}
> =20
> +	local_irq_enable();
> +
>  	return entered_state;
>  }
> =20
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

