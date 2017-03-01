From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 2/3] thermal: add support for the thermal sensor on
 Allwinner new SoCs
Date: Wed, 1 Mar 2017 16:56:06 +0100
Message-ID: <20170301155606.dkx3nfm4rkj2kewc@lukather>
References: <20170301132108.L3LK6WWv@smtp1h.mail.yandex.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8858907203287569530=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170301132108.L3LK6WWv@smtp1h.mail.yandex.net>
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


--===============8858907203287569530==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qoq7slwd2joajh2m"
Content-Disposition: inline


--qoq7slwd2joajh2m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 01, 2017 at 06:20:51PM +0800, Icenowy Zheng wrote:
>=20
> 2017=E5=B9=B43=E6=9C=881=E6=97=A5 18:14=E4=BA=8E Maxime Ripard <maxime.ri=
pard@free-electrons.com>=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Tue, Feb 28, 2017 at 03:18:13PM +0800, Icenowy Zheng wrote:=20
> > >=20
> > > 2017=E5=B9=B42=E6=9C=8828=E6=97=A5 14:44=E4=BA=8E Maxime Ripard <maxi=
me.ripard@free-electrons.com>=E5=86=99=E9=81=93=EF=BC=9A=20
> > > >=20
> > > > On Tue, Feb 28, 2017 at 03:40:53AM +0800, Icenowy Zheng wrote:=20
> > > > > From: Ondrej Jirman <megous@megous.com>=20
> > > > >=20
> > > > > Allwinner SoCs from H3 (including H5, A64, etc) have a new versio=
n of=20
> > > > > thermal sensor, and needs a new driver for it.=20
> > > > >=20
> > > > > Add such a driver.=20
> > > > >=20
> > > > > Currently only H3 is supported, but other SoCs are easily to be=
=20
> > > > > supported by adding new formula and set the sensor number.=20
> > > > >=20
> > > > > Signed-off-by: Ond=C5=99ej Jirman <megous@megous.com>=20
> > > > > [Icenowy: extend to support further multiple-sensor SoCs, change =
commit=20
> > > > >=C2=A0 message]=20
> > > > > Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>=20
> > > >=20
> > > > There's no need to create a new driver for that. This can be handle=
d=20
> > > > by the GPADC driver we already have.=20
> > >=20
> > > sun8i-ths is not GPADC at all.=20
> > >=20
> > > The latest SoC I know that use GPADC as thermal sensor is A33.=20
> >
> > It's not called the same way, but it definitely is an evolution of the=
=20
> > same controller. There's no need for a new driver, only reworking what=
=20
> > is already there.=20
>=20
> I don't think so -- here's some evidence:
>=20
> 1. The old GPADC do not have module clock.

The A33 could use a PLL.

> 2. The old GPADC do not have calibration stored in eFUSE.

The A33 had calibration data stored in the efuses.

> 3. R40 SoC have both RTP (it should be the old GPADC) and
> new-generation THS.

And this is probably just to be compatible with the A20.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--qoq7slwd2joajh2m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYtu8WAAoJEBx+YmzsjxAgU3AP/jcf+wtudZBUyNEn+c3kosVC
fWFRvRQrmD9ojWX1oh9koVilRhjqWaZ7rVwrbRQETutl9gJBaqc3JfZrx7G9Qx9Z
Dv2RMNCYP+lOhsxKc6/2nHu1aY1gFNcZ/ToicWD0uNvly25wUndTLN/aovS38v8J
1QFgE1PrrkXDi3iNpjby1t4ICEU7ijejgoWVn5UdoXPv5zu3amLRFShgm5eHSFfk
O2aPvM0D1N8kBhUJZmr/rOycSudDlkUV59uVMzMSb+d3ChMwLSCOI7LdVmqmw4PL
CsSkRtKChS5ieBKKm1hMhdjzbl/vZta7HgaTGA+pBg91AELCHv3VbjnknrLB1jtt
f1rb08z8CBfuOClYkB8V3+lDonRywaTR80OBpHZVBbLEZK8FHwBmZseybXyHCwtF
UJKQKkGah5Lmn83bd05inKrdBheM2vBWHzc4LwEaDF4dOLhN8EGw9zPpT97iLpf7
q6dN2n3WLs5ZlT4nyR1ujIJp2cJEUSGW855Pgvor7kwuZkupexb30u7vEkm43hxC
G7DxTdKLcN0Jt9SiCdspGCLWoLvrcSvTeWjdrQ0AJCRQ6keMvbuZtH4Q2+aytLuk
Sn/+YW9WZL6gykkxpJbXmPifh+7ikpOCvMXSz6gz2xpDglSilSHHCWec9+ANC4Hz
GTVw6xcKwhYc4aXdbgDp
=nEVk
-----END PGP SIGNATURE-----

--qoq7slwd2joajh2m--


--===============8858907203287569530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8858907203287569530==--
