From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 14/21] cpuidle: coupled: don't compare cpu masks unnecessarily
Date: Thu, 26 Sep 2013 00:06:39 +0200
Message-ID: <52435E6F.4000002@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org> <564c8b1f073dc396b54866a2220b09b7869289f4.1379779777.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f172.google.com ([74.125.82.172]:62466 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226Ab3IYWGn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2013 18:06:43 -0400
Received: by mail-we0-f172.google.com with SMTP id w61so302964wes.17
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2013 15:06:42 -0700 (PDT)
In-Reply-To: <564c8b1f073dc396b54866a2220b09b7869289f4.1379779777.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Colin Cross <ccross@google.com>

On 09/22/2013 03:21 AM, Viresh Kumar wrote:
> In cpuidle_coupled_register_device() we do following:
> 	if (WARN_ON(!cpumask_equal(&dev->coupled_cpus, &coupled->coupled_cpu=
s)))
> 		coupled->prevent++;
>=20
> This is only required to be done when we are using 'coupled' from an =
existing
> cpuidle_device and not when we have just done this:
>=20
> 	coupled->coupled_cpus =3D dev->coupled_cpus
>=20
> So, move this compare statement to the right place.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Cc'ed Colin Cross.

> ---
>  drivers/cpuidle/coupled.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
> index e952936..19a89eb 100644
> --- a/drivers/cpuidle/coupled.c
> +++ b/drivers/cpuidle/coupled.c
> @@ -642,6 +642,10 @@ int cpuidle_coupled_register_device(struct cpuid=
le_device *dev)
>  		other_dev =3D per_cpu(cpuidle_devices, cpu);
>  		if (other_dev && other_dev->coupled) {
>  			coupled =3D other_dev->coupled;
> +
> +			if (WARN_ON(!cpumask_equal(&dev->coupled_cpus,
> +						&coupled->coupled_cpus)))
> +				coupled->prevent++;
>  			goto have_coupled;
>  		}
>  	}
> @@ -655,9 +659,6 @@ int cpuidle_coupled_register_device(struct cpuidl=
e_device *dev)
> =20
>  have_coupled:
>  	dev->coupled =3D coupled;
> -	if (WARN_ON(!cpumask_equal(&dev->coupled_cpus, &coupled->coupled_cp=
us)))
> -		coupled->prevent++;
> -
>  	cpuidle_coupled_update_online_cpus(coupled);
> =20
>  	coupled->refcnt++;
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

