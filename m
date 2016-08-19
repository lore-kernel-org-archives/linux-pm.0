From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: Always enable debugfs support if available
Date: Fri, 19 Aug 2016 13:32:51 +0200
Message-ID: <CAPDyKFp_MunWh4nR1MV8F_An9QctJnxyE1=U-m8DVEaL_gz=jg@mail.gmail.com>
References: <1470912005-10914-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470912005-10914-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 11 August 2016 at 12:40, Jon Hunter <jonathanh@nvidia.com> wrote:
> Debugfs support for PM domains is only enabled if both CONFIG_PM_DEBUG
> and CONFIG_PM_ADVANCED_DEBUG are enabled. CONFIG_PM_ADVANCED_DEBUG is
> described as "extra PM attributes in sysfs for low-level
> debugging/testing" which does not seem related.
>
> Given that the debugfs for PM domains only allows users to view the
> state of the PM domains, always enable debugfs support for PM domains
> if PM domains and debugfs support is enabled.
>
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index a1f2aff33997..058c8b6d2871 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1636,7 +1636,7 @@ EXPORT_SYMBOL_GPL(genpd_dev_pm_attach);
>
>  /***        debugfs support        ***/
>
> -#ifdef CONFIG_PM_ADVANCED_DEBUG
> +#ifdef CONFIG_DEBUG_FS
>  #include <linux/pm.h>
>  #include <linux/device.h>
>  #include <linux/debugfs.h>
> @@ -1784,4 +1784,4 @@ static void __exit pm_genpd_debug_exit(void)
>         debugfs_remove_recursive(pm_genpd_debugfs_dir);
>  }
>  __exitcall(pm_genpd_debug_exit);
> -#endif /* CONFIG_PM_ADVANCED_DEBUG */
> +#endif /* CONFIG_DEBUG_FS */
> --
> 2.1.4
>
