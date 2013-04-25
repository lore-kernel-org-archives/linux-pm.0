From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/2] ARM: s3c64xx: cpuidle: use init/exit common routine
Date: Thu, 25 Apr 2013 11:35:28 +0200
Message-ID: <5178F8E0.6010606@linaro.org>
References: <1366728077-18988-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:62100 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752370Ab3DYJfc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Apr 2013 05:35:32 -0400
Received: by mail-ee0-f46.google.com with SMTP id c13so1185311eek.33
        for <linux-pm@vger.kernel.org>; Thu, 25 Apr 2013 02:35:31 -0700 (PDT)
In-Reply-To: <1366728077-18988-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, lethal@linux-sh.org, kgene.kim@samsung.com, ben-linux@fluff.org, horms+renesas@verge.net.au, linux-samsung-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 04/23/2013 04:41 PM, Daniel Lezcano wrote:
> Remove the duplicated code and use the cpuidle common code for initia=
lization.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Hi Kim and Ben,

It is the last patch in the series which was not acked-by.
Rafael is willing to take it in its tree if you ack it.

Are you ok if this patch ?

Thanks
-- Daniel

>  arch/arm/mach-s3c64xx/cpuidle.c |   14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/arch/arm/mach-s3c64xx/cpuidle.c b/arch/arm/mach-s3c64xx/=
cpuidle.c
> index 852ff16..3c8ab07 100644
> --- a/arch/arm/mach-s3c64xx/cpuidle.c
> +++ b/arch/arm/mach-s3c64xx/cpuidle.c
> @@ -40,8 +40,6 @@ static int s3c64xx_enter_idle(struct cpuidle_device=
 *dev,
>  	return index;
>  }
> =20
> -static DEFINE_PER_CPU(struct cpuidle_device, s3c64xx_cpuidle_device)=
;
> -
>  static struct cpuidle_driver s3c64xx_cpuidle_driver =3D {
>  	.name	=3D "s3c64xx_cpuidle",
>  	.owner  =3D THIS_MODULE,
> @@ -60,16 +58,6 @@ static struct cpuidle_driver s3c64xx_cpuidle_drive=
r =3D {
> =20
>  static int __init s3c64xx_init_cpuidle(void)
>  {
> -	int ret;
> -
> -	cpuidle_register_driver(&s3c64xx_cpuidle_driver);
> -
> -	ret =3D cpuidle_register_device(&s3c64xx_cpuidle_device);
> -	if (ret) {
> -		pr_err("Failed to register cpuidle device: %d\n", ret);
> -		return ret;
> -	}
> -
> -	return 0;
> +	return cpuidle_register(&s3c64xx_cpuidle_driver, NULL);
>  }
>  device_initcall(s3c64xx_init_cpuidle);


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

