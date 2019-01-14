From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH v1 04/10] cpufreq: qcom-hw: Register as a cpufreq cooling
 device
Date: Mon, 14 Jan 2019 12:54:35 -0800
Message-ID: <20190114205435.GM261387@google.com>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
 <bd172905b0208b958f8c4f239b55ac3e345c60a8.1547481320.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bd172905b0208b958f8c4f239b55ac3e345c60a8.1547481320.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org, edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 14, 2019 at 10:04:56PM +0530, Amit Kucheria wrote:
> Add the CPUFREQ_AUTO_REGISTER_COOLING_DEV flag to allow the cpufreq core
> to auto-register the driver as a cooling device.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
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

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
