From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/2] arm64: dts: hi6220: Add all CPUs in cooling maps
Date: Thu, 5 Jul 2018 10:44:21 +0200
Message-ID: <b3d817e6-f694-0a63-afce-a8ec9c78aace@linaro.org>
References: <cover.1530766981.git.viresh.kumar@linaro.org>
 <fd741a8140809406ce86c479bbf6f03319490a64.1530766981.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fd741a8140809406ce86c479bbf6f03319490a64.1530766981.git.viresh.kumar@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, robh@kernel.org, Wei Xu <xuwei5@hisilicon.com>
Cc: linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, devicetree@vger.kernel.org, olof@lixom.net, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 05/07/2018 07:09, Viresh Kumar wrote:
> Each CPU can (and does) participate in cooling down the system but the
> DT only captures the CPU0 in the cooling maps. Things work by chance as
> under normal circumstances its the CPU0 which is used by the operating
> systems to probe the cooling devices. But as soon as that ordering
> changes and any other CPU is used to bring up the cooling device, we
> will start seeing errors.
> 
> On the other hand, the hardware is partially defined in DT in these
> cases and we must do a better job by capturing all devices.
> 
> Add all devices (CPUs here) in the cooling maps which are also affected
> by the trip point.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index 247024df714f..919d36b91bf3 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -886,7 +886,14 @@
>  				cooling-maps {
>  					map0 {
>  						trip = <&target>;
> -						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +						cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +								 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>  					};
>  				};
>  			};
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
