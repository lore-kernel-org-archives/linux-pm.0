From: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: Add Spreadtrum SC27XX fuel gauge
 unit documentation
Date: Thu, 20 Sep 2018 02:46:12 +0200
Message-ID: <20180920004612.63biirau5qxnbxxo@earth.universe>
References: <1b3f165e2a806dd3d4b7712160ee3bda72f7d675.1536736399.git.baolin.wang@linaro.org>
 <20180916135721.rhu3rn4fsrmmgnbf@earth.universe>
 <CAMz4ku+4pJHivw2FLjtpaBs7yQxgDH-kZ3AgHWWQr5Lb_UcYwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xcwdf3hh3w7gnphb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMz4ku+4pJHivw2FLjtpaBs7yQxgDH-kZ3AgHWWQr5Lb_UcYwg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Craig Tatlor <ctatlor97@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>
List-Id: linux-pm@vger.kernel.org


--xcwdf3hh3w7gnphb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 17, 2018 at 11:43:30AM +0800, Baolin Wang wrote:
> Hi Sebastian,
>=20
> On 16 September 2018 at 21:57, Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> > Hi,
> >
> > On Wed, Sep 12, 2018 at 03:29:38PM +0800, Baolin Wang wrote:
> >> This patch adds the binding documentation for Spreadtrum SC27XX series=
 PMICs
> >> fuel gauge unit device, which is used to calculate the battery capacit=
y.
> >>
> >> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> >> ---
> >>  .../devicetree/bindings/power/supply/sc27xx-fg.txt |   55 +++++++++++=
+++++++++
> >>  1 file changed, 55 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/power/supply/sc2=
7xx-fg.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.=
txt b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
> >> new file mode 100644
> >> index 0000000..7447bae
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
> >> @@ -0,0 +1,55 @@
> >> +Spreadtrum SC27XX PMICs Fuel Gauge Unit Power Supply Bindings
> >> +
> >> +Required properties:
> >> +- compatible: Should be one of the following:
> >> +  "sprd,sc2720-fgu",
> >> +  "sprd,sc2721-fgu",
> >> +  "sprd,sc2723-fgu",
> >> +  "sprd,sc2730-fgu",
> >> +  "sprd,sc2731-fgu".
> >> +- reg: The address offset of fuel gauge unit.
> >> +- bat-detect-gpio: GPIO for battery detection.
> >> +- io-channels: Specify the IIO ADC channel to get temperature.
> >> +- io-channel-names: Should be "bat-temp".
> >> +- sprd,inner-resist: Specify the the battery inner resistance (mOhm).
> >
> > This should be a property of the battery.without the sprd, prefix.
>=20
> Right. But I did not find one proper property of the battery, so I
> will add one new standard property of battery

Thanks.

> named 'inner-resistance-microohm' in next version. Is it OK for you?

The proper suffix is -micro-ohms according to
Documentation/devicetree/bindings/property-units.txt

Also the proper English term is internal resistance as far
as I know (and Wikipedia also names it this way), so I
suggest to name the property 'internal-resistance-micro-ohms'.

> >> +- sprd,ocv-cap-table: Provide the battery capacity percent with corre=
sponding
> >> +  open circuit voltage (ocv) of the battery, which is used to look up=
 current
> >> +  battery capacity according to current baterry ocv values.
> >
> > This should also be part of the battery binding. I just reviewed a
> > patchset for the Qualcomm Battery Monitoring System, which needs the
> > same functionality. The Qualcomm binding is more advanced, but
> > should also support this simpler case. Thus I think it makes sense
> > to use its description as base for adding support for this feature
> > to Documentation/devicetree/bindings/power/supply/battery.txt
>=20
> That's great. But could you give me the link of Qualcomm binding,
> which I can change my bindings. Thanks for your comments.

https://patchwork.kernel.org/patch/10464633/

-- Sebastian

--xcwdf3hh3w7gnphb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlui7dQACgkQ2O7X88g7
+pqS/g/9FnEPHKRIBRw/MTICOD5x5VMJlGCPl5dqZfRkxQwLlwPCY3LnhrNjTE5e
i2xn34dV8o5jIMiZvrnbobBejknjl2w8wbRoXzFZaOurTT+in3ECEqGtL/7y/H6U
RI75GNgMcST4y+FRH0UCI3+6gg2gDmWKChzoBgLii71BFKTZlVmFzSjInIpr6bjV
xMbfz8eT5xV8iVdy6/GbDpV4+yHIko/MiMznf8GjaSHjhcF66f/HKegOqGauMXCt
yBaSC3nLhryGRLkdo08U1H2XYWJ3cD2P55Crix5Qlk8WR5bK/OGHEaHWsQPKqNgD
L9CBrytcHQP5BjCO/aTudt826n7NiPDAfk1+ACBwKV17yAd2nlWDVhi3X3fzRBts
IsWpytu2eYvT2Qb7A0AmHcoPV+2yIQ/EolNsf0HgA1cg7CKRg5B2jxWhXsV9w2SP
67JI3O/7xLh2gpkcxGkmeYhmJf27y1/kvp1Xtqak3IMCFk7oGq6MykKdErn9wBma
i1n4GNLcAMrgkaTJ1Uk6JFDjipsR0J+Vd2Vwqjau0MLdlefksZP9XdfRIMnBJqR3
nh/q7hI2bIkv8EY2ZpmAL+8Gibe2l9Y/71yuRy1+JQn5ZmXPNAk+m/XrpfW4l0DT
JE8YAs+Gzdp2OEdohymSzgaK5A8gogqchRqh/BOC+vc50c1GRH8=
=aiuD
-----END PGP SIGNATURE-----

--xcwdf3hh3w7gnphb--
