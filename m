From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v14 09/11] power: supply: bq27xxx: Enable data memory
 update for certain chips
Date: Mon, 3 Jul 2017 18:48:34 +0200
Message-ID: <20170703164833.govvgqz7xxbeuycv@earth>
References: <20170607183759.20261-1-liam@networkimprov.net>
 <20170607183759.20261-10-liam@networkimprov.net>
 <20170615160218.sq5jychjn7x2dhyq@earth>
 <CAKvHMgT-QW1GXizipj0bRk7DMhwv=NsZJnvoQ_9OEjf_MgfJgg@mail.gmail.com>
 <20170616103307.bfl6ig66qeq2qvz6@earth>
 <CAKvHMgSP6KR+4LRb0p3amAXyD=-r6Ap_i06cTffhnVOvE7NLJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oojayy5ep46mm5e6"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52993 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751960AbdGCQsi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2017 12:48:38 -0400
Content-Disposition: inline
In-Reply-To: <CAKvHMgSP6KR+4LRb0p3amAXyD=-r6Ap_i06cTffhnVOvE7NLJQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Pali Rohar <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Enric Balletbo <enric.balletbo@collabora.com>, Paul Kocialkowski <contact@paulk.fr>, Quentin Schulz <quentin.schulz@free-electrons.com>, Liam Breck <kernel@networkimprov.net>


--oojayy5ep46mm5e6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jun 16, 2017 at 04:32:13AM -0700, Liam Breck wrote:
> On Fri, Jun 16, 2017 at 3:33 AM, Sebastian Reichel
> <sebastian.reichel@collabora.co.uk> wrote:
> > Hi Liam,
> >
> > On Fri, Jun 16, 2017 at 02:21:42AM -0700, Liam Breck wrote:
> >> On Thu, Jun 15, 2017 at 9:02 AM, Sebastian Reichel
> >> <sebastian.reichel@collabora.co.uk> wrote:
> >> > On Wed, Jun 07, 2017 at 11:37:57AM -0700, Liam Breck wrote:
> >> >>  static const struct i2c_device_id bq27xxx_i2c_id_table[] =3D {
> >> >> -     { "bq27200", BQ27000 },
> >> >> -     { "bq27210", BQ27010 },
> >> >> -     { "bq27500", BQ2750X },
> >> >> -     { "bq27510", BQ2751X },
> >> >> -     { "bq27520", BQ2751X },
> >> >> -     { "bq27500-1", BQ27500 },
> >> >> -     { "bq27510g1", BQ27510G1 },
> >> >> -     { "bq27510g2", BQ27510G2 },
> >> >> -     { "bq27510g3", BQ27510G3 },
> >> >> -     { "bq27520g1", BQ27520G1 },
> >> >> -     { "bq27520g2", BQ27520G2 },
> >> >> -     { "bq27520g3", BQ27520G3 },
> >> >> -     { "bq27520g4", BQ27520G4 },
> >> >> -     { "bq27530", BQ27530 },
> >> >> -     { "bq27531", BQ27530 },
> >> >> -     { "bq27541", BQ27541 },
> >> >> -     { "bq27542", BQ27541 },
> >> >> -     { "bq27546", BQ27541 },
> >> >> -     { "bq27742", BQ27541 },
> >> >> -     { "bq27545", BQ27545 },
> >> >> -     { "bq27421", BQ27421 },
> >> >> -     { "bq27425", BQ27421 },
> >> >> -     { "bq27441", BQ27421 },
> >> >> -     { "bq27621", BQ27421 },
> >> >> +     /* dest.    di->real_chip       di->chip      */
> >> >> +     { "bq27200",   (BQ27000   << 16) |  BQ27000   },
> >> >> +     { "bq27210",   (BQ27010   << 16) |  BQ27010   },
> >> >> +     { "bq27500",   (BQ2750X   << 16) |  BQ2750X   },
> >> >> +     { "bq27510",   (BQ2751X   << 16) |  BQ2751X   },
> >> >> +     { "bq27520",   (BQ2752X   << 16) |  BQ2751X   },
> >> >> +     { "bq27500-1", (BQ27500   << 16) |  BQ27500   },
> >> >> +     { "bq27510g1", (BQ27510G1 << 16) |  BQ27510G1 },
> >> >> +     { "bq27510g2", (BQ27510G2 << 16) |  BQ27510G2 },
> >> >> +     { "bq27510g3", (BQ27510G3 << 16) |  BQ27510G3 },
> >> >> +     { "bq27520g1", (BQ27520G1 << 16) |  BQ27520G1 },
> >> >> +     { "bq27520g2", (BQ27520G2 << 16) |  BQ27520G2 },
> >> >> +     { "bq27520g3", (BQ27520G3 << 16) |  BQ27520G3 },
> >> >> +     { "bq27520g4", (BQ27520G4 << 16) |  BQ27520G4 },
> >> >> +     { "bq27530",   (BQ27530   << 16) |  BQ27530   },
> >> >> +     { "bq27531",   (BQ27531   << 16) |  BQ27530   },
> >> >> +     { "bq27541",   (BQ27541   << 16) |  BQ27541   },
> >> >> +     { "bq27542",   (BQ27542   << 16) |  BQ27541   },
> >> >> +     { "bq27546",   (BQ27546   << 16) |  BQ27541   },
> >> >> +     { "bq27742",   (BQ27742   << 16) |  BQ27541   },
> >> >> +     { "bq27545",   (BQ27545   << 16) |  BQ27545   },
> >> >> +     { "bq27421",   (BQ27421   << 16) |  BQ27421   },
> >> >> +     { "bq27425",   (BQ27425   << 16) |  BQ27421   },
> >> >> +     { "bq27441",   (BQ27441   << 16) |  BQ27421   },
> >> >> +     { "bq27621",   (BQ27621   << 16) |  BQ27421   },
> >> >
> >> > This is ugly. The proper way to do this is by providing a pointer
> >> > to a structure with all required information. E.g.:
> >> >
> >> > static const struct bq27xxx_pdata chip_info_bq27530 {
> >> >     .reg_layout =3D &reg_info_bq27530,
> >> >     .feature =3D false,
> >> >     /* more stuff */
> >> > };
> >> >
> >> > static const struct bq27xxx_pdata chip_info_bq27531 {
> >> >     .reg_layout =3D &reg_info_bq27530,
> >> >     .feature =3D true,
> >> >     /* more stuff */
> >> > };
> >> >
> >> > /* ... */
> >> >
> >> > static const struct i2c_device_id bq27xxx_i2c_id_table[] =3D {
> >> > /* ... */
> >> > { "bq27530", &chip_info_bq27530 },
> >> > { "bq27531", &chip_info_bq27531 },
> >> > /* ... */
> >> > }
> >>
> >> How's this...
> >>
> >> static const struct bq27xxx_chip_ids[] =3D {
> >>   [BQ27425] =3D { .chip =3D BQ27421, .real_chip =3D BQ27425 },
> >>   ...
> >> }
> >>
> >> static const struct i2c_device_id bq27xxx_i2c_id_table[] =3D {
> >>   { "bq27425", &bq27xxx_chip_ids[BQ27425] },
> >> ...
> >
> > That's better, but let's get rid of real_chip. Just add the required
> > information directly to the above struct (e.g. seal_key, ramtype).
>=20
> I don't think the new chip data belongs in bq27*_i2c.c.
> All the (extensive) existing chip data is in the main file.

Obviously. That's how it works when you supply a chip_id instead
of a pointer to the chip_info. bq27xxx outgrew being simple enough
to just provide a chip_id.

> A later patch could rework the chip data scheme; I was trying to
> minimize changes in this one.

Trying to generate small changes is appreciated, creating hacks is
not.

> The original i2c table did a real_chip
> -> chip mapping. Now we're just carrying real_chip forward.
>=20
> The easiest fix would be to define a macro which does << and |
>
> { "bq27621",   BQ27XXX_ID_PAIR(BQ27621, BQ27421) },

We do not want the easiest hack adding support, but a clean solution
acceptable for the mainline kernel. I consider the real_chip stuff
not very readable^W^W^W a huge mess.

-- Sebastian

--oojayy5ep46mm5e6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlladV8ACgkQ2O7X88g7
+ppq/g/9EGT7nDRfuMlbn69RYPqQnqeeab70BsGgvzZoA6B1WVh9Wu04exa7j2Ge
o35J+M058Ei/7zlHdXfStNyLPd8kh5WblADYFyj+ImfuvuglvXQf3g2/GNvRZnW3
uTP5bP4UAZUJBnsCDVc7r5ZNMk/PeeoXEh5tfxdMX9HvcLgUq8wOb6I0uJeDzrNL
Mn7KQ/idyHDxnooPflSb3T54BBmQJJqe13mL80oBhKSd4OQ3xPepYCNzHNcKYyf9
bwFGWwdHDFnznCsC2jrqdRCh7D11wtYiHq5iu2SW/G8LaHGrfR6pvuVmNAyDUb31
MrBNBaEmI6SUiCI0uiYk+P387pttFBF9z7siQarumHgOawIBEHYJFZcHaAeG4Lnl
o6+L48VCcxFDfiF4ZJH3m+gdDPbwkEYp+Z/Kh2o5IJFd0+SFELgz9/Mj6iAdkDWZ
K60G23Sphz2Txm81G4xE9V1q52tGl/RrPky1cyPXN8qyjp3GklNXP3Ommw4s9TOu
fuQOe1rCsynqDY9g/ocN9dxM6YE86YY0Wf/Ky3UI7V8p24v1oH5zysPTvoi2hTDv
BX4cjdwjm8Qpiduo4/0pq6vMpA2dXtwjThH2IVIBYZOV64c+hki99I/RLipL/d0y
rXltwcFg+MLFh5o5WMjAMLLfEPF0bvAPq5Oqsiz9GGdG/+F1qkw=
=CNgm
-----END PGP SIGNATURE-----

--oojayy5ep46mm5e6--
