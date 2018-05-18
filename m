From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v1 01/11] cpufreq: tegra20: Change module description
Date: Fri, 18 May 2018 07:23:50 +0530
Message-ID: <20180518015350.5nihxltyxn5bhdho@vireshk-i7>
References: <20180517180056.13336-1-digetx@gmail.com>
 <20180517180056.13336-2-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180517180056.13336-2-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 17-05-18, 21:00, Dmitry Osipenko wrote:
> Change module description to be in line with the other Tegra drivers, just
> for consistency.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/cpufreq/tegra20-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
> index 2bd62845e9d5..10793498355e 100644
> --- a/drivers/cpufreq/tegra20-cpufreq.c
> +++ b/drivers/cpufreq/tegra20-cpufreq.c
> @@ -210,7 +210,7 @@ static void __exit tegra_cpufreq_exit(void)
>  
>  
>  MODULE_AUTHOR("Colin Cross <ccross@android.com>");
> -MODULE_DESCRIPTION("cpufreq driver for Nvidia Tegra2");
> +MODULE_DESCRIPTION("NVIDIA Tegra20 cpufreq driver");
>  MODULE_LICENSE("GPL");
>  module_init(tegra_cpufreq_init);
>  module_exit(tegra_cpufreq_exit);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
