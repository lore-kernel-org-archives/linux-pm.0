From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: sysfs: parse string as enum when writing
 property
Date: Wed, 12 Apr 2017 16:41:33 +0200
Message-ID: <20170412144133.hyhvsayucdaypj45@earth>
References: <1491249177-8945-1-git-send-email-david@lechnology.com>
 <20170411161222.t23gsn4pvxofhnrh@earth>
 <f695eb57-d6b9-a1a6-a47f-347a5663478a@lechnology.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pl55obbnow5irfer"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f695eb57-d6b9-a1a6-a47f-347a5663478a@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--pl55obbnow5irfer
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 11, 2017 at 11:38:40AM -0500, David Lechner wrote:
> On 04/11/2017 11:12 AM, Sebastian Reichel wrote:
> > On Mon, Apr 03, 2017 at 02:52:57PM -0500, David Lechner wrote:
> > > This fixes the TODO to parse strings and convert them to enum values
> > > when writing to a power_supply class property sysfs attribute.
> > >=20
> > > There is at least one driver that has a writable enum property that
> > > previously could only be written as an integer, so a fallback to writ=
ing
> > > enums as integers instead of strings is provided so we don't break ex=
isting
> > > userspace programs.
> > >=20
> > > Signed-off-by: David Lechner <david@lechnology.com>
> > >=20
> > > ---
> > >  drivers/power/supply/power_supply_sysfs.c | 124 ++++++++++++++++++++=
----------
> > >  1 file changed, 85 insertions(+), 39 deletions(-)
> >=20
> > drivers/power/supply/power_supply_sysfs.c: In function =E2=80=98power_s=
upply_store_property=E2=80=99:
> > drivers/power/supply/power_supply_sysfs.c:138:9: error: implicit declar=
ation of function =E2=80=98sysfs_match_string=E2=80=99 [-Werror=3Dimplicit-=
function-declaration]
>=20
> This is something I found in linux-next. I did not realize it was new.
> It looks like it is part of a patch series for USB-C connectors.[1]
>=20
> It greatly simplifies things, so I think we should wait for that patch to
> land.

Agreed. Can you resend after v4.12-rc1 has been tagged?

-- Sebastian

--pl55obbnow5irfer
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljuPJoACgkQ2O7X88g7
+poT2xAAm5lyivlwqnjVyVS5baGCDgMobexDW3z4In/0SymIB4clQNMWkYD8+w5S
WsFWbJh6/xV87VN5FaJM+cixUzf469gJDEJh7lbUULlKrCVIQ98WQ4gKXmFXqbs6
jGnFjYi0wfxH4ZlUkJu/rADGhMliYVp6PMkuqyDMZBhtBClWUhQlAUhRTeTD0ohm
IvMA1KV7jcL67B73OpzqGjIQSDBQ/sIjJkcoNZouSkOhheHyN6AkqS/154mfMUdM
/neeY58KTgNmiIcnAaSAOK+SHS9qDwTX4utBI0fykEWAFz6mZPnq5weSqnFO4iNY
GoEC1bYBep67h7Cu48Z3MVFXnGtgFYkBOeQx9rYexSmw2VXfjIjkCGjUjRW+PBc5
BaoJDSVLPERR48TCqAqQNpC3mJSs9rWItlV9YPBsLD8q20MTaEE+jrvsMBhukfma
qFO5TEjeYrcfw+pBc5n/q5lMxGAxt6Xakx8ODkTxPW6Q0Fi0cLtMN1fKie4N9deX
oQj1aXF2votYYwiwNGIrQkrN63sN/oZEbs3tSJrRaswrDxht5bGk+nfAO8wl8H6V
vJE5/ahpiIL/x66EBVphiYglMe8iFU77uH0gKYbEnWsbOkHiZwpSbdWiTToRUbI+
/cOZH9HYjVi/EdFOtUVEtruipxYOkl6gnsLeyYAQQeYfrHHznho=
=QPaf
-----END PGP SIGNATURE-----

--pl55obbnow5irfer--
