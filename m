From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / core: fix kerneldoc comment for
 device_pm_wait_for_dev
Date: Mon, 18 Mar 2019 13:17:10 +0100
Message-ID: <20190318121710.GG6101@amd>
References: <20190316034841.31451-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Qf1oXS95uex85X0R"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190316034841.31451-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--Qf1oXS95uex85X0R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-03-15 23:48:41, Yangtao Li wrote:
> Rearrange comment to make the comment style consistent, the previous
> function parameters are described first.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  drivers/base/power/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index 0cff68bd7b4b..eddb54057ed6 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -2069,8 +2069,8 @@ EXPORT_SYMBOL_GPL(__suspend_report_result);
> =20
>  /**
>   * device_pm_wait_for_dev - Wait for suspend/resume of a device to compl=
ete.
> - * @dev: Device to wait for.
>   * @subordinate: Device that needs to wait for @dev.
> + * @dev: Device to wait for.
>   */
>  int device_pm_wait_for_dev(struct device *subordinate, struct device *de=
v)
>  {

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Qf1oXS95uex85X0R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyPjEYACgkQMOfwapXb+vKiIACfaImgNuI9nyp2zWc1zjI6P1Uy
ZaEAmwQIqDMH/OWJjyg5gexXKeWlaLlN
=FNoo
-----END PGP SIGNATURE-----

--Qf1oXS95uex85X0R--
