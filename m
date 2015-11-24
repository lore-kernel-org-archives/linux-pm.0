From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 1/5] ARM: dts: sun8i: Add SID node
Date: Tue, 24 Nov 2015 07:38:09 +0100
Message-ID: <20151124063808.GB32142@lukather>
References: <cover.1448263428.git.atx@atx.name>
 <b897b1c8741c8a871163b84d01b480f99329536d.1448263428.git.atx@atx.name>
 <20151123124356.GW32142@lukather>
 <CAGb2v65qfaTdQqXHD=-FHz1M1sHCTro97QETZUH=vA2BbRS+7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Cjvo8w+V8lMs5Jsv"
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGb2v65qfaTdQqXHD=-FHz1M1sHCTro97QETZUH=vA2BbRS+7A@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Josef Gajdusek <atx@atx.name>, linux-sunxi <linux-sunxi@googlegroups.com>, linux-clk <linux-clk@vger.kernel.org>, linux-pm@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, gpatchesrdh@mveas.com, Mike Turquette <mturquette@linaro.org>, Hans De Goede <hdegoede@redhat.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Emilio Lopez <emilio@elopez.com.ar>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-pm@vger.kernel.org


--Cjvo8w+V8lMs5Jsv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2015 at 11:13:13AM +0800, Chen-Yu Tsai wrote:
> Hi,
>=20
> On Mon, Nov 23, 2015 at 8:43 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Mon, Nov 23, 2015 at 09:02:48AM +0100, Josef Gajdusek wrote:
> >> Add a node describing the Security ID memory to the
> >> Allwinner H3 .dtsi file.
> >>
> >> Signed-off-by: Josef Gajdusek <atx@atx.name>
> >> ---
> >>  arch/arm/boot/dts/sun8i-h3.dtsi | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i=
-h3.dtsi
> >> index 0faa38a..58de718 100644
> >> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> >> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> >> @@ -359,6 +359,13 @@
> >>                       #size-cells =3D <0>;
> >>               };
> >>
> >> +             sid: eeprom@01c14000 {
> >> +                     compatible =3D "allwinner,sun4i-a10-sid";
> >> +                     reg =3D <0x01c14000 0x400>;
> >
> > The datasheet says it's 256 bytes wide, while the size here is of 1kB,
> > is it intentional?
>=20
> My H3 datasheet (v1.1) says its 1 kB wide.

Is it? in the Security ID section, it is said to be 2kb =3D=3D 256B wide.

> It'd be nice if Allwinner actually listed the "usable" E-fuse
> offsets and widths, instead of having us dig through the SDK code.

Yep.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--Cjvo8w+V8lMs5Jsv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWVAXQAAoJEBx+YmzsjxAgPQYP/iP6PvN/UMQmKwO0HR7KEgZw
Pwyg9fx0eoZkBqyS1chxiQ1ptFLKlEgHlorthCa5F67e+b1968vMrLYnZrALTDCO
zd+9ktnNAgU4QaHo6qbE0ThDkHd5qFd3bshnBijLnD2vEhWOjX6Ec1Y/XJoZDV1Y
FuezTZeyM2stHSoL+dLHw3XU2T6Zef2V5u0iqgStqzsdhwM5bo5+vi5srVKPzvnX
WZyRsJHhQ9v+1gcOLjx5RdVPe4egh/5WEGoCGdLb7c7dJF2CmQICdhyOA+r/Bhe5
Oi6F1N65bnEFss36dqDM+Ql6Z7xf39vI5aJ0vqtabUSPFLlVMwWf31Ezao1fQQNT
hHarPjEqMRCCYo9mpCrZnZnRc7eVI3WNwo4C6t0WYPb6Gyfp6X2rCThBp5QTGH54
fQJTm7rJ6hq94miYxpO6p6ldXIQOxK/BgBs5KeAuH8w6cnLj7t5eUCD1xoWeQ5li
7Kz5AfYgmyjR9nK1TT1COkQd37JDLKxq39dqrDWdJ4PLUrB6E78RuYvPlnD0Ebms
bzNW5ZQVXcBCCe7eRvmBHi327LhMZeXc81/qyzXwiAPu2s7bZA9N9oHsSh3op5RF
TJNca13GyCuKCP475gVEA8HhRZVLUZSM13TEuE5MH4rHxk2GI3NRyZEnPgcAsV0O
NYmbhaYx2Ac8spijiTEK
=hDTM
-----END PGP SIGNATURE-----

--Cjvo8w+V8lMs5Jsv--
