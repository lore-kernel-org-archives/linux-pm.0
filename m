From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v2] power: reset: use restart_notifier mechanism for
 msm-poweroff
Date: Mon, 22 Sep 2014 10:30:41 -0700
Message-ID: <20140922173041.GE10233@codeaurora.org>
References: <1411371774-6834-1-git-send-email-pramod.gurav@smartplayin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1411371774-6834-1-git-send-email-pramod.gurav@smartplayin.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Pramod Gurav <pramod.gurav@smartplayin.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Josh Cartwright <joshc@codeaurora.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09/22, Pramod Gurav wrote:
> diff --git a/drivers/power/reset/msm-poweroff.c b/drivers/power/reset/msm-poweroff.c
> index 774f9a3..db73238 100644
> --- a/drivers/power/reset/msm-poweroff.c
> +++ b/drivers/power/reset/msm-poweroff.c
> @@ -24,17 +24,24 @@
>  #include <asm/system_misc.h>

We can remove this include now too?

>  
>  static void __iomem *msm_ps_hold;
> -
[...]
> @@ -47,8 +54,10 @@ static int msm_restart_probe(struct platform_device *pdev)
>  	if (IS_ERR(msm_ps_hold))
>  		return PTR_ERR(msm_ps_hold);
>  
> +	register_restart_handler(&restart_nb);
> +
>  	pm_power_off = do_msm_poweroff;
> -	arm_pm_restart = do_msm_restart;
> +

And it looks like we should be including <linux/pm.h> for the
pm_power_off hook?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
