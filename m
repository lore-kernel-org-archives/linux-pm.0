From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH v2] dt-binding: arm/cpus.txt: fix dynamic-power-coefficient unit
Date: Thu, 30 Aug 2018 09:46:18 +0100
Message-ID: <87y3co8co5.fsf@e105922-lin.cambridge.arm.com>
References: <1535526518-29022-1-git-send-email-vincent.guittot@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1535526518-29022-1-git-send-email-vincent.guittot@linaro.org>
        (Vincent Guittot's message of "Wed, 29 Aug 2018 09:08:38 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, edubezval@gmail.com, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Vincent,

Vincent Guittot <vincent.guittot@linaro.org> writes:

> The unit of dynamic-power-coefficient is described as mW/MHz/uV^2 whereas
> its usage in the code assumes that unit is uW/MHz/V^2
>
> In drivers/thermal/cpu_cooling.c, the code is :
>
> power = (u64)capacitance * freq_mhz * voltage_mv * voltage_mv;
> do_div(power, 1000000000);
>
> which can be summarized as :
> power (mW) = capacitance * freq_mhz/1000 * (voltage_mv/1000)^2
> or
> power (mW) = (capacitance * freq_mhz * (voltage_mv/1000)^2) / 1000
> then
> power (mW) = power (uW) / 1000
> so
> power (uW) = capacitance * freq_mhz * (voltage_mv/1000)^2
>
> Furthermore, if we test basic values like :
> voltage_mv = 1000mV = 1V
> freq_mhz = 1000Mhz
>
> The minimum possible power, when dynamic-power-coefficient equals 1, will
> be with current unit:
> min power = 1 * 1000  * (1000000)^2 = 10^15 mW
> which is not realistic
>
> With the unit used by the code, the min power is
> min power =  1 * 1000 * 1^2 = 1000uW = 1mW which is far more realistic
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Acked-by: Punit Agrawal <punit.agrawal@arm.com>

Thanks for fixing the mismatch.

> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> index 29e1dc5..71d8cd0 100644
> --- a/Documentation/devicetree/bindings/arm/cpus.txt
> +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> @@ -274,7 +274,7 @@ described below.
>  		Usage: optional
>  		Value type: <prop-encoded-array>
>  		Definition: A u32 value that represents the running time dynamic
> -			    power coefficient in units of mW/MHz/uV^2. The
> +			    power coefficient in units of uW/MHz/V^2. The
>  			    coefficient can either be calculated from power
>  			    measurements or derived by analysis.
>  
> @@ -285,7 +285,7 @@ described below.
>  
>  			    Pdyn = dynamic-power-coefficient * V^2 * f
>  
> -			    where voltage is in uV, frequency is in MHz.
> +			    where voltage is in V, frequency is in MHz.
>  
>  Example 1 (dual-cluster big.LITTLE system 32-bit):
