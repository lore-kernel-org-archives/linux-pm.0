From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH v2 03/12] arm64: dts: tegra210: set thermtrip
Date: Fri, 26 Apr 2019 11:21:05 +0800
Message-ID: <2accde0e-6c6d-fdf9-44fe-479a4330729d@nvidia.com>
References: <1550744327-4677-1-git-send-email-wni@nvidia.com>
 <1550744327-4677-4-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550744327-4677-4-git-send-email-wni@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: thierry.reding@gmail.com
Cc: daniel.lezcano@linaro.org, edubezval@gmail.com, robh@kernel.org, linux-tegra@vger.kernel.org, rui.zhang@intel.com, srikars@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Thierry,
Eduardo have picked this series to his branch except dts patches.
Please check
"git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git"
in the linus branch. They will be merged in the next major kernel release.

Could you please take these three dts changes?
Here is the list:
[PATCH v2 03/12] arm64: dts: tegra210: set thermtrip
[PATCH v2 06/12] arm64: dts: tegra210: set gpu hw throttle level
[PATCH v2 10/12] arm64: dts: tegra210: set EDP interrupt line

Thanks.
Wei.

On 21/2/2019 6:18 PM, Wei Ni wrote:
> Set "nvidia,thermtrips" property, it used to set
> HW shutdown temperatures.
> 
> Signed-off-by: Wei Ni <wni@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra210.dtsi | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> index 6574396d2257..582d56820bbb 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
> @@ -1410,6 +1410,9 @@
>  		reset-names = "soctherm";
>  		#thermal-sensor-cells = <1>;
>  
> +		nvidia,thermtrips = <TEGRA124_SOCTHERM_SENSOR_CPU 102500
> +				     TEGRA124_SOCTHERM_SENSOR_GPU 103000>;
> +
>  		throttle-cfgs {
>  			throttle_heavy: heavy {
>  				nvidia,priority = <100>;
> @@ -1429,8 +1432,8 @@
>  				<&soctherm TEGRA124_SOCTHERM_SENSOR_CPU>;
>  
>  			trips {
> -				cpu-shutdown-trip {
> -					temperature = <102500>;
> +				cpu-critical-trip {
> +					temperature = <102000>;
>  					hysteresis = <0>;
>  					type = "critical";
>  				};
> @@ -1457,7 +1460,7 @@
>  				<&soctherm TEGRA124_SOCTHERM_SENSOR_MEM>;
>  
>  			trips {
> -				mem-shutdown-trip {
> +				mem-critical-trip {
>  					temperature = <103000>;
>  					hysteresis = <0>;
>  					type = "critical";
> @@ -1479,8 +1482,8 @@
>  				<&soctherm TEGRA124_SOCTHERM_SENSOR_GPU>;
>  
>  			trips {
> -				gpu-shutdown-trip {
> -					temperature = <103000>;
> +				gpu-critical-trip {
> +					temperature = <102500>;
>  					hysteresis = <0>;
>  					type = "critical";
>  				};
> @@ -1507,7 +1510,7 @@
>  				<&soctherm TEGRA124_SOCTHERM_SENSOR_PLLX>;
>  
>  			trips {
> -				pllx-shutdown-trip {
> +				pllx-critical-trip {
>  					temperature = <103000>;
>  					hysteresis = <0>;
>  					type = "critical";
> 
