From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH] thermal: broadcom: ns-thermal: depends/default only for
 NS/NSP
Date: Wed, 31 May 2017 20:09:08 -0700
Message-ID: <20170601030906.GA4502@localhost.localdomain>
References: <1496260544-4200-1-git-send-email-jon.mason@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33134 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbdFADJN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 May 2017 23:09:13 -0400
Content-Disposition: inline
In-Reply-To: <1496260544-4200-1-git-send-email-jon.mason@broadcom.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Mason <jon.mason@broadcom.com>
Cc: Zhang Rui <rui.zhang@intel.com>, rafal@milecki.pl, Florian Fainelli <f.fainelli@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 31, 2017 at 03:55:44PM -0400, Jon Mason wrote:
> ARCH_BCM_IPROC includes support for many SoCs, not all of which have the
> same thermal hardware interface as the Northstar/Northstar Plus SoCs.
> This is not a major issue, as this driver will only be probed if the
> relevant device tree entry is present.  However, it will result in a
> slightly larger than necessary kernel.  By limiting the driver to only
> work on the NS/NSP SoCs, we can avoid the issue.
>=20
> Suggested-by: Scott Branden <scott.branden@broadcom.com>
> Signed-off-by: Jon Mason <jon.mason@broadcom.com>

Should this commit message include a Fixes: tag?

Maybe
Fixes: a94cb7e ("thermal: broadcom: add Northstar thermal driver")

> ---
>  drivers/thermal/broadcom/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/thermal/broadcom/Kconfig b/drivers/thermal/broadcom/=
Kconfig
> index 42c098e86f84..c729dad2348c 100644
> --- a/drivers/thermal/broadcom/Kconfig
> +++ b/drivers/thermal/broadcom/Kconfig
> @@ -8,8 +8,8 @@ config BCM2835_THERMAL
> =20
>  config BCM_NS_THERMAL
>  	tristate "Northstar thermal driver"
> -	depends on ARCH_BCM_IPROC || COMPILE_TEST
> -	default y if ARCH_BCM_IPROC
> +	depends on ARCH_BCM_NSP || ARCH_BCM_5301X || COMPILE_TEST
> +	default y if ARCH_BCM_NSP || ARCH_BCM_5301X
>  	help
>  	  Support for the Northstar and Northstar Plus family of SoCs (e.g.
>  	  BCM4708, BCM4709, BCM5301x, BCM95852X, etc). It contains DMU (Device
> --=20
> 2.7.4
>=20

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZL4VMAAoJEA6VkvSQfF5TSU0P/3TkNaPxK1vn+f0uK74zYoY9
kLcEtczz+o44H3tm8e0naLdVx84VTIQh4pMQAh/3dNMalC5V29B5qT3+v4V0AmDB
grOjjWNbjtFesGW1xqSOIU8LX37ymOwSPpzakxxsHQsQVimEgqi3qdoJh2pCmrhe
tcsGIrz76rtqYkJSUN36zHhsg5o4o84l+gB0rOCkkLjk/ibseBN2/QJpDwtW3Pms
N1SAjxyR67BbfpSRbByB3NwHuiHM0fQQaWaLzduD6G7sYCBRRI7lJ6SVW8vvUoTy
Gb8n/+F9YEvvL9T6n/puZY8/t3bEqWhCtGXbwrdSB5ER6SHxQ4/8e8puZN7umd3J
Dhd0HgSpRf7sg0zdeiFdJMeCvbXhzwqWIbW+FjhDaTp7Y6Uwftx34SawGemOMwMx
eAYQtY3aYJXifmrYXTuP9ycRaPGIBNiaNiz2Q8r4HccE2rwt5143JLcva0GGjXN1
RUu24Mdwdave+9s/XpTTvHSQwQWx35qQy/HARwzZdPmP68be1ooSifLAOzH1A+iM
s7piFiPdUOv8KEDHMUjX1ZW1ziwc5rP0545+B1ankjsQygUNphuGTrxVVhfOdh5z
PRPOM1zITgTa58Y1MmUlOhkjxdd3C1vU5G0IaLwCYA/MrgE26/KmOcrOHewz/HHH
MEW1zSnXiNojiz5ak2oQ
=IPci
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--
