From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v2 4/9] cpufreq: Add a flag to auto-register a cooling device
Date: Mon, 14 Jan 2019 15:57:51 -0800
Message-ID: <154751027198.169631.16299398103212295726@swboyd.mtv.corp.google.com>
References: <cover.1547458732.git.amit.kucheria@linaro.org> <e195496f42375259f1b202eae39d20a56725f4a7.1547458732.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e195496f42375259f1b202eae39d20a56725f4a7.1547458732.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>, linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, viresh.kumar@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, tdas@codeaurora.org, dianders@chromium.org, mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Quoting Amit Kucheria (2019-01-14 02:21:06)
> All cpufreq drivers do similar things to register as a cooling device.
> Provide a cpufreq driver flag so drivers can just ask the cpufreq core
> to register the cooling device on their behalf. This allows us to get
> rid of duplicated code in the drivers.
>=20
> Suggested-by: Stephen Boyd <swboyd@chromium.org>
> Suggested-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---
>  drivers/cpufreq/cpufreq.c | 13 +++++++++++++
>  include/linux/cpufreq.h   |  6 ++++++
>  2 files changed, 19 insertions(+)
>=20
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 6f23ebb395f1..7faebfc61e60 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -30,6 +30,7 @@
>  #include <linux/syscore_ops.h>
>  #include <linux/tick.h>
>  #include <trace/events/power.h>
> +#include <linux/cpu_cooling.h>

Maybe this is supposed to be ordered alphabetically? If so, this should
be much higher.

> =20
>  static LIST_HEAD(cpufreq_policy_list);
> =20
> @@ -1318,6 +1319,12 @@ static int cpufreq_online(unsigned int cpu)
>         if (cpufreq_driver->ready)
>                 cpufreq_driver->ready(policy);
> =20
> +       if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
> +               struct thermal_cooling_device **cdev =3D &policy->cooldev;
> +
> +               *cdev =3D of_cpufreq_cooling_register(policy);
> +       }

This seems to be some complicated way of writing:

		policy->cooldev =3D of_cpufreq_cooling_register(policy);

?

> +
>         pr_debug("initialization complete\n");
> =20
>         return 0;
> @@ -1411,6 +1418,12 @@ static int cpufreq_offline(unsigned int cpu)
>         if (has_target())
>                 cpufreq_exit_governor(policy);
> =20
> +       if (cpufreq_driver->flags & CPUFREQ_AUTO_REGISTER_COOLING_DEV) {
> +               struct thermal_cooling_device **cdev =3D &policy->cooldev;
> +
> +               cpufreq_cooling_unregister(*cdev);

Similar? I'm confused!
