From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 1/3] power: supply: bq24735-charger: simplify register
 update to stop charging
Date: Wed, 14 Dec 2016 17:41:33 +0100
Message-ID: <20161214164132.mxbx4tiwefbe6c2r@earth>
References: <1481673405-4547-1-git-send-email-peda@axentia.se>
 <1481673405-4547-2-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y44t7al2dlzn3ib2"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1481673405-4547-2-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--y44t7al2dlzn3ib2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 14, 2016 at 12:56:43AM +0100, Peter Rosin wrote:
> Providing value bits outside of the mask is pointless.
>=20
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  drivers/power/supply/bq24735-charger.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/power/supply/bq24735-charger.c b/drivers/power/suppl=
y/bq24735-charger.c
> index eb7783b42e0a..1d5c9206e0ed 100644
> --- a/drivers/power/supply/bq24735-charger.c
> +++ b/drivers/power/supply/bq24735-charger.c
> @@ -111,8 +111,7 @@ static inline int bq24735_enable_charging(struct bq24=
735 *charger)
>  		return 0;
> =20
>  	return bq24735_update_word(charger->client, BQ24735_CHG_OPT,
> -				   BQ24735_CHG_OPT_CHARGE_DISABLE,
> -				   ~BQ24735_CHG_OPT_CHARGE_DISABLE);
> +				   BQ24735_CHG_OPT_CHARGE_DISABLE, 0);
>  }
> =20
>  static inline int bq24735_disable_charging(struct bq24735 *charger)

Thanks for your patch. We are currently in the merge
window and your patch will appear in linux-next once
4.10-rc1 has been tagged by Linus Torvalds.

Until then I queued it into this branch:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/log=
/?h=3Dfor-next-next

-- Sebastian

--y44t7al2dlzn3ib2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhRdjoACgkQ2O7X88g7
+por1BAAn5VDl4+2rzFwZK/VPw2ZloKQhneDz2RRNa7vJyBvZg9+uAlxzfqY+yvu
mc/G8jKcFaCLDrJnszOTSHizNC1CxtWBlC7jU2eoBTCzCqKqqo2E3o3jewM87LP3
XtOgsEoo1ks089mvgK6PL8MuxXpsylNZb1OZAmKBDsXCPsuOoMlIMW7EAPU2dnnL
2gsBCFbaBSQ8Os9CphuTHBhSRhx8hTCoZmhZGEJ2F+VHsw7D5HRPe4Wn6iKZrax8
HiFZC1gYDrJ0Zm87snbLQwtoUYQvJJxuudRrjRZV3XtnFTk+DXHRAk8kWX6qxMLZ
k7Wmmdqn8lj8XkJn6MsCl6XBqD/0j0l6etcNoepSU8w6jXCgLy/oHosiCxi3jtD5
c2NfPCB/3InDW/+nid+yy7yBc077xol120rFL37X/geNwJpsrzPuVgKDwHfM5Qej
5ghMSme0xlI3zJV8jfFuTFfhyzozrKNJD5E01AyNpyyQJBmPw4SoOgd1JYjPfdVr
9jFA3nrCNdQBW8ZNQLnngq7ldZL8yWukeIT21krVVOL5jjz/Or55Syhhy0bI4zqh
V7FnbiOTcCxONgb3cGStxKYhDhhIyUXn4L2GFw0lkHXK7dbCxzEF01xyGSvpbdUz
vcQXUl7G7eDLaxy+zwFfDAnyQHbIcZx6xpPk0xwPPL0hGjTKfn0=
=fP/V
-----END PGP SIGNATURE-----

--y44t7al2dlzn3ib2--
