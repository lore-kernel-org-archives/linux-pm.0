From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 06/21] cpuidle: rearrange code in __cpuidle_driver_init()
Date: Wed, 25 Sep 2013 23:40:58 +0200
Message-ID: <5243586A.1090605@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org> <72ec40529db737fe0eea6d14fc43fa332f9c5d59.1379779777.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:62522 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab3IYVlB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2013 17:41:01 -0400
Received: by mail-wi0-f170.google.com with SMTP id cb5so5875541wib.1
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2013 14:41:00 -0700 (PDT)
In-Reply-To: <72ec40529db737fe0eea6d14fc43fa332f9c5d59.1379779777.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/22/2013 03:20 AM, Viresh Kumar wrote:
> This is trivial patch that just reorders few statements in
> __cpuidle_driver_init() routine, so that we don't need both 'continue=
' and
> 'break' in the for loop. Functionally it shouldn't change anything.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpuidle/driver.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index 8df66c8..6279e1c 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -172,12 +172,10 @@ static void __cpuidle_driver_init(struct cpuidl=
e_driver *drv)
>  	 * order, because usually one of the deeper states have this flag s=
et.
>  	 */
>  	for (i =3D drv->state_count - 1; i >=3D 0 ; i--) {
> -
> -		if (!(drv->states[i].flags & CPUIDLE_FLAG_TIMER_STOP))
> -			continue;
> -
> -		drv->bctimer =3D 1;
> -		break;
> +		if (drv->states[i].flags & CPUIDLE_FLAG_TIMER_STOP) {
> +			drv->bctimer =3D 1;
> +			break;
> +		}
>  	}
>  }

Well, I don't have a strong opinion on that, it is "Schtroumpf Vert et
Vert Schtroumpf" :)  [1]

  -- Daniel

[1] http://en.wikipedia.org/wiki/Schtroumpf_Vert_et_Vert_Schtroumpf


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

