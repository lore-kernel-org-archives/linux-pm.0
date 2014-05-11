From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: powernv: make local function static
Date: Mon, 12 May 2014 00:02:52 +0530
Message-ID: <536FC254.2000702@linux.vnet.ibm.com>
References: <1399794680-22210-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1399794680-22210-1-git-send-email-computersforpeace@gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "ego@linux.vnet.ibm.com" <ego@linux.vnet.ibm.com>, Preeti U Murthy <preeti@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On 05/11/2014 01:21 PM, Brian Norris wrote:
> powernv_cpufreq_get() is only referenced in this file.
> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: cpufreq@vger.kernel.org
> Cc: linux-pm@vger.kernel.org

Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
 
Regards,
Srivatsa S. Bhat

> ---
>  drivers/cpufreq/powernv-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
> index af4968813e76..bb1d08dc8cc8 100644
> --- a/drivers/cpufreq/powernv-cpufreq.c
> +++ b/drivers/cpufreq/powernv-cpufreq.c
> @@ -235,7 +235,7 @@ static void powernv_read_cpu_freq(void *arg)
>   * firmware for CPU 'cpu'. This value is reported through the sysfs
>   * file cpuinfo_cur_freq.
>   */
> -unsigned int powernv_cpufreq_get(unsigned int cpu)
> +static unsigned int powernv_cpufreq_get(unsigned int cpu)
>  {
>  	struct powernv_smp_call_data freq_data;
> 

