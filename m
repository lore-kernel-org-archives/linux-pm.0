From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH RESEND 06/11] thermal: use EXPORT_SYMBOL_GPL
Date: Wed, 17 Apr 2013 23:20:46 +0800
Message-ID: <1366212046.2091.57.camel@rzhang1-mobl4>
References: <1365437258-31412-1-git-send-email-eduardo.valentin@ti.com>
	 <1365437258-31412-7-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1365437258-31412-7-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2013-04-08 at 12:07 -0400, Eduardo Valentin wrote:
> Restrict usage of GPL modules.
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>

NACK for
thermal_zone_trend_get/thermal_instance_get/thermal_cdev_update, for the
reasons stated earlier.
ACK for the others.

thanks,
rui
> ---
>  drivers/thermal/thermal_sys.c |   24 ++++++++++++------------
>  1 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> index 242c82a..602596e 100644
> --- a/drivers/thermal/thermal_sys.c
> +++ b/drivers/thermal/thermal_sys.c
> @@ -168,7 +168,7 @@ int thermal_zone_trend_get(struct thermal_zone_device *tz, int trip)
>  
>  	return trend;
>  }
> -EXPORT_SYMBOL(thermal_zone_trend_get);
> +EXPORT_SYMBOL_GPL(thermal_zone_trend_get);
>  
>  struct thermal_instance *thermal_instance_get(struct thermal_zone_device *tz,
>  			struct thermal_cooling_device *cdev, int trip)
> @@ -191,7 +191,7 @@ struct thermal_instance *thermal_instance_get(struct thermal_zone_device *tz,
>  
>  	return target_instance;
>  }
> -EXPORT_SYMBOL(thermal_instance_get);
> +EXPORT_SYMBOL_GPL(thermal_instance_get);
>  
>  static void print_bind_err_msg(struct thermal_zone_device *tz,
>  			struct thermal_cooling_device *cdev, int ret)
> @@ -434,7 +434,7 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
>  	for (count = 0; count < tz->trips; count++)
>  		handle_thermal_trip(tz, count);
>  }
> -EXPORT_SYMBOL(thermal_zone_device_update);
> +EXPORT_SYMBOL_GPL(thermal_zone_device_update);
>  
>  static void thermal_zone_device_check(struct work_struct *work)
>  {
> @@ -1197,7 +1197,7 @@ free_mem:
>  	kfree(dev);
>  	return result;
>  }
> -EXPORT_SYMBOL(thermal_zone_bind_cooling_device);
> +EXPORT_SYMBOL_GPL(thermal_zone_bind_cooling_device);
>  
>  /**
>   * thermal_zone_unbind_cooling_device - unbind a cooling device from a thermal zone
> @@ -1237,7 +1237,7 @@ unbind:
>  	kfree(pos);
>  	return 0;
>  }
> -EXPORT_SYMBOL(thermal_zone_unbind_cooling_device);
> +EXPORT_SYMBOL_GPL(thermal_zone_unbind_cooling_device);
>  
>  static void thermal_release(struct device *dev)
>  {
> @@ -1334,7 +1334,7 @@ unregister:
>  	device_unregister(&cdev->device);
>  	return ERR_PTR(result);
>  }
> -EXPORT_SYMBOL(thermal_cooling_device_register);
> +EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
>  
>  /**
>   * thermal_cooling_device_unregister - removes the registered thermal cooling device
> @@ -1394,7 +1394,7 @@ void thermal_cooling_device_unregister(struct thermal_cooling_device *cdev)
>  	device_unregister(&cdev->device);
>  	return;
>  }
> -EXPORT_SYMBOL(thermal_cooling_device_unregister);
> +EXPORT_SYMBOL_GPL(thermal_cooling_device_unregister);
>  
>  void thermal_cdev_update(struct thermal_cooling_device *cdev)
>  {
> @@ -1417,7 +1417,7 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
>  	cdev->ops->set_cur_state(cdev, target);
>  	cdev->updated = true;
>  }
> -EXPORT_SYMBOL(thermal_cdev_update);
> +EXPORT_SYMBOL_GPL(thermal_cdev_update);
>  
>  /**
>   * thermal_notify_framework - Sensor drivers use this API to notify framework
> @@ -1435,7 +1435,7 @@ void thermal_notify_framework(struct thermal_zone_device *tz, int trip)
>  {
>  	handle_thermal_trip(tz, trip);
>  }
> -EXPORT_SYMBOL(thermal_notify_framework);
> +EXPORT_SYMBOL_GPL(thermal_notify_framework);
>  
>  /**
>   * create_trip_attrs - create attributes for trip points
> @@ -1687,7 +1687,7 @@ unregister:
>  	device_unregister(&tz->device);
>  	return ERR_PTR(result);
>  }
> -EXPORT_SYMBOL(thermal_zone_device_register);
> +EXPORT_SYMBOL_GPL(thermal_zone_device_register);
>  
>  /**
>   * thermal_device_unregister - removes the registered thermal zone device
> @@ -1754,7 +1754,7 @@ void thermal_zone_device_unregister(struct thermal_zone_device *tz)
>  	device_unregister(&tz->device);
>  	return;
>  }
> -EXPORT_SYMBOL(thermal_zone_device_unregister);
> +EXPORT_SYMBOL_GPL(thermal_zone_device_unregister);
>  
>  #ifdef CONFIG_NET
>  static struct genl_family thermal_event_genl_family = {
> @@ -1832,7 +1832,7 @@ int thermal_generate_netlink_event(struct thermal_zone_device *tz,
>  
>  	return result;
>  }
> -EXPORT_SYMBOL(thermal_generate_netlink_event);
> +EXPORT_SYMBOL_GPL(thermal_generate_netlink_event);
>  
>  static int genetlink_init(void)
>  {
