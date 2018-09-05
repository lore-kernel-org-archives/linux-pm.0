From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v1] thermal: core: Fix use-after-free in
 thermal_cooling_device_destroy_sysfs
Date: Wed, 5 Sep 2018 09:53:29 -0700
Message-ID: <20180905165327.GA1841@localhost.localdomain>
References: <20180813171400.15345-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180813171400.15345-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 13, 2018 at 08:14:00PM +0300, Dmitry Osipenko wrote:
> This patch fixes use-after-free that was detected by KASAN. The bug is
> triggered on a CPUFreq driver module unload by freeing 'cdev' on device
> unregister and then using the freed structure during of the cdev's sysfs
> data destruction. The solution is to unregister the sysfs at first, then
> destroy sysfs data and finally release the cooling device.
> 
> Cc: <stable@vger.kernel.org> # v4.17+
> Fixes: 8ea229511e06 ("thermal: Add cooling device's statistics in sysfs")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Acked-by: Eduardo Valentin <edubezval@gmail.com>

Rui, can you please queue this one?

> ---
>  drivers/thermal/thermal_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 6ab982309e6a..441778100887 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1102,8 +1102,9 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
>  	mutex_unlock(&thermal_list_lock);
>  
>  	ida_simple_remove(&thermal_cdev_ida, cdev->id);
> -	device_unregister(&cdev->device);
> +	device_del(&cdev->device);
>  	thermal_cooling_device_destroy_sysfs(cdev);
> +	put_device(&cdev->device);
>  }
>  EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
>  
> -- 
> 2.18.0
> 
