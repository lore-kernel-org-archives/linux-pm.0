From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 21/21] cpuidle: change governor from within cpuidle_replace_governor()
Date: Thu, 26 Sep 2013 00:50:55 +0200
Message-ID: <524368CF.4030803@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org> <5b758e21eeb97f5f68191819c0820673692b6b75.1379779777.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:43170 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab3IYWu6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2013 18:50:58 -0400
Received: by mail-wg0-f51.google.com with SMTP id c11so350268wgh.30
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2013 15:50:57 -0700 (PDT)
In-Reply-To: <5b758e21eeb97f5f68191819c0820673692b6b75.1379779777.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/22/2013 03:21 AM, Viresh Kumar wrote:
> When I first read cpuidle_replace_governor()'s name I thought it will=
 replace
> the governor (as per its name) but then found that it just returns th=
e next best
> governor. And cpuidle_unregister_governor() actually replaces it.
>=20
> We always replace current governor with the next best and this inform=
ation is
> already present with cpuidle_replace_governor() and so we don't reall=
y need to
> send an additional argument for it.
>=20
> Also, it makes sense to actually call cpuidle_switch_governor() from =
within
> cpuidle_replace_governor() instead.
>=20
> Along with this ret_gov is now renamed as new_gov to better suit its =
purpose.

Actually I am wondering if all this stuff is not over-engineered.

There are 2 governors, each of them suits for a specific kernel config,
periodic tick or tickless system.

menu     =3D> tickless system
periodic =3D> periodic tick system

IMHO, all the code with rating checking and so do not really makes
sense. Wouldn't make sense to remove this code ?

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpuidle/governor.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/cpuidle/governor.c b/drivers/cpuidle/governor.c
> index ea2f8e7..deb6e50 100644
> --- a/drivers/cpuidle/governor.c
> +++ b/drivers/cpuidle/governor.c
> @@ -98,26 +98,27 @@ int cpuidle_register_governor(struct cpuidle_gove=
rnor *gov)
>  }
> =20
>  /**
> - * cpuidle_replace_governor - find a replacement governor
> - * @exclude_rating: the rating that will be skipped while looking fo=
r
> - * new governor.
> + * cpuidle_replace_governor - replace governor with highest rating o=
ne
> + *
> + * Finds governor (excluding cpuidle_curr_governor) with highest rat=
ing and
> + * replaces cpuidle_curr_governor with it.
>   */
> -static struct cpuidle_governor *cpuidle_replace_governor(int exclude=
_rating)
> +static inline void cpuidle_replace_governor(void)
>  {
>  	struct cpuidle_governor *gov;
> -	struct cpuidle_governor *ret_gov =3D NULL;
> +	struct cpuidle_governor *new_gov =3D NULL;
>  	unsigned int max_rating =3D 0;
> =20
>  	list_for_each_entry(gov, &cpuidle_governors, governor_list) {
> -		if (gov->rating =3D=3D exclude_rating)
> +		if (gov =3D=3D cpuidle_curr_governor)
>  			continue;
>  		if (gov->rating > max_rating) {
>  			max_rating =3D gov->rating;
> -			ret_gov =3D gov;
> +			new_gov =3D gov;
>  		}
>  	}
> =20
> -	return ret_gov;
> +	cpuidle_switch_governor(new_gov);
>  }
> =20
>  /**
> @@ -130,11 +131,8 @@ void cpuidle_unregister_governor(struct cpuidle_=
governor *gov)
>  		return;
> =20
>  	mutex_lock(&cpuidle_lock);
> -	if (gov =3D=3D cpuidle_curr_governor) {
> -		struct cpuidle_governor *new_gov;
> -		new_gov =3D cpuidle_replace_governor(gov->rating);
> -		cpuidle_switch_governor(new_gov);
> -	}
> +	if (gov =3D=3D cpuidle_curr_governor)
> +		cpuidle_replace_governor();
>  	list_del(&gov->governor_list);
>  	mutex_unlock(&cpuidle_lock);
>  }
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

