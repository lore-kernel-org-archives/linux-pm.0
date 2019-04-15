From: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH] thermal: intel: int340x: processor_thermal_device:
 simplify to get driver data
Date: Mon, 15 Apr 2019 19:28:09 +0300
Message-ID: <20190415162809.GU9224@smile.fi.intel.com>
References: <1555339710-28028-1-git-send-email-sumeet.r.pawnikar@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1555339710-28028-1-git-send-email-sumeet.r.pawnikar@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 15, 2019 at 08:18:30PM +0530, Sumeet Pawnikar wrote:
> From: "Pawnikar, Sumeet R" <sumeet.r.pawnikar@intel.com>
> 
> This simplifies getting the 'driver_data' from 'struct device' directly.
> Going through platform_device or pci_dev is not required. Also removes
> condition check as the private data stored with dev pointer, means
> irrespective of enumeration mode, we can use dev_get_drvdata().
> This removes the unnecessary step back and forth.
> 

Indeed, good clean up!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> ---
>  .../int340x_thermal/processor_thermal_device.c     |   11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> index 8e1cf4d..2a7cbaa 100644
> --- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> +++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
> @@ -81,22 +81,13 @@ enum proc_thermal_emum_mode_type {
>  					struct device_attribute *attr, \
>  					char *buf) \
>  { \
> -	struct pci_dev *pci_dev; \
> -	struct platform_device *pdev; \
> -	struct proc_thermal_device *proc_dev; \
> +	struct proc_thermal_device *proc_dev = dev_get_drvdata(dev); \
>  	\
>  	if (proc_thermal_emum_mode == PROC_THERMAL_NONE) { \
>  		dev_warn(dev, "Attempted to get power limit before device was initialized!\n"); \
>  		return 0; \
>  	} \
>  	\
> -	if (proc_thermal_emum_mode == PROC_THERMAL_PLATFORM_DEV) { \
> -		pdev = to_platform_device(dev); \
> -		proc_dev = platform_get_drvdata(pdev); \
> -	} else { \
> -		pci_dev = to_pci_dev(dev); \
> -		proc_dev = pci_get_drvdata(pci_dev); \
> -	} \
>  	return sprintf(buf, "%lu\n",\
>  	(unsigned long)proc_dev->power_limits[index].suffix * 1000); \
>  }
> -- 
> 1.7.9.5
> 

-- 
With Best Regards,
Andy Shevchenko
