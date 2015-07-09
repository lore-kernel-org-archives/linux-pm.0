From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/2] power: reset: at91: add sama5d3 reset function
Date: Thu, 9 Jul 2015 14:03:35 +0200
Message-ID: <20150709120335.GW28632@lukather>
References: <1436436947-11210-1-git-send-email-josh.wu@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hk/xWDG3xnLTY+FR"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:46788 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752988AbbGIMFD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2015 08:05:03 -0400
Content-Disposition: inline
In-Reply-To: <1436436947-11210-1-git-send-email-josh.wu@atmel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Josh Wu <josh.wu@atmel.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-arm-kernel@lists.infradead.org, Guenter Roeck <linux@roeck-us.net>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Fabian Frederick <fabf@skynet.be>, linux-pm@vger.kernel.org


--hk/xWDG3xnLTY+FR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 09, 2015 at 06:15:46PM +0800, Josh Wu wrote:
> As since sama5d3, to reset the chip, we don't need to shutdown the ddr
> controller.
>=20
> So add a new compatible string and new restart function for sama5d3 and
> later chips. As we don't use sama5d3 ddr controller, so remove it as
> well.
>=20
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>=20
>  drivers/power/reset/at91-reset.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-=
reset.c
> index 36dc52f..8944b63 100644
> --- a/drivers/power/reset/at91-reset.c
> +++ b/drivers/power/reset/at91-reset.c
> @@ -123,6 +123,14 @@ static int at91sam9g45_restart(struct notifier_block=
 *this, unsigned long mode,
>  	return NOTIFY_DONE;
>  }
> =20
> +static int sama5d3_restart(struct notifier_block *this, unsigned long mo=
de,
> +			void *cmd)
> +{
> +	writel(cpu_to_le32(AT91_RSTC_KEY | AT91_RSTC_PERRST | AT91_RSTC_PROCRST=
),
> +				at91_rstc_base);
> +	return NOTIFY_DONE;
> +}
> +
>  static void __init at91_reset_status(struct platform_device *pdev)
>  {
>  	u32 reg =3D readl(at91_rstc_base + AT91_RSTC_SR);
> @@ -155,13 +163,13 @@ static void __init at91_reset_status(struct platfor=
m_device *pdev)
>  static const struct of_device_id at91_ramc_of_match[] =3D {
>  	{ .compatible =3D "atmel,at91sam9260-sdramc", },
>  	{ .compatible =3D "atmel,at91sam9g45-ddramc", },
> -	{ .compatible =3D "atmel,sama5d3-ddramc", },
>  	{ /* sentinel */ }
>  };
> =20
>  static const struct of_device_id at91_reset_of_match[] =3D {
>  	{ .compatible =3D "atmel,at91sam9260-rstc", .data =3D at91sam9260_resta=
rt },
>  	{ .compatible =3D "atmel,at91sam9g45-rstc", .data =3D at91sam9g45_resta=
rt },
> +	{ .compatible =3D "atmel,sama5d3-rstc", .data =3D sama5d3_restart },
>  	{ /* sentinel */ }
>  };
> =20
> @@ -181,17 +189,21 @@ static int at91_reset_of_probe(struct platform_devi=
ce *pdev)
>  		return -ENODEV;
>  	}
> =20
> -	for_each_matching_node(np, at91_ramc_of_match) {
> -		at91_ramc_base[idx] =3D of_iomap(np, 0);
> -		if (!at91_ramc_base[idx]) {
> -			dev_err(&pdev->dev, "Could not map ram controller address\n");
> -			return -ENODEV;
> +	match =3D of_match_node(at91_reset_of_match, pdev->dev.of_node);
> +	at91_restart_nb.notifier_call =3D match->data;
> +
> +	if (match->data !=3D sama5d3_restart) {

Using of_device_is_compatible seems more appropriate.

Also, why are you changing the order of this loop and the notifier
registration?

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--hk/xWDG3xnLTY+FR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVnmMXAAoJEBx+YmzsjxAgq6gQAKxXlMypn6Ftz4C/G8OV/t8Y
656uK+NcxdS6Wo8dldZaOd5rHicsbdsh0DYI2HaEvWpsdir4o1kp348GHgnpxLe2
iZ17fdJ/JUpjd10UvgLWQdCz0bgUTEEytYDwGn02ElnWl/6EzJgy8z7i8LAv9zIe
ql9tie/yX0qVpPfiBZyiqq2phyeBoaXfNclFTZO0jN337MENl8Qbp97kaL2HY/ga
0Q7vx7fkLx90ZOKRFPgHI2OCRa9R9zWz6S0SfwxxdLTj4JHdbA2m5sDM6Wo746cV
6clsI1A0pMTvqJjdTCpPA/yg5aM75HVt0GRYPt/Jzs5hZgAXyMrMOkMprCIWDvBD
N3fJ4ePDkWwRE9sZJxxuJci6ibEV+ahZEpkaFLCy3olE6kjseMLF3wFbztQvR0xP
9htx8WXAGXHxBAk3cs3SRyYKiuiPof5dwO2aywd5AtQJMEH5lzcQr2ocmQYb/asU
wIt+iiN7ReySiGiDQ33cn37fl3CicFCZ22zzG00vlNsjXxGRPf93G9POyAF7gwB3
CzBefKR7EY49btOKjhD7TlTPoX549+OunNMKjfpxgoGJRMBWj2LAoRPq1UbDG0Aq
bTYCxThLOsH2ifM6QImXtgdpBC0dUhba0ZHaGJIrQjwJFvJ7AExyqJJgO7q+URzt
bbpkW/DztZQYcMEoNr9i
=UcLg
-----END PGP SIGNATURE-----

--hk/xWDG3xnLTY+FR--
