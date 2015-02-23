From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 2/3] power: mxs_power: add driver for mxs power
 subsystem
Date: Mon, 23 Feb 2015 16:38:12 +0100
Message-ID: <20150223153812.GA5499@earth>
References: <54C0AFE4.3020701@i2se.com>
 <20150125150431.GE2719@earth.universe>
 <1719204322.245040.1422301605670.JavaMail.open-xchange@oxbaltgw03.schlund.de>
 <20150127001629.GP21293@sirena.org.uk>
 <1954124242.301697.1422383709733.JavaMail.open-xchange@oxbaltgw09.schlund.de>
 <20150127194346.GN21293@sirena.org.uk>
 <443299280.47516.1422483725178.JavaMail.open-xchange@oxbaltgw03.schlund.de>
 <20150128225937.GA12749@earth.universe>
 <964800678.25817.1422996087477.JavaMail.open-xchange@oxbaltgw04.schlund.de>
 <1766258118.893447.1424429861770.JavaMail.open-xchange@oxbaltgw03.schlund.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1766258118.893447.1424429861770.JavaMail.open-xchange-h4m1HHXQYNGvCDav5jC2oMgmgJlYmuWJ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 20, 2015 at 11:57:41AM +0100, Stefan Wahren wrote:
> > power: power@80044000 {
> > compatible =3D "fsl,imx28-power"; /* handled by mxs_power.c */
> > #address-cells =3D <1>;
> > #size-cells =3D <1>;
> > reg =3D <0x80044000 0x2000>;
> > interrupts =3D <6>;
> > switching-frequency =3D <24000000>; /* new property */
> > ranges;
> >
> > reg_vddd: regulator@80044040 {
> > reg =3D <0x80044040 0x10>,
> > <0x80044010 0x10>,
> > <0x800440c0 0x10>;
> > reg-names =3D "base-address",
> > "v5ctrl-address",
> > "status-address";
> > compatible =3D "fsl,imx28-vddd"; /* handled by mxs-regulator.c */
> > regulator-name =3D "vddd";
> > regulator-min-microvolt =3D <1350000>;
> > regulator-max-microvolt =3D <1550000>;
> > vddd-supply =3D <&reg_vdda>;
> > };
> >
> > reg_vdda: regulator@80044050 {
> > reg =3D <0x80044050 0x10>,
> > <0x80044010 0x10>,
> > <0x800440c0 0x10>;
> > reg-names =3D "base-address",
> > "v5ctrl-address",
> > "status-address";
> > compatible =3D "fsl,imx28-vdda"; /* handled by mxs-regulator.c */
> > regulator-name =3D "vdda";
> > regulator-min-microvolt =3D <1725000>;
> > regulator-max-microvolt =3D <1950000>;
> > vdda-supply =3D <&reg_vddio>;
> > };
> >
> > reg_vddio: regulator@80044060 {
> > reg =3D <0x80044060 0x10>,
> > <0x80044010 0x10>,
> > <0x800440c0 0x10>;
> > reg-names =3D "base-address",
> > "v5ctrl-address",
> > "status-address";
> > compatible =3D "fsl,imx28-vddio"; /* handled by mxs-regulator.c */
> > regulator-name =3D "vddio";
> > regulator-min-microvolt =3D <3000000>;
> > regulator-max-microvolt =3D <3575000>;
> > regulator-microvolt-offset =3D <80000>;
> > };
> > };
> >
> > Please correct me if i'm wrong.
> >
> > Stefan
>=20
> Gentle Ping.

The binding looks ok to me. It would be nice to get an ACK of a DT
binding maintainer, though.

-- Sebastian

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU60lgAAoJENju1/PIO/qa0sMP/j5RAxqzBnPSGBF4cNJpqQwv
HBeooBRuNsbKzZH1KLg89Rkzp64OO07/irqQsPYgY6dmw+8NryjDEdhvNeM98Rbn
h9Pbf/6g+4UOEU7KAu5zToC/kdNN32Yod5CDomNh03ak8LOBQfump5fxUizaqEzI
R4mo8AD1mYaiDHwICdqqGQEY9+zcV+eSFlXBO/3wpGU8/VaIe5TlgMPtU1CxHC9K
z3xbVanB4l75RmQN9CFqbbzyp/TZOlJf44xAR6RvK560Kmw3W//hXB+9zEmuG1Wv
tI0J4sQ5X3gK5q7Ub4B6o5NBxbafKlG0iGPp/ZG+AfYJAKpGeHhEjNuJ7I7WYPUr
wyvhngyR+Whg8gZ1zJmUskkIaWoQNg396yzXJMNn2fMz7hhJs89uRmmQL+YXI0jY
HPl+kfZhgOLwgFaGClp3apFAoNro3XY8anA4AWCABlNG0y+R5KohAQwLnSf/427A
txHW4mDUbRD8WmwcjeBSdiFcWVICG/Emz6brP5Pzy7jcWEOQpydWKd2eACXKa5vH
aXjHL/WkV+V03CPzBrunaMgKOnVvc9UzqZ2C2CkRQIgnxNhznit4nziwNTzDJ7aj
gpgX0n3E8o3Yu5DRt/BMVoqTyMeoI4CcFw8Wrwnf8Ngz1+PN81em/2pikuKZxKts
T7fPll2wL/qP/4vPhVZL
=OxgP
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
