From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V7 11/12] arm64: tegra: add soctherm node for Tegra210
Date: Tue, 15 Mar 2016 12:46:22 -0700
Message-ID: <20160315194620.GA26619@localhost.localdomain>
References: <1457665894-30141-1-git-send-email-wni@nvidia.com>
 <20160314192500.GE1872@localhost.localdomain>
 <56E7E734.5010307@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33203 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965811AbcCOTq0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Mar 2016 15:46:26 -0400
Content-Disposition: inline
In-Reply-To: <56E7E734.5010307@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: rui.zhang@intel.com, thierry.reding@gmail.com, MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 15, 2016 at 06:43:00PM +0800, Wei Ni wrote:
>=20
>=20
> On 2016=E5=B9=B403=E6=9C=8815=E6=97=A5 03:25, Eduardo Valentin wrote:
> > * PGP Signed by an unknown key
> >=20
> > On Fri, Mar 11, 2016 at 11:11:34AM +0800, Wei Ni wrote:
> >> Adds soctherm node for Tegra210, and add cpu,
> >> gpu, mem, pllx as thermal-zones. Set critical
> >> trip temp for cpu and gpu thermal zone.
> >>
> >> Signed-off-by: Wei Ni <wni@nvidia.com>
> >> ---
> >>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 60 +++++++++++++++++++++++=
+++++++++
> >>  1 file changed, 60 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boo=
t/dts/nvidia/tegra210.dtsi
> >> index cd4f45ccd6a7..c7ef500a347e 100644
> >> --- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> >> +++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> >> @@ -3,6 +3,7 @@
> >>  #include <dt-bindings/memory/tegra210-mc.h>
> >>  #include <dt-bindings/pinctrl/pinctrl-tegra.h>
> >>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >> +#include <dt-bindings/thermal/tegra124-soctherm.h>
> >> =20
> >>  / {
> >>  	compatible =3D "nvidia,tegra210";
> >> @@ -802,4 +803,63 @@
> >>  				(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
> >>  		interrupt-parent =3D <&gic>;
> >>  	};
> >> +
> >> +	soctherm: thermal-sensor@0,700e2000 {
> >> +		compatible =3D "nvidia,tegra210-soctherm";
> >> +		reg =3D <0x0 0x700e2000 0x0 0x1000>;
> >> +		interrupts =3D <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
> >> +		clocks =3D <&tegra_car TEGRA210_CLK_TSENSOR>,
> >> +			<&tegra_car TEGRA210_CLK_SOC_THERM>;
> >> +		clock-names =3D "tsensor", "soctherm";
> >> +		resets =3D <&tegra_car 78>;
> >> +		reset-names =3D "soctherm";
> >> +		#thermal-sensor-cells =3D <1>;
> >> +	};
> >> +
> >> +	thermal-zones {
> >> +		cpu {
> >> +			polling-delay-passive =3D <1000>;
> >> +			polling-delay =3D <0>;
> >> +
> >> +			thermal-sensors =3D
> >> +				<&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
> >> +
> >> +			trips {
> >> +				cpu_shutdown_trip: shutdown-trip {
> >> +					temperature =3D <102500>;
> >> +					hysteresis =3D <1000>;
> >> +					type =3D "critical";
> >> +				};
> >> +			};
> >> +		};
> >> +		mem {
> >> +			polling-delay-passive =3D <0>;
> >> +			polling-delay =3D <0>;
> >> +
> >> +			thermal-sensors =3D
> >> +				<&soctherm TEGRA124_SOCTHERM_SENSOR_MEM>;
> >=20
> >=20
> > Why no trips for mem? Why should we  care ?
>=20
> The critical trip temperature will be set to HW for critical shutdown. No=
rmally,
> we just take care the CPU and GPU temperature. And in HW, the MEM use the=
 same
> critical trip with GPU. For PLLX, we just keep the default critical trip =
in HW.
> So I didn't configure the MEM and PLLX. I can add critical trips for them.

Ok. Please add them.

>=20
> >=20
> > Please have a look on the binding to check for mandatory properties and
> > sub nodes.
>=20
> Hmm, yes, the trips and cooling-maps are required properties. How about t=
o add a
> dummy-cool-dev, so that it could be compatible with the binding.
>=20

Yeah, what people are doing, when the cooling devices are not ready to
be linked, is to add an empty section of cooling-maps.


> Wei.
>=20
> >=20
> >> +		};
> >> +		gpu {
> >> +			polling-delay-passive =3D <1000>;
> >> +			polling-delay =3D <0>;
> >> +
> >> +			thermal-sensors =3D
> >> +				<&soctherm TEGRA124_SOCTHERM_SENSOR_GPU>;
> >> +
> >> +			trips {
> >> +				gpu_shutdown_trip: shutdown-trip {
> >> +					temperature =3D <103000>;
> >> +					hysteresis =3D <1000>;
> >> +					type =3D "critical";
> >> +				};
> >> +			};
> >> +		};
> >> +		pllx {
> >> +			polling-delay-passive =3D <0>;
> >> +			polling-delay =3D <0>;
> >> +
> >> +			thermal-sensors =3D
> >> +				<&soctherm TEGRA124_SOCTHERM_SENSOR_PLLX>;
> >=20
> > ditto
> >=20
> >> +		};
> >> +	};
> >>  };
> >> --=20
> >> 1.9.1
> >>
> >=20
> > * Unknown Key
> > * 0x7DA4E256
> >=20

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJW6GaKAAoJEMLUO4d9pOJWArkH/RhlWkNFksSrHcfvywLxPyd6
s6Fx1M9RNawI9tDf3BLSdWISrBjpblCiIEhwCX0b7/zdzk7k5Hh4k/wv59wkEiVH
gUtxDKH6FeZrhNjmhb+Q3YqSVJLTAL6sOgPgEJaGAXnEuBpr3SwQtgTMtqGSa3O0
epPsP2y9z+TvRVNmrXihLG0a2Bqr6T9IAwbbaIVthjIBJ314JOlGUhUy8r983cen
qUOB08CCOcZz0Z7LowL0WkbP818bZRhNjjYs0VTQv0GbIBwq0g4xzyIWVCOX/caG
Kx4lFkRITDnB0PUJhbx8m30aUYcMKziuRHKJMSHh1l9S3YDlJrm5PMhTNmeR0a8=
=kVhD
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
