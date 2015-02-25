From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 1/2] thermal: exynos: Fix wrong control of power down
 detection mode for Exynos7
Date: Wed, 25 Feb 2015 15:01:38 -0400
Message-ID: <20150225190137.GI2306@developer.amazonguestwifi.org>
References: <1424753815-15113-1-git-send-email-cw00.choi@samsung.com>
 <1424753815-15113-2-git-send-email-cw00.choi@samsung.com>
 <20150225100330.0ef63a95@amdc2363>
 <CAM4voakf6oeSEdtGtHRzQ-tC6XMbsU+VNtBnqeed8J4btKA3Yg@mail.gmail.com>
 <20150225132508.5143c9cf@amdc2363>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zgY/UHCnsaNnNXRx"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150225132508.5143c9cf@amdc2363>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: l.majewski@majess.pl, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--zgY/UHCnsaNnNXRx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2015 at 01:25:08PM +0100, Lukasz Majewski wrote:
> Hi Eduardo,
>=20
> > Hi Lukasz,
> >=20
> > On Wed, Feb 25, 2015 at 2:33 PM, Lukasz Majewski
> > <l.majewski@samsung.com> wrote:
> > > Hi Abhilash,
> > >
> > >> This patch fixes the wrong control of PD_DET_EN (power down
> > >> detection mode) for Exynos7 because exynos7_tmu_control() always
> > >> enables the power down detection mode regardless 'on' parameter.
> > >>
> > >> Cc: Zhang Rui <rui.zhang@intel.com>
> > >> Cc: Eduardo Valentin <edubezval@gmail.com>
> > >> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> > >> ---
> > >>  drivers/thermal/samsung/exynos_tmu.c | 3 ++-
> > >>  1 file changed, 2 insertions(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/thermal/samsung/exynos_tmu.c
> > >> b/drivers/thermal/samsung/exynos_tmu.c index 933cd80..a60f527
> > >> 100644 --- a/drivers/thermal/samsung/exynos_tmu.c
> > >> +++ b/drivers/thermal/samsung/exynos_tmu.c
> > >> @@ -682,6 +682,7 @@ static void exynos7_tmu_control(struct
> > >> platform_device *pdev, bool on)
> > >>       if (on) {
> > >>               con |=3D (1 << EXYNOS_TMU_CORE_EN_SHIFT);
> > >> +             con |=3D (1 << EXYNOS7_PD_DET_EN_SHIFT);
> > >>               interrupt_en =3D
> > >>                       (of_thermal_is_trip_valid(tz, 7)
> > >>                       << EXYNOS7_TMU_INTEN_RISE7_SHIFT) |
> > >> @@ -704,9 +705,9 @@ static void exynos7_tmu_control(struct
> > >> platform_device *pdev, bool on) interrupt_en <<
> > >> EXYNOS_TMU_INTEN_FALL0_SHIFT; } else {
> > >>               con &=3D ~(1 << EXYNOS_TMU_CORE_EN_SHIFT);
> > >> +             con &=3D ~(1 << EXYNOS7_PD_DET_EN_SHIFT);
> > >>               interrupt_en =3D 0; /* Disable all interrupts */
> > >>       }
> > >> -     con |=3D 1 << EXYNOS7_PD_DET_EN_SHIFT;
> > >>
> > >>       writel(interrupt_en, data->base + EXYNOS7_TMU_REG_INTEN);
> > >>       writel(con, data->base + EXYNOS_TMU_REG_CONTROL);
> > >
> > > Could you test this patch if it isn't introducing any regression on
> > > your HW?
> >=20
> > The patch does not cause any regression on exynos7 and seems
> > logically correct.
> >=20
> > Tested-by: Abhilash Kesavan <a.kesavan@samsung.com>
> >=20
>=20
> Eduardo, it is up to you if you prefer to take this fix directly or via
> the new thermal-samsung tree ?
>=20
> From when shall I regard myself as a maintainer? :-)
>=20

Yeah. Go ahead and collect it.

>=20
> >=20
> > Regards,
> > Abhilash
> > >
> > > --
> > > Best regards,
> > >
> > > Lukasz Majewski
> > >
> > > Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
>=20
>=20
> --=20
> Best regards,
>=20
> Lukasz Majewski
>=20
> Samsung R&D Institute Poland (SRPOL) | Linux Platform Group

--zgY/UHCnsaNnNXRx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJU7hwGAAoJEMLUO4d9pOJW+RsH/2VBj6wQ7pv8BXCIZ6B4NjlE
h3YaNLHDxf26ASDVi8A1A+m5ZmtYXuRIJ4wK2le00D3h6x+SP8CYevE9uRsX2H3W
xO4r2iIMoXMUUrk+eiR2abiILOrov70aoSD0QkTCmuZ5hRJQJeQhdX6/e5uEKAU7
2JEvPytH+SpFVidyjQ7XFAQ5x8JM+3bswQuyi+svg/xelg8Va6Bib1p3lYOTTnv5
laLCugBViqAlqvvAQgHwSfP3GIQauQ2RqaKEWPCbjTCKRX1C/SH2UdznddZ/oFCK
1HZqw1uPRtqF3dQd0dTOr1HT+sqXD5wtV/O5ui0m3xQCtxZSbNAtL3bZ8nhlGxU=
=x+vi
-----END PGP SIGNATURE-----

--zgY/UHCnsaNnNXRx--
