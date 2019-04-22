From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] thermal: intel: int340x: processor_thermal_device:
 simplify to get driver data
Date: Mon, 22 Apr 2019 16:55:34 +0800
Message-ID: <1555923334.26198.25.camel@intel.com>
References: <1555339710-28028-1-git-send-email-sumeet.r.pawnikar@intel.com>
         <20190415162809.GU9224@smile.fi.intel.com>
         <1555922784.26198.20.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1555922784.26198.20.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc: edubezval@gmail.com, daniel.lezcano@linaro.org, srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 一, 2019-04-22 at 16:46 +0800, Zhang Rui wrote:
> On 一, 2019-04-15 at 19:28 +0300, Andy Shevchenko wrote:
> > 
> > On Mon, Apr 15, 2019 at 08:18:30PM +0530, Sumeet Pawnikar wrote:
> > > 
> > > 
> > > From: "Pawnikar, Sumeet R" <sumeet.r.pawnikar@intel.com>
> > > 
just one comment, the author name you used is not consistent with the
name you used for your Signed-off-by 'Pawnikar, Sumeet R <sumeet.r.pawn
ikar@intel.com>', and checkpatch complains about missing Signed-off-by
from patch author.
Please fix your gitconfig and run checkpatch before sending next time.

thanks,
rui

> > > This simplifies getting the 'driver_data' from 'struct device'
> > > directly.
> > > Going through platform_device or pci_dev is not required. Also
> > > removes
> > > condition check as the private data stored with dev pointer,
> > > means
> > > irrespective of enumeration mode, we can use dev_get_drvdata().
> > > This removes the unnecessary step back and forth.
> > > 
> > Indeed, good clean up!
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > 
> Thanks, patch applied.
> 
> -rui
> > 
> > > 
> > > 
> > > Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> > > ---
> > >  .../int340x_thermal/processor_thermal_device.c     |   11 +-----
> > > --
> > > ---
> > >  1 file changed, 1 insertion(+), 10 deletions(-)
> > > 
> > > diff --git
> > > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.
> > > c
> > > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.
> > > c
> > > index 8e1cf4d..2a7cbaa 100644
> > > ---
> > > a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.
> > > c
> > > +++
> > > b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.
> > > c
> > > @@ -81,22 +81,13 @@ enum proc_thermal_emum_mode_type {
> > >  					struct device_attribute
> > > *attr, \
> > >  					char *buf) \
> > >  { \
> > > -	struct pci_dev *pci_dev; \
> > > -	struct platform_device *pdev; \
> > > -	struct proc_thermal_device *proc_dev; \
> > > +	struct proc_thermal_device *proc_dev =
> > > dev_get_drvdata(dev); \
> > >  	\
> > >  	if (proc_thermal_emum_mode == PROC_THERMAL_NONE) { \
> > >  		dev_warn(dev, "Attempted to get power limit
> > > before
> > > device was initialized!\n"); \
> > >  		return 0; \
> > >  	} \
> > >  	\
> > > -	if (proc_thermal_emum_mode == PROC_THERMAL_PLATFORM_DEV)
> > > {
> > > \
> > > -		pdev = to_platform_device(dev); \
> > > -		proc_dev = platform_get_drvdata(pdev); \
> > > -	} else { \
> > > -		pci_dev = to_pci_dev(dev); \
> > > -		proc_dev = pci_get_drvdata(pci_dev); \
> > > -	} \
> > >  	return sprintf(buf, "%lu\n",\
> > >  	(unsigned long)proc_dev->power_limits[index].suffix *
> > > 1000); \
> > >  }
> > > -- 
> > > 1.7.9.5
