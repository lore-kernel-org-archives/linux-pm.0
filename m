From: Zhang Rui <rui.zhang@intel.com>
Subject: RE: [PATCH 5/8] Thermal: Create Thermal map sysfs attributes for a
 zone
Date: Fri, 08 Feb 2013 17:55:11 +0800
Message-ID: <1360317311.2242.82.camel@rzhang1-mobl4>
References: <1360061183-14137-1-git-send-email-durgadoss.r@intel.com>
	 <1360061183-14137-6-git-send-email-durgadoss.r@intel.com>
	 <1360314270.2242.45.camel@rzhang1-mobl4>
	 <4D68720C2E767A4AA6A8796D42C8EB5927AB1E@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4D68720C2E767A4AA6A8796D42C8EB5927AB1E@BGSMSX101.gar.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "R, Durgadoss" <durgadoss.r@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "hongbo.zhang@linaro.org" <hongbo.zhang@linaro.org>, "wni@nvidia.com" <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 2013-02-08 at 02:08 -0700, R, Durgadoss wrote:
> Hi Rui,
> 
> > -----Original Message-----
> > From: Zhang, Rui
> > Sent: Friday, February 08, 2013 2:35 PM
> > To: R, Durgadoss
> > Cc: linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org;
> > eduardo.valentin@ti.com; hongbo.zhang@linaro.org; wni@nvidia.com
> > Subject: Re: [PATCH 5/8] Thermal: Create Thermal map sysfs attributes for a
> > zone
> > 
> > On Tue, 2013-02-05 at 16:16 +0530, Durgadoss R wrote:
> > > This patch creates a thermal map sysfs node under
> > > /sys/class/thermal/zoneX/. This contains
> > > entries named mapY_trip_type, mapY_sensor_name,
> > > mapY_cdev_name, mapY_trip_mask, mapY_weights.
> > sorry I still not quite understand.
> > 
> > does it look like?
> > /sys/class/thermal/zoneX/
> > |
> > map-->|-->map0_trip_type
> >       |...
> >       |-->map0_weight
> >       |-->map1_trip_type
> >       |...
> >       |-->map1_weight
> >       |...
> > 
> 
> There is no separate 'map' directory.
> So, everything is under /sys/class/thermal/zoneX/ directly,
> named as map0_weight etc...
> 
got it.

thanks,
rui

> I think I should make the Doc/ABI patch should clarify this.
> 
> Thanks,
> Durga
