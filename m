From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v1 3/3] PM / sysfs: Convert to use DEVICE_ATTR_RO /
 DEVICE_ATTR_RW
Date: Wed, 15 Nov 2017 13:04:29 +0100
Message-ID: <20171115120429.GA8990@amd>
References: <20171110182809.85953-1-andriy.shevchenko@linux.intel.com>
 <20171110182809.85953-3-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59169 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932460AbdKOMEc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Nov 2017 07:04:32 -0500
Content-Disposition: inline
In-Reply-To: <20171110182809.85953-3-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2017-11-10 20:28:09, Andy Shevchenko wrote:
> Use DEVICE_ATTR_RO() and DEVICE_ATTR_RW() macros instead of
> open coding them.
>=20
> No functional change intended.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAloMLU0ACgkQMOfwapXb+vLYTQCeP/WHHMczRvdiPl3JyPY1L038
n1UAmgLO9YEHAnXqUpnjzSDojZ2YVlEU
=Sg23
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
