From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: bq27x00_battery: Add missing MODULE_ALIAS
Date: Thu, 30 Apr 2015 17:55:27 +0200
Message-ID: <20150430155527.GF6133@earth>
References: <1430252586-5104-1-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SxgehGEc6vB0cZwN"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60427 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891AbbD3Pzd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 30 Apr 2015 11:55:33 -0400
Content-Disposition: inline
In-Reply-To: <1430252586-5104-1-git-send-email-marek@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, hns@goldelico.com


--SxgehGEc6vB0cZwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 28, 2015 at 10:23:06PM +0200, Marek Belisko wrote:
> Without MODULE_ALIAS bq27x00_battery module won't get loaded
> automatically.
>=20
> Signed-off-by: Marek Belisko <marek@goldelico.com>
> ---
>  drivers/power/bq27x00_battery.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/bq27x00_batt=
ery.c
> index a57433d..542927e 100644
> --- a/drivers/power/bq27x00_battery.c
> +++ b/drivers/power/bq27x00_battery.c
> @@ -1109,6 +1109,12 @@ static void __exit bq27x00_battery_exit(void)
>  }
>  module_exit(bq27x00_battery_exit);
> =20
> +#ifdef CONFIG_BATTERY_BQ27X00_PLATFORM
> +MODULE_ALIAS("platform:bq27000-battery");
> +#else
> +MODULE_ALIAS("i2c:bq27000-battery");
> +#endif
> +
>  MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
>  MODULE_DESCRIPTION("BQ27x00 battery monitor driver");
>  MODULE_LICENSE("GPL");

NAK. You should set the alias by checking for
CONFIG_BATTERY_BQ27X00_PLATFORM and CONFIG_BATTERY_BQ27X00_I2C
respectively, so that all scenarios are handled.

-- Sebastian

--SxgehGEc6vB0cZwN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVQlBvAAoJENju1/PIO/qaYeIP+wWzPSeDq5YcTc1nG1bLQsAb
hDjeWyXyV8OwGhbKqKqkGmbo6P0WJRx4GissCvVGMcTrWdmw5dlW93FUeqKiK8Cv
zhp5stKNodRBNCtNUlxjnpLevie0jT63ScWpZVV5+KfKSZAsv8HTf3lQriDsl0Q7
Fx3mqN8SuRFurEelc5tkdxeReUNhpQXmdPScPG6iRScpBlFIqTtQxu32rhegeE+C
hHNoSXWN1myT8AAwDKfT3FwwrXocS1DHnv4qKjGqgXxKg7LXrdCm1SKL4A00AtiN
d+2TGVuxSUihohFxP6G3LkWDZOU74qhKREK8VRI4aWsNQ5ostg8bdNUjrTxoPsCS
l+ZJ3rgHAtrKvbRLGD8q7PamGemfdlsf1/YX/XfqwM2lAZKXO/XWFGXRyE/yegcO
sQPO8TX2hnTapyIH1CMHku+K/z3qzGAEOWkCXFQE74rPZYmz2BqghVn2Y+b98Nr7
govV82l4bn/tH9pXvMeh6CeYTZVCTVPyjgI75uLDBRtgYwl/hIAe0ZkDDQx1LAjJ
xcmZmqee6kcRT4hAIUmR47LJqlWfCxDz6H52ePNQA5mpoFPjyUKkYkZnNUEhVM+M
zGT7OXUwR4+MAuxObFL7lMFKrWJrPwtbrgC/yDPHoAhGRRv2i2qNAou5IhVHDqcP
5jQw32UtRngsFz2759j3
=Iy0u
-----END PGP SIGNATURE-----

--SxgehGEc6vB0cZwN--
