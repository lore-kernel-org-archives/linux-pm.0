From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v1 05/11] cpufreq: tegra20: Clean up included headers
Date: Fri, 18 May 2018 07:28:54 +0530
Message-ID: <20180518015854.glj25krzacf7rnd7@vireshk-i7>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-6-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180517180056.13336-6-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 17-05-18, 21:00, Dmitry Osipenko wrote:
> Remove unused/unneeded headers and sort them in the alphabet order.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/tegra20-cpufreq.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
> index 69f033d297e1..61f00d1cba26 100644
> --- a/drivers/cpufreq/tegra20-cpufreq.c
> +++ b/drivers/cpufreq/tegra20-cpufreq.c
> @@ -16,16 +16,9 @@
>   *
>   */
>  
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/types.h>
> -#include <linux/sched.h>
> -#include <linux/cpufreq.h>
> -#include <linux/delay.h>
> -#include <linux/init.h>
> -#include <linux/err.h>
>  #include <linux/clk.h>
> -#include <linux/io.h>
> +#include <linux/cpufreq.h>
> +#include <linux/module.h>

Ideally you should keep all the headers whose declarations your code
is using directly. It may happen that removing above still compiles
because cpufreq.h has included the headers indirectly for you. But
that will break the day cpufreq.h doesn't need those headers anymore.

So just make sure you aren't using any of them in your code. For
example you are using bool in your code and so you shouldn't remove
types.h ? Same for init.h as you are using __init and __exit.

>  
>  static struct cpufreq_frequency_table freq_table[] = {
>  	{ .frequency = 216000 },
> -- 
> 2.17.0

-- 
viresh
