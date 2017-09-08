From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH V2 13/13] thermal/drivers/hisi: Remove mutex_lock in the
 code
Date: Thu, 7 Sep 2017 20:25:43 -0700
Message-ID: <20170908032542.GF2755@localhost.localdomain>
References: <1504554972-2624-1-git-send-email-daniel.lezcano@linaro.org>
 <1504554972-2624-13-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1504554972-2624-13-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, kevin.wangtao@linaro.org, leo.yan@linaro.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Sep 04, 2017 at 09:56:12PM +0200, Daniel Lezcano wrote:
> The mutex is used to protect against writes in the configuration register.
> 
> That happens at probe time, with no possible race yet.
> 
> Then when the module is unloaded and at suspend/resume.
> 
> When the module is unloaded, it is an userspace operation, thus via a process.
> Suspending the system goes through the freezer to suspend all the tasks
> synchronously before continuing. So it is not possible to hit the suspend ops
> in this driver while we are unloading it.
> 
> The resume is the same situation than the probe.
> 
> In other words, even if there are several places where we write the
> configuration register, there is no situation where we can write it at the same
> time, so far as I can judge

To me is good to trend towards removal of a lock. Also keep in mind that
the thermal zone has a lock of its own. However, remember that get temp
may be called also from sysfs interaction, from your threaded irq and
from the workqueue in the thermal core that does the polling state
machine.

> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Leo Yan <leo.yan@linaro.org>
> Tested-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/thermal/hisi_thermal.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
> index cce3d10..39f4627 100644
> --- a/drivers/thermal/hisi_thermal.c
> +++ b/drivers/thermal/hisi_thermal.c
> @@ -53,7 +53,6 @@ struct hisi_thermal_sensor {
>  };
>  
>  struct hisi_thermal_data {
> -	struct mutex thermal_lock;    /* protects register data */
>  	struct platform_device *pdev;
>  	struct clk *clk;
>  	struct hisi_thermal_sensor sensor;
> @@ -200,14 +199,10 @@ static inline void hisi_thermal_hdak_set(void __iomem *addr, int value)
>  
>  static void hisi_thermal_disable_sensor(struct hisi_thermal_data *data)
>  {
> -	mutex_lock(&data->thermal_lock);
> -
>  	/* disable sensor module */
>  	hisi_thermal_enable(data->regs, 0);
>  	hisi_thermal_alarm_enable(data->regs, 0);
>  	hisi_thermal_reset_enable(data->regs, 0);
> -
> -	mutex_unlock(&data->thermal_lock);
>  }
>  
>  static int hisi_thermal_get_temp(void *__data, int *temp)
> @@ -344,7 +339,6 @@ static int hisi_thermal_probe(struct platform_device *pdev)
>  	if (!data)
>  		return -ENOMEM;
>  
> -	mutex_init(&data->thermal_lock);
>  	data->pdev = pdev;
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -- 
> 2.7.4
> 
