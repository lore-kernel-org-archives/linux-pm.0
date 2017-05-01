From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 05/14] power: max17042_battery: Change name in
 power_supply_desc to "main-battery"
Date: Mon, 1 May 2017 17:50:50 +0200
Message-ID: <20170501155050.o5226rcfzxtrzvju@earth>
References: <20170414183259.24382-1-hdegoede@redhat.com>
 <20170414183259.24382-5-hdegoede@redhat.com>
 <20170501122253.e3nrr4dql2nt3cba@earth>
 <caf9b434-29bb-e03a-0287-c12de9beec0d@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wpkx4opzo6bjcm7h"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58178 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753784AbdEAPux (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 11:50:53 -0400
Content-Disposition: inline
In-Reply-To: <caf9b434-29bb-e03a-0287-c12de9beec0d@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org


--wpkx4opzo6bjcm7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Hans,

On Mon, May 01, 2017 at 05:11:13PM +0200, Hans de Goede wrote:
> Thank you for merging all my recent patches.

You are welcome!

> On 01-05-17 14:22, Sebastian Reichel wrote:
> > > Change the name in max17042's power_supply_desc to "main-battery" to
> > > match, so that power_supply_am_i_supplied() can be used to implement
> > > POWER_SUPPLY_PROP_STATUS.
> >=20
> > I did not queue this patch and patch 14. First of all: Currently 4/30
> > chargers have this, which I wouldn't call "almost all". I think this
> > is not the right solution, especially as it will break once a system
> > has more than one "main" battery (like some of the newer thinkpads).
> >=20
> > For DT based systems we have generic support to specify the
> > dependency as phandle. This obviously won't work for you.
> > I suggest to use a device property for supplying the correct name
> > to the charger instead.
>=20
> Ok, fair enough.
>=20
> So to be clear you are suggesting that we modify the charger driver
> (or the power-supply-core) to check for a "supplied-to"
> string-array device property which then overrides the power_supply_config=
=2Esupplied_to
> array's default value in the driver?
>=20
> Or do you want to modify the fuel-gauge driver (or the power-supply-core)
> to check for a "supplied-from" string-array device property which then
> is used to fill in the power_supply.supplied_from array ?
>=20
> Looking at how currently the power-supply-core fills in power_supply.supp=
lied_from
> from devicetree when #ifdef CONFIG_OF is true, I think the best (and
> most consistent) solution would be to change the :
>=20
> #else
> static inline int power_supply_check_supplies(struct power_supply *psy)
> {
>         return 0;
> }
> #endif
>=20
> Code block to check for a "supplied-from" string-array device property
> and populate the power_supply.supplied_from string array with its
> contents if found.
>=20
> If you can let me know how exactly you want to solve this I can whip
> up (and test) patch for this.

Adding this to non-DT power_supply_check_supplies() and naming the
property "supplied-from" sounds good.

-- Sebastian

--wpkx4opzo6bjcm7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHWVoACgkQ2O7X88g7
+prwBA//W531tIkwJnZwj/1FXya8zTkmPiEcuuM1JrTaEZNkofqeahmQhVDlJ8aR
/jeOoo+G4CmtPi5+8IvRRRS6iBgMaA+RjfatF46LsYEoJ3u9QQ//VwPcxF+vOw5h
jJHo+ZTP9kXPJncR4sVSDoM7PC3+tIlc05MoqrmTqiHNkVQoaCq5OLS6q3GrFTzR
Ve22bKD6nnZq2ZpErfPzGB08cqL0QPBl78cRHRq2+9bNsiOIRaLwHylt6OZ5a76A
0McrdKjmW5tOhuXvCepGhd1Z5fPRdXpPG/A1w9Yd+8rFBou5VdtHMGukOVlhiC0i
/kO6f2CXdO8YP/5D7PvxOY8hm+AQbWQVgay5QC6F79Zu1pELhhX9inU95dE5+yG7
iQtIJauFUcYidfizTHqBejQ1KxU2EZ/oGQp5bWMcLohDa0ymqVKAtgo46KwQcFJD
1lyBaob5tgAoJexn8Hf2MPIpa0DE42gH5lK+vKmUzuxYyCunV5Ts18oN+cX5vAA8
7emIKzzhgQuuWGqclknisOWoXyIiIqx1O59Nh8qxqM0My7PIBcrU21OK0us7yfkg
k7JODsxPAMmzZ3Hf88kIkOFxaLXNFOb/0J2RFePsPtZrzSxE4UWm6grZA4SYwn1w
7deD7oNBC4Ln86l9mEa/hv+Bk6szmmLb91QNgtA5fF//mHHc1hY=
=JCj0
-----END PGP SIGNATURE-----

--wpkx4opzo6bjcm7h--
