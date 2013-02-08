From: Zhang Rui <rui.zhang@intel.com>
Subject: RE: [PATCH 1/8] Thermal: Create sensor level APIs
Date: Fri, 08 Feb 2013 17:54:35 +0800
Message-ID: <1360317275.2242.81.camel@rzhang1-mobl4>
References: <1360061183-14137-1-git-send-email-durgadoss.r@intel.com>
	 <1360061183-14137-2-git-send-email-durgadoss.r@intel.com>
	 <1360310031.2242.24.camel@rzhang1-mobl4>
	 <4D68720C2E767A4AA6A8796D42C8EB5927AA18@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB5927AA18@BGSMSX101.gar.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "hongbo.zhang@linaro.org" <hongbo.zhang@linaro.org>, "wni@nvidia.com" <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 2013-02-08 at 01:26 -0700, R, Durgadoss wrote:
> Hi Rui,
> 
> > -----Original Message-----
> > From: Zhang, Rui
> > Sent: Friday, February 08, 2013 1:24 PM
> > To: R, Durgadoss
> > Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > eduardo.valentin@ti.com; hongbo.zhang@linaro.org; wni@nvidia.com
> > Subject: Re: [PATCH 1/8] Thermal: Create sensor level APIs
> > 
> > On Tue, 2013-02-05 at 16:16 +0530, Durgadoss R wrote:
> > > This patch creates sensor level APIs, in the
> > > generic thermal framework.
> 
> [snip.]
> 
> > > +
> > >  static ssize_t
> > >  type_show(struct device *dev, struct device_attribute *attr, char *buf)
> > >  {
> > > @@ -707,6 +807,10 @@ static DEVICE_ATTR(mode, 0644, mode_show,
> > mode_store);
> > >  static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show,
> > passive_store);
> > >  static DEVICE_ATTR(policy, S_IRUGO | S_IWUSR, policy_show,
> > policy_store);
> > >
> > > +/* Thermal sensor attributes */
> > > +static DEVICE_ATTR(sensor_name, 0444, sensor_name_show, NULL);
> > > +static DEVICE_ATTR(temp_input, 0444, sensor_temp_show, NULL);
> > > +
> > >  /* sys I/F for cooling device */
> > >  #define to_cooling_device(_dev)	\
> > >  	container_of(_dev, struct thermal_cooling_device, device)
> > > @@ -1493,6 +1597,182 @@ static void remove_trip_attrs(struct
> > thermal_zone_device *tz)
> > >  }
> > >
> > >  /**
> > > + * enable_sensor_thresholds - create sysfs nodes for thresholdX
> > 
> > this is a little confusing.
> > I'd prefer
> > thermal_sensor_sysfs_add() and create sensor_name and temp_input
> > attribute in this function as well, and thermal_sensor_sysfs_remove()
> > to remove the sysfs I/F.
> > And further more, we can do this for thermal zones and cooling devices.
> 
> I agree, and we will change this.
> Since this involves change for all standard APIs, I think it is better to submit
> a separate patch to do this. What do you think ?
> 
I'm okay with this.

thanks,
rui
> > 
> > others look okay to me.
> 
> Thank you :-)
> 
> > 
> > thanks,
> > rui
> 
