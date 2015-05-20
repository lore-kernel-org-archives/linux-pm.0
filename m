From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v5 3/3] dts: hi6220: enable thermal sensor for hisilicon
 SoC
Date: Tue, 19 May 2015 21:51:01 -0700
Message-ID: <20150520045100.GB4295@localhost.localdomain>
References: <1431933109-22764-1-git-send-email-kong.kongxinwei@hisilicon.com>
 <1431933109-22764-4-git-send-email-kong.kongxinwei@hisilicon.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33728 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbbESVvH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2015 17:51:07 -0400
Content-Disposition: inline
In-Reply-To: <1431933109-22764-4-git-send-email-kong.kongxinwei@hisilicon.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: rui.zhuang@intel.com, amit.kucheria@linaro.org, punit.agrawal@arm.com, Javi.Merino@arm.com, jorge.ramirez-ortiz@linaro.org, haojian.zhuang@linaro.org, linux-pm@vger.kernel.org, dan.zhao@hisilicon.com, devicetree@vger.kernel.org, gongyu@hisilicon.com, guodong.xu@linaro.org, robh@kernel.org, mark.rutland@arm.com, linuxarm@huawei.com, zhenwei.wang@hisilicon.com, leo.yan@linaro.org, mporter@konsulko.com, zhangfei.gao@linaro.org, liguozhu@hisilicon.com


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2015 at 03:11:49PM +0800, Xinwei Kong wrote:
> From: kongxinwei <kong.kongxinwei@hisilicon.com>
>=20
> Dts includes two part: the first part is related with thermal sensor;
> the second part is related with thermal zones, in this part it will
> define the thermal zones and which sensor device should be bound to.
> it also need specify the polling interval for every thermal zone.
>=20
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: kongxinwei <kong.kongxinwei@hisilicon.com>
> ---
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 127 ++++++++++++++++++++++++=
++++++
>  1 file changed, 127 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/hisilicon/hi6220.dtsi
>=20
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/=
dts/hisilicon/hi6220.dtsi
> new file mode 100644
> index 0000000..82f213d
> --- /dev/null
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -0,0 +1,127 @@
> +
> +#include <dt-bindings/thermal/thermal.h>
> +
> +/ {
> +
> +	tsensor: tsensor@0,f7030700 {
> +		compatible =3D "hisilicon,tsensor";
> +		reg =3D <0x0 0xf7030700 0x0 0x1000>;
> +		interrupts =3D <0 7 0x4>;
> +		clocks =3D <&clock_sys HI6220_TSENSOR_CLK>;
> +		clock-names =3D "thermal_clk";
> +		#thermal-sensor-cells =3D <1>;
> +
> +	thermal-zones {

The thermal-zones node is typically in the root node, not inside the
sensor node.

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

Not even cpufreq? in your driver you mention about cpufreq cooling.

Do you have cpufreq-dt driver  properly setup in your board?

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
> +}

Are you sure this DT file works? I think it misses a closing \}.

> --=20
> 1.9.1
>=20
>=20

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVXBKxAAoJEMLUO4d9pOJWIqAH/2U0uIzoL1Udlv/gDeZd06px
OqP5Tbkha1pkK9rwVdFt9zIx3wS6xjfDksDLbGisZ3xCd5pYJHEoGgB3U+7keaY5
6Etmi0zRmA3iwVpbpNQ8D5Noox45EVCP4WBKuTWnVNrT+bKhe+awMpWlnxTvT8fm
ewVmoiOuAgxebWBVmVdy2Yntaoscovhk/mT8pFnL4e0OA7whA+XSxmhmqAMVY9FM
mFVGlNCUzIhMHYxVRx/1rSTvWtEx2clThW5LIu6w9UtQEYfjIt9FCTRGY2Zqgshl
jg97r4p3686vFa8AiwlnmKrZLwJtHlkJius7NUPwt8LEXYbpcxHqm9E/C/ZxMGU=
=15Ss
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
