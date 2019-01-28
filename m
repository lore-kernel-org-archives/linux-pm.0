From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v4 3/9] cpufreq: qcom-hw: Register as a cpufreq cooling
 device
Date: Mon, 28 Jan 2019 09:32:59 +0100
Message-ID: <36e00871-46c5-3c55-5a47-904a2796e4d4@linaro.org>
References: <cover.1548654899.git.amit.kucheria@linaro.org>
 <65d7297bbf98fd525d3785f2e8eb5a412ffd3a6b.1548654899.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <65d7297bbf98fd525d3785f2e8eb5a412ffd3a6b.1548654899.git.amit.kucheria@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>, linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org, edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org, mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Taniya Das <tdas@codeaurora.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 28/01/2019 07:41, Amit Kucheria wrote:
> Add the CPUFREQ_AUTO_REGISTER_COOLING_DEV flag to allow the cpufreq core
> to auto-register the driver as a cooling device.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index d83939a1b3d4..ed32849a3d40 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -231,7 +231,8 @@ static struct freq_attr *qcom_cpufreq_hw_attr[] = {
>  
>  static struct cpufreq_driver cpufreq_qcom_hw_driver = {
>  	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
> -			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
> +			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
> +			  CPUFREQ_AUTO_REGISTER_COOLING_DEV,
>  	.verify		= cpufreq_generic_frequency_table_verify,
>  	.target_index	= qcom_cpufreq_hw_target_index,
>  	.get		= qcom_cpufreq_hw_get,
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
