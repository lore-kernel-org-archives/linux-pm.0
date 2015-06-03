From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v6 3/3] dts: hi6220: enable thermal sensor for hisilicon
 SoC
Date: Wed, 3 Jun 2015 16:06:50 -0700
Message-ID: <20150603230648.GB7640@localhost.localdomain>
References: <1432120598-18268-1-git-send-email-kong.kongxinwei@hisilicon.com>
 <1432120598-18268-4-git-send-email-kong.kongxinwei@hisilicon.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:35209 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbbFCQG4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2015 12:06:56 -0400
Content-Disposition: inline
In-Reply-To: <1432120598-18268-4-git-send-email-kong.kongxinwei@hisilicon.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Xinwei Kong <kong.kongxinwei@hisilicon.com>, Wei Xu <xuwei5@hisilicon.com>
Cc: rui.zhuang@intel.com, amit.kucheria@linaro.org, punit.agrawal@arm.com, Javi.Merino@arm.com, jorge.ramirez-ortiz@linaro.org, haojian.zhuang@linaro.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, dan.zhao@hisilicon.com, devicetree@vger.kernel.org, gongyu@hisilicon.com, guodong.xu@linaro.org, robh@kernel.org, linuxarm@huawei.com, zhenwei.wang@hisilicon.com, leo.yan@linaro.org, mporter@konsulko.com, liguozhu@hisilicon.com


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2015 at 07:16:38PM +0800, Xinwei Kong wrote:
> From: kongxinwei <kong.kongxinwei@hisilicon.com>
>=20
> Dts includes two part: the first part is related with thermal sensor;
> the second part is related with thermal zones, in this part it will
> define the thermal zones and which sensor device should be bound to.
> it also need specify the polling interval for every thermal zone.
>=20
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: kongxinwei <kong.kongxinwei@hisilicon.com>

Acked-by: Eduardo Valentin <edubezval@gmail.com>

I have taken the patches containing the driver changes and the
Documentation entry. But this patch needs to go via your your
machine code tree (Wei Xu).

BR,

Eduardo Valentin

> ---
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 124 ++++++++++++++++++++++++=
++++++
>  1 file changed, 124 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/=
dts/hisilicon/hi6220.dtsi
> index 8ade3d9..eb465a6 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -6,6 +6,7 @@
> =20
>  #include <dt-bindings/clock/hi6220-clock.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/thermal/thermal.h>
> =20
>  / {
>  	compatible =3D "hisilicon,hi6220";
> @@ -173,4 +174,127 @@
>  			clock-names =3D "uartclk", "apb_pclk";
>  		};
>  	};
> +
> +	tsensor: tsensor@0,f7030700 {
> +		compatible =3D "hisilicon,tsensor";
> +		reg =3D <0x0 0xf7030700 0x0 0x1000>;
> +		interrupts =3D <0 7 0x4>;
> +		clocks =3D <&sys_ctrl HI6220_TSENSOR_CLK>;
> +		clock-names =3D "thermal_clk";
> +		#thermal-sensor-cells =3D <1>;
> +	};
> +
> +	thermal-zones {
> +		local: local {
> +			/* milliseconds */
> +			polling-delay-passive =3D <1000>;
> +			/* milliseconds */
> +			polling-delay =3D <5000>;
> +
> +			/* sensor	ID */
> +			thermal-sensors =3D <&tsensor  0>;
> +
> +			trips {
> +				local_alert: local_alert {
> +					/* millicelsius */
> +					temperature =3D <70000>;
> +					/* millicelsius */
> +					hysteresis =3D <2000>;
> +					type =3D "passive";
> +				};
> +				local_crit: local_crit {
> +					temperature =3D <90000>;
> +					hysteresis =3D <2000>;
> +					type =3D "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				/* There are currently no cooling maps
> +				because there are no cooling devices */
> +			};
> +		};
> +
> +		cluster1: cluster1 {
> +			polling-delay-passive =3D <1000>;
> +			polling-delay =3D <5000>;
> +
> +			/* sensor	ID */
> +			thermal-sensors =3D <&tsensor  1>;
> +
> +			trips {
> +				cluster1_alert: cluster1_alert {
> +					temperature =3D <70000>;
> +					hysteresis =3D <2000>;
> +					type =3D "passive";
> +				};
> +				cluster1_crit: cluster1_crit {
> +					temperature =3D <90000>;
> +					hysteresis =3D <2000>;
> +					type =3D "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				/* There are currently no cooling maps
> +				because there are no cooling devices */
> +			};
> +		};
> +
> +		cluster0: cluster0 {
> +			polling-delay-passive =3D <1000>;
> +			polling-delay =3D <5000>;
> +
> +			/* sensor	ID */
> +			thermal-sensors =3D <&tsensor  2>;
> +
> +			trips {
> +				cluster0_alert: cluster0_alert {
> +					temperature =3D <70000>;
> +					hysteresis =3D <2000>;
> +					type =3D "passive";
> +				};
> +				cluster0_crit: cluster0_crit {
> +					temperature =3D <90000>;
> +					hysteresis =3D <2000>;
> +					type =3D "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				map0 {
> +					trip =3D <&cluster0_alert>;
> +					cooling-device =3D
> +					    <&cpu0 THERMAL_NO_LIMIT
> +						THERMAL_NO_LIMIT>;
> +				};
> +			};
> +		};
> +
> +		gpu: gpu {
> +			polling-delay-passive =3D <1000>;
> +			polling-delay =3D <5000>;
> +
> +			/* sensor	ID */
> +			thermal-sensors =3D <&tsensor  3>;
> +
> +			trips {
> +				gpu_alert: gpu_alert {
> +					temperature =3D <70000>;
> +					hysteresis =3D <2000>;
> +					type =3D "passive";
> +				};
> +				gpu_crit: gpu_crit {
> +					temperature =3D <90000>;
> +					hysteresis =3D <2000>;
> +					type =3D "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				/* There are currently no cooling maps
> +				because there are no cooling devices */
> +			};
> +		};
> +	};
>  };
> --=20
> 1.9.1
>=20
>=20

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVb4iCAAoJEMLUO4d9pOJWGPMH/RWHDBzErFhVs+qlgW/zyYLz
/x+Ygoqr3I/jUBztOIuzKGNlxdZ6smBVW8Eg4PYLLGwiUOJhOkwS6kw9ePbslwUn
XhO+5mcvjJ6eOjz5NVSBO6WEqpikkWKe3kkd5WGD0usQ6Wct7eFcTWtaNBcoV3YN
27rzCJ/0G8J4XuUltdI+V5u1op+OqOp+u9R7o/4JyMIvi2jhkdwrKsl4BaIDEE1T
jKHVwlgTuPFbgk3/DYJ1bRXaD2uBJODwzzbV6bW+6CYvVauX0y77RDB1gS39cW9v
Y8plXzPsVHN9fzMd98qer7Jc/ndy7XBJrITzpuIe8+Rp53ZL+LZcPMkjj00yxRs=
=z5fO
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
