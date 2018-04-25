From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: fix speedstep_detect_processor()'s return type
Date: Wed, 25 Apr 2018 08:16:47 +0530
Message-ID: <20180425024647.woeugwev6qchwert@vireshk-i7>
References: <20180424131414.1653-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180424131414.1653-1-luc.vanoostenryck@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 24-04-18, 15:14, Luc Van Oostenryck wrote:
> speedstep_detect_processor() is declared as returing an
> 'enum speedstep_processor' but use an 'int' in its definition.
> 
> Fix this by using 'enum speedstep_processor' in its definition too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/cpufreq/speedstep-lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/speedstep-lib.c b/drivers/cpufreq/speedstep-lib.c
> index e3a9962ee..cabb6f48e 100644
> --- a/drivers/cpufreq/speedstep-lib.c
> +++ b/drivers/cpufreq/speedstep-lib.c
> @@ -252,7 +252,7 @@ EXPORT_SYMBOL_GPL(speedstep_get_frequency);
>   *********************************************************************/
>  
>  /* Keep in sync with the x86_cpu_id tables in the different modules */
> -unsigned int speedstep_detect_processor(void)
> +enum speedstep_processor speedstep_detect_processor(void)
>  {
>  	struct cpuinfo_x86 *c = &cpu_data(0);
>  	u32 ebx, msr_lo, msr_hi;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
