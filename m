From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: ACPI: make function acpi_cpufreq_fast_switch
 static
Date: Mon, 4 Jun 2018 12:41:41 +0530
Message-ID: <20180604071141.wzxjtxa2hwlbkaw3@vireshk-i7>
References: <20180601130512.30857-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180601130512.30857-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 01-06-18, 14:05, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The function acpi_cpufreq_fast_switch is local to the source and does
> not need to be in global scope, so make it static.
> 
> Cleans up sparse warning:
> drivers/cpufreq/acpi-cpufreq.c:468:14: warning: symbol
> 'acpi_cpufreq_fast_switch' was not declared. Should it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 9449657d72f0..32ba4bc972e7 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -465,8 +465,8 @@ static int acpi_cpufreq_target(struct cpufreq_policy *policy,
>  	return result;
>  }
>  
> -unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
> -				      unsigned int target_freq)
> +static unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
> +					     unsigned int target_freq)
>  {
>  	struct acpi_cpufreq_data *data = policy->driver_data;
>  	struct acpi_processor_performance *perf;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
