From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] blackfin-cpufreq: Change return type of cpu_set_cclk()
 to that of clk_set_rate()
Date: Sat, 19 Dec 2015 07:29:26 +0530
Message-ID: <20151219015926.GJ3946@ubuntu>
References: <5674598B.6020000@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5674598B.6020000@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-pm@vger.kernel.org

On 18-12-15, 20:07, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 18 Dec 2015 19:43:27 +0100
> 
> The return type "unsigned long" was used by the cpu_set_cclk() function
> while the type "int" is provided by the clk_set_rate() function.
> Let us make this usage consistent.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/cpufreq/blackfin-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/blackfin-cpufreq.c b/drivers/cpufreq/blackfin-cpufreq.c
> index a9f8e5b..2a6f3ac 100644
> --- a/drivers/cpufreq/blackfin-cpufreq.c
> +++ b/drivers/cpufreq/blackfin-cpufreq.c
> @@ -112,7 +112,7 @@ static unsigned int bfin_getfreq_khz(unsigned int cpu)
>  }
>  
>  #ifdef CONFIG_BF60x
> -unsigned long cpu_set_cclk(int cpu, unsigned long new)
> +int cpu_set_cclk(int cpu, unsigned long new)
>  {
>  	struct clk *clk;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
