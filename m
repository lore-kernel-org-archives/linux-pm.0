From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] dt-bindings: hwmon (pwm-fan) Remove dead
 "cooling-*-state" properties
Date: Tue, 19 Mar 2019 08:00:14 -0700
Message-ID: <20190319150014.GA29158@roeck-us.net>
References: <afde4ebd929821d63b5172c8e70e15f0725a4b49.1553006788.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <afde4ebd929821d63b5172c8e70e15f0725a4b49.1553006788.git.robin.murphy@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org, jdelvare@suse.com, heiko@sntech.de, linux-pm@vger.kernel.org, s.hauer@pengutronix.de, krzk@kernel.org, jonathanh@nvidia.com, thierry.reding@gmail.com, kgene@kernel.org, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 19, 2019 at 02:54:04PM +0000, Robin Murphy wrote:
> The old "cooling-{min,max}-state" properties for thermal bindings were
> ratified to "cooling-{min,max}-level" by commit eb168b70dea5 ("of:
> thermal: Fix inconsitency between cooling-*-state and cooling-*-level"),
> which were later removed entirely by commit e04907dbc259 ("dt-bindings:
> thermal: Remove "cooling-{min|max}-level" properties").
> 
> The pwm-fan binding, however, was apparently in-flight in parallel with
> that ratification, and so managed to introduce an example of the old
> properties which escaped the scope of the later cleanup and has thus
> continued to be dutifully copied for new boards despite being useless.
> Clean up these remaining undocumented anachronisms to minimise any
> further confusion.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

For hwmon: Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Presented as one big hwmon patch for simplicity, but the DT changes
> can quite easily be broken out by platform if maintainers prefer.
> 
> Robin.
> 
>  Documentation/devicetree/bindings/hwmon/pwm-fan.txt | 2 --
>  arch/arm/boot/dts/exynos4412-odroidu3.dts           | 2 --
>  arch/arm/boot/dts/exynos5410-odroidxu.dts           | 2 --
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi  | 2 --
>  arch/arm/boot/dts/imx6qdl-emcon.dtsi                | 2 --
>  arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts  | 2 --
>  arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi       | 2 --
>  arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi       | 2 --
>  8 files changed, 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> index 49ca5d83ed13..716e84f3bbb2 100644
> --- a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> +++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> @@ -12,8 +12,6 @@ Optional properties:
>  Example:
>  	fan0: pwm-fan {
>  		compatible = "pwm-fan";
> -		cooling-min-state = <0>;
> -		cooling-max-state = <3>;
>  		#cooling-cells = <2>;
>  		pwms = <&pwm 0 10000 0>;
>  		cooling-levels = <0 102 170 230>;
> diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
> index 2bdf899df436..6d400b01d9c9 100644
> --- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
> +++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
> @@ -34,8 +34,6 @@
>  	fan0: pwm-fan {
>  		compatible = "pwm-fan";
>  		pwms = <&pwm 0 10000 0>;
> -		cooling-min-state = <0>;
> -		cooling-max-state = <3>;
>  		#cooling-cells = <2>;
>  		cooling-levels = <0 102 170 230>;
>  	};
> diff --git a/arch/arm/boot/dts/exynos5410-odroidxu.dts b/arch/arm/boot/dts/exynos5410-odroidxu.dts
> index 434a7591ff63..8f9e08f940ab 100644
> --- a/arch/arm/boot/dts/exynos5410-odroidxu.dts
> +++ b/arch/arm/boot/dts/exynos5410-odroidxu.dts
> @@ -38,8 +38,6 @@
>  	fan0: pwm-fan {
>  		compatible = "pwm-fan";
>  		pwms = <&pwm 0 20972 0>;
> -		cooling-min-state = <0>;
> -		cooling-max-state = <3>;
>  		#cooling-cells = <2>;
>  		cooling-levels = <0 130 170 230>;
>  	};
> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> index 5f195ad7e467..93a48f2dda49 100644
> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
> @@ -44,8 +44,6 @@
>  	fan0: pwm-fan {
>  		compatible = "pwm-fan";
>  		pwms = <&pwm 0 20972 0>;
> -		cooling-min-state = <0>;
> -		cooling-max-state = <3>;
>  		#cooling-cells = <2>;
>  		cooling-levels = <0 130 170 230>;
>  	};
> diff --git a/arch/arm/boot/dts/imx6qdl-emcon.dtsi b/arch/arm/boot/dts/imx6qdl-emcon.dtsi
> index 397e205551c4..70d26616d771 100644
> --- a/arch/arm/boot/dts/imx6qdl-emcon.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-emcon.dtsi
> @@ -77,8 +77,6 @@
>  
>  	pwm_fan: pwm-fan {
>  		compatible = "pwm-fan";
> -		cooling-min-state = <0>;
> -		cooling-max-state = <4>;
>  		#cooling-cells = <2>;
>  		pwms = <&pwm4 0 50000>;
>  		cooling-levels = <0 64 127 191 255>;
> diff --git a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> index b62e96945846..73801b48d1d8 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra194-p2972-0000.dts
> @@ -57,8 +57,6 @@
>  		pwms = <&pwm4 0 45334>;
>  
>  		cooling-levels = <0 64 128 255>;
> -		cooling-min-state = <0>;
> -		cooling-max-state = <3>;
>  		#cooling-cells = <2>;
>  	};
>  
> diff --git a/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi b/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
> index 1b35d612b660..cc35c88dafd9 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
> @@ -56,8 +56,6 @@
>  			fan: fan@18 {
>  				compatible = "ti,amc6821";
>  				reg = <0x18>;
> -				cooling-min-state = <0>;
> -				cooling-max-state = <9>;
>  				#cooling-cells = <2>;
>  			};
>  
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> index 0130b9f98c9d..490be7a6a851 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
> @@ -369,8 +369,6 @@
>  	fan: fan@18 {
>  		compatible = "ti,amc6821";
>  		reg = <0x18>;
> -		cooling-min-state = <0>;
> -		cooling-max-state = <9>;
>  		#cooling-cells = <2>;
>  	};
>  
> -- 
> 2.20.1.dirty
> 
