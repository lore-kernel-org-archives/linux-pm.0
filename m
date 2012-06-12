From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [RFC PATCH 3/12] thermal: set upper and lower limits
	when binding
Date: Tue, 12 Jun 2012 12:52:39 +0300
Message-ID: <20120612095215.GA3837@besouro>
References: <1339384801.1492.156.camel@rui.sh.intel.com>
Reply-To: eduardo.valentin@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1339384801.1492.156.camel@rui.sh.intel.com>
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

On Mon, Jun 11, 2012 at 11:20:01AM +0800, Zhang Rui wrote:
> 
> Set upper and lower limits when binding
> a thermal cooling device to a thermal zone device.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/acpi/thermal.c         |   34 ++++++++++++++++++++++++----------
>  drivers/platform/x86/acerhdf.c |    2 +-
>  drivers/thermal/thermal_sys.c  |   20 ++++++++++++++------
>  include/linux/thermal.h        |    3 ++-
>  4 files changed, 41 insertions(+), 18 deletions(-)
> 
> Index: rtd3/drivers/thermal/thermal_sys.c
> ===================================================================
> --- rtd3.orig/drivers/thermal/thermal_sys.c
> +++ rtd3/drivers/thermal/thermal_sys.c
> @@ -248,7 +248,7 @@ passive_store(struct device *dev, struct
>  				     sizeof("Processor")))
>  				thermal_zone_bind_cooling_device(tz,
>  								 THERMAL_TRIPS_NONE,
> -								 cdev);
> +								 cdev, -1, -1);
>  		}
>  		mutex_unlock(&thermal_list_lock);
>  		if (!tz->passive_delay)
> @@ -760,7 +760,8 @@ static void thermal_zone_device_check(st
>   */
>  int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
>  				     int trip,
> -				     struct thermal_cooling_device *cdev)
> +				     struct thermal_cooling_device *cdev,
> +				     long upper, long lower)
>  {
>  	struct thermal_cooling_device_instance *dev;
>  	struct thermal_cooling_device_instance *pos;
> @@ -784,6 +785,15 @@ int thermal_zone_bind_cooling_device(str
>  	if (tz != pos1 || cdev != pos2)
>  		return -EINVAL;
>  
> +	cdev->ops->get_max_state(cdev, &max_state);
> +
> +	/* lower default 0, upper default max_state */
> +	lower = lower < 0 ? 0 : lower;
> +	upper = upper < 0 ? max_state : upper;
> +
> +	if (lower > upper || upper > max_state)
> +		return -EINVAL;
> +

>From this version of the code, I assume we want to:
a. Allow cooling binding instances to have ranges overlapping.
b. Allow a binding with only one state (lower == upper).

Is this the expected behavior?

>  	dev =
>  	    kzalloc(sizeof(struct thermal_cooling_device_instance), GFP_KERNEL);
>  	if (!dev)
> @@ -791,10 +801,8 @@ int thermal_zone_bind_cooling_device(str
>  	dev->tz = tz;
>  	dev->cdev = cdev;
>  	dev->trip = trip;
> -
> -	cdev->ops->get_max_state(dev, &max_state);
> -	dev->upper = max_state;
> -	dev->lower = 0;
> +	dev->upper = upper;
> +	dev->lower = lower;
>  
>  	result = get_idr(&tz->idr, &tz->lock, &dev->id);
>  	if (result)
> Index: rtd3/include/linux/thermal.h
> ===================================================================
> --- rtd3.orig/include/linux/thermal.h
> +++ rtd3/include/linux/thermal.h
> @@ -143,7 +143,8 @@ struct thermal_zone_device *thermal_zone
>  void thermal_zone_device_unregister(struct thermal_zone_device *);
>  
>  int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
> -				     struct thermal_cooling_device *);
> +				     struct thermal_cooling_device *,
> +				     long, long);
>  int thermal_zone_unbind_cooling_device(struct thermal_zone_device *, int,
>  				       struct thermal_cooling_device *);
>  void thermal_zone_device_update(struct thermal_zone_device *);
> Index: rtd3/drivers/acpi/thermal.c
> ===================================================================
> --- rtd3.orig/drivers/acpi/thermal.c
> +++ rtd3/drivers/acpi/thermal.c
> @@ -729,11 +729,9 @@ static int thermal_notify(struct thermal
>  	return 0;
>  }
>  
> -typedef int (*cb)(struct thermal_zone_device *, int,
> -		  struct thermal_cooling_device *);
>  static int acpi_thermal_cooling_device_cb(struct thermal_zone_device *thermal,
>  					struct thermal_cooling_device *cdev,
> -					cb action)
> +					int bind)
>  {
>  	struct acpi_device *device = cdev->devdata;
>  	struct acpi_thermal *tz = thermal->devdata;
> @@ -758,7 +756,14 @@ static int acpi_thermal_cooling_device_c
>  			handle = tz->trips.passive.devices.handles[i];
>  			status = acpi_bus_get_device(handle, &dev);
>  			if (ACPI_SUCCESS(status) && (dev == device)) {
> -				result = action(thermal, trip, cdev);
> +				if (bind)
> +					result =
> +						thermal_zone_bind_cooling_device(
> +							thermal, trip, cdev, -1, -1);
> +				else
> +					result =
> +						thermal_zone_unbind_cooling_device(
> +							thermal, trip, cdev);
>  				if (result)
>  					goto failed;
>  			}
> @@ -775,7 +780,13 @@ static int acpi_thermal_cooling_device_c
>  			handle = tz->trips.active[i].devices.handles[j];
>  			status = acpi_bus_get_device(handle, &dev);
>  			if (ACPI_SUCCESS(status) && (dev == device)) {
> -				result = action(thermal, trip, cdev);
> +				if (bind)
> +					result =
> +						thermal_zone_bind_cooling_device(
> +							thermal, trip, cdev, -1, -1);
> +				else
> +					result = thermal_zone_unbind_cooling_device(
> +							thermal, trip, cdev);
>  				if (result)
>  					goto failed;
>  			}
> @@ -786,7 +797,12 @@ static int acpi_thermal_cooling_device_c
>  		handle = tz->devices.handles[i];
>  		status = acpi_bus_get_device(handle, &dev);
>  		if (ACPI_SUCCESS(status) && (dev == device)) {
> -			result = action(thermal, -1, cdev);
> +			if (bind)
> +				result = thermal_zone_bind_cooling_device(thermal,
> +								-1, cdev, -1, -1);
> +			else
> +				result = thermal_zone_unbind_cooling_device(thermal,
> +								-1, cdev);
>  			if (result)
>  				goto failed;
>  		}
> @@ -800,16 +816,14 @@ static int
>  acpi_thermal_bind_cooling_device(struct thermal_zone_device *thermal,
>  					struct thermal_cooling_device *cdev)
>  {
> -	return acpi_thermal_cooling_device_cb(thermal, cdev,
> -				thermal_zone_bind_cooling_device);
> +	return acpi_thermal_cooling_device_cb(thermal, cdev, 1);
>  }
>  
>  static int
>  acpi_thermal_unbind_cooling_device(struct thermal_zone_device *thermal,
>  					struct thermal_cooling_device *cdev)
>  {
> -	return acpi_thermal_cooling_device_cb(thermal, cdev,
> -				thermal_zone_unbind_cooling_device);
> +	return acpi_thermal_cooling_device_cb(thermal, cdev, 0);
>  }
>  
>  static const struct thermal_zone_device_ops acpi_thermal_zone_ops = {
> Index: rtd3/drivers/platform/x86/acerhdf.c
> ===================================================================
> --- rtd3.orig/drivers/platform/x86/acerhdf.c
> +++ rtd3/drivers/platform/x86/acerhdf.c
> @@ -329,7 +329,7 @@ static int acerhdf_bind(struct thermal_z
>  	if (cdev != cl_dev)
>  		return 0;
>  
> -	if (thermal_zone_bind_cooling_device(thermal, 0, cdev)) {
> +	if (thermal_zone_bind_cooling_device(thermal, 0, cdev, -1, -1)) {
>  		pr_err("error binding cooling dev\n");
>  		return -EINVAL;
>  	}
> 
> 
