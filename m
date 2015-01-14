From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v3 09/16] dts: Documentation: Extending documentation
 entry for exynos-thermal
Date: Wed, 14 Jan 2015 15:01:12 -0400
Message-ID: <20150114190110.GA4105@developer>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1421242874-3425-1-git-send-email-l.majewski@samsung.com>
 <1421242874-3425-10-git-send-email-l.majewski@samsung.com>
 <20150114185223.GE3672@developer>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150114185223.GE3672@developer>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2015 at 02:52:25PM -0400, Eduardo Valentin wrote:
> On Wed, Jan 14, 2015 at 02:41:07PM +0100, Lukasz Majewski wrote:
> > Properties necessary for providing Exynos thermal configuration via dev=
ice
> > tree.
> >=20
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > ---
> > Changes for v3:
> > - New patch
> >=20
> > ---
> >  .../devicetree/bindings/thermal/exynos-thermal.txt      | 17 +++++++++=
++++++++
> >  1 file changed, 17 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/thermal/exynos-thermal.t=
xt b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> > index ae738f5..0f44932 100644
> > --- a/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> > +++ b/Documentation/devicetree/bindings/thermal/exynos-thermal.txt
> > @@ -39,6 +39,18 @@
> >  - vtmu-supply: This entry is optional and provides the regulator node =
supplying
> >  		voltage to TMU. If needed this entry can be placed inside
> >  		board/platform specific dts file.
> > +Following properties are mandatory (depending on SoC):
> > +- samsung,tmu_gain: Gain value for internal TMU operation.
> > +- samsung,tmu_reference_voltage: Value of TMU IP block's reference vol=
tage
> > +- samsung,tmu_noise_cancel_mode: Mode for noise cancellation
> > +- samsung,tmu_efuse_value: Default level of temperature - it is needed=
 when
> > +			   in factory fusing produced wrong value
> > +- samsung,tmu_min_efuse_value: Minimum temperature fused value
> > +- samsung,tmu_max_efuse_value: Maximum temperature fused value
> > +- samsung,tmu_first_point_trim: First point trimming value
> > +- samsung,tmu_second_point_trim: Second point trimming value
> > +- samsung,tmu_default_temp_offset: Default temperature offset
> > +- samsung,tmu_cal_type: Callibration type
> > =20
> >  Example 1):
> > =20
> > @@ -51,6 +63,7 @@ Example 1):
> >  		clock-names =3D "tmu_apbif";
> >  		status =3D "disabled";
> >  		vtmu-supply =3D <&tmu_regulator_node>;
> > +		#include "exynos4412-tmu-sensor-conf.dtsi"
> >  	};
> > =20
> >  Example 2):
> > @@ -61,6 +74,7 @@ Example 2):
> >  		interrupts =3D <0 58 0>;
> >  		clocks =3D <&clock 21>;
> >  		clock-names =3D "tmu_apbif";
> > +		#include "exynos5440-tmu-sensor-conf.dtsi"
>=20
> Did I miss something or at this point the above file does not exist yet?
>=20
> Please make sure each commit / patch is in a compilable/usable/working
> state.

I know this is a Documentation file, but the comment above still
applies.

>=20
> >  	};
> > =20
> >  Example 3): (In case of Exynos5420 "with misplaced TRIMINFO register")
> > @@ -70,6 +84,7 @@ Example 3): (In case of Exynos5420 "with misplaced TR=
IMINFO register")
> >  		interrupts =3D <0 184 0>;
> >  		clocks =3D <&clock 318>, <&clock 318>;
> >  		clock-names =3D "tmu_apbif", "tmu_triminfo_apbif";
> > +		#include "exynos4412-tmu-sensor-conf.dtsi"
> >  	};
> > =20
> >  	tmu_cpu3: tmu@1006c000 {
> > @@ -78,6 +93,7 @@ Example 3): (In case of Exynos5420 "with misplaced TR=
IMINFO register")
> >  		interrupts =3D <0 185 0>;
> >  		clocks =3D <&clock 318>, <&clock 319>;
> >  		clock-names =3D "tmu_apbif", "tmu_triminfo_apbif";
> > +		#include "exynos4412-tmu-sensor-conf.dtsi"
> >  	};
> > =20
> >  	tmu_gpu: tmu@100a0000 {
> > @@ -86,6 +102,7 @@ Example 3): (In case of Exynos5420 "with misplaced T=
RIMINFO register")
> >  		interrupts =3D <0 215 0>;
> >  		clocks =3D <&clock 319>, <&clock 318>;
> >  		clock-names =3D "tmu_apbif", "tmu_triminfo_apbif";
> > +		#include "exynos4412-tmu-sensor-conf.dtsi"
> >  	};
> > =20
> >  Note: For multi-instance tmu each instance should have an alias correc=
tly
> > --=20
> > 2.0.0.rc2
> >=20



--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUtrztAAoJEMLUO4d9pOJWdrIH/3gY36oWnqKWeNwxxC/Z9eX9
Dzbk/WBcBmWkvnCwitsxdLIAtfx9CgEQLtXoY91aY9qwoWAYO73AhMqj39EAdw0x
jeGXm665L8ig5lp2XXVBwqHnN7W8+X1j2qS3dB8RImhgUCQPLjz36f6bp9P90+ro
pkFrJfsV2XUSB8S2ifx/LMu/Da9PFkJ9VlXirp6dZWLd5Z2pdsLWQjFk2+LXAWiU
2zj3fTftncsJbkhJrTkKMVkaYQVStJHq7qbZ7ky2EA3RgHjyysILfRFMe6mwJCr/
ncn71GtKaPir14RSCyMSV94sbM3ydcUDxlc9JSVTXX93aPUSFsRIg9D3ELPYzQY=
=vOni
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
