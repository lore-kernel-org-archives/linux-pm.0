From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] driver core: remove define_genpd_open_function() and
 define_genpd_debugfs_fops()
Date: Mon, 3 Dec 2018 10:23:59 +0100
Message-ID: <20181203092359.GA21500@amd>
References: <20181201015154.4718-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181201015154.4718-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, khilman@kernel.org, ulf.hansson@linaro.org, len.brown@intel.com, broonie@kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-11-30 20:51:54, Yangtao Li wrote:
> We already have the DEFINE_SHOW_ATTRIBUTE,There is no need to define such
> a macro,so remove define_genpd_open_function and define_genpd_debugfs_fop=
s.
> Also use DEFINE_SHOW_ATTRIBUTE to simplify somecode.

"and there", ", so".

> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Otherwise looks good.

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwE9i4ACgkQMOfwapXb+vK+3QCgrzj/A2MVArH+6HYu9tslOC3+
FEUAn3yBGHd80WYr+KsdPk9YQZiQpKta
=Ore1
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
