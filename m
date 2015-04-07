From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: Document the hi6220 thermal sensor
 bindings
Date: Mon, 6 Apr 2015 21:27:28 -0700
Message-ID: <20150407042727.GA30242@localhost.localdomain>
References: <1427785162-15172-1-git-send-email-kong.kongxinwei@hisilicon.com>
 <1427785162-15172-2-git-send-email-kong.kongxinwei@hisilicon.com>
 <20150406140355.GI30984@beef>
 <5523530E.3000400@hisilicon.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5523530E.3000400@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: Matt Porter <mporter@konsulko.com>, rui.zhuang@intel.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linuxarm@huawei.com, xuwei5@hisilicon.com, linux-kernel@vger.kernel.org, jorge.ramirez-ortiz@linaro.org, xweikong@hotmail.com, liguozhu@hisilicon.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2015 at 11:46:22AM +0800, Xinwei Kong wrote:
>=20
>=20
> On 2015/4/6 22:03, Matt Porter wrote:
> > On Tue, Mar 31, 2015 at 02:59:21PM +0800, Xinwei Kong wrote:
> >> From: kongxinwei <kong.kongxinwei@hisilicon.com>
> >>
> >> This adds documentation of device tree bindings for the
> >> thermal sensor controller of hi6220 SoC.
> >>
> >> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> >> Signed-off-by: kongxinwei <kong.kongxinwei@hisilicon.com>
> >> ---
> >>  .../bindings/thermal/hisilicon-thermal.txt         | 45 +++++++++++++=
+++++++++
> >>  1 file changed, 45 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/thermal/hisilico=
n-thermal.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/thermal/hisilicon-therm=
al.txt b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
> >> new file mode 100644
> >> index 0000000..ceb6e2e
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/thermal/hisilicon-thermal.txt
> >> @@ -0,0 +1,45 @@
> >> +* Hisilicon Thermal
> >> +
> >> +This driver is for hi6220 SoC which contain 4 thermal sensor.
> >> +
> >> +	1. sensor 0: local sensor;
> >> +	2. sensor 1: remote sensor for ACPU cluster 1;
> >> +	3. sensor 2: remote sensor for ACPU cluster 2;
> >> +	4. sensor 3: remote sensor for GPU.
> >> +
> >> +Every sensor use one child node to represent it, so thermal sensor in=
clude
> >> +parent node and four child node. The parent node describe common feat=
ure and
> >> +child node describe private feature for thermal sensor;
> >> +
> >> +** Required properties :
> >> +
> >> +- compatible: "hisilicon,tsensor".
> >> +- reg: physical base address of thermal sensor and length of memory m=
apped
> >> +  region.
> >> +- interrupt: The interrupt number to the cpu. Defines the interrupt u=
sed
> >> +  by SOCTHERM.
> >> +- clock-names: Input clock name, should be 'thermal_clk'.
> >> +- clocks: phandles for clock specified in "clock-names" property.
> >> +- #thermal-sensor-cells: Should be 1. See ./thermal.txt for a descrip=
tion.
> >> +
> >> +** Required properties for child nodes :
> >> +
> >> +- hisilicon,tsensor-id: the index of thermal sensor and use it to dis=
tinguish
> >> +  thermal sensor. For example: <0> stands for local sensor; <1> stand=
s for
> >> +  acpu1 sensor;
> >=20
> > Please show an example illustrating why this property is needed. The
> > example below doesn't show any per sensor properties aside from the
> > sensor id. Other bindings with a similar sub-sensor hardware design like
> > tegra-soctherm and rockchip-thermal don't have a need for a vendor
> > specific property like this. Their drivers simply iterate over an id
> > index during thermal sensor registration.
> >=20
> > -Matt
> >=20
> Thermal Ip of hisilicon SoC can get four module temperature--local sensor=
, ACPU0
> sensor, ACPU1 sensor and gpu sensor. In order to use these sensors, this =
driver
> will make use of sensor id to distinguish sensor in using process.
>=20
> These four sensors only get one sensor temperature at the same times. Bec=
ause
> these sensor commonly use the same register by setting diff value to enab=
le one
> sensor. howerver, sensor id is key flag for these diff sensor modules.
>=20
> If deleting sensor id, this driver will define some value which set diff =
sensor
> regitser and it difficult to understand sensor register operation.

The above still do not explain why you need a specific property.

Could you please check
Documentation/devicetree/bindings/thermal/thermal.txt file?

There are several examples there on how to define DT nodes for the exact
case you describe above.

>=20
> Thanks
> Xinwei
>=20
> >> +
> >> +Example :
> >> +
> >> +	tsensor: tsensor@0,f7030700 {
> >> +		compatible =3D "hisilicon,tsensor";
> >> +		reg =3D <0x0 0xf7030700 0x0 0x1000>;
> >> +		interrupts =3D <0 7 0x4>;
> >> +		clocks =3D <&clock_sys HI6220_TSENSOR_CLK>;
> >> +		clock-names =3D "thermal_clk";
> >> +		#thermal-sensor-cells =3D <1>;
> >> +
> >> +		local_sensor {
> >> +			hisilicon,tsensor-id =3D <0>;
> >> +		}
> >> +		.......
> >> +	}
> >> --=20
> >> 1.9.1
> >>
> >>
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >=20
> > .
> >=20
>=20

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVI1yqAAoJEMLUO4d9pOJW8acIAITEiFrWnwAo9SS5bflrhXMS
INct/JzsiARt5NcPzXjef09p3ySF3Z9lgPRQFZzZTKSaYrqgTSWd2LR+cZYx1vmf
lmSv0URV7v0vywN2PUrkMYdw3JeiPryieYM5KCjw8xa4dswB7jAoe0Tr4htUz9ow
PH7EcyzEst0ih5la3o/rbMWQ0SIf15S2O3cuiPClyIMow3Zb0b+lUEeTLmfcullx
8/EWAJNJTlfi8A/K2+BfrvbQEYW9jLoxwfXS/m/KvMo4w7xl1VpJlP32AqiZ/Qxw
gtji/Dowqvp8ROEwHto5NQ1J5pAVuxaDWrPzXeZdwwg15SU6xx2OkNgHWsuefnU=
=YEW4
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
