From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/3] power_supply: bq27xxx_battery: Group register
 mappings into one table
Date: Fri, 10 Jun 2016 03:29:34 +0200
Message-ID: <20160610012934.GA5848@earth>
References: <20160531184500.10871-1-afd@ti.com>
 <20160531184500.10871-3-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6c2NcOVqGQ03X4Wi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160531184500.10871-3-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--6c2NcOVqGQ03X4Wi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 31, 2016 at 01:45:00PM -0500, Andrew F. Davis wrote:
> Currently for each device with a unique register map we have a named
> array that we then merge into a multidimensional array. Skip this
> middle step and apply the register arrays directly to the multi-array.

I applied the first two patches, but the third (this one) does not
compile for me:

  CC [M]  drivers/power/bq27xxx_battery.o
drivers/power/bq27xxx_battery.c:108:2: warning: braces around scalar initia=
lizer
  [BQ27000] =3D {
  ^
drivers/power/bq27xxx_battery.c:108:2: note: (near initialization for =E2=
=80=98bq27xxx_regs[1]=E2=80=99)
drivers/power/bq27xxx_battery.c:109:4: error: array index in non-array init=
ializer
   [BQ27XXX_REG_CTRL] =3D 0x00,
    ^
drivers/power/bq27xxx_battery.c:109:4: note: (near initialization for =E2=
=80=98bq27xxx_regs[1]=E2=80=99)
drivers/power/bq27xxx_battery.c:110:4: error: array index in non-array init=
ializer
   [BQ27XXX_REG_TEMP] =3D 0x06,
    ^
=2E..

-- Sebastian

--6c2NcOVqGQ03X4Wi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXWhfuAAoJENju1/PIO/qaHgAP/3GHbIxEXw07gkkUMdI8rFik
TjJrUE0HUMLFOWOz2JWLTtlAkkbAEjGMBPqNshmT/M/mVT96ekzacFn3JEmqVrlf
9AvcolDCvz2TfxUucF1TNKCv+hDZ5QFNX/GAFF5pMoOgLsJpLzl26/x/Xs4PNyY9
cDY9K1zM5lY6YSJteN+1lKk1eIro8ssXDRZhLLekPUxBeybcJU/cOjVuD7PE7ZpM
Sue3hznMPgHE7gsQcavQa+U1UnhchZ4s7l7S9/zzxqZFS4IUl6LcVSOx/9JEX8EA
T8+VvxkszNNWUfSJXgAE1C5JUouACM0AyxFrCTtiSObkHsxmF5TI3da15acYMV1l
Fc+H4KUhe9EIm/QnZExI0zImmLJ2r9TGpD3zdXKF1TaX0biW0A+Emf/CqsHeGfGE
h49B6dA/BfJXxUPG6PZ1g6B+gQT9OXF9CGDpJwBpdIO8IV+lP09wwpvFldH8HVwN
j6DFvbn1zaxsxx/1XPooaYPhh3ANFyoyACP/P1E65470jtKpaHx8Ry+9YDCfo54f
QitKLgkyoMz9vsJVeGmylPRUpj4Bm9GyNtD1uwaqH0V5kzGyc/1Mcb595HWEytZz
bPBakIW5tAcRgoEy4Mxc3VdAF5dfvssy66AwttwHbgAjyj3voEqMIb5Kp+3FF4ms
bIQ+YPJGN42R5sBc+aHN
=s/Nq
-----END PGP SIGNATURE-----

--6c2NcOVqGQ03X4Wi--
