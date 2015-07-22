From: Liviu Dudau <Liviu.Dudau@arm.com>
Subject: Re: [PATCH v4 8/8] arm64: dts: add clock support for all the cpus
Date: Wed, 22 Jul 2015 14:32:23 +0100
Message-ID: <20150722133223.GI14923@e106497-lin.cambridge.arm.com>
References: <1433760002-24120-1-git-send-email-sudeep.holla@arm.com>
 <1433760002-24120-9-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:9488 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933193AbbGVNc0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 22 Jul 2015 09:32:26 -0400
In-Reply-To: <1433760002-24120-9-git-send-email-sudeep.holla@arm.com>
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@kernel.org>, Olof Johansson <olof@lixom.net>

On Mon, Jun 08, 2015 at 11:40:02AM +0100, Sudeep Holla wrote:
> This patch adds the CPU clocks so that the CPU DVFS can be enabled.
>=20
> Cc: Liviu Dudau <Liviu.Dudau@arm.com>
> Cc: Jon Medhurst (Tixy) <tixy@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm64/boot/dts/arm/juno-r1.dts | 6 ++++++
>  arch/arm64/boot/dts/arm/juno.dts    | 6 ++++++
>  2 files changed, 12 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dt=
s/arm/juno-r1.dts
> index 69130840c6cd..5eef4aa0c532 100644
> --- a/arch/arm64/boot/dts/arm/juno-r1.dts
> +++ b/arch/arm64/boot/dts/arm/juno-r1.dts
> @@ -66,6 +66,7 @@
>  			device_type =3D "cpu";
>  			enable-method =3D "psci";
>  			next-level-cache =3D <&A57_L2>;
> +			clocks =3D <&scpi_dvfs 0>;
>  		};
> =20
>  		A57_1: cpu@1 {
> @@ -74,6 +75,7 @@
>  			device_type =3D "cpu";
>  			enable-method =3D "psci";
>  			next-level-cache =3D <&A57_L2>;
> +			clocks =3D <&scpi_dvfs 0>;
>  		};
> =20
>  		A53_0: cpu@100 {
> @@ -82,6 +84,7 @@
>  			device_type =3D "cpu";
>  			enable-method =3D "psci";
>  			next-level-cache =3D <&A53_L2>;
> +			clocks =3D <&scpi_dvfs 1>;
>  		};
> =20
>  		A53_1: cpu@101 {
> @@ -90,6 +93,7 @@
>  			device_type =3D "cpu";
>  			enable-method =3D "psci";
>  			next-level-cache =3D <&A53_L2>;
> +			clocks =3D <&scpi_dvfs 1>;
>  		};
> =20
>  		A53_2: cpu@102 {
> @@ -98,6 +102,7 @@
>  			device_type =3D "cpu";
>  			enable-method =3D "psci";
>  			next-level-cache =3D <&A53_L2>;
> +			clocks =3D <&scpi_dvfs 1>;
>  		};
> =20
>  		A53_3: cpu@103 {
> @@ -106,6 +111,7 @@
>  			device_type =3D "cpu";
>  			enable-method =3D "psci";
>  			next-level-cache =3D <&A53_L2>;
> +			clocks =3D <&scpi_dvfs 1>;
>  		};
> =20
>  		A57_L2: l2-cache0 {
> diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/a=
rm/juno.dts
> index ce1128a54c8d..c02f880584e8 100644
> --- a/arch/arm64/boot/dts/arm/juno.dts
> +++ b/arch/arm64/boot/dts/arm/juno.dts
> @@ -66,6 +66,7 @@
>  			device_type =3D "cpu";
>  			enable-method =3D "psci";
>  			next-level-cache =3D <&A57_L2>;
> +			clocks =3D <&scpi_dvfs 0>;
>  		};
> =20
>  		A57_1: cpu@1 {
> @@ -74,6 +75,7 @@
>  			device_type =3D "cpu";
>  			enable-method =3D "psci";
>  			next-level-cache =3D <&A57_L2>;
> +			clocks =3D <&scpi_dvfs 0>;
>  		};
> =20
>  		A53_0: cpu@100 {
> @@ -82,6 +84,7 @@
>  			device_type =3D "cpu";
>  			enable-method =3D "psci";
>  			next-level-cache =3D <&A53_L2>;
> +			clocks =3D <&scpi_dvfs 1>;
>  		};
> =20
>  		A53_1: cpu@101 {
> @@ -90,6 +93,7 @@
>  			device_type =3D "cpu";
>  			enable-method =3D "psci";
>  			next-level-cache =3D <&A53_L2>;
> +			clocks =3D <&scpi_dvfs 1>;
>  		};
> =20
>  		A53_2: cpu@102 {
> @@ -98,6 +102,7 @@
>  			device_type =3D "cpu";
>  			enable-method =3D "psci";
>  			next-level-cache =3D <&A53_L2>;
> +			clocks =3D <&scpi_dvfs 1>;
>  		};
> =20
>  		A53_3: cpu@103 {
> @@ -106,6 +111,7 @@
>  			device_type =3D "cpu";
>  			enable-method =3D "psci";
>  			next-level-cache =3D <&A53_L2>;
> +			clocks =3D <&scpi_dvfs 1>;
>  		};
> =20
>  		A57_L2: l2-cache0 {
> --=20
> 1.9.1
>=20

Acked-by: Liviu Dudau <Liviu.Dudau@arm.com>

--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    =C2=AF\_(=E3=83=84)_/=C2=AF

