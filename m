From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v8 0/6] typec: tcpm: Add sink side support for PPS
Date: Wed, 25 Apr 2018 01:26:33 +0200
Message-ID: <20180424232633.s475bsccxjhm7lpy@earth.universe>
References: <cover.1524490253.git.Adam.Thomson.Opensource@diasemi.com>
 <20180424135749.GA21610@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="44yhsknp6vltwubg"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180424135749.GA21610@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>, linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org


--44yhsknp6vltwubg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Tue, Apr 24, 2018 at 03:57:49PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 23, 2018 at 03:10:55PM +0100, Adam Thomson wrote:
> > This patch set adds sink side support for the PPS feature introduced in=
 the
> > USB PD 3.0 specification.
> >=20
> > The source PPS supply is represented using the Power Supply framework t=
o provide
> > access and control APIs for dealing with it's operating voltage and cur=
rent,
> > and switching between a standard PDO and PPS APDO operation. During sta=
ndard PDO
> > operation the voltage and current is read-only, but for APDO PPS these =
are
> > writable as well to allow for control.
> >=20
> > It should be noted that the keepalive for PPS is not handled within TCP=
M. The
> > expectation is that the external user will be required to ensure re-req=
uests
> > occur regularly to ensure PPS remains and the source does not hard rese=
t.
>=20
> Sebastian, any objection from me taking this series through my USB tree?

I currently have the power-supply bits in a local branch for
testing. I would like to have this in the power-supply
tree, since there is at least one pending driver which could
directly use the newly introduced usb_type.

I can either provide an immutable branch with a signed tag, or
you can merged it and provide me an immutable branch.

If you merge it via the USB tree patch 2-4 are

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

--44yhsknp6vltwubg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlrfvSYACgkQ2O7X88g7
+prnBg/6A1GYGRGjg129432dnH46Ak8t2wEUmVGPyWuq/BKtW8IrH13ooJnW1fDn
3hHSJuIi6CEeORhKB4eKohZ0n+cP1ajUl0vrAA0s1GJlr1bSeU30mLhFp1Ww7/Tc
fT//cgvz/uDfRSOXyF90Uz354/uWFBN5LnjqFkgoSbAkxZEz9oEVqFGUxScW9OV7
McP3ueZD6AgavK+25u4M/yJE2P3eVsjGTIBAC5B4Y9X1wGt6H8Y3hLpY2q8xcrXT
dge3Q4B3Kn6bmhKAlIA8m/hwa88zCr5uinerm5HGRmEBzTzWdzvBkigUGJS59men
n6HBoRXvYUggN4JxFIMKwNZmRctlq8BnVLEfjGoMNYT26OCRK/izeFXyLdPx3PaH
nmTkGFuJFSYbTVF5tTG11DCJ1WKfiopoJJIm0iILNBfUOOCTMT+dIKgGApBgOKfy
AYYAsH+3mCaxJBo4cnnn5iOREUFMA7/C4O3I524wPsZGS/8+MVvtP2ws4Ssepl0T
gspVTUmd18LrrgxPz4lQzGm1E9rzomVDgkgG8bpeQvdsTiyK4+jCGUhJw6GRuKZA
8//R80/uu/NuR1R12nN7vv50DUSQS111XTu3N4N0IN6IAZbZb/kvrAq/PjneQE6f
7LvC2mNg1PQiRtVJzUCVEMrFxOHgu1Tw7rARLwUYGQptAg0lGBc=
=N7UJ
-----END PGP SIGNATURE-----

--44yhsknp6vltwubg--
