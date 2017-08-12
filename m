From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC v2 3/5] power: supply: bq27xxx: Enable data memory update
 for certain chips
Date: Sat, 12 Aug 2017 14:57:55 -0400
Message-ID: <20170812185755.e2hfkboiirsxyk3v@earth>
References: <20170807062216.19988-1-liam@networkimprov.net>
 <20170807062216.19988-4-liam@networkimprov.net>
 <20170812160443.5fvelnzw5gzdgu5j@earth>
 <CAKvHMgRXAtgqzYOJg+NiWvS1-uDAx_YaOrqejGKyUedzzEZujQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="l5d7ifylmrlaorry"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750864AbdHLS55 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 12 Aug 2017 14:57:57 -0400
Content-Disposition: inline
In-Reply-To: <CAKvHMgRXAtgqzYOJg+NiWvS1-uDAx_YaOrqejGKyUedzzEZujQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-pm@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>, Liam Breck <kernel@networkimprov.net>


--l5d7ifylmrlaorry
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 12, 2017 at 11:00:46AM -0700, Liam Breck wrote:
> >> +#if 0 /* not yet tested */
> >> +static struct bq27xxx_dm_reg bq27500_dm_regs[] =3D {
> >> +     [BQ27XXX_DM_DESIGN_CAPACITY]   =3D { 48, 10, 2,    0, 65535 },
> >> +     [BQ27XXX_DM_DESIGN_ENERGY]     =3D { }, /* missing on chip */
> >> +     [BQ27XXX_DM_TERMINATE_VOLTAGE] =3D { 80, 48, 2, 1000, 32767 },
> >> +};
> >> +#else
> >> +#define bq27500_dm_regs 0
> >> +#endif
> >
> > I guess we can just drop the untested bits and add them once
> > somebody needs/tested them. The values are directly from the
> > datasheet anyways, right?
>=20
> These parameters are dispersed among lots of others in the datasheets,
> and the dispersion varies by datasheet, so not that easy to find. Can
> we leave them in?

sure, if it's hard to obtain them.

-- Sebastian

--l5d7ifylmrlaorry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmPT7AACgkQ2O7X88g7
+prBVRAAmJSaPB2HoVsHTaTervUinJwGNj/oYCTJszt94VKOlu+jV4zIJb8bHueV
h5E7CXK4eb+o3fQMRj305uPRr/9cFqMCM+uTVPG3QdfKEeZ/wrj5drw/t1dzyJDn
NUpy4R3j5/KwKLUrUfSUFzG9aK6iDg0m7bwhlUO4yWnNmu+WRBkj0wsueKXKjKhS
9kmAuDkUZJ9oGO84c1AY/Oa7sf6NWyFMFjfLVSEm9oYi8NK0i4JoxhOuq7laRkiC
8dPXlTLnRlmaxWEj7/8tGwgvlAmlml6OkiSks5zXElzS0xNTgz9Ni5mqV1kCoz97
ebHx/EliMwGq4nxowEh4Kn+YjM47Ma3hxDKZXBvk4F5jJcJMT07CgsK9hMs5KyNK
e8Ti1rsEA8dtErjN9QcE32HuGHw1sBui4UjV7UoeMUMg/uq39pNcmmkaZbueneyw
6Y+HbYZrGuhMK7w2VWuTqNdwFWYUzA1PTTczeStG3nhp3T7Jzd98dmZEmb33SIKK
7fjx6/7SZ5/D3MdegHs/Yqbv16yNs8qPcWjGhCOnofUDQ5I/ZRZl3c1yWOl/Ew0d
NcaYL+mBOpsKJ/F0mAM6gqjaLe1jqQCMthDSenWPKLsJPD59V9830NzZoowT8x0q
XeFPywpflPCtv5ivTaChoUgH3O+/l0kwbQc6xUxWZ1/2QLsHtTg=
=F9Sc
-----END PGP SIGNATURE-----

--l5d7ifylmrlaorry--
