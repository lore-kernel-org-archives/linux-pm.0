From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 1/3] thermal: armada_thermal: Replace mdelay with
 usleep_range in armada370_init_sensor
Date: Thu, 26 Apr 2018 19:11:24 -0700
Message-ID: <20180427021122.GA30803@localhost.localdomain>
References: <1523347982-29373-1-git-send-email-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1523347982-29373-1-git-send-email-baijiaju1990@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hey Jia-Ju,

On Tue, Apr 10, 2018 at 04:13:02PM +0800, Jia-Ju Bai wrote:
> armada370_init_sensor() is never called in atomic context.
> 
> armada370_init_sensor() is set as ".init_sensor" in 
> struct armada_thermal_data.
> ".init_sensor" is called armada_thermal_probe().
> armada_thermal_probe() is set as ".probe" in struct platform_driver.
> This function is not called in atomic context.
> 
> Despite never getting called from atomic context, armada370_init_sensor()
> calls mdelay() to busily wait.
> This is not necessary and can be replaced with usleep_range() to
> avoid busy waiting.
> 
> This is found by a static analysis tool named DCNS written by myself.
> And I also manually check it.
> 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> ---
>  drivers/thermal/armada_thermal.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
> index ae75328..807fe74 100644
> --- a/drivers/thermal/armada_thermal.c
> +++ b/drivers/thermal/armada_thermal.c
> @@ -113,7 +113,7 @@ static void armada370_init_sensor(struct platform_device *pdev,
>  	reg &= ~PMU_TDC0_START_CAL_MASK;
>  	writel(reg, priv->control);
>  
> -	mdelay(10);
> +	usleep_range(10000, 11000);

Cool, but these have been already translated into msleep():
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/thermal/armada_thermal.c#n141


>  }
>  
>  static void armada375_init_sensor(struct platform_device *pdev,
> -- 
> 1.9.1
> 
