From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 2/3] thermal: add support for the thermal sensor on
 Allwinner new SoCs
Date: Wed, 1 Mar 2017 11:14:56 +0100
Message-ID: <20170301101456.a745eghkjoz5zzk7@lukather>
References: <20170301054835.mUDm4hZv@smtp2m.mail.yandex.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2814144027513372952=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170301054835.mUDm4hZv@smtp2m.mail.yandex.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Icenowy Zheng <icenowy@aosc.xyz>
Cc: Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Valentin <edubezval@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============2814144027513372952==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3bewbit4du2nboip"
Content-Disposition: inline


--3bewbit4du2nboip
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2017 at 03:18:13PM +0800, Icenowy Zheng wrote:
>=20
> 2017=E5=B9=B42=E6=9C=8828=E6=97=A5 14:44=E4=BA=8E Maxime Ripard <maxime.r=
ipard@free-electrons.com>=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Tue, Feb 28, 2017 at 03:40:53AM +0800, Icenowy Zheng wrote:=20
> > > From: Ondrej Jirman <megous@megous.com>=20
> > >=20
> > > Allwinner SoCs from H3 (including H5, A64, etc) have a new version of=
=20
> > > thermal sensor, and needs a new driver for it.=20
> > >=20
> > > Add such a driver.=20
> > >=20
> > > Currently only H3 is supported, but other SoCs are easily to be=20
> > > supported by adding new formula and set the sensor number.=20
> > >=20
> > > Signed-off-by: Ond=C5=99ej Jirman <megous@megous.com>=20
> > > [Icenowy: extend to support further multiple-sensor SoCs, change comm=
it=20
> > >=C2=A0 message]=20
> > > Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>=20
> >
> > There's no need to create a new driver for that. This can be handled=20
> > by the GPADC driver we already have.=20
>=20
> sun8i-ths is not GPADC at all.
>=20
> The latest SoC I know that use GPADC as thermal sensor is A33.

It's not called the same way, but it definitely is an evolution of the
same controller. There's no need for a new driver, only reworking what
is already there.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--3bewbit4du2nboip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYtp8cAAoJEBx+YmzsjxAgZ0IP/0HAvNHaPhYU2o10C+Ls/ofn
6sTvk875Hba8mgND/7hQ4VJJ4aGqXHamXDZ4DtMyHtpgySBLBvM3MLg2cgPJzO0T
eFRMQUO8al5P/kuBzpOtNXwYCfZfmPqTBXGTg06wbk90MG0IMXWdaAhSFnU41Ub0
d/Y9lyW/vf1vRurcioHc8obsbLxn/ZVOoP4Ic/ivZTUaJrfpmoqxjrx4T1VGajgJ
MHOS8G1CuW9LgTGB5PIhqQHO2x7htWFQujJJ+gBI2cP0NYEdFuB6HMiydHC4/Ni6
KqeAgbNnL9wZKDPJTvznBaOvjSWsOijjnLlSh2y947seG5xW4thY1VjtqhG225Df
+C8QbfZQnYJn73TB9lHAlGpKWuxc5DwDbnYTDfGdkLz1yyOWXjF1az/7kYdcCq1Y
R/pjwe4Wg3K+fiO6SdnXcwMisIBEKg7bakt++IqQje3j3TH2uc1F5uuyCWMlizh+
WStd+dKpTDM1kAOFFgXo0XnKCtb2LFnD8DpYsO0J4vXv1l7ozMRwKUwi1cC3XChx
POWSOWeIrnmnitGrWeD8ZCErdrF69aYGR+/xZqWASTTkwXEV1JDLtyBDscmeBiyM
VcwQBir/aBn5aAHSF2gK5+RH4KJU3Ewx0ltg+Hw+T4wwNgPK9K2VrnIIjFkr/3M7
XG4kQrW5SJB50VNfnY+c
=bvLQ
-----END PGP SIGNATURE-----

--3bewbit4du2nboip--


--===============2814144027513372952==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2814144027513372952==--
