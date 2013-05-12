From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] Cpufreq: Fix incorrect dependecies for ARM SA11xx drivers
Date: Sun, 12 May 2013 20:34:56 +0530
Message-ID: <CAOh2x=mL-_fm8pxUCJCM1MWQxca2ygJWpDS_OTnOfcLS4ZHC1g@mail.gmail.com>
References: <1367756288-13422-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1367756288-13422-1-git-send-email-shc_work@mail.ru>
Sender: cpufreq-owner@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Sun, May 5, 2013 at 5:48 PM, Alexander Shiyan <shc_work@mail.ru> wrote:
>
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  drivers/cpufreq/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index a1488f5..534fcb8 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -47,7 +47,7 @@ config CPU_FREQ_STAT_DETAILS
>
>  choice
>         prompt "Default CPUFreq governor"
> -       default CPU_FREQ_DEFAULT_GOV_USERSPACE if CPU_FREQ_SA1100 || CPU_FREQ_SA1110
> +       default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1100_CPUFREQ || ARM_SA1110_CPUFREQ
>         default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
>         help
>           This option sets which CPUFreq governor shall be loaded at

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
