From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 03/11] cpufreq: tegra20: Clean up included headers
Date: Mon, 21 May 2018 11:14:09 +0530
Message-ID: <20180521054409.3n6z434de5ibzufq@vireshk-i7>
References: <20180518200642.24815-1-digetx@gmail.com>
 <20180518200642.24815-4-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180518200642.24815-4-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 18-05-18, 23:06, Dmitry Osipenko wrote:
> Remove unused/unneeded headers and sort them in the alphabet order.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
>  drivers/cpufreq/tegra20-cpufreq.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
> index dd8a76a64a8e..bec1a50a8138 100644
> --- a/drivers/cpufreq/tegra20-cpufreq.c
> +++ b/drivers/cpufreq/tegra20-cpufreq.c
> @@ -16,16 +16,12 @@
>   *
>   */
>  
> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/types.h>
> -#include <linux/sched.h>
> +#include <linux/clk.h>
>  #include <linux/cpufreq.h>
> -#include <linux/delay.h>
> -#include <linux/init.h>
>  #include <linux/err.h>
> -#include <linux/clk.h>
> -#include <linux/io.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
>  
>  static struct cpufreq_frequency_table freq_table[] = {
>  	{ .frequency = 216000 },

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
