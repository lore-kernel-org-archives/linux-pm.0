From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [RFC/RFT 01/10] i2c: add 'is_suspended' flag for i2c adapters
Date: Wed, 19 Dec 2018 00:33:54 +0100
Message-ID: <20181218233354.pie5i3lvrrhq5q2c@ninjato>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <20181210210310.12677-2-wsa+renesas@sang-engineering.com>
 <a4fdd7f1-be79-48fd-0d13-410276962384@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kkoegvsoxj4nbwmq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a4fdd7f1-be79-48fd-0d13-410276962384@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--kkoegvsoxj4nbwmq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +	unsigned int is_suspended:1;	/* owned by the I2C core */
>=20
> When more stuff is added to this bit field (which always happens at
> some point) updates to all members of the bit field will have to use
> the same root-adapter-locking, or we will suffer from RMW-races. So
> this feels like an invitation for future disaster. Maybe a comment
> about that to remind our future selves? Or perhaps the bit field
> should be avoided altogether?

Changed to bool. Thanks!


--kkoegvsoxj4nbwmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwZg+EACgkQFA3kzBSg
KbZljQ/9FWhnSg2KAf/UssubqDJ1lmNWr9tNZYeZy56inKDT504CHLS7psgOekeS
ktdvqMny8x08MmKEeeKRUiAyc/G7RH2fqzYDehX7/fTp9JurpkAzUU3R3ojKKTUk
LttUvwiH3sox6DTtxNwVX5L+QlrJYj7MdGYLh4C7wC5GEmaqdK0Gev5wyksiqu8b
CpY5l6Mux+3ZIm1s3gQaa1mC6wVGvodvtpJ569ttR2XaaX4uhlg9OGDAGTT5Xck8
4rUiXKYBIvv3pGoq8KSNVunayb8zo82vsspr3QzCW010Tn9HKAbAJkvj85qBVcrq
f7ibMz8yI0cSyewn9rxQJlO7XPrkigRTyNScUhansbHOygY0lRa2VT7yh1at3uCg
FeGV6K3DSOYh43W+iy+qL+pUmiVzuTBiQ+Si+Ko3FcoGqx2OMg9dUk7Jm3ReWo5E
gRF0i1i5EmpP6qtzpd4miyVlrMupj4VL5huRV1vT67UgHHyrirMnXwuvLm7Lejwb
NTPAJSVCDC7lgiqnw9zfVqART0ZLm0iWGQGYOoMAVl1XCowvkB4GmSAztviWOyui
m+1pEjjwNMKntfoQqSi00B4dPBwxNsYTesAoBSNJuDYwkoDcsigM42sqKykKydDa
rcb4ZgX+UA8hP7VGZFnjouQWkU6KsoJNr9SxJuvqGlaOjwNvC1k=
=fCGw
-----END PGP SIGNATURE-----

--kkoegvsoxj4nbwmq--
