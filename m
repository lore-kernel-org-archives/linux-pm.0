From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [RFC PATCH 11/12] thermal: introduce cooling state
	arbitrator
Date: Wed, 13 Jun 2012 17:23:16 +0300
Message-ID: <20120613142316.GB16714@besouro>
References: <1339384839.1492.165.camel@rui.sh.intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1339384839.1492.165.camel@rui.sh.intel.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hello Rui,

On Mon, Jun 11, 2012 at 11:20:39AM +0800, Zhang Rui wrote:
> 
> Introduce simple arbitrator for setting device cooling state,
> to fix the problem that a cooling device may be referenced by
> by multiple trip points in multiple thermal zones.
> 
> 
> With this patch, we have two stages for updating a thermal zone,
> 1. check if a thermal_instance needs to be updated or not
> 2. update the cooling device, based on the target cooling state
>    of all its instances.
> 
> Note that, currently, the cooling device is set to the deepest
> cooling state required.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/thermal/thermal_sys.c |   41 ++++++++++++++++++++++++++++++++++++++---
>  include/linux/thermal.h       |    1 +
>  2 files changed, 39 insertions(+), 3 deletions(-)
> 
> Index: rtd3/drivers/thermal/thermal_sys.c
> ===================================================================
> --- rtd3.orig/drivers/thermal/thermal_sys.c
> +++ rtd3/drivers/thermal/thermal_sys.c
> @@ -54,6 +54,7 @@ struct thermal_instance {
>  	int trip;
>  	unsigned long upper;	/* Highest cooling state for this trip point */
>  	unsigned long lower;	/* Lowest cooling state for this trip point */
> +	unsigned long target;	/* expected cooling state */
>  	char attr_name[THERMAL_NAME_LENGTH];
>  	struct device_attribute attr;
>  	struct list_head tz_node; /* node in tz->instances */
> @@ -812,6 +813,7 @@ int thermal_zone_bind_cooling_device(str
>  	dev->trip = trip;
>  	dev->upper = upper;
>  	dev->lower = lower;
> +	dev->target = -1;
>  
>  	result = get_idr(&tz->idr, &tz->lock, &dev->id);
>  	if (result)
> @@ -949,6 +951,7 @@ thermal_cooling_device_register(char *ty
>  	strcpy(cdev->type, type);
>  	INIT_LIST_HEAD(&cdev->instances);
>  	cdev->ops = ops;
> +	cdev->updated = 1;
>  	cdev->device.class = &thermal_class;
>  	cdev->devdata = devdata;
>  	dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
> @@ -1040,6 +1043,32 @@ void thermal_cooling_device_unregister(s
>  }
>  EXPORT_SYMBOL(thermal_cooling_device_unregister);
>  
> +static void thermal_zone_do_update(struct thermal_zone_device *tz)
> +{
> +	struct thermal_instance *instance1, *instance2;
> +	struct thermal_cooling_device *cdev;
> +	int target;
> +
> +	list_for_each_entry(instance1, &tz->instances, tz_node) {
> +		cdev = instance1->cdev;
> +
> +		/* cooling device has already been updated*/
> +		if (cdev->updated)
> +			continue;
> +
> +		target = 0;
> +		/* Make sure cdev enters the deepest cooling state */
> +		list_for_each_entry(instance2, &cdev->instances, cdev_node) {
> +			if (instance2->target == -1)
> +				continue;
> +			if (instance2->target > target)
> +				target = instance2->target;
> +		}
> +		cdev->ops->set_cur_state(cdev, target);
> +		cdev->updated = 1;
> +	}
> +}

I think the above arbitrator solution does not escalate. As I can see,
the arbitrator takes care of cooling device instances in the same thermal zone.

What if you have a device which expose cooling device instances in different
thermal zones?

Besides, the thermal constraint might collide with pm QoS or with settings
coming from user space interfaces.

That's actually why I was suggesting to have this 'arbitrator' or constraint
management outside the thermal framework. And managed per device at some
other abstraction layer.

> +
>  /*
>   * Cooling algorithm for active trip points
>   *
> @@ -1086,19 +1115,24 @@ static void thermal_zone_trip_update(str
>  				cur_state = cur_state > instance->lower ?
>  				    (cur_state - 1) : instance->lower;
>  			}
> -			cdev->ops->set_cur_state(cdev, cur_state);
> +			instance->target = cur_state;
> +			cdev->updated = 0; /* cooling device needs update */
>  		}
>  	} else {	/* below trip */
>  		list_for_each_entry(instance, &tz->instances, tz_node) {
>  			if (instance->trip != trip)
>  				continue;
>  
> +			/* Do not use the deacitve thermal instance */
> +			if (instance->target == -1)
> +				continue;
>  			cdev = instance->cdev;
>  			cdev->ops->get_cur_state(cdev, &cur_state);
>  
>  			cur_state = cur_state > instance->lower ?
> -				    (cur_state - 1) : instance->lower;
> -			cdev->ops->set_cur_state(cdev, cur_state);
> +				    (cur_state - 1) : -1;
> +			instance->target = cur_state;
> +			cdev->updated = 0; /* cooling device needs update */
>  		}
>  	}
>  
> @@ -1159,6 +1193,7 @@ void thermal_zone_device_update(struct t
>  		}
>  	}
>  
> +	thermal_zone_do_update(tz);
>  	if (tz->forced_passive)
>  		thermal_zone_device_passive(tz, temp, tz->forced_passive,
>  					    THERMAL_TRIPS_NONE);
> Index: rtd3/include/linux/thermal.h
> ===================================================================
> --- rtd3.orig/include/linux/thermal.h
> +++ rtd3/include/linux/thermal.h
> @@ -86,6 +86,7 @@ struct thermal_cooling_device {
>  	struct device device;
>  	void *devdata;
>  	const struct thermal_cooling_device_ops *ops;
> +	int updated; /* 1 if the cooling device does not need update */
>  	struct list_head instances;
>  	struct list_head node;
>  };
> 
> 
