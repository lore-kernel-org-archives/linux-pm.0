From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [Patch v2 1/3] dt-bindings: Document the hi3660 thermal sensor
 bindings
Date: Fri, 30 Jun 2017 20:05:36 -0700
Message-ID: <20170701030534.GB11424@localhost.localdomain>
References: <1497930035-60894-3-git-send-email-kevin.wangtao@hisilicon.com>
 <1498102923-68481-1-git-send-email-kevin.wangtao@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34893 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbdGADFk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jun 2017 23:05:40 -0400
Content-Disposition: inline
In-Reply-To: <1498102923-68481-1-git-send-email-kevin.wangtao@hisilicon.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tao Wang <kevin.wangtao@hisilicon.com>
Cc: rui.zhang@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sunzhaosheng@hisilicon.com, leo.yan@linaro.org

On Thu, Jun 22, 2017 at 11:42:01AM +0800, Tao Wang wrote:
> This adds documentation of device tree bindings for the
> thermal sensor controller of hi3660 SoC.
>=20
> Signed-off-by: Tao Wang <kevin.wangtao@hisilicon.com>
> ---
> Changes in v2:
> - remove redundant property
>=20
>  .../devicetree/bindings/thermal/hi3660-thermal.txt |   16 ++++++++++++++=
++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/hi3660-ther=
mal.txt
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/hi3660-thermal.txt=
 b/Documentation/devicetree/bindings/thermal/hi3660-thermal.txt
> new file mode 100644
> index 0000000..f3dddcf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/thermal/hi3660-thermal.txt
> @@ -0,0 +1,16 @@
> +* Temperature Sensor on hisilicon hi3660 SoC
> +

Would you mind add some more description of the sensors/where to find
further hardware documentation?

> +** Required properties :
> +
> +- compatible: "hisilicon,thermal-hi3660".
> +- reg: physical base address of thermal sensor and length of memory mapp=
ed
> +  region.
> +- #thermal-sensor-cells: Should be 1. See ./thermal.txt for a descriptio=
n.
> +
> +Example :
> +
> +	tsensor: tsensor {
> +		compatible =3D "hisilicon,thermal-hi3660";
> +		reg =3D <0x0 0xfff30000 0x0 0x1000>;
> +		#thermal-sensor-cells =3D <1>;
> +	 };
> --=20
> 1.7.9.5
>=20
