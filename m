From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [RFC PATCH 3/5] thermal: Add support for the thermal sensor on
 A23/33
Date: Tue, 28 Jun 2016 13:46:40 +0200
Message-ID: <20160628114640.GE5550@lukather>
References: <20160628101325.2522-1-icenowy@aosc.xyz>
 <20160628101325.2522-3-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0738689973533869486=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160628101325.2522-3-icenowy@aosc.xyz>
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, emilio@elopez.com.ar, mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, edubezval@gmail.com, wens@csie.org, robh+dt@kernel.org, rui.zhang@intel.com, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--===============0738689973533869486==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2qXFWqzzG3v1+95a"
Content-Disposition: inline


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for working on this.

On Tue, Jun 28, 2016 at 06:13:23PM +0800, Icenowy Zheng wrote:
> This patch adds support for the sun8iw3 thermal sensor on
> Allwinner A23/33 SoCs.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

The IP is awfully similar to the A31's, which already has a driver
(drivers/input/touchscreen/sun4i-ts.c).

There's no reason to add a new one here.

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--2qXFWqzzG3v1+95a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXcmOgAAoJEBx+YmzsjxAgCloP/RDSvYyA518FR5v7//CArHXA
lnT7ifb8uLBI1mCT+zGOOcjf21yY4R7Jms+OEhqMAMfhk/LLuFcK6naK6pCRBbdc
7c9uIjcYlDyQCuUWEae5pUJLpHV1oLydZ6oLKh+nQ6YRBgV5r//7z7utP4Efap11
TzHwe6P9OLYkqLcRt5m8ofHF+jeSMXmaCPiEgPeVJvaBuSi4bIc1rBXPQypri8Y0
tcbvktoVsbjJ9WVLhnk+KZQuR9O28bc0Mb6iscUEX1CV89T1O+zOCj+WE5xkc/cD
xjXL9L+wUdRx6KuH1x4F9kMi0fbmAg78vdXfRbf0SDfTCxPCt6xDZOhhOnO23MwQ
nr4Te9lMZUAjAHo+r4qxeLWCg5RORE10BfpGLgOMRRaESKqBZIgN36XoSK3aF/2D
nVpxgOBISlH0eFkAsQSMlIucFKWMj2vm0YpRL1FW51o7/fc0dzWGMSxN17xSmyhV
8I46kFehqH4rcYAJBnmt7ByhXC7JQOKzv5lnEgK1lpc9DLqVJdZyimOQNUkSdF6b
uYOnL6wPvCX1RkuIPq2j9R6wV/00jQrGT5m2kFnuyGhogX/0fV3/imdHISKDXCjU
g3osaLOxk4KMpzDEViU//5ykTi8M7943zNIXboVJxUAM5l4J72LZH1ERz8NnyP1F
MJl9wkGzjOx/h92stazQ
=wERd
-----END PGP SIGNATURE-----

--2qXFWqzzG3v1+95a--


--===============0738689973533869486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0738689973533869486==--
