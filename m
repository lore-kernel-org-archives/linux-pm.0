From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC PATCH] cpuidle: fix device->state_count handling
Date: Fri, 09 Aug 2013 18:01:22 +0200
Message-ID: <52051252.9020405@linaro.org>
References: <8500767.uCb7Y0sjbx@amdc1032>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:48167 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934068Ab3HIQBQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2013 12:01:16 -0400
Received: by mail-wg0-f45.google.com with SMTP id x12so3687826wgg.0
        for <linux-pm@vger.kernel.org>; Fri, 09 Aug 2013 09:01:15 -0700 (PDT)
In-Reply-To: <8500767.uCb7Y0sjbx@amdc1032>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org

On 08/09/2013 01:59 PM, Bartlomiej Zolnierkiewicz wrote:
> Use device->state_count instead of driver->state_count in
> cpuidle_play_dead(), ladder_select_state() and menu_select().
>=20
> This allows cpuidle drivers to override maximum allowable
> state number for a given device, which is what some cpuidle
> drivers would like to do (i.e. EXYNOS cpuidle driver).
>=20
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
> Alternatively, we can make EXYNOS cpuidle driver work without
> device->state_count (at a some tiny performance cost?). This
> would allow us to remove device->state_count completely as it
> is not needed by any other cpuidle driver currently (AFAICS).

I am inclined for this solution.

The state_count was initially in the device structure, then it has been
moved to the driver structure and the code has been changed accordingly=
=2E
That was part of the cpuidle code consolidation made by Deepthi Dharwar
(46bcfad7).

This patch is one step back.

There is an alternate solution. May be you can use the multiple driver
support to register two cpuidle driver (one for each cpus) ? It was
initially made to support cpus with different latencies but that should
work.

>  drivers/cpuidle/cpuidle.c          |    2 +-
>  drivers/cpuidle/governors/ladder.c |    2 +-
>  drivers/cpuidle/governors/menu.c   |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> Index: b/drivers/cpuidle/cpuidle.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/cpuidle/cpuidle.c	2013-08-08 14:36:09.611488750 +0200
> +++ b/drivers/cpuidle/cpuidle.c	2013-08-08 14:39:02.291486116 +0200
> @@ -57,7 +57,7 @@ int cpuidle_play_dead(void)
>  		return -ENODEV;
> =20
>  	/* Find lowest-power state that supports long-term idle */
> -	for (i =3D drv->state_count - 1; i >=3D CPUIDLE_DRIVER_STATE_START;=
 i--)
> +	for (i =3D dev->state_count - 1; i >=3D CPUIDLE_DRIVER_STATE_START;=
 i--)
>  		if (drv->states[i].enter_dead)
>  			return drv->states[i].enter_dead(dev, i);
> =20
> Index: b/drivers/cpuidle/governors/ladder.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/cpuidle/governors/ladder.c	2013-08-08 14:36:09.61148875=
0 +0200
> +++ b/drivers/cpuidle/governors/ladder.c	2013-08-08 14:39:02.29948611=
6 +0200
> @@ -87,7 +87,7 @@ static int ladder_select_state(struct cp
>  		last_residency =3D last_state->threshold.promotion_time + 1;
> =20
>  	/* consider promotion */
> -	if (last_idx < drv->state_count - 1 &&
> +	if (last_idx < dev->state_count - 1 &&
>  	    !drv->states[last_idx + 1].disabled &&
>  	    !dev->states_usage[last_idx + 1].disable &&
>  	    last_residency > last_state->threshold.promotion_time &&
> Index: b/drivers/cpuidle/governors/menu.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- a/drivers/cpuidle/governors/menu.c	2013-08-08 14:36:09.611488750 =
+0200
> +++ b/drivers/cpuidle/governors/menu.c	2013-08-08 14:39:02.299486116 =
+0200
> @@ -312,7 +312,7 @@ static int menu_select(struct cpuidle_dr
>  	 * Find the idle state with the lowest power while satisfying
>  	 * our constraints.
>  	 */
> -	for (i =3D CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i++) {
> +	for (i =3D CPUIDLE_DRIVER_STATE_START; i < dev->state_count; i++) {
>  		struct cpuidle_state *s =3D &drv->states[i];
>  		struct cpuidle_state_usage *su =3D &dev->states_usage[i];
> =20
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

  * English - detected
  * English
  * French

  * English
  * French

 <javascript:void(0);>
