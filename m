From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: Re: [PATCH] cpufreq: Initialize the governor again while restoring policy
Date: Wed, 8 Jul 2015 14:02:19 +0800
Message-ID: <CALx668VuejL=DduQMe4Bi51m+U78r+h-EOYLprqm1PvLp0ecrA@mail.gmail.com>
References: <f428ecb0927075b25cf7e2ea5fb00eab3d254fdd.1436333568.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f428ecb0927075b25cf7e2ea5fb00eab3d254fdd.1436333568.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Jon Medhurst (Tixy)" <tixy@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 8, 2015 at 1:53 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> When all CPUs of a policy are hot-unplugged, we EXIT the governor but
> don't mark policy->governor as NULL. This was done in order to keep last
> used governor's information intact in sysfs, while the CPUs are offline.
>
> We also missed marking policy->governor as NULL while restoring the
> policy. Because of that, we call __cpufreq_governor(CPUFREQ_GOV_LIMITS)
> for an uninitialized policy. Which eventually returns -EBUSY.
>
> Fix this by setting policy->governor to NULL while restoring the policy.

Tested-by: "Pi-Cheng Chen <pi-cheng.chen@linaro.org>"

Thanks for your fix.

>
> Reported-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> Reported-by: "Jon Medhurst (Tixy)" <tixy@linaro.org>
> Fixes: 18bf3a124ef8 ("cpufreq: Mark policy->governor = NULL for inactive policies")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> For 4.2-rc
>
>  drivers/cpufreq/cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index b612411655f9..2c22e3902e72 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -1132,6 +1132,7 @@ static struct cpufreq_policy *cpufreq_policy_restore(unsigned int cpu)
>
>                 down_write(&policy->rwsem);
>                 policy->cpu = cpu;
> +               policy->governor = NULL;
>                 up_write(&policy->rwsem);
>         }
>
> --
> 2.4.0
>
