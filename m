From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH 4/4] ARM: bcm2835: add thermal driver to default_config
Date: Thu, 12 May 2016 16:26:13 -0700
Message-ID: <87lh3eamei.fsf@eliezer.anholt.net>
References: <1463063738-11506-1-git-send-email-kernel@martin.sperl.org> <1463063738-11506-5-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1463063738-11506-5-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org writes:

> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>
> Add the thermal driver to list of compiled modules
> in the default config for bcm2835.
>
> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
> ---
>  arch/arm/configs/bcm2835_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm283=
5_defconfig
> index 29a44bd..634e07e 100644
> --- a/arch/arm/configs/bcm2835_defconfig
> +++ b/arch/arm/configs/bcm2835_defconfig
> @@ -71,6 +71,8 @@ CONFIG_SPI_BCM2835=3Dy
>  CONFIG_SPI_BCM2835AUX=3Dy
>  CONFIG_GPIO_SYSFS=3Dy
>  # CONFIG_HWMON is not set
> +CONFIG_THERMAL=3Dy
> +CONFIG_BCM2835_THERMAL=3Dy
>  CONFIG_WATCHDOG=3Dy
>  CONFIG_BCM2835_WDT=3Dy
>  CONFIG_FB=3Dy
> --=20
> 2.1.4

It would be nice to see multi_v7_defconfig changed, too, since that's
what we expect people to be actually using

This patch is: Reviewed-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXNREVAAoJELXWKTbR/J7o2CUP/1+gLOzjz75Qg20nD7dBgCJL
0/imT58Q6A0/T2oqt6/hoQ3bOIqgaOlj/Rv36Zybam8O9fErVjsRnOwmGoB38tBN
uERMOU0WSG33oZkGKyHNdrBTTLTzrWuFBhkalb+J+t97C+rizXm2wNmV+LgESyiH
yRHA6ybDLl0u1/iHnM7ujHIr4IQm1VkHYSfmJQJRr98cTleELX5dxYZ7T1z2AOIb
2HpluGLKtJdZiqxR3lupeNn5Gga17kuq2HsWRChnBqj+5ycgELGk2nh2EKP9ebPl
4uq1byeWbqFF99OTLs1Vt4saZowoXOdPYeasdY74oiDg3CmkmNOhhsnJVWXjH3ee
/wQ0JEK3LpllETXkPX0lbFTx8F/IEe+SgU4iweJB/VvztQsqha+t8cHoeU94p6BJ
QcxkHS+lqoe07PNHYs4svVEQvGmBaTz5pkkYIQT974bd46D9hu9eDkFOwN+TweZu
CmJvwVb8PJxy+kx4cQGL5FqDSLkP5b+5Hj8Hwn1yN99yMQgCAUqtODxQ4wZYaY13
JdWqiNoXuzCNc/M2yEKxXoGc9DnFEbrpwMQ5nMoefQxnAHUImkJ8MwJhOtHyiICN
LyYe+uODvrN5L13nPqfrBP54zJ0K2SvvFBK/uMpWRcUrqHpl4flRpEp1JY+Ed+/k
2G1/6uApL4de5soK4Hts
=JOJY
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
