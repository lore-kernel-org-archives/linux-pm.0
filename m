From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v14 09/11] power: supply: bq27xxx: Enable data memory
 update for certain chips
Date: Fri, 16 Jun 2017 12:33:07 +0200
Message-ID: <20170616103307.bfl6ig66qeq2qvz6@earth>
References: <20170607183759.20261-1-liam@networkimprov.net>
 <20170607183759.20261-10-liam@networkimprov.net>
 <20170615160218.sq5jychjn7x2dhyq@earth>
 <CAKvHMgT-QW1GXizipj0bRk7DMhwv=NsZJnvoQ_9OEjf_MgfJgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jowytsqbgm5vjs6q"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47732 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752589AbdFPKdL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Jun 2017 06:33:11 -0400
Content-Disposition: inline
In-Reply-To: <CAKvHMgT-QW1GXizipj0bRk7DMhwv=NsZJnvoQ_9OEjf_MgfJgg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Pali Rohar <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Enric Balletbo <enric.balletbo@collabora.com>, Paul Kocialkowski <contact@paulk.fr>, Quentin Schulz <quentin.schulz@free-electrons.com>, Liam Breck <kernel@networkimprov.net>


--jowytsqbgm5vjs6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Liam,

On Fri, Jun 16, 2017 at 02:21:42AM -0700, Liam Breck wrote:
> On Thu, Jun 15, 2017 at 9:02 AM, Sebastian Reichel
> <sebastian.reichel@collabora.co.uk> wrote:
> > On Wed, Jun 07, 2017 at 11:37:57AM -0700, Liam Breck wrote:
> >>  static const struct i2c_device_id bq27xxx_i2c_id_table[] =3D {
> >> -     { "bq27200", BQ27000 },
> >> -     { "bq27210", BQ27010 },
> >> -     { "bq27500", BQ2750X },
> >> -     { "bq27510", BQ2751X },
> >> -     { "bq27520", BQ2751X },
> >> -     { "bq27500-1", BQ27500 },
> >> -     { "bq27510g1", BQ27510G1 },
> >> -     { "bq27510g2", BQ27510G2 },
> >> -     { "bq27510g3", BQ27510G3 },
> >> -     { "bq27520g1", BQ27520G1 },
> >> -     { "bq27520g2", BQ27520G2 },
> >> -     { "bq27520g3", BQ27520G3 },
> >> -     { "bq27520g4", BQ27520G4 },
> >> -     { "bq27530", BQ27530 },
> >> -     { "bq27531", BQ27530 },
> >> -     { "bq27541", BQ27541 },
> >> -     { "bq27542", BQ27541 },
> >> -     { "bq27546", BQ27541 },
> >> -     { "bq27742", BQ27541 },
> >> -     { "bq27545", BQ27545 },
> >> -     { "bq27421", BQ27421 },
> >> -     { "bq27425", BQ27421 },
> >> -     { "bq27441", BQ27421 },
> >> -     { "bq27621", BQ27421 },
> >> +     /* dest.    di->real_chip       di->chip      */
> >> +     { "bq27200",   (BQ27000   << 16) |  BQ27000   },
> >> +     { "bq27210",   (BQ27010   << 16) |  BQ27010   },
> >> +     { "bq27500",   (BQ2750X   << 16) |  BQ2750X   },
> >> +     { "bq27510",   (BQ2751X   << 16) |  BQ2751X   },
> >> +     { "bq27520",   (BQ2752X   << 16) |  BQ2751X   },
> >> +     { "bq27500-1", (BQ27500   << 16) |  BQ27500   },
> >> +     { "bq27510g1", (BQ27510G1 << 16) |  BQ27510G1 },
> >> +     { "bq27510g2", (BQ27510G2 << 16) |  BQ27510G2 },
> >> +     { "bq27510g3", (BQ27510G3 << 16) |  BQ27510G3 },
> >> +     { "bq27520g1", (BQ27520G1 << 16) |  BQ27520G1 },
> >> +     { "bq27520g2", (BQ27520G2 << 16) |  BQ27520G2 },
> >> +     { "bq27520g3", (BQ27520G3 << 16) |  BQ27520G3 },
> >> +     { "bq27520g4", (BQ27520G4 << 16) |  BQ27520G4 },
> >> +     { "bq27530",   (BQ27530   << 16) |  BQ27530   },
> >> +     { "bq27531",   (BQ27531   << 16) |  BQ27530   },
> >> +     { "bq27541",   (BQ27541   << 16) |  BQ27541   },
> >> +     { "bq27542",   (BQ27542   << 16) |  BQ27541   },
> >> +     { "bq27546",   (BQ27546   << 16) |  BQ27541   },
> >> +     { "bq27742",   (BQ27742   << 16) |  BQ27541   },
> >> +     { "bq27545",   (BQ27545   << 16) |  BQ27545   },
> >> +     { "bq27421",   (BQ27421   << 16) |  BQ27421   },
> >> +     { "bq27425",   (BQ27425   << 16) |  BQ27421   },
> >> +     { "bq27441",   (BQ27441   << 16) |  BQ27421   },
> >> +     { "bq27621",   (BQ27621   << 16) |  BQ27421   },
> >
> > This is ugly. The proper way to do this is by providing a pointer
> > to a structure with all required information. E.g.:
> >
> > static const struct bq27xxx_pdata chip_info_bq27530 {
> >     .reg_layout =3D &reg_info_bq27530,
> >     .feature =3D false,
> >     /* more stuff */
> > };
> >
> > static const struct bq27xxx_pdata chip_info_bq27531 {
> >     .reg_layout =3D &reg_info_bq27530,
> >     .feature =3D true,
> >     /* more stuff */
> > };
> >
> > /* ... */
> >
> > static const struct i2c_device_id bq27xxx_i2c_id_table[] =3D {
> > /* ... */
> > { "bq27530", &chip_info_bq27530 },
> > { "bq27531", &chip_info_bq27531 },
> > /* ... */
> > }
>=20
> How's this...
>
> static const struct bq27xxx_chip_ids[] =3D {
>   [BQ27425] =3D { .chip =3D BQ27421, .real_chip =3D BQ27425 },
>   ...
> }
>=20
> static const struct i2c_device_id bq27xxx_i2c_id_table[] =3D {
>   { "bq27425", &bq27xxx_chip_ids[BQ27425] },
> ...

That's better, but let's get rid of real_chip. Just add the required
information directly to the above struct (e.g. seal_key, ramtype).

-- Sebastian

--jowytsqbgm5vjs6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllDs+AACgkQ2O7X88g7
+ppidQ//QLJ2T42lOv+jmFJzZU2qYPQ4lp0IcmphquMoLoKHI29a7TPuDo7Pusuk
o2/xAwTFdOxMJeKbKZt8XFhlmOh4LJ3GNT9/bbEGLA/5U1eQlV6r/Nuw+013Eeyy
1sofLggFEoOZVUiKYXUIDtP4vHKeq/2QpNEqQKWEdOuQdDhls48+o4tWTJQp8JHC
pbUKD+EfnRcjSdlkBKAhKfvoYT747yacLSUTu/1HFmC3Eq0bzFfeCnR+DruyDg1X
R2NlSKuJjh/rghyy42Xxb1H+dHcvcstuNU+zlvbZupYaqsKOMZn4QI/Q8G29v3CR
++hEUSeXiPH25hX7H6nJlhiy3qHMzVGWUzJ3MPzmAA7ylZYP1M88GEqLEXlmUkpE
ONfygUewRwmJkervmiX8WN0qx/D65xwZY3s59fMWi6H2ep/4uE0JPH4j5EGgAe9A
iuvgaYto2vtklJbuwpb/LLZzOKT+/BFDlc/TmTJmNEuyQPCIVNsE+6YZODKE75t6
r+4tNcQw4eRRH8WWbHKrtPGC14TWJJ8Wx0q9Z38jg80TsnKwHqf3oYHcUJ8y1zbn
ODrSC573hWhhopBeQJDeurh3DATXMYL5PKLX8XqLVWp429l03mvn5uSSxDUkO1fe
OBiUienH79eD5SGh3ua9AwnG0egOKDyXglcxjVXd5+36ZAvuDh8=
=rBnA
-----END PGP SIGNATURE-----

--jowytsqbgm5vjs6q--
