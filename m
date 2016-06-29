From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: qcom-smbb: add extcon dependency
Date: Wed, 29 Jun 2016 16:38:03 +0200
Message-ID: <20160629143803.GA28325@earth>
References: <20160629143056.7405-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54132 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066AbcF2Ois (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 29 Jun 2016 10:38:48 -0400
Content-Disposition: inline
In-Reply-To: <20160629143056.7405-1-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Courtney Cavin <courtney.cavin@sonymobile.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 29, 2016 at 04:30:02PM +0200, Arnd Bergmann wrote:
> Building the smbb driver without extcon results in a link failure:
>=20
> drivers/power/built-in.o: In function `smbb_usb_valid_handler':
> :(.text+0x3190): undefined reference to `extcon_set_cable_state_'
> drivers/power/built-in.o: In function `smbb_charger_probe':
> :(.text+0x3880): undefined reference to `devm_extcon_dev_allocate'
> :(.text+0x3898): undefined reference to `devm_extcon_dev_register'
>=20
> This adds a Kconfig dependency.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 56d7df8716b2 ("power: Add Qualcomm SMBB driver")
> ---
>  drivers/power/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
> index 0f11a0f4c369..acd4a1524a1e 100644
> --- a/drivers/power/Kconfig
> +++ b/drivers/power/Kconfig
> @@ -394,6 +394,7 @@ config CHARGER_QCOM_SMBB
>  	tristate "Qualcomm Switch-Mode Battery Charger and Boost"
>  	depends on MFD_SPMI_PMIC || COMPILE_TEST
>  	depends on OF
> +	depends on EXTCON
>  	help
>  	  Say Y to include support for the Switch-Mode Battery Charger and
>  	  Boost (SMBB) hardware found in Qualcomm PM8941 PMICs.  The charger

Thanks, queued.

-- Sebastian

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXc91HAAoJENju1/PIO/qatQYP/1LyrhSpTxO+grfr6Vdpxcz6
ZLvHaAoIcxjfT4Pgijx7kA6bHjLDVz3xLNo9/MbyJ58NGKkI5aNEj0H0SIW58Hny
lWW9A1Z/G8N4uqV7+OMZo4qXRzH16xaxqh+ivWBfARL5ZZCt2OjEkbFnGKnQhxjk
yKOIBsoO41UYpdMCbzZC/mVrXncthANviZWku30jZdCISNOeJXocyOIoLPXXOsFd
Ciebq1KDyHmlYGj70IUVvQGd3S009covT1+p+34G6zbASwQ6mcHGFBnUO1/aKqhI
FoZm4fXsYakUIibXzil14cbV2Whv/7yqF78TEBN2nDNJQYhsGsCd6KMjLoww1TDA
9D0Ij2Kqpx764B/YTFxBL7rNCP/0kYxdkFKYkD8Lc3l5JS+tmahuQ1+bH1c3bc7m
MceV2SjKF+EDGLreYIzdfRS+Lac3GpVyoI8hgb8bb95UIaO00V83k5EltAj3OwAQ
FTmo4sQwxjIoYnpvvbgnXzCxdUEidjiHcmX+6TaNmkDUWi3O/xsj2+KSFL3eYinP
sqbKjmdXuPY9zNgM7PxLcqzQS6gQGYLNQR7wxY9TfJkW4afg1xNiOBhcD8cM0ZKQ
N50mvOG99xI1p7Ulib7n1Yu2PtMhU+ONeoIOlv3a9HkcgPcjseI70cPfDtpBQTsZ
TXZU+H/0+TIRTzWYEL8v
=Mqpc
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
