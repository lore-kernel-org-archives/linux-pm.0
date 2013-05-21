From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: spurious bL cpufreq driver messages
Date: Wed, 22 May 2013 01:45:46 +0200
Message-ID: <11917612.jOVuLqOMKF@vostro.rjw.lan>
References: <519686BC.3090101@gmail.com> <CAL_JsqLEv38DwnL4=ToXtEKNrDbgYv_0qiOc+cXZSjnfKVbeNg@mail.gmail.com> <CAKohpomG5E2FAeZGnX3eBw8fOiX3K8sWEeHgb5NT_FT3y+Cg1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:44131 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751972Ab3EUXhH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 21 May 2013 19:37:07 -0400
In-Reply-To: <CAKohpomG5E2FAeZGnX3eBw8fOiX3K8sWEeHgb5NT_FT3y+Cg1w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robherring2@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>

On Monday, May 20, 2013 10:06:49 AM Viresh Kumar wrote:
> On 19 May 2013 01:21, Rob Herring <robherring2@gmail.com> wrote:
> > No, it still registers the bL driver. The problem is not that DT data
> > is missing, but it is present on a single cluster system.
> 
> I misread your mail.. I got the problem now.. Below should fix your
> issue (It is rebased on the patch I pointed to you earlier):
> 
> Attached too for testing as gmail copy-paste will break it.
> 
> @Rafael: Once Rob gives his Tested-by, please queue it for 3.10-rcs
> 
> ------------x-----------------x-----------------
> 
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Mon, 20 May 2013 09:57:17 +0530
> Subject: [PATCH] cpufreq: arm_big_little_dt: Instantiate as platform_driver
> 
> As multiplatform build is being adopted by more and more ARM platforms, initcall
> function should be used very carefully. For example, when both arm_big_little_dt
> and cpufreq-cpu0 drivers are compiled in, arm_big_little_dt driver may try to
> register even if we had platform device for cpufreq-cpu0 registered.
> 
> To eliminate this undesired the effect, the patch changes arm_big_little_dt
> driver to have it instantiated as a platform_driver. Then it will only run on
> platforms that create the platform_device "arm-bL-cpufreq-dt".
> 
> Reported-by: Rob Herring <robherring2@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

The patch (from the attachment) didn't apply for me.  Please check the
bleeding-edge branch.

Thanks,
Rafael


> ---
>  drivers/cpufreq/arm_big_little_dt.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/arm_big_little_dt.c
> b/drivers/cpufreq/arm_big_little_dt.c
> index 27e2f45..fd9e3ea 100644
> --- a/drivers/cpufreq/arm_big_little_dt.c
> +++ b/drivers/cpufreq/arm_big_little_dt.c
> @@ -26,6 +26,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/opp.h>
> +#include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include "arm_big_little.h"
> @@ -95,7 +96,7 @@ static struct cpufreq_arm_bL_ops dt_bL_ops = {
>  	.init_opp_table = dt_init_opp_table,
>  };
> 
> -static int generic_bL_init(void)
> +static int generic_bL_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np;
> 
> @@ -106,13 +107,22 @@ static int generic_bL_init(void)
>  	of_node_put(np);
>  	return bL_cpufreq_register(&dt_bL_ops);
>  }
> -module_init(generic_bL_init);
> 
> -static void generic_bL_exit(void)
> +static int generic_bL_remove(struct platform_device *pdev)
>  {
> -	return bL_cpufreq_unregister(&dt_bL_ops);
> +	bL_cpufreq_unregister(&dt_bL_ops);
> +	return 0;
>  }
> -module_exit(generic_bL_exit);
> +
> +static struct platform_driver generic_bL_platdrv = {
> +	.driver = {
> +		.name	= "arm-bL-cpufreq-dt",
> +		.owner	= THIS_MODULE,
> +	},
> +	.probe		= generic_bL_probe,
> +	.remove		= generic_bL_remove,
> +};
> +module_platform_driver(generic_bL_platdrv);
> 
>  MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
>  MODULE_DESCRIPTION("Generic ARM big LITTLE cpufreq driver via DT");
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
