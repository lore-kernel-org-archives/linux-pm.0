From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 2/2] goldfish: Enable ACPI-based enumeration for goldfish
 battery
Date: Fri, 26 Feb 2016 21:03:26 +0100
Message-ID: <20160226200326.GA19840@earth>
References: <20160226184455.2962.92705.stgit@localhost.localdomain>
 <20160226184541.2962.40016.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43411 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754956AbcBZUDc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 26 Feb 2016 15:03:32 -0500
Content-Disposition: inline
In-Reply-To: <20160226184541.2962.40016.stgit@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan <alan@linux.intel.com>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alan,

On Fri, Feb 26, 2016 at 06:45:50PM +0000, Alan wrote:
> From: Yu Ning <yu.ning@intel.com>
>=20
> Besides adding ACPI bindings to the goldfish battery driver, modify the
> ACPI driver to inform it that goldfish battery is a platform device.
> The latter step is necessary with kernel 3.16 or newer.

I don't understand the second part of the commit message. The patch
only seems to add ACPI bindings to the goldfish battery driver. Did
you forget to add something?

-- Sebastian

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW0K+KAAoJENju1/PIO/qaMI4P/2WiPRqiAbrXMc1KHi5cQvHm
CtokjuGk2qQ7UX/+IUeWmCRMGJ/HfdzLT9sXZu7UNlyqdkKzzRN3uN0GFoIg7SXi
PGzjPRiuq/Yy1bVrvl3oX1eSVR1mdZ7FylA1EnwHX6DRiJzHVbIzSmarHW5Jb7RT
0Tnm06WKxvhwyzDUTjGav9ZnXYcwiZta8uRrUkZTUMNHYRtKgd4qlyUMvAe5cBIO
hzTGHfUZou+0HQyNQEgGEXM/xwvvnTnDFyWgnAUzxCNjnrSulg4jIsqHfj1eK5QI
J1pjtnwKt4a8gLy6yjdjTFBGKD87tqND9402Sl485BGf0ivB7LnJuB0bwqtvZe56
3Afqt6yieNFcbfXklyB8MKevToIbHLyr42Hrx8cezTCJWX3m2/n1Pk8CybwWMxNN
jtTwOzyO9NZPaKZMDU8/4J6a0xtqY/01DS7xKinGFAZHVnGw3vLpInu/VyEp/goK
n7FYlpnG6e8Ig6fUgtm632mjIWku/W92/5jQUZG9FeHb2237cDEupBeoQvOxWBvb
Jigudtk+Ix65fwLqaY7G35XXweXKFsJ3TTBIApLrhhTGaqJaNsgAW6WVdverQpHe
ysa3csQqbkdIj8WdcaTGl5gBYUJFtnlPyGIkk1D1dHJTXpD9+C/pGv1l6VsGM73O
7sVOry1DMKBnrLnrLGR/
=XzE8
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
