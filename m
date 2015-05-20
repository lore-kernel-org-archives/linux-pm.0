From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC/RFT v2 0/2] power_supply: Fix NULL pointer dereference from
 uevent
Date: Thu, 21 May 2015 00:20:54 +0200
Message-ID: <20150520222053.GC28218@earth>
References: <1432019582-27612-1-git-send-email-k.kozlowski@samsung.com>
 <77C4D085-96E6-4874-BD7A-AC4BDFAC3A58@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <77C4D085-96E6-4874-BD7A-AC4BDFAC3A58@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 19, 2015 at 10:28:39AM +0200, Dr. H. Nikolaus Schaller wrote:
> Am 19.05.2015 um 09:13 schrieb Krzysztof Kozlowski <k.kozlowski@samsung.c=
om>:
> > Changes since v1:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 1. Patch 2: fix invalid member used for container_of().
> > 2. Patch 2: Replace WARN with pr_warn() in __power_supply_register()
> >   if parent is missing.
> >=20
> >=20
> > Description:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > This is an idea to fix issue in bq27x00 driver (and probably in others)
> > reported by H. Nikolaus Schaller [0].
> >=20
> > The fixes are marked RFC/RFT because:
> > 1. I do not have bq27x00-like device. I confirmed this and tested on
> >   modified drivers (max77693, ACPI AC). These drivers are not
> >   impacted by the issue but one can easily adjust them to reproduce
> >   the problem.
> > 2. The first uevent coming from power_supply_register() is now
> >   different because it won't contain device properties. I am
> >   not sure how this impacts userspace.
> >=20
> > Comments are welcomed.
>=20
> appears to work! bq27000 is coming up now without hickups.
>=20
> What I can=E2=80=99t test is if the uevent is reasonable because we do not
> have a specific rule triggered by it in our system.
>=20
> So from my side we are now happy with the solution.

So you would be ok with the following added to the patches?

Tested-By: Dr. H. Nikolaus Schaller <hns@goldelico.com>

-- Sebastian

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVXQjDAAoJENju1/PIO/qaMz0P/ROk3lvax447ZoG0EpdC8mWF
yTZRqeOIO0GkiK4QvejudCbo2fIEt16rp/sAFqip6YhuyKrTPvDBO7tmnxutU+cX
4tMC9HujbetQzWU+vaMJgOwJwbQdU6ScoqmcP2dFib84C2o7VjGF3g3lV03Zmu65
W8S7GMecC7+z0/Rml2OEu+Vs9j2VWn94z/Hy8PuR7Cur9jnTZwNaNSVSXeTKfkAC
GWQQyasCiHxHFfkqt/ejVtSEGsh12LLHIrnJl00m7KKdiB/5vIrLv5FQLjYo/ltf
T9kWpqFwijfVAEaMQIgFyyQu+FMbftjeGi6iNgoF4OycTd3w+LdL7v6XXSfrklKh
AknAq9dWI22AV0eMhiJiKTbH7hKbaFZCpnnEuscnBpTFjUSsD9rg44Sjfg6w++Id
lmQnx9hr8Rg+KvRbqOxOww8P7YSK1X7ggCxccFuZMBpJj5goPv1K1J8GBDY0rHMj
NfOFkxVOL8BpIIEl1/PEHF798bMPJ/K68kNElQbBXYnm18aZ/PLEUtNppKl9uUQi
3y8mf3s/LHM6W21fWV3bRo2Neb7M1dw7mVoUxDTr5qR7peR0qEXwbGDMzMyaTH9R
4NztWcFi+f/T5ewRKm+HmvIPnsKJmeESKmYosaDlOwCusFW6uGwFuBLVzbVf6GyR
uL+GStHNopC4j3SqoJj4
=GM96
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
