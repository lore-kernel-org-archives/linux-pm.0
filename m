From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: ti: move to new dev_pm_opp_set_supported_hw() API
Date: Thu, 9 Feb 2017 23:00:49 +0100
Message-ID: <CAJZ5v0g-wYrrUdEDaNgjnTih7=U9RitK_88P5BoTtn1uJoxbAw@mail.gmail.com>
References: <20170209150240.1094801-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170209150240.1094801-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Dave Gerlach <d-gerlach@ti.com>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 9, 2017 at 4:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> We have a conflict between the interface change in one patch, and the
> newly added driver using the old interface:
>
> drivers/cpufreq/ti-cpufreq.c: In function 'ti_cpufreq_init':
> drivers/cpufreq/ti-cpufreq.c:250:6: error: assignment makes integer from pointer without a cast [-Werror=int-conversion]
>
> This adapts the driver accordingly.
>
> Fixes: fa30184d192e ("PM / OPP: Return opp_table from dev_pm_opp_set_*() routines")
> Fixes: 36cae4bca3bc ("cpufreq: ti: Add cpufreq driver to determine available OPPs at runtime")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/cpufreq/ti-cpufreq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index a2a4e84c6166..d1ae3e608f59 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -247,8 +247,8 @@ static int ti_cpufreq_init(void)
>
>         of_node_put(opp_data->opp_node);
>
> -       ret = dev_pm_opp_set_supported_hw(opp_data->cpu_dev, version,
> -                                         VERSION_COUNT);
> +       ret = PTR_ERR_OR_ZERO(dev_pm_opp_set_supported_hw(opp_data->cpu_dev,
> +                                                version, VERSION_COUNT));
>         if (ret) {
>                 dev_err(opp_data->cpu_dev,
>                         "Failed to set supported hardware\n");
> --

Thanks for the fix, but I fixed this up manually in the original patch
in the meantime.

Thanks,
Rafael
