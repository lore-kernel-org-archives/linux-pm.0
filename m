From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] thermal: broadcom: Allow for NSP to use ns-thermal
 driver
Date: Thu, 27 Apr 2017 09:37:00 -0700
Message-ID: <20170427163658.GC18276@localhost.localdomain>
References: <1493153351-12698-1-git-send-email-jon.mason@broadcom.com>
 <1493153351-12698-2-git-send-email-jon.mason@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RIYY1s2vRbPFwWeW"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1493153351-12698-2-git-send-email-jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Florian Fainelli <florian.fainelli-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--RIYY1s2vRbPFwWeW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Jason,

On Tue, Apr 25, 2017 at 04:49:10PM -0400, Jon Mason wrote:
> Change the iProc Kconfig to select THERMAL and THERMAL_OF, which allows
> the ns-thermal driver to be selected via menuconfig.  Also, change the
> ns-thermal driver to work on any iProc based SoC.  Finally, tweak the
> Kconfig description to mention support for NSP and make the default on
> for iProc based platforms.


Thanks for the patch, but..
>=20
> Signed-off-by: Jon Mason <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> ---
>  arch/arm/mach-bcm/Kconfig        | 2 ++
>  drivers/thermal/broadcom/Kconfig | 9 +++++----
>  2 files changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index a0e66d8..da2bfeb 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -19,6 +19,8 @@ config ARCH_BCM_IPROC
>  	select GPIOLIB
>  	select ARM_AMBA
>  	select PINCTRL
> +	select THERMAL
> +	select THERMAL_OF
>  	help
>  	  This enables support for systems based on Broadcom IPROC architected =
SoCs.
>  	  The IPROC complex contains one or more ARM CPUs along with common

It would be better if this is split and sent through your arch tree, to
avoid conflicts. I could also pick it if you get an ack from one of your
maintainers. Still, first option is preferable.

> diff --git a/drivers/thermal/broadcom/Kconfig b/drivers/thermal/broadcom/=
Kconfig
> index f0dea8a..26d706c 100644
> --- a/drivers/thermal/broadcom/Kconfig
> +++ b/drivers/thermal/broadcom/Kconfig
> @@ -1,8 +1,9 @@
>  config BCM_NS_THERMAL
>  	tristate "Northstar thermal driver"
>  	depends on ARCH_BCM_IPROC || COMPILE_TEST
> +	default ARCH_BCM_IPROC

Not sure if this is really what you wanted. Based on your commit log
message, you meant the following, perhaps?

 +	default y if ARCH_BCM_IPROC

>  	help
> -	  Northstar is a family of SoCs that includes e.g. BCM4708, BCM47081,
> -	  BCM4709 and BCM47094. It contains DMU (Device Management Unit) block
> -	  with a thermal sensor that allows checking CPU temperature. This
> -	  driver provides support for it.
> +	  Support for the Northstar and Northstar Plus family of SoCs (e.g.
> +	  BCM4708, BCM4709, BCM5301x, BCM95852X, etc). It contains DMU (Device

Did we look BCM47094 somehow on this patch?

> +	  Management Unit) block with a thermal sensor that allows checking CPU
> +	  temperature.
> --=20
> 2.7.4
>=20

--RIYY1s2vRbPFwWeW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZAh4jAAoJEA6VkvSQfF5TyfUP/1P/wLzUACSkH7IqUTHentkY
jU+NRu2AhZs9Gu7ePDFn3cdnc+dhKru+4+wDR2ntMABiYH4SHmhDpZScztCTLL6d
UDueqE/S4nZ2YEf8CSO47DLPuxiAcENRKj0/QZIeepFrDuH4xviMIyC3IEeD4OBo
wtO4E1CuBcsgEkk3uxnx8nF9cSlSOm8rcLvFPuWWp2PzYcSXyOgQ2fa4zyv6mGSg
4nxjtdxGpgJebJz0TbWNORqO519clE8frk13vftambaQnEo1iiXTWzktxzGsZ2jr
EvY+viAM4ZtDXxWtJKRbXHUPDFlkDRgCeXJOPIk+D7Us5sFzhw7rJNKKfhyoP/Nl
kU+BksdyLuIFpn7uMN+XYoT/3oAS8MXDFlS9qXI2IZuHT2aAZeqqYohYq48/fpAS
6R633qXSmfredqagwy8Q2agccqcyLx9CIBtdQCDgfxlcGowKaDcOlkYPllnXEfNP
0kD0logTUjxOeOogej0xih4xhyIErlzzzCayDfuaWladiPSktQZRLklyMJJ7VDMS
c7KKphaq7Bk1HJd2FpEnxaUhIGZQiQn+p5YEkSJdKxsfT5/5tZmjZCi9afn59I7m
UuxAQRhBMeB1te4PZlEYs+ET0DnPnDFAgKVwxgUze6gHEcIverR6ifGDOm6FSmIt
QsBZpKA+OB7qxRzw0Ipp
=yNF2
-----END PGP SIGNATURE-----

--RIYY1s2vRbPFwWeW--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
