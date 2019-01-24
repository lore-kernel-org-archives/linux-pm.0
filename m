From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / wakeup: fix comment of pm_wakeup_dev_event()
Date: Thu, 24 Jan 2019 13:26:33 +0100
Message-ID: <20190124122633.GA24847@amd>
References: <20190123162201.26366-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190123162201.26366-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2019-01-23 11:22:01, Yangtao Li wrote:
> This brings the kernel doc in line with the function signature.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

> @@ -783,7 +783,7 @@ void pm_wakeup_ws_event(struct wakeup_source *ws, uns=
igned int msec, bool hard)
>  EXPORT_SYMBOL_GPL(pm_wakeup_ws_event);
> =20
>  /**
> - * pm_wakeup_event - Notify the PM core of a wakeup event.
> + * pm_wakeup_dev_event - Notify the PM core of a wakeup event.
>   * @dev: Device the wakeup event is related to.
>   * @msec: Anticipated event processing time (in milliseconds).
>   * @hard: If set, abort suspends in progress and wake up from suspend-to=
-idle.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlxJrvkACgkQMOfwapXb+vJA9wCaAlwptI3DbN0d7LGOmjY8d3aM
2EoAn3N/XMDMdrC+7D96VjzY5un9RApl
=187Q
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
