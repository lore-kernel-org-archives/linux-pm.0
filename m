From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 13/21] cpuidle: use drv instead of cpuidle_driver in show_current_driver()
Date: Thu, 26 Sep 2013 00:05:14 +0200
Message-ID: <52435E1A.9010108@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org> <dee4978199c13f45547f50a5f709c9b0d57f669b.1379779777.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:37148 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754292Ab3IYWFR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Sep 2013 18:05:17 -0400
Received: by mail-we0-f169.google.com with SMTP id t60so305524wes.14
        for <linux-pm@vger.kernel.org>; Wed, 25 Sep 2013 15:05:16 -0700 (PDT)
In-Reply-To: <dee4978199c13f45547f50a5f709c9b0d57f669b.1379779777.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 09/22/2013 03:21 AM, Viresh Kumar wrote:
> Instances of "struct cpuidle_driver *" are consistently named as "drv=
" in
> cpuidle core. Its broken only at one place: show_current_driver().
>=20
> Fix it for consistency.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/cpuidle/sysfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index a022393..e918b6d 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -52,12 +52,12 @@ static ssize_t show_current_driver(struct device =
*dev,
>  				   char *buf)
>  {
>  	ssize_t ret;
> -	struct cpuidle_driver *cpuidle_driver;
> +	struct cpuidle_driver *drv;
> =20
>  	spin_lock(&cpuidle_driver_lock);
> -	cpuidle_driver =3D cpuidle_get_driver();
> -	if (cpuidle_driver)
> -		ret =3D sprintf(buf, "%s\n", cpuidle_driver->name);
> +	drv =3D cpuidle_get_driver();
> +	if (drv)
> +		ret =3D sprintf(buf, "%s\n", drv->name);
>  	else
>  		ret =3D sprintf(buf, "none\n");
>  	spin_unlock(&cpuidle_driver_lock);
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

