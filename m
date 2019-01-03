From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v2 2/9] i2c: reject new transfers when adapters are
 suspended
Date: Thu, 3 Jan 2019 19:59:18 +0100
Message-ID: <20190103185917.zfcw24n5w4n4qu2q@ninjato>
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
 <20181222202623.4521-3-wsa+renesas@sang-engineering.com>
 <5e560c2e-4da9-05ef-9bfa-3391fdd8ad23@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="waep5l5pjqydoewa"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5e560c2e-4da9-05ef-9bfa-3391fdd8ad23@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--waep5l5pjqydoewa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I share your desire to have the check for this shared in core code,
> but I'm afraid that just is not going to work.

Okay, so this series is definately not it. Probably the previous one
which exposes helpers is not a bad idea after all. Because it is
ulitmately the driver's decision when to use the helpers...


--waep5l5pjqydoewa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlwuW4EACgkQFA3kzBSg
KbbIYA//U3lleoAK/oWl+9UNpk7CP0tKUplkb/9WLfa5od5R+/aqf5OcavI6ebxa
WELpu0Hu849QTMrm5eYiADrtR4nRdsCHwxtUTfpgbyX63j8DIb0PoQOX6T7vDHNm
ODoIzVQ/rBEK0CFBGGUhqBrU6ZeH2Cgp30WsgB76KhRQptrtK7why4J4afBlGeMS
ZwEkd+bHyY4iFB4DY685UcvK4x0W+PJbmgEDnSG2ArR4M/G9M8RTljd+5aYO96zb
feEp0CTL3huFaVRyUKam6+V8aQc4FgLUl+WlSzlK4zdZ+CVUlxB3r45KA9QXDhi0
xxScjdMoYWAhQ1VZPCMSYgCzV3duiChgztBtzI+uiSOlI1Og94uu0VzasIQ7diNM
VeOgKLEiO4viwncZOY/cg/tnwz/PJFjubY2xrXdWGURnlNBGfxznso9FCnEy06Pk
jWShb8+X0q3NQFMepdD2DlzQYUYGguEANRXkkRICBqXoHhjo8GOyd1Rf7HiA+hqO
cYYHo3+zY6hllamSTkuEHKLLGPu7GP+seUyVXz2MvEgq3yL763MEviUCCt1/xb/G
5v2XkY0Jv5NaRj6n0xD+xj1lS//vUNDtIf8JegowCQqaAAsLXJeT1/MJyo7xMQvC
YggEZWu+12HQvPZyq446l9wP46xV8D95GukSI6HCnJsDSqDaTkA=
=ujG8
-----END PGP SIGNATURE-----

--waep5l5pjqydoewa--
