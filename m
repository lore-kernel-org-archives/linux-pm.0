From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 3/3] cpufreq: arm_big_little: Add support to register
 a cpufreq cooling device
Date: Fri, 13 Nov 2015 10:26:10 +0530
Message-ID: <20151113045610.GC3576@ubuntu>
References: <1447090163-13700-1-git-send-email-punit.agrawal@arm.com>
 <1447090163-13700-4-git-send-email-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447090163-13700-4-git-send-email-punit.agrawal@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, edubezval@gmail.com, dawei.chien@mediatek.com, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On 09-11-15, 17:29, Punit Agrawal wrote:
> Register passive cooling devices when initialising cpufreq on
> big.LITTLE systems. If the device tree provides a dynamic power
> coefficient for the CPUs then the bound cooling device will support
> the extensions that allow it to be used with all the existing thermal
> governors including the power allocator governor.
> 
> A cooling device will be created per individual frequency domain and
> can be bound to thermal zones via the thermal DT bindings.
> 
> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> ---
>  drivers/cpufreq/arm_big_little.c | 52 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
> index f1e42f8..72a2777 100644
> --- a/drivers/cpufreq/arm_big_little.c
> +++ b/drivers/cpufreq/arm_big_little.c
> @@ -23,6 +23,7 @@
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
>  #include <linux/cpumask.h>
> +#include <linux/cpu_cooling.h>
>  #include <linux/export.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> @@ -55,6 +56,10 @@ static bool bL_switching_enabled;
>  #define ACTUAL_FREQ(cluster, freq)  ((cluster == A7_CLUSTER) ? freq << 1 : freq)
>  #define VIRT_FREQ(cluster, freq)    ((cluster == A7_CLUSTER) ? freq >> 1 : freq)
>  
> +struct private_data {
> +	struct thermal_cooling_device *cdev;
> +};

I think we need to be consistent within the driver, and so this must
be stored in a similar way to what we do for other structures. We have
static arrays for them, please do it that way only OR first change all
of them to be part of a bigger private_data structure.

-- 
viresh
