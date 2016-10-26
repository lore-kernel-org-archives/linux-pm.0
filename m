From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / Domains: check for negative return from
 of_count_phandle_with_args
Date: Wed, 26 Oct 2016 13:00:08 +0200
Message-ID: <20161026110007.GA23875@amd>
References: <20161025163327.2179-1-colin.king@canonical.com>
 <7htwc0thwv.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:54940 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754100AbcJZLAO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Oct 2016 07:00:14 -0400
Content-Disposition: inline
In-Reply-To: <7htwc0thwv.fsf@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Colin King <colin.king@canonical.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2016-10-25 11:14:40, Kevin Hilman wrote:
> Colin King <colin.king@canonical.com> writes:
>=20
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > The return from of_count_phandle_with_args can be negative, so we
> > should avoid kcalloc of a negative count of genpd_power_stat structs
> > by sanity checking if count is zero or less.
> >
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>=20
> Acked-by: Kevin Hilman <khilman@baylibre.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgQjLcACgkQMOfwapXb+vKzggCgmxk1CU8N2uYRjWwTS0mRnZYH
cmUAn3l4wX677CyUASWGhugIkGz7S2M2
=LzEa
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
