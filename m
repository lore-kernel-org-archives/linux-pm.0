From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/4] PM / core: Introduce some helper for better Code
 reuse
Date: Mon, 18 Mar 2019 13:20:30 +0100
Message-ID: <20190318122030.GH6101@amd>
References: <20190316045928.31934-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="y9PDtDHaFrXNoMPU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190316045928.31934-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--y9PDtDHaFrXNoMPU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2019-03-16 00:59:24, Yangtao Li wrote:
> This patch set introduces some functions and macros that help reduce
> code duplication.
>=20
> Yangtao Li (4):
>   PM / core: Introduce dpm_async_fn() helper
>   PM / core: Introduce DEVICE_SUSPEND_FUNC() helper macro
>   PM / core: Introduce ASYNC_RESUME_FUNC() helper macro
>   PM / core: Introduce ASYNC_SUSPEND_FUNC() helper macro
>=20
>  drivers/base/power/main.c | 182 ++++++++++++--------------------------
>  1 file changed, 59 insertions(+), 123 deletions(-)

I'm not a big fan. Yes, you got line count down. But no, I do not
think "beauty" of the macros makes it worth it.
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--y9PDtDHaFrXNoMPU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlyPjQ4ACgkQMOfwapXb+vJd9wCguW/nBTK2LtLS+vq9VZKgdD7Q
+LoAnj9BVw71if8NFT0uaB7RV5SlCBxg
=cbth
-----END PGP SIGNATURE-----

--y9PDtDHaFrXNoMPU--
