From: Pramod Gurav <pramod.gurav@smartplayin.com>
Subject: Re: [PATCH v3] power: reset: use restart_notifier mechanism for msm-poweroff
Date: Tue, 23 Sep 2014 11:58:13 +0530
Message-ID: <542112FD.7080302@smartplayin.com>
References: <1411452520-29589-1-git-send-email-pramod.gurav@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1411452520-29589-1-git-send-email-pramod.gurav@smartplayin.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Pramod Gurav <pramod.gurav@smartplayin.com>
Cc: linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Josh Cartwright <joshc@codeaurora.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-pm@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

+linux-arm-msm
On Tuesday 23 September 2014 11:38 AM, Pramod Gurav wrote:
> This change replaces use of arm_pm_restart with recently introduced
> reset mechanism in Linux kernel called restart_notifier.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Josh Cartwright <joshc@codeaurora.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: linux-pm@vger.kernel.org
> 
> Signed-off-by: Pramod Gurav <pramod.gurav@smartplayin.com>
> ---
> Tested on Dragonboard APQ8074
> 
> Changes since v2:
> - Removed unwanted header file and added linux/pm.h
> 
> Changes since v1:
> - Initialized restart_nb with its declaration
> - Removed return check for register_restart_handler as it always
>   returns 0 as per Guenter's suggestion to Josh's similar patch.
>   This takes care of Guenter's comments on error logs and NULL
>   initialization of restart_nb.notifier_call.
> ---
>  drivers/power/reset/msm-poweroff.c |   20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/power/reset/msm-poweroff.c b/drivers/power/reset/msm-poweroff.c
> index 774f9a3..4702efd 100644
> --- a/drivers/power/reset/msm-poweroff.c
> +++ b/drivers/power/reset/msm-poweroff.c
> @@ -20,21 +20,27 @@
>  #include <linux/platform_device.h>
>  #include <linux/module.h>
>  #include <linux/reboot.h>
> -
> -#include <asm/system_misc.h>
> +#include <linux/pm.h>
>  
>  static void __iomem *msm_ps_hold;
> -
> -static void do_msm_restart(enum reboot_mode reboot_mode, const char *cmd)
> +static int do_msm_restart(struct notifier_block *nb, unsigned long action,
> +			   void *data)
>  {
>  	writel(0, msm_ps_hold);
>  	mdelay(10000);
> +
> +	return NOTIFY_DONE;
>  }
>  
> +static struct notifier_block restart_nb = {
> +	.notifier_call = do_msm_restart,
> +	.priority = 128,
> +};
> +
>  static void do_msm_poweroff(void)
>  {
>  	/* TODO: Add poweroff capability */
> -	do_msm_restart(REBOOT_HARD, NULL);
> +	do_msm_restart(&restart_nb, 0, NULL);
>  }
>  
>  static int msm_restart_probe(struct platform_device *pdev)
> @@ -47,8 +53,10 @@ static int msm_restart_probe(struct platform_device *pdev)
>  	if (IS_ERR(msm_ps_hold))
>  		return PTR_ERR(msm_ps_hold);
>  
> +	register_restart_handler(&restart_nb);
> +
>  	pm_power_off = do_msm_poweroff;
> -	arm_pm_restart = do_msm_restart;
> +
>  	return 0;
>  }
>  
> 
