From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 2/3] thermal: armada_thermal: Replace mdelay with msleep
 in armada375_init_sensor
Date: Thu, 26 Apr 2018 19:12:07 -0700
Message-ID: <20180427021204.GB30803@localhost.localdomain>
References: <1523347996-29417-1-git-send-email-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1523347996-29417-1-git-send-email-baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 10, 2018 at 04:13:16PM +0800, Jia-Ju Bai wrote:
> armada375_init_sensor() is never called in atomic context.
> 
> armada375_init_sensor() is set as ".init_sensor" in
> struct armada_thermal_data.
> ".init_sensor" is called armada_thermal_probe().
> armada_thermal_probe() is set as ".probe" in struct platform_driver.
> This function is not called in atomic context.
> 
> Despite never getting called from atomic context, armada375_init_sensor()
> calls mdelay() to busily wait.
> This is not necessary and can be replaced with msleep() to
> avoid busy waiting.
> 
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/thermal/armada_thermal.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index ae75328..0825a7a 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -127,11 +127,11 @@ static void armada375_init_sensor(struct platform_device *pdev,
>  	reg &= ~A375_HW_RESETn;
>  
>  	writel(reg, priv->control + 4);
> -	mdelay(20);
> +	msleep(20);
>  
>  	reg |= A375_HW_RESETn;
>  	writel(reg, priv->control + 4);
> -	mdelay(50);
> +	msleep(50);

Already done:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thermal/armada_thermal.c#n144

>  }
>  
>  static void armada380_init_sensor(struct platform_device *pdev,
> -- 
> 1.9.1
> 
