From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH] power: bq24190_charger: Change first_time flag reset
 condition
Date: Fri, 29 May 2015 04:34:40 +0200
Message-ID: <20150529023439.GA17735@earth>
References: <1432803932-5315-1-git-send-email-thomas.elste@imms.de>
 <1432803932-5315-2-git-send-email-thomas.elste@imms.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:33201 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753342AbbE2CfE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 28 May 2015 22:35:04 -0400
Content-Disposition: inline
In-Reply-To: <1432803932-5315-2-git-send-email-thomas.elste@imms.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Elste <thomas.elste@imms.de>
Cc: linux-pm@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 28, 2015 at 11:05:32AM +0200, Thomas Elste wrote:
> The initial register reset of BQ24190 generates a charger status change
> whose propagation via power_supply_changed is prevented using a flag.
> This flag gets never reset so all following events are ignored as well
> leading for example to userspace not detecting charger connects/disconnec=
ts.
>=20
> Therefor change the reset condition of first_time flag, so only the
> propagation of the first charger status change is prevented.
>=20
> Signed-off-by: Thomas Elste <thomas.elste@imms.de>
> ---
>  drivers/power/bq24190_charger.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/power/bq24190_charger.c b/drivers/power/bq24190_char=
ger.c
> index 407c4af..052db78 100644
> --- a/drivers/power/bq24190_charger.c
> +++ b/drivers/power/bq24190_charger.c
> @@ -1258,10 +1258,13 @@ static irqreturn_t bq24190_irq_handler_thread(int=
 irq, void *data)
>  	 * register reset so we should ignore that one (the very first
>  	 * interrupt received).
>  	 */
> -	if (alert_userspace && !bdi->first_time) {
> -		power_supply_changed(bdi->charger);
> -		power_supply_changed(bdi->battery);
> -		bdi->first_time =3D false;
> +	if (alert_userspace) {
> +		if (!bdi->first_time) {
> +			power_supply_changed(bdi->charger);
> +			power_supply_changed(bdi->battery);
> +		} else {
> +			bdi->first_time =3D false;
> +		}
>  	}
> =20
>  out:

Thanks, queued for 4.2.

-- Sebastian

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVZ9A8AAoJENju1/PIO/qaq/0P/2Pn0dS0eTMnvBnBoqqhuPBL
ydXMIawhK7mwjhlSDk2CzriXj5bhvDR/WYVpQWiFEnBcVmr3ctTuD7ZrF5MExhe5
sPX3hCCYW5fGTBVCT+m3F3t2wTIsDMtxxcAH2bhhHc21FJKP/rXMjaxihULIHQKO
sQ2cq5co9FVSTEaq3eZIFVfWdAGRZf5avHoljmCNl0GnGm8GCSHk5ZLML2qLIcFZ
FICYkz9b0tzAkJ5MGgSPjceKbWjDjWJ3MtkbfRnOBWXbnZhHuvsQ62IQr8+OfBeR
xvWHALPC7+K6vjxKfK5L9/BerhQae6fxVgnkHvTQXZT0nan6LO67fkfvNcbyfD3c
4UqTNKkfVUICV8PGUdNJ4cxiIg2ALFnb+YcQQq+73rPaN8e3B60GmqHsj77FyxcU
NlEDVZpIH01zUjcYwFSsTmK6UUQbjU4gP/w24XrdPLhyVeTELu97iNVDvCBCP6ZI
tZwQIZf7QAxaoSx8KKxnOqoRvQ/YwEnre72xSPFgF+zlcmMrrbhDy5386GUbAJnP
82LixqC81rlDHiDVvc9vNwzrU5dP6M+h3/TWzWvsSXih0hQRnBdPx1QbA+BVMoTp
vvmueI7sZgo/TdabWORwiBLEsFm0uKP5WDMk8njCYw9VpatCOT5SPXSs8Gsu/tGz
J5r5HgqnjJia+giJczO4
=qIlu
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
