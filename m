From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v3 0/5] bq27xxx_battery data memory update
Date: Tue, 29 Aug 2017 23:22:59 +0200
Message-ID: <20170829212259.gs4bljwscrprsfjl@earth>
References: <20170824033617.20840-1-liam@networkimprov.net>
 <20170829105413.6wbejdaxxxd6hk7b@earth>
 <0bf4ba2f-18f9-1204-8241-8acb6ac6f490@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ewnjxx5yrniqmvra"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57153 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751314AbdH2VXD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 29 Aug 2017 17:23:03 -0400
Content-Disposition: inline
In-Reply-To: <0bf4ba2f-18f9-1204-8241-8acb6ac6f490@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Liam Breck <liam@networkimprov.net>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>


--ewnjxx5yrniqmvra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[adding Julia to Cc for Coccinelle question]

Hi,

On Tue, Aug 29, 2017 at 10:31:57AM -0500, Andrew F. Davis wrote:
> On 08/29/2017 05:54 AM, Sebastian Reichel wrote:
> > On Wed, Aug 23, 2017 at 08:36:12PM -0700, Liam Breck wrote:
> >> Overview:
> >> * Reorganizes chip data definitions
> >> * Enables features landed in these patches:
> >>   dt-bindings: power: supply: bq27xxx: Add monitored-battery documenta=
tion
> >>   power: supply: bq27xxx: Add chip data memory read/write support
> >>   power: supply: bq27xxx: Add power_supply_battery_info support
> >> * Supports the following chips (only BQ27425 is active)
> >>   BQ27500, 545, 425, 421, 441, 621
> >>
> >> Changes in v3:
> >> * BQ27425 tested; workaround minor chip bug
> >> * Dropped driver_version
> >> * Fixed dbg_dupes logic for .props & .dm_regs
> >> * Dropped two props array dupes
> >>
> >> Changes in v2:
> >> * Added di->opts flags for remaining chip features
> >> * Commented out untested bq27xxx_dm_regs parameters
> >> * Changed dbg_dupes to run only once
> >>
> >> Notes on v1:
> >> * Not fully tested (hence RFC tag)
> >=20
> > Thanks, full series queued.
> >=20
> > -- Sebastian
> >=20
>=20
> Hold up, I'm just now seeing this series, looks like Liam left me out of
> the CC despite being a reviewer in the MAINTAINERS file.. (possibly due
> to me actually reviewing these patches and making him fix shit). I've
> actively NACK'd some of these changes previously, making this all the
> sneakier -_-

oh, I did not notice, that you are no longer Cc'd.

> Anyway, I've not got the time to fight these changes anymore, but at
> very least could you drop 4/5, it's static analysis code made into a
> runtime check built into a kernel driver, if not at least add my
> nacked-by. :)

Since it's not critical at all and nobody depends on it, I dropped 4/5
for now. I agree, that checking it at runtime is not nice. On the other
hand I do think a duplication check makes sense. Doing a static
check should be possible, but I have no idea how to implement this
(without much effort). I suspect Coccinelle can do it, so I added
Julia.

For reference this is the runtime check:
https://patchwork.kernel.org/patch/9918953/

-- Sebastian

> >> Liam Breck (5):
> >>   power: supply: bq27xxx: Create single chip data table
> >>   power: supply: bq27xxx: Add chip IDs for previously shadowed chips
> >>   power: supply: bq27xxx: Enable data memory update for certain chips
> >>   power: supply: bq27xxx: Flag identical chip data when in debug mode
> >>   power: supply: bq27xxx: Remove duplicate chip data arrays
> >>
> >>  drivers/power/supply/bq27xxx_battery.c     | 514 ++++++++++++++------=
---------
> >>  drivers/power/supply/bq27xxx_battery_i2c.c |  16 +-
> >>  include/linux/power/bq27xxx_battery.h      |  10 +-
> >>  3 files changed, 265 insertions(+), 275 deletions(-)
> >>
> >> --=20
> >> 2.13.2
> >>

--ewnjxx5yrniqmvra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlml2y4ACgkQ2O7X88g7
+ppsxg/+KWUau7Q3ouEHqHB3nD+kXz1ZLgRpQvCIfEyA1Cq2gZmXOAgzCPoIum8R
77+9DCAxzzkDKH01e9xZC+EB5UmTDJvwnkNrymrUU0bAkFt+I3xjscmjz2txIdQh
SYJHCTmAWRtPKSxzD5dAUjH5+Bfx4o92TU0isvFNMQIX6YpEDaslcRDLeIN1oN+d
Qz6MYRLyuGMe0V+sjSF6bG4/zGJJxTWCRys7wxpB2v3MBpVVAJQ/BM7Zl33VeLIm
YouJ0NepaZ1Rz9iMauiFqhNe3ziir1zB6VQSoIzfNxWwHtBfwGldwUOYBjHhEUqs
ffDJvsvE9PAWzaX61BMHuxNxBGcwYXmTAxRyK8y/IsgC9QzHDL/81AjLPXpgYWPB
R7/Ra1xyu6Z/ywTBjxa9jcnGt4n5gZ/sIQgYDYE38C/Ktw9Ek1rZYQH5vwskrLDc
HlS3TD+00phZ5E9NpVhmnhcEAjlyK4nvI0CCCw3aIMYqIroWmpSopghwbattIkhA
EzZJrTVxUTesOtLW9ZAT/dfY8gkUMie1OufuO5mvRv1tJEDZho4uRlFFpT58OQbx
LjnGozzLD6k7EKJ/G1bFuGRoLm+TGLsHEc+HFFeCpXyUXl8F9ij7PwTk9tFflDdB
VXlS2JK0yHk27eOXmU/Mn9wShGL6IRMWhk1/CseKhKRCLbJyHfQ=
=UTgs
-----END PGP SIGNATURE-----

--ewnjxx5yrniqmvra--
