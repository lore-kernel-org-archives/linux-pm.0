From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v2] cpufreq: arm_big_little: fix frequency check when bL switcher
 is active
Date: Mon, 26 Oct 2015 05:42:28 -0700
Message-ID: <20151026124228.22783.64941@quantum>
References: <1445421333.2916.13.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445421333.2916.13.camel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Jon Medhurst (Tixy)" <tixy@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Quoting Jon Medhurst (Tixy) (2015-10-21 02:55:33)
> The check for correct frequency being set in bL_cpufreq_set_rate is
> broken when the big.LITTLE switcher is active, for two reasons.
> 
> 1. The 'new_rate' variable gets overwritten before the test by the
> code calculating the frequency of the old cluster.
> 
> 2. The frequency returned by bL_cpufreq_get_rate will be the virtual
> frequency, not the actual one the intended version of new_rate contains.
> 
> This means the function always returns an error causing an endless
> stream of: "cpufreq: __target_index: Failed to change cpu frequency: -5"
> 
> As the intent is to check for errors that clk_set_rate doesn't report
> lets move the check to immediately after that and directly use
> clk_get_rate, rather than the arm_big_little helpers which only confuse
> matters. Also, update the comment to be hopefully clearer about the
> purpose of the code.
> 
> Fixes: 0a95e630b49a ("cpufreq: arm_big_little: check if the frequency is set correctly")
> 
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Michael Turquette <mturquette@baylibre.com>

Fixing exception paths for clk_change_rate is on the TODO list.

Regards,
Mike

> ---
> 
> Changes since V1:
> - Check rate using clk_get_rate rather than disabling check when bL
>   switcher active
> 
> Sudeep, I added your Ack from the last comment on the previous patch.
> This final patch differs from what was discussed only in the commit
> message and in source comment which is hopefully more clear and is
> also satisfactory.
> 
> I've also added Michael Turquette's correct email to the CC this time,
> rather than his old Linaro address which was bouncing.
> 
>  drivers/cpufreq/arm_big_little.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
> index f1e42f8..c5d256c 100644
> --- a/drivers/cpufreq/arm_big_little.c
> +++ b/drivers/cpufreq/arm_big_little.c
> @@ -149,6 +149,19 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
>                         __func__, cpu, old_cluster, new_cluster, new_rate);
>  
>         ret = clk_set_rate(clk[new_cluster], new_rate * 1000);
> +       if (!ret) {
> +               /*
> +                * FIXME: clk_set_rate hasn't returned an error here however it
> +                * may be that clk_change_rate failed due to hardware or
> +                * firmware issues and wasn't able to report that due to the
> +                * current design of the clk core layer. To work around this
> +                * problem we will read back the clock rate and check it is
> +                * correct. This needs to be removed once clk core is fixed.
> +                */
> +               if (clk_get_rate(clk[new_cluster]) != new_rate * 1000)
> +                       ret = -EIO;
> +       }
> +
>         if (WARN_ON(ret)) {
>                 pr_err("clk_set_rate failed: %d, new cluster: %d\n", ret,
>                                 new_cluster);
> @@ -189,15 +202,6 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
>                 mutex_unlock(&cluster_lock[old_cluster]);
>         }
>  
> -       /*
> -        * FIXME: clk_set_rate has to handle the case where clk_change_rate
> -        * can fail due to hardware or firmware issues. Until the clk core
> -        * layer is fixed, we can check here. In most of the cases we will
> -        * be reading only the cached value anyway. This needs to  be removed
> -        * once clk core is fixed.
> -        */
> -       if (bL_cpufreq_get_rate(cpu) != new_rate)
> -               return -EIO;
>         return 0;
>  }
>  
> -- 
> 2.1.4
> 
> 
> 
