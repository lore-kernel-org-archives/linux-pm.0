From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH resend v2] power: supply: bq27xxx: enable writing
 capacity values for bq27421
Date: Wed, 30 Aug 2017 02:37:45 +0200
Message-ID: <20170830003745.6iimg4zn2cuybp7n@earth>
References: <be410e440d889b2e46208b523bdb890e860c5046.1504037446.git.hns@goldelico.com>
 <CAKvHMgQDcgabM3UogXE3L07n9yiHgD3FfJ5GCOqkAk1=SA2A=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aex5j57exachm5ww"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKvHMgQDcgabM3UogXE3L07n9yiHgD3FfJ5GCOqkAk1=SA2A=Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: "H. Nikolaus Schaller" <hns@goldelico.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, "Andrew F. Davis" <afd@ti.com>, linux-pm@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com
List-Id: linux-pm@vger.kernel.org


--aex5j57exachm5ww
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 29, 2017 at 01:20:27PM -0700, Liam Breck wrote:
> Hi Nikolaus, thanks for the patch...
>=20
> On Tue, Aug 29, 2017 at 1:10 PM, H. Nikolaus Schaller <hns@goldelico.com>=
 wrote:
> > Tested on Pyra prototype with bq27421.
> >
> > Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> > ---
> >  drivers/power/supply/bq27xxx_battery.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/sup=
ply/bq27xxx_battery.c
> > index b6c3120ca5ad..e3c878ef7c7e 100644
> > --- a/drivers/power/supply/bq27xxx_battery.c
> > +++ b/drivers/power/supply/bq27xxx_battery.c
> > @@ -688,7 +688,7 @@ static struct bq27xxx_dm_reg bq27545_dm_regs[] =3D {
> >  #define bq27545_dm_regs 0
> >  #endif
> >
> > -#if 0 /* not yet tested */
> > +#if 1 /* tested on Pyra */
> >  static struct bq27xxx_dm_reg bq27421_dm_regs[] =3D {
>
> I think we can drop the #if and #else...#endif so it's just the
> dm_regs table, as with bq27425.

Yes, please.

-- Sebastian

--aex5j57exachm5ww
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlmmCNkACgkQ2O7X88g7
+pr0Wg//VpAriTqjKTRT/wrdVfVGKp9AfnqFFFcCJf4K67YZn0AXQow+ODrXlpwm
0t1VOXKj0gDyIBTYzrmqcsaFP4BtQCIJXCJRHDv9jorjhrYCZAbe4rZawqew6nSa
zf85a7+3z9KLTRwlAByo725HbBmTYek3r+t6YOHLWoCRXDObMAx4V2ZLx7Kf21Zx
DV/gHfIsueJQnQnybHxAqcTiWRu3XnF2X+h2iFNR/BBk1LOOosj9oqVw+DjwrPWo
fJRgSrBoTsP9zbj09l1MHbpKC8LUjZMCrTrvKEs0wUiSZCs5ZCoXVzERdIZsJpB5
hnXWp6gkcV1GDFOtEyha2GLeMnTDfda4/etoneFn3dZtu7wTIiSh/d6c3zFnanvc
jjk+7KdHWbnGBRRx9xrUvPJwrn9JrG8SZJ/uoMqFwYfbCHh27Sq35HFNfF+JSaxG
FxYITHJEqyrCFxl9PxuSwQwjVwsusAZNp/3GRNjTByBwxqovyRq1pZGrPJ0i/Tis
wWV4khX/MF814dYtMD1hflMTzNOgNMVqku06v8io+aA0YcFNQK9LAfDpTt1Oq/oF
InA59dmP+NCmAuSy6mows6CFZQzSPZDPO+ORhgZUbiEv6kRKKUXxtKMoZzbdpglW
GRwQvM2RLTACK93qoFZbZO+ArpoDtgTKz5C7G7oYp/CSJ4Vdn7A=
=DhwM
-----END PGP SIGNATURE-----

--aex5j57exachm5ww--
