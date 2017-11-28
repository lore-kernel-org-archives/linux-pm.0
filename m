From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: longhaul: Set transition_delay_us to 20 ms
Date: Tue, 28 Nov 2017 23:07:36 +0100
Message-ID: <CAJZ5v0gTk_XpszbnvifxiaySMXomDSxpcr_yG2MPpLvX6L4CFA@mail.gmail.com>
References: <alpine.LRH.2.21.1711241741080.10361@math.ut.ee> <ed89c17b60d7183144ab4ac4b125fbed373fe670.1511838689.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ed89c17b60d7183144ab4ac4b125fbed373fe670.1511838689.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Meelis Roos <mroos@linux.ee>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, "4 . 14+" <stable@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 28, 2017 at 4:11 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> The commit e948bc8fbee0 ("cpufreq: Cap the default transition delay
> value to 10 ms") caused a regression on EPIA-M min-ITX computer where
> shutdown or reboot hangs occasionally with a print message like:
>
> longhaul: Warning: Timeout while waiting for idle PCI bus
> cpufreq: __target_index: Failed to change cpu frequency: -16
>
> This probably happens because the cpufreq governor tries to change the
> frequency of the CPU faster than allowed by the hardware.
>
> With the above commit, the default transition delay comes to 10 ms for a
> transition_latency of 200 us. Set the default transition delay to 20 ms
> directly to fix this regression.
>
> Fixes: e948bc8fbee0 ("cpufreq: Cap the default transition delay value to 10 ms")
> Cc: 4.14+ <stable@vger.kernel.org> # 4.14+
> Reported-by: Meelis Roos <mroos@linux.ee>
> Suggested-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/longhaul.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
> index c46a12df40dd..56eafcb07859 100644
> --- a/drivers/cpufreq/longhaul.c
> +++ b/drivers/cpufreq/longhaul.c
> @@ -894,7 +894,7 @@ static int longhaul_cpu_init(struct cpufreq_policy *policy)
>         if ((longhaul_version != TYPE_LONGHAUL_V1) && (scale_voltage != 0))
>                 longhaul_setup_voltagescaling();
>
> -       policy->cpuinfo.transition_latency = 200000;    /* nsec */
> +       policy->transition_delay_us = 20000;    /* usec */
>
>         return cpufreq_table_validate_and_show(policy, longhaul_table);
>  }
> --

Meelis, please check if this fixes the shutdown issue you have
reported recently.

Thanks,
Rafael
