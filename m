From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2 2/2] cpufreq: dt: Implement online/offline() callbacks
Date: Tue, 12 Feb 2019 10:43:13 +0100
Message-ID: <CAJZ5v0hLOD-5XDp7jAwt4EqWYGAU9VZzumNchW9_+bt7F1MdQw@mail.gmail.com>
References: <cover.1549955027.git.viresh.kumar@linaro.org> <8030961ef762018fc286e4d3d3a010638e900e53.1549955027.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8030961ef762018fc286e4d3d3a010638e900e53.1549955027.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 12, 2019 at 8:07 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Implement the light-weight tear down and bring up helpers to reduce the
> amount of work to do on CPU offline/online operation.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq-dt.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
> index 7ba392911cd0..1aefaa1b0ca2 100644
> --- a/drivers/cpufreq/cpufreq-dt.c
> +++ b/drivers/cpufreq/cpufreq-dt.c
> @@ -295,6 +295,21 @@ static int cpufreq_init(struct cpufreq_policy *policy)
>         return ret;
>  }
>
> +static int cpufreq_online(struct cpufreq_policy *policy)
> +{
> +       /* We did light-weight tear down earlier, nothing to do here */
> +       return 0;
> +}

I think you could avoid having to add this empty stub if the core
checked for both online and offline, that is

if (driver->offline || driver->online) {
    ret = driver->online ? driver->online(policy) : 0;
} else {
    ret = driver->init(policy);
}

or similar.

> +
> +static int cpufreq_offline(struct cpufreq_policy *policy)
> +{
> +       /*
> +        * Preserve policy->driver_data and don't free resources on light-weight
> +        * tear down.
> +        */
> +       return 0;
> +}
> +
>  static int cpufreq_exit(struct cpufreq_policy *policy)
>  {
>         struct private_data *priv = policy->driver_data;
> @@ -319,6 +334,8 @@ static struct cpufreq_driver dt_cpufreq_driver = {
>         .get = cpufreq_generic_get,
>         .init = cpufreq_init,
>         .exit = cpufreq_exit,
> +       .online = cpufreq_online,
> +       .offline = cpufreq_offline,
>         .name = "cpufreq-dt",
>         .attr = cpufreq_dt_attr,
>         .suspend = cpufreq_generic_suspend,
> --
> 2.20.1.321.g9e740568ce00
>
