From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v3 0/5] bq27xxx_battery data memory update
Date: Tue, 29 Aug 2017 12:54:13 +0200
Message-ID: <20170829105413.6wbejdaxxxd6hk7b@earth>
References: <20170824033617.20840-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2t3fv33v4nfrg3yj"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56164 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbdH2KyR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 06:54:17 -0400
Content-Disposition: inline
In-Reply-To: <20170824033617.20840-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>


--2t3fv33v4nfrg3yj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 23, 2017 at 08:36:12PM -0700, Liam Breck wrote:
> Overview:
> * Reorganizes chip data definitions
> * Enables features landed in these patches:
>   dt-bindings: power: supply: bq27xxx: Add monitored-battery documentation
>   power: supply: bq27xxx: Add chip data memory read/write support
>   power: supply: bq27xxx: Add power_supply_battery_info support
> * Supports the following chips (only BQ27425 is active)
>   BQ27500, 545, 425, 421, 441, 621
>=20
> Changes in v3:
> * BQ27425 tested; workaround minor chip bug
> * Dropped driver_version
> * Fixed dbg_dupes logic for .props & .dm_regs
> * Dropped two props array dupes
>=20
> Changes in v2:
> * Added di->opts flags for remaining chip features
> * Commented out untested bq27xxx_dm_regs parameters
> * Changed dbg_dupes to run only once
>=20
> Notes on v1:
> * Not fully tested (hence RFC tag)

Thanks, full series queued.

-- Sebastian

> Liam Breck (5):
>   power: supply: bq27xxx: Create single chip data table
>   power: supply: bq27xxx: Add chip IDs for previously shadowed chips
>   power: supply: bq27xxx: Enable data memory update for certain chips
>   power: supply: bq27xxx: Flag identical chip data when in debug mode
>   power: supply: bq27xxx: Remove duplicate chip data arrays
>=20
>  drivers/power/supply/bq27xxx_battery.c     | 514 ++++++++++++++---------=
------
>  drivers/power/supply/bq27xxx_battery_i2c.c |  16 +-
>  include/linux/power/bq27xxx_battery.h      |  10 +-
>  3 files changed, 265 insertions(+), 275 deletions(-)
>=20
> --=20
> 2.13.2
>=20

--2t3fv33v4nfrg3yj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmlR9IACgkQ2O7X88g7
+pqejw/+JQg41jPOb1fuu9zAba6QBtn76jSOoGwRV5y7pamVYEmtpOUsY6K+e4cf
cCwBLWVE7DpQpoAle6/qGYA4qQZZb3SWfiYw5lMeU5MErBUX4fqfvL8C5aaaMYvs
BmaRYy5t7snaRyZwC4IWAD9janvr1bONw4HsVvadLIXGZoDjidfv1n4uPSA4lJLo
sETpESEdLS8cQWwmfYAh1kCZG5qWvRJDE+kqqSjH0BDHSpGlhoH8e7lYzLl0oC61
/Cj1XSwqSC0vTPUXZwcYkdBVl8eLahp85zcqc/EJARPqrcQRa/QuBUB57oc9J08P
x/HJgOc/OUM9oPsnAKOxM+5lnq18btVh9yoceYIGt+/JJEpl96roDLEHj/JmuyVw
8ztFOBWLGPi2gzt9tMLL/ZJ23HHhJkeBNY45qdDvRaG3PkWg9FYMPk7aZp0UhEeX
gVn8F11kzLFZ0LXi6KIRqHHJ5WvpFq/u14i2Rgz65NRz3bXOkLkfEISqOFnN0yPl
eYZFhpXVTSXSdzYsA3MzebrT58M+sNrcraQIIRMEqzscNcjuDEFyXS0V+FzYy7uP
KCU1TaWl7SrigXk73iEZ9mm6UaEaScCvuAz/2HLp0uwf4WIK7GSDB2iL3KBkK3bg
3czKWLOLB+UX89O8u+4XYbX5xU9YJ+804Uwf5TQuhaRxOOKcBJA=
=I72i
-----END PGP SIGNATURE-----

--2t3fv33v4nfrg3yj--
