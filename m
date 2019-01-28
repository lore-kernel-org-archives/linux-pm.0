From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v4 2/9] cpufreq: Auto-register the driver as a thermal
 cooling device if asked
Date: Mon, 28 Jan 2019 10:03:19 +0100
Message-ID: <CAJZ5v0huESFqOADqyym-ci-XcWpL4tbcd9a-jxe_KArXKpHFyw@mail.gmail.com>
References: <cover.1548654899.git.amit.kucheria@linaro.org> <f6f09e5af6fe78fc27cbdc53a8dc688c6b4124b7.1548654899.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f6f09e5af6fe78fc27cbdc53a8dc688c6b4124b7.1548654899.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, Stephen Boyd <swboyd@chromium.org>, Doug Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Tao Wang <kevin.wangtao@hisilicon.com>, Sudeep Holla <sudeep.holla@arm.com>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 28, 2019 at 7:44 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> All cpufreq drivers do similar things to register as a cooling device.
> Provide a cpufreq driver flag so drivers can just ask the cpufreq core
> to register the cooling device on their behalf. This allows us to get
> rid of duplicated code in the drivers.
>
> In order to allow this, we add a struct thermal_cooling_device pointer
> to struct cpufreq_policy so that drivers don't need to store it in a
> private data structure.
>
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  drivers/cpufreq/cpufreq.c | 9 +++++++++
>  include/linux/cpufreq.h   | 9 +++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index e35a886e00bc..29ed78b0b77b 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -19,6 +19,7 @@
>
>  #include <linux/cpu.h>
>  #include <linux/cpufreq.h>
> +#include <linux/cpu_cooling.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/init.h>
> @@ -1318,6 +1319,9 @@ static int cpufreq_online(unsigned int cpu)
>         if (cpufreq_driver->ready)
>                 cpufreq_driver->ready(policy);
>
> +       if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV)

It would be good to use IS_ENABLED(CONFIG_CPU_THERMAL) here and below
as a hint for the compiler.

> +               policy->cdev = of_cpufreq_cooling_register(policy);
> +
>         pr_debug("initialization complete\n");
>
>         return 0;
> @@ -1405,6 +1409,11 @@ static int cpufreq_offline(unsigned int cpu)
>                 goto unlock;
>         }
>
> +       if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
> +               cpufreq_cooling_unregister(policy->cdev);
> +               policy->cdev = NULL;
> +       }
> +
>         if (cpufreq_driver->stop_cpu)
>                 cpufreq_driver->stop_cpu(policy);
>
