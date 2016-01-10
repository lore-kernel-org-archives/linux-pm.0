From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/2] i2c: always enable RuntimePM for the adapter device
Date: Sun, 10 Jan 2016 09:27:52 +0100
Message-ID: <20160110082752.GB1526@katana>
References: <1450891169-13708-1-git-send-email-wsa@the-dreams.de>
 <1450891169-13708-2-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1450891169-13708-2-git-send-email-wsa@the-dreams.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: linux-pm@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 23, 2015 at 06:19:28PM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>=20
> The adapter device is a logical device. Because of that, it already uses
> pm_runtime_no_callbacks() in the core. To ensure proper propagation from
> the children (i2c devices) to the parent of the adapter (the HW device),
> make sure RuntimePM is enabled in any case.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied to for-next, thanks!


--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWkhYIAAoJEBQN5MwUoCm2X6kP/AvwqKjOjbRJh7rM4Ejh13SS
y9/6T55ZfKDB0mztJfwIay5lySbNBO0KPNcSU4g2OxP6qY2MXqUHPINdWmTBmKzK
BDvLx+4dkHSmfUmyOlz9ddRonyYYz+MpboMqgJ9+J+4kOhrQylV2h5p6huO+qix+
UzccyQOoQcLVSptPS8ude/G//EGuRimmWTdcumihiQZixZUNU+Jy7dNEh/Z5IOmh
y1zE9xdQbNBhbbclJ017dUxH+7RPLU6KkWwuv80y9oHQdOAR5KAStBf+ddAlYw5E
NswBoYV0a6tmVlgdOAAw8KYE7ih2BpJ4mDyZoR0hKRlDn/fcCeth9O8MmtUKTnfV
setO6uUrMp/HnFEbbTuU10E8Pl3lLsujq6MzabW4IuFpFiE8/oIxHzBAZu+6hYlC
S7osUbwGFt1jgyzcGHBwjYMkyunp7DpEuYdyG6YeWM7zZ0CeQmbhX2KVXJBU4Mey
2LwC/FnpJTimAwaJ3TchIrJdVqC1mDOauHQogySosfITd1eznyPcQxPWeAOJhzDv
xwl0jxFCkPzRpNr+9MjTP0N5LfPrR0qWh2YqnHdINGJhm3k4UrO/INzIclF4KTsJ
KUgtvYHZmSx1gV/h3jmsoQxSbVbYr79rb83Ax56clalDxAJLaBpapBIC2sa9TU0J
ZwWGhkkQaunQnYyJPubU
=PqEJ
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
