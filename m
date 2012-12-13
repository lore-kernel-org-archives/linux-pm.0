From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [RFC PATCH 2/7] Thermal: Create zone level APIs
Date: Thu, 13 Dec 2012 15:00:54 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB592487C8@BGSMSX101.gar.corp.intel.com>
References: <1353149158-19102-1-git-send-email-durgadoss.r@intel.com>
	<1353149158-19102-3-git-send-email-durgadoss.r@intel.com>
 <CAJLyvQzB6nGayefJM5-Qak7XxG_yPGFEPc6gv=j8cPrtUjP=Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11813 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756115Ab2LMPBA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Dec 2012 10:01:00 -0500
In-Reply-To: <CAJLyvQzB6nGayefJM5-Qak7XxG_yPGFEPc6gv=j8cPrtUjP=Pg@mail.gmail.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "wni@nvidia.com" <wni@nvidia.com>, "eduardo.valentin@ti.com" <eduardo.valentin@ti.com>, "amit.kachhap@linaro.org" <amit.kachhap@linaro.org>, "sachin.kamat@linaro.org" <sachin.kamat@linaro.org>

Hi,


> -----Original Message-----
> From: linux-pm-owner@vger.kernel.org [mailto:linux-pm-
> owner@vger.kernel.org] On Behalf Of Hongbo Zhang
> Sent: Thursday, December 13, 2012 11:53 AM
> To: R, Durgadoss
> Cc: Zhang, Rui; linux-pm@vger.kernel.org; wni@nvidia.com;
> eduardo.valentin@ti.com; amit.kachhap@linaro.org;
> sachin.kamat@linaro.org
> Subject: Re: [RFC PATCH 2/7] Thermal: Create zone level APIs
> 
> On 17 November 2012 18:45, Durgadoss R <durgadoss.r@intel.com> wrote:
> > This patch adds a new thermal_zone structure to
> > thermal.h. Also, adds zone level APIs to the thermal
> > framework.
> >
> > Signed-off-by: Durgadoss R <durgadoss.r@intel.com>

[A big cut.]

> >  #define to_cooling_device(_dev)        \
> >         container_of(_dev, struct thermal_cooling_device, device)
> > @@ -1557,6 +1615,146 @@ static void remove_trip_attrs(struct
> thermal_zone_device *tz)
> >         kfree(tz->trip_hyst_attrs);
> >  }
> >
> > +struct thermal_zone *create_thermal_zone(const char *name, void
> *devdata)
> Durgaross,
> Since more sensors can be added into one thermal zone, think about
> this situation that every sensor is in itself file separately:

Yes, we thought about this scenario.
The way the new framework is designed is like below:

The thermal sensor source file can be generic (can be any sensor driver, in any
subsystem). This driver will use the sensor APIs and register with thermal
framework to participate in platform Thermal management. This does not
(and should not) know about which zone it belongs to, or any other information
about platform thermals. A sensor driver is a standalone piece of code, which
can optionally register with thermal framework.

However, for any platform, there should be a platformX_thermal.c file,
which will know about the platform thermal characteristics (like how many sensors,
zones, cooling devices, etc.. And how they are related to each other i.e the
mapping information). Only in this file, the zone level APIs should be used, in
which case the file will have all information required to attach various sensors
to a particular zone.

This way, we can have one platform level thermal file, which can support
multiple platforms (may be)using the same set of sensors (but)binded in a different way.
This file can get the platform thermal information through Firmware,
ACPI tables, device tree etc.

Unfortunately, today we don't have many drivers that can be clearly differentiated
as 'sensor_file.c' and 'platform_thermal_file.c'. But very soon we will need/have.
The reason I am saying this is because we are seeing a lot of chip drivers,
starting to use thermal framework, and we should keep it really light-weight
for them to do so.

An Example: drivers/hwmon/emc1403.c - a generic thermal chip driver
In one platform this sensor can belong to 'ZoneA' and in another the
same can belong to 'ZoneB'. But, emc1403.c does not really care about
where does it belong. It just reports temperature.
[Okay, I just picked an example, it doesn't register with framework,
as of today :-)]

> 
> sensorA_file.c:
> if common_zone_for_AB not there;
> create common_zone_for_AB;

This create_zone should not even be in sensorA_file.c.
It should be moved to platform level file.

> add sensorA into common_zone_for_AB;
> 
> sensorB_file.c:
> if common_zone_for_AB not there;
> create common_zone_for_AB;
> add sensorB into common_zone_for_AB;
> 

Same here..

> But how to check dedicate thermal zone is created or not? we are
> lacking of this interface.
> Here are two ways to achieve this from my point of view:
> a)
> add interface get_thermal_zone_byname(const char *name) which will
> walk through the thermal_zone_list.

However, (despite this problem we are talking about)
we can introduce this API, if needed.

> b)
> add one more parameter for current interface, like this
> create_thermal_zone(const char *name, void *devdata, bool reuse)
> if reuse==ture {
> if thermal zone already created, return it;
> else create thermal zone;
> } else {
> if thermal zone already created, return error;
> else create thermal zone;
> }
> 
> I prefer a), how do you think about it?

I know I wrote a lengthy explanation. Let me know if it makes sense.
If it does, then probably I will add it to our Documentation file.

Thanks,
Durga
