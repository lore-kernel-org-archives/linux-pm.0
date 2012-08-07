From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RESEND PATCH] conservative: Initialise the cpu field during governor start
Date: Wed, 8 Aug 2012 00:22:03 +0200
Message-ID: <201208080022.03731.rjw@sisk.pl>
References: <201207232055.26506.rjw@sisk.pl> <1343121972-9130-1-git-send-email-amit.daniel@samsung.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1343121972-9130-1-git-send-email-amit.daniel@samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: Amit Daniel Kachhap <amit.daniel@samsung.com>
Cc: cpufreq@vger.kernel.org, amit.kachhap@linaro.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, July 24, 2012, Amit Daniel Kachhap wrote:
> This change initialises the cpu id field of cs_cpu_dbs_info structure in
> conservative governor and keep this consistent with other governors.
> Similar initialisation is present in ondemand governor.
> 
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>

Applied to the linux-next branch of the linux-pm.git tree as v3.7 material.

Thanks,
Rafael


> ---
>  drivers/cpufreq/cpufreq_conservative.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
> index 235a340..a1563d7 100644
> --- a/drivers/cpufreq/cpufreq_conservative.c
> +++ b/drivers/cpufreq/cpufreq_conservative.c
> @@ -504,6 +504,7 @@ static int cpufreq_governor_dbs(struct cpufreq_policy *policy,
>  				j_dbs_info->prev_cpu_nice =
>  						kcpustat_cpu(j).cpustat[CPUTIME_NICE];
>  		}
> +		this_dbs_info->cpu = cpu;
>  		this_dbs_info->down_skip = 0;
>  		this_dbs_info->requested_freq = policy->cur;
>  
> 

