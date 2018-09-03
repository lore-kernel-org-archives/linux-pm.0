From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] dt-binding: arm/cpus.txt: fix
 dynamic-power-coefficient unit
Date: Mon, 3 Sep 2018 12:09:29 +0530
Message-ID: <20180903063929.oic5rgynzos2a4s2@vireshk-i7>
References: <1535526518-29022-1-git-send-email-vincent.guittot@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1535526518-29022-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, punit.agrawal@arm.com, edubezval@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 29-08-18, 09:08, Vincent Guittot wrote:
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
> ---
>  Documentation/devicetree/bindings/arm/cpus.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
