From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] devfreq: Suspend all devices on system shutdown
Date: Mon, 28 Jan 2019 10:17:17 +0900
Message-ID: <9fbfc35c-9448-f1ae-6e47-7d5f6bba22de@samsung.com>
References: <CGME20190125135414eucas1p2ffc71c63f1a27f67d076dec889954b40@eucas1p2.samsung.com>
        <20190125135403.10228-1-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125135403.10228-1-m.szyprowski@samsung.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Luba <l.luba@partner.samsung.com>, Markus Reichl <m.reichl@fivetechno.de>
List-Id: linux-pm@vger.kernel.org

Hi,

On 19. 1. 25. 오후 10:54, Marek Szyprowski wrote:
> This way devfreq core ensures that all its devices will be set to safe
> operation points before reboot operation. There are board on which some
> aggressive power saving operation points are behind the capabilities of
> the bootloader to properly reset the hardware and boot the board. This
> way one can avoid board crash early after reboot.
> 
> Similar pattern is used in CPUfreq subsystem.
> 
> Reported-by: Markus Reichl <m.reichl@fivetechno.de>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 0ae3de76833b..f6aba8344c56 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -23,6 +23,7 @@
>  #include <linux/devfreq.h>
>  #include <linux/workqueue.h>
>  #include <linux/platform_device.h>
> +#include <linux/syscore_ops.h>
>  #include <linux/list.h>
>  #include <linux/printk.h>
>  #include <linux/hrtimer.h>
> @@ -1422,6 +1423,10 @@ static struct attribute *devfreq_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(devfreq);
>  
> +static struct syscore_ops devfreq_syscore_ops = {
> +	.shutdown = devfreq_suspend,
> +};
> +
>  static int __init devfreq_init(void)
>  {
>  	devfreq_class = class_create(THIS_MODULE, "devfreq");
> @@ -1438,6 +1443,8 @@ static int __init devfreq_init(void)
>  	}
>  	devfreq_class->dev_groups = devfreq_groups;
>  
> +	register_syscore_ops(&devfreq_syscore_ops);
> +
>  	return 0;
>  }
>  subsys_initcall(devfreq_init);
> 

Looks good to me.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
