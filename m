From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] cpufreq: Allow light-weight tear down on CPU offline operation
Date: Mon, 11 Feb 2019 11:51:07 +0100
Message-ID: <CAJZ5v0hhxUQxf9VbhU_6B29MYspNo0Go+o4_OkxgnBe8+bGTdw@mail.gmail.com>
References: <cover.1549874368.git.viresh.kumar@linaro.org> <03ac36a174f6c28be0b3af9d2db8631d56695f1d.1549874368.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <03ac36a174f6c28be0b3af9d2db8631d56695f1d.1549874368.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 11, 2019 at 9:41 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The cpufreq core doesn't remove the cpufreq policy anymore on CPU
> offline operation, rather that happens when the CPU device gets
> unregistered from the kernel. This allows faster recovery when the CPU
> comes back online. This is also very useful during system wide
> suspend/resume where we offline all non-boot CPUs during suspend and
> then bring them back on resume.
>
> This commit takes the same idea a step ahead to allow drivers to do
> light weight tear-down during CPU offline operation.
>
> A new callback is introduced, light_weight_exit(), which gets called
> when all the CPUs of a policy are removed/offlined and the existing
> exit() callback gets called when the policy gets freed.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 16 +++++++++++-----
>  include/linux/cpufreq.h   |  1 +
>  2 files changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 96a69c67a545..215a8bfc78bb 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1421,11 +1421,12 @@ static int cpufreq_offline(unsigned int cpu)
>                 cpufreq_exit_governor(policy);
>
>         /*
> -        * Perform the ->exit() even during light-weight tear-down,
> -        * since this is a core component, and is essential for the
> -        * subsequent light-weight ->init() to succeed.
> +        * Perform the ->light_weight_exit() during light-weight tear-down, as
> +        * that allows fast recovery when the CPU comes back.
>          */
> -       if (cpufreq_driver->exit) {
> +       if (cpufreq_driver->light_weight_exit) {
> +               cpufreq_driver->light_weight_exit(policy);
> +       } else if (cpufreq_driver->exit) {
>                 cpufreq_driver->exit(policy);
>                 policy->freq_table = NULL;
>         }
> @@ -1454,8 +1455,13 @@ static void cpufreq_remove_dev(struct device *dev, struct subsys_interface *sif)
>         cpumask_clear_cpu(cpu, policy->real_cpus);
>         remove_cpu_dev_symlink(policy, dev);
>
> -       if (cpumask_empty(policy->real_cpus))
> +       if (cpumask_empty(policy->real_cpus)) {
> +               /* We did light-weight exit earlier, do full tear down now */
> +               if (cpufreq_driver->light_weight_exit)
> +                       cpufreq_driver->exit(policy);
> +
>                 cpufreq_policy_free(policy);
> +       }
>  }
>
>  /**
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index 9db074ecbbd7..36ce31516041 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -325,6 +325,7 @@ struct cpufreq_driver {
>         /* optional */
>         int             (*bios_limit)(int cpu, unsigned int *limit);
>
> +       int             (*light_weight_exit)(struct cpufreq_policy *policy);

Can you call it "offline"?

>         int             (*exit)(struct cpufreq_policy *policy);
>         void            (*stop_cpu)(struct cpufreq_policy *policy);
>         int             (*suspend)(struct cpufreq_policy *policy);
> --
