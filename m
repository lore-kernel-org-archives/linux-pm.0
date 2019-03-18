From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / core: fix kerneldoc comment for
 dpm_watchdog_handler()
Date: Mon, 18 Mar 2019 13:16:54 +0100
Message-ID: <20190318121654.GF6101@amd>
References: <20190316033751.31323-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="w3uUfsyyY1Pqa/ej"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190316033751.31323-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--w3uUfsyyY1Pqa/ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2019-03-15 23:37:51, Yangtao Li wrote:
> This brings the kernel doc in line with the function signature.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  drivers/base/power/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index f80d298de3fa..0cff68bd7b4b 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -478,7 +478,7 @@ struct dpm_watchdog {
> =20
>  /**
>   * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
> - * @data: Watchdog object address.
> + * @t: The timer that pm watchdog depends on.
>   *
>   * Called when a driver has timed out suspending or resuming.
>   * There's not much we can do here to recover so panic() to

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--w3uUfsyyY1Pqa/ej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyPjDYACgkQMOfwapXb+vJCQACfXKyj6G3VQJoj9h6CmUWWU1cV
/HQAoLYW/5IkOCcKLMxSEq30xxiM60pE
=8I4/
-----END PGP SIGNATURE-----

--w3uUfsyyY1Pqa/ej--
