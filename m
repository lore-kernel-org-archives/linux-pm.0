From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 1/5] cpufreq: Don't wait for CPU to going offline to
 restart governor
Date: Thu, 7 Aug 2014 14:24:37 +0530
Message-ID: <CAKohpon=xWZJzfN0PceVntumAUFfCsbG1ibUwSxewB7bE=U7bQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Saravana Kannan <skannan@codeaurora.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Todd Poynor <toddpoynor@google.com>, "Srivatsa S . Bhat" <srivatsa@mit.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Sorry for the really long delay this time around. I am used to replying within a
day normally, and this time it just took so much time.

For next time please rebase on latest updates in pm/linux-next as there are
few updates there.

On 25 July 2014 06:37, Saravana Kannan <skannan@codeaurora.org> wrote:
> There's no need to wait for the CPU going down to fully go offline to
> restart the governor. We can stop the governor, change policy->cpus and
> immediately restart the governor. This should reduce the time without any
> CPUfreq monitoring and also help future patches with simplifying the code.

I agree with the idea here, though the $subject can be improved a bit
here..

> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> ---
>  drivers/cpufreq/cpufreq.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 62259d2..ee0eb7b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1390,6 +1390,21 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
>                 cpufreq_driver->stop_cpu(policy);
>         }
>
> +       down_write(&policy->rwsem);
> +       cpumask_clear_cpu(cpu, policy->cpus);
> +       up_write(&policy->rwsem);

There is a down_read() present early in this routine and we better update this
at that place only.

> +       if (cpus > 1 && has_target()) {

We already have a if (cpus > 1) block, move this there.

> +               ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
> +               if (!ret)
> +                       ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
> +
> +               if (ret) {
> +                       pr_err("%s: Failed to start governor\n", __func__);
> +                       return ret;
> +               }
> +       }
> +
>         return 0;
>  }
>
> @@ -1410,15 +1425,12 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
>                 return -EINVAL;
>         }
>
> -       down_write(&policy->rwsem);
> +       down_read(&policy->rwsem);
>         cpus = cpumask_weight(policy->cpus);
> -
> -       if (cpus > 1)
> -               cpumask_clear_cpu(cpu, policy->cpus);
> -       up_write(&policy->rwsem);
> +       up_read(&policy->rwsem);
>
>         /* If cpu is last user of policy, free policy */
> -       if (cpus == 1) {
> +       if (cpus == 0) {
>                 if (has_target()) {
>                         ret = __cpufreq_governor(policy,
>                                         CPUFREQ_GOV_POLICY_EXIT);
> @@ -1447,15 +1459,6 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
>
>                 if (!cpufreq_suspended)
>                         cpufreq_policy_free(policy);
> -       } else if (has_target()) {
> -               ret = __cpufreq_governor(policy, CPUFREQ_GOV_START);
> -               if (!ret)
> -                       ret = __cpufreq_governor(policy, CPUFREQ_GOV_LIMITS);
> -
> -               if (ret) {
> -                       pr_err("%s: Failed to start governor\n", __func__);
> -                       return ret;
> -               }
>         }

Also, you must mention in the log about an important change you are making.
Don't know if there are any side effects...

You are emptying policy->cpus on removal of last CPU of a policy, which wasn't
the case earlier.
