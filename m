From: Javi Merino <javi.merino@arm.com>
Subject: Re: Fix: Bind Cooling Device Weight
Date: Mon, 29 Dec 2014 10:40:21 +0000
Message-ID: <20141229104021.GD32102@e104805>
References: <5492C634.5030604@arm.com>
 <20141218134334.GA6276@developer>
 <1419218315.19619.6.camel@rzhang1-toshiba>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:54082 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114AbaL2Kk3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Dec 2014 05:40:29 -0500
Content-Disposition: inline
In-Reply-To: <1419218315.19619.6.camel@rzhang1-toshiba>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Kapileshwar Singh <Kapileshwar.Singh@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Punit Agrawal <Punit.Agrawal@arm.com>

On Mon, Dec 22, 2014 at 03:18:35AM +0000, Zhang Rui wrote:
> On Thu, 2014-12-18 at 09:43 -0400, Eduardo Valentin wrote:
> > On Thu, Dec 18, 2014 at 12:19:00PM +0000, Kapileshwar Singh wrote:
> > > The Problem:
> > > 
> > > In the current code, the weight of the cooling device, which is read as
> > > contribution from the device tree in of-thermal.c as:
> > > 
> > > 
> > >         ret = of_property_read_u32(np, "contribution", &prop);
> > >         if (ret == 0)
> > >                 __tbp->usage = prop;
> > > 
> > > This is only stored in the private devicedata as:
> > > 
> > >         ((__thernal_zone *)cdev->devdata)->__tbp->usage
> > > 
> > > As of-thermal.c specifies its "bind" operation and does not populate
> > > tzd->tzp->tbp, this causes an erroneous access in the fair-share
> > > governor when it tries to access the weight:
> > > 
> > > instance->target = get_target_state(tz, cdev,
> > >                                         tzp->tbp[i].weight,
> > > cur_trip_level);
> > > 
> > > 
> > > The Proposed solution:
> > > 
> > > The proposed solution has the following changes:
> > > 
> > >  1. Passing the weight as an argument to thermal_zone_bind_cooling_device
> > > 
> > >  2. Storing the weight in the thermal_instance data structure created in
> > > the thermal_zone_bind_cooling_device function
> > > 
> > >  3. Changing the accesses in the governor accordingly.
> > 
> > Shouldn't we simply:
> > 1. In of-thermal, populate tzd->tzp->tbp by passing a tbp with correct
> > tbp's in the registration call:
> > 	zone = thermal_zone_device_register(child->name, tz->ntrips,
> > 						0,
> > 						tz,
> > 						ops,
> > /* This guy needs to be filled properly */	tzp,
> > 						tz->passive_delay,
> > 						tz->polling_delay);
> > 
> Agreed.
> 
> > 2. Add a proper check in the governor to avoid accessing thermal zones
> > with missing data.
> > 
> > I know there is a check in place:
> >         if (!tz->tzp || !tz->tzp->tbp)
> > 	          return -EINVAL;
> > 
> > which based in your description seams to be failing. Here, I need more
> > info from your side describing what exactly you are seeing. Can you
> > please post the kernel log when the failure happens? Does it output a
> > kernel segfault or is the governor simply not working?
> > 
> > I would expect, with the current code, the governor be silent and
> > non-functional, which needs to be fixed too.
> 
> Plus, I think we should add an optional .validate() callback for each
> governor, to check if the thermal zone meets the requirement of the
> governor or not before switching to it.

The patch "thermal: let governors have private data for each thermal
zone" that you applied[0] allows you to do that.  Governors
can have a bind_to_tz() op that can fail.  If it does, then the switch
doesn't happen and you continue with the old governor.

[0] http://article.gmane.org/gmane.linux.power-management.general/54163

Cheers,
Javi
