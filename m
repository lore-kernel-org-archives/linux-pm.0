From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC v2 2/5] power: supply: bq27xxx: Add chip IDs for previously
 shadowed chips
Date: Sat, 12 Aug 2017 14:45:27 -0400
Message-ID: <20170812184526.v5ewwm2q5vkm7eh4@earth>
References: <20170807062216.19988-1-liam@networkimprov.net>
 <20170807062216.19988-3-liam@networkimprov.net>
 <20170812150243.yglsy42mpigff6gw@earth>
 <CAKvHMgQciRY+v0prYsfcLUOGcgzz9RRmMawwBMuKF60qC8U4Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o2vh4ahaxwvolpp7"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbdHLSp2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 12 Aug 2017 14:45:28 -0400
Content-Disposition: inline
In-Reply-To: <CAKvHMgQciRY+v0prYsfcLUOGcgzz9RRmMawwBMuKF60qC8U4Rg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>, Liam Breck <kernel@networkimprov.net>


--o2vh4ahaxwvolpp7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 12, 2017 at 10:56:09AM -0700, Liam Breck wrote:
> Hi Sebastian,
>=20
> On Sat, Aug 12, 2017 at 8:02 AM, Sebastian Reichel <sre@kernel.org> wrote:
> > Hi,
> >
> > On Sun, Aug 06, 2017 at 11:22:13PM -0700, Liam Breck wrote:
> >> From: Liam Breck <kernel@networkimprov.net>
> >>
> >> For the existing feature set, these chips act like ones already listed,
> >> so they had been given false but functional IDs. We will be adding fea=
tures
> >> which obsolete that shadowing, so the following IDs are added:
> >> BQ2752X, 531, 542, 546, 742, 425, 441, 621
> >
> > Patch looks ok, but the patch description does not match the patch?
>=20
> Does this clarify it?
>=20
> For the existing driver features, the chips below act like others already=
 ID'd,
> so they had been given false but functional IDs. We will be adding featur=
es
> which obsolete that ID shadowing, so the following IDs are added:
> BQ2752X, 531, 542, 546, 742, 425, 441, 621
>
> >> Chip-specific features are now tracked by BQ27XXX_O_* flags in di->opt=
s.
> >>
> >> No functional changes to the driver.

I was too tired when I read that yesterday in the airplane. I'm
fine with both texts and throw in a third suggestion:

Add explicit chip IDs for some chips, that are currently using a
compatible chip ID. This is required due to incompatible advanced
features, that will be added later. To keep chip handling simple,
the chip features are now tracked using flags in di->opts. Driver
functionality is not supposed to change.

Choose the one you like most.

-- Sebastian

--o2vh4ahaxwvolpp7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmPTMQACgkQ2O7X88g7
+prapRAAkjCDfiRopsnc4vfcUrlpWjqynyJTk5avZBU+PGCN/41kYjuMSJDAc1h5
Qj/UqZA5JUrFxBwDBSkCxn2vDRVmMxyaS6+OAPkLYafWg8kcBAQ2at0zTw+ndj1D
1kkFJ3dmVMH1WECS8Cg5xRXA/DVbez+I+10wqlRilLThWHuD+nNY2STLtVYMxpSY
IDnr09eQwbmFyims34wkx30jOU2Sxb6PRPBlcpdz/Z9bVzmOHzteeuw9/Rgp5eMS
sO84LIPccxwij8WMzlYWzk6A0D8JLIxWUGjptGLWWQWrNxck1Vu1wmV865wfciF0
M87pw2pKAUxXjAoujW0E639I0+nKoI2thgDC3j4ece8LwHiMtWwrPSb9DnmNyYxv
W0C7Z91pNUWXAkvhNFV+jx4gF1H9jF94bZrNvcYIJJNqlC5BUYckMT2G8hRCIVM3
Aue/K4IGjMCk0A4nfZke3UpXDewDkckQz1mdeTByJr3d8ZiKbG+/5qKYS9ns7bVP
cuQ1Ss2nryyMwJtijoABTd7CXqX7kPOGQcgNuSKvZhvQKu426UtTyfkjT7rmYrGV
0e3wTpbYRUs8PwjwVGFAKRHbjordOSx9dO5qlCyEHRD8T3wrO69TXSy9euBoPGP8
DsqVjzzExHj382+T9wXAA1Ky590qoZ24sEVCWLZV6IaZYsgTLE0=
=y0dQ
-----END PGP SIGNATURE-----

--o2vh4ahaxwvolpp7--
