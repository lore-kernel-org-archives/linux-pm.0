From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH] arm64: tegra: fix compatible string for Tegra132 fuse
 node
Date: Tue, 3 May 2016 18:11:08 +0800
Message-ID: <5728793C.7000109@nvidia.com>
References: <1462267942-2165-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1462267942-2165-1-git-send-email-wni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, thierry.reding@gmail.com, robh+dt@kernel.org, rui.zhang@intel.com
Cc: MLongnecker@nvidia.com, swarren@wwwdotorg.org, mikko.perttunen@kapsi.fi, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Sorry, please ignore this mail.

On 2016=E5=B9=B405=E6=9C=8803=E6=97=A5 17:32, Wei Ni wrote:
> This patch changes the compatible of Tegra132 fuse node
> to "nvidia,tegra132-efuse", instead of "nvidia,tegra1124-efuse".
> Because the CONFIG_ARCH_TEGRA_124_SOC will not be enabled for
> Tegra132, the fuse driver can't find the corresponding node.
>=20
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra132.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/arm64/boot/dts/nvidia/tegra132.dtsi b/arch/arm64/bo=
ot/dts/nvidia/tegra132.dtsi
> index 5d013809448b..ee101cb52f70 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra132.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra132.dtsi
> @@ -582,7 +582,7 @@
>  	};
> =20
>  	fuse@7000f800 {
> -		compatible =3D "nvidia,tegra124-efuse";
> +		compatible =3D "nvidia,tegra132-efuse";
>  		reg =3D <0x0 0x7000f800 0x0 0x400>;
>  		clocks =3D <&tegra_car TEGRA124_CLK_FUSE>;
>  		clock-names =3D "fuse";
>=20
