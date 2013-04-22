From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [V3 patch 10/19] ARM: s3c64xx: cpuidle: use init/exit common
 routine
Date: Mon, 22 Apr 2013 08:32:13 +0200
Message-ID: <5174D96D.40602@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org> <1365770165-27096-11-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:39245 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753858Ab3DVGcW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Apr 2013 02:32:22 -0400
Received: by mail-wi0-f172.google.com with SMTP id hm14so488078wib.11
        for <linux-pm@vger.kernel.org>; Sun, 21 Apr 2013 23:32:21 -0700 (PDT)
In-Reply-To: <1365770165-27096-11-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kgene.kim@samsung.com, Ben Dooks <ben-linux@fluff.org>
Cc: rjw@sisk.pl, Andrew Lunn <andrew@lunn.ch>, khilman@deeprootsystems.com, nsekhar@ti.com, josephl@nvidia.com, patches@linaro.org, magnus.damm@gmail.com, tony@atomide.com, plagnioj@jcrosoft.com, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, swarren@wwwdotorg.org, rob.herring@calxeda.com, horms@verge.net.au, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, jkosina@suse.cz, linux-pm@vger.kernel.org, lethal@linux-sh.org, kernel@pengutronix.de

On 04/12/2013 02:35 PM, Daniel Lezcano wrote:
> Remove the duplicated code and use the cpuidle common code for initia=
lization.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Kim, Ben,

is it possible you ack this patch if you are ok with it ?

So it can go into the linux-pm tree before the merge windows [1]

Thanks !

-- Daniel

[1] http://www.spinics.net/lists/linux-acpi/msg43138.html

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

