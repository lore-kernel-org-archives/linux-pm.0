From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: select IRQ_WORK in Kconfig
Date: Wed, 10 Feb 2016 16:28:33 +0100
Message-ID: <CAJZ5v0jqyd41Vzm61BEMeSHs=sAGYghM77nipBMVhQiyRfeqGw@mail.gmail.com>
References: <1455117265-3007562-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455117265-3007562-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 10, 2016 at 4:14 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The cpufreq core code has started using the irq_work infrastructure, but that
> can be disabled in Kconfig, causing a link failure:
>
> drivers/cpufreq/cpufreq_governor.c: In function 'gov_queue_irq_work':
> drivers/cpufreq/cpufreq_governor.c:251:3: error: implicit declaration of function 'irq_work_queue_on' [-Werror=implicit-function-declaration]
>
> This adds an explicit 'select' to ensure it's always enabled.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 0144fa03ef46 ("cpufreq: governor: Replace timers with utilization update callbacks")
> ---
>  drivers/cpufreq/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index 3050e8d48887..ca05037dd565 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -3,6 +3,7 @@ menu "CPU Frequency scaling"
>  config CPU_FREQ
>         bool "CPU Frequency scaling"
>         select SRCU
> +       select IRQ_WORK
>         help
>           CPU Frequency scaling allows you to change the clock speed of
>           CPUs on the fly. This is a nice method to save power, because
> --

Good catch, thanks!

I'll update the patch to do that.

Thanks,
Rafael
