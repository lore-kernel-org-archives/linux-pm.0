From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: arm_big_little: check if the frequency is
 set correctly
Date: Mon, 27 Apr 2015 15:56:18 +0530
Message-ID: <CAKohpomtkPCwHN1ivTSLOg9xj8nKGua=m8LerRG_djMfOr1DiA@mail.gmail.com>
References: <1430128266-15012-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430128266-15012-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On 27 April 2015 at 15:21, Sudeep Holla <sudeep.holla@arm.com> wrote:
> The actual frequency is set through "clk_change_rate" which is void
> function. If the underlying hardware fails and returns error, the error
> is lost in the clk layer. In order to track such failures, we need to
> read back the frequency(just the cached value as clk_recalc called after
> clk->ops->set_rate gets the frequency)
>
> This patch adds check to see if the frequency is set correctly or if
> they were any hardware failures and sends the appropriate errors to the
> cpufreq core.
>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Michael Turquette <mike.turquette@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/cpufreq/arm_big_little.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
> index e1a6ba66a7f5..f65e19f340d0 100644
> --- a/drivers/cpufreq/arm_big_little.c
> +++ b/drivers/cpufreq/arm_big_little.c
> @@ -186,6 +186,15 @@ bL_cpufreq_set_rate(u32 cpu, u32 old_cluster, u32 new_cluster, u32 rate)
>                 mutex_unlock(&cluster_lock[old_cluster]);
>         }
>
> +       /*
> +        * FIXME: clk_set_rate has to handle the case where clk_change_rate
> +        * can fail due to hardware or firmware issues. Until the clk core
> +        * layer is fixed, we can check here. In most of the cases we will
> +        * be reading only the cached value anyway. This needs to  be removed
> +        * once clk core is fixed.
> +        */
> +       if (bL_cpufreq_get_rate(cpu) != new_rate)
> +               return -EIO;
>         return 0;
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
