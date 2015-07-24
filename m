From: Sebastian Reichel <sre@kernel.org>
Subject: Re: power_supply: Making "enum power_supply_type type" dynamic
Date: Fri, 24 Jul 2015 17:26:47 +0200
Message-ID: <20150724152647.GI27569@earth>
References: <D854C92F57B1B347B57E531E78D05EAD578645A4@BGSMSX104.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IR1Y5IvQhrKgS4e6"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36802 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751895AbbGXP0v (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 24 Jul 2015 11:26:51 -0400
Content-Disposition: inline
In-Reply-To: <D854C92F57B1B347B57E531E78D05EAD578645A4@BGSMSX104.gar.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Pallala, Ramakrishna" <ramakrishna.pallala@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>


--IR1Y5IvQhrKgS4e6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 02, 2015 at 05:56:17PM +0000, Pallala, Ramakrishna wrote:
> Currently 'enum power_supply_type type' is part of 'struct
> power_supply_desc' which is again defined as a 'const *' in
> 'struct power_supply'
>=20
> Can we move the 'enum power_supply_type type' to 'struct
> power_supply' itself?
>=20
> Rational behind this is, if you take any mobile or tablet device
> it comes with one USB charging port but it can support multiple
> charging cables like SDP, CDP and DCP etc.. So whenever we connect
> any of these cables we need to adjust the charger parameters
> accordingly.
>
> So the point here is, If we are using same physical charging port
> and the same charger IC for setting up the charging we can have
> one power supply class registration from the charger driver and
> change the power supply type based on the cable detection at
> runtime.
>=20
> The current implementation forces us to create multiple power
> supply objects for each cable type which is not optimal as all
> these objects set/get methods operate on the same set of
> registers.

Sounds legit. I would prefer not to modify all existing drivers, though.
Instead of 'moving' the type field I suggest the following strategy:

struct power_supply_desc {
    ...
    enum power_supply_type type;
    ...
}

struct power_supply {
    ...
    enum power_supply_type type;
    ...
}

struct power_supply * power_supply_register(...) {
    ...
    psy.type =3D psy_desc.type;
    ...
}

This way chargers with static type, batteries, ... do not have
to be changed at all and runtime changeable chargers have a
nice default value.

-- Sebastian

--IR1Y5IvQhrKgS4e6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVslkvAAoJENju1/PIO/qaFpoP/2no838Qj3/O6X4CIki3zWod
gbGClJFrRid0WrQ+cIEIJmsVmKHG1k9UojkJ36D9iWsEGdxkwOwgXv349j/ihRwg
AkB3tTg6d8n/8+k+puTONX4czDIe+dSAcwiXYrComXlVPVVFJ3KMK4w8v6S0FbTI
imJIMFHOgt560rYioQGXJmUiHICYmsu1+l+znNZXDLS/ojJE8sqrI1Yt7eKT4saN
m7xLbDDeuFkmE3W/UHgM+JvlApZ9I4FrUaQV7EfKlhH3nI6YzzcVMTzdAhFwCGrC
EYHIZDajoMAW5y7qnQ4BBzbfXyG+COYWHmHca8/evj9FUz5ElFKTVSMZzw6L7pW1
zi3EZZ2LL16b2TCxFmdQ/af4ISKlgMjUonS/PYQwQC0V3U+0SDxetoYrGKdM80UN
VckfQlGCftxBI0y9/5dPZNButctfZ6+G5y5qZbPH1GFD0GVQzV7KNzHu9lhJkMT7
Vduf/VFScGVOV/N+0sZtgpcgAHxpoOfeYU3WiDmMz7sN9Jtfk1gitLUVMpyot9h8
Is19Hp2eAa/aGC94UOMZvMeV594crsxw3lBijIS//kEbT+w1LeAhxO40BPfQ/mnk
n3aUBYWHZlf0xMwHE2+zB3IzMwq9Du7AQ4GCsLIdWuNvoq545/xg8tmJ0TK0b+Ro
CO2sybem9Mejkjv5OMLy
=UMHS
-----END PGP SIGNATURE-----

--IR1Y5IvQhrKgS4e6--
