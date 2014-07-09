From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 03/14] cpufreq: Add support for per-policy driver data
Date: Wed, 9 Jul 2014 10:33:21 -0400
Message-ID: <53BD52B1.4060608@ti.com>
References: <cover.1404231535.git.viresh.kumar@linaro.org> <0614df495e361dd23ebe2d4e4ee3d40cb23948da.1404231535.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <0614df495e361dd23ebe2d4e4ee3d40cb23948da.1404231535.git.viresh.kumar@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@rjwysocki.net, shawn.guo@linaro.org
Cc: nm@ti.com, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, t.figa@samsung.com, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, thomas.ab@samsung.com, arvind.chauhan@arm.com, spk.linux@gmail.com
List-Id: linux-pm@vger.kernel.org

On Tuesday 01 July 2014 12:32 PM, Viresh Kumar wrote:
> Drivers supporting multiple clusters or multiple 'struct cpufreq_policy'
> instances may need to keep per-policy data. If the core doesn't support them,
> they might do it in the most unoptimized way: 'per-cpu' data.
> 
> This patch adds another field in 'struct cpufreq_policy': 'driver_data'. It
> isn't accessed by core and is for driver's internal use.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  include/linux/cpufreq.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index ec4112d..d4b1108 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -112,6 +112,9 @@ struct cpufreq_policy {
>  	spinlock_t		transition_lock;
>  	wait_queue_head_t	transition_wait;
>  	struct task_struct	*transition_task; /* Task which is doing the transition */
> +
> +	/* For cpufreq driver's internal use */
> +	void			*driver_data;
>  };
>  
Minor comment for consistency either maintain same commenting style
for the above structure (description after the variable) or may
be clean up the comments in another patch.

Regards,
Santosh
