From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 1/1] thermal: setup monitor only once after handling trips
Date: Mon, 30 Nov 2015 11:10:42 -0800
Message-ID: <20151130191041.GB5900@localhost.localdomain>
References: <1448424468-18736-1-git-send-email-edubezval@gmail.com>
 <1448435910.15712.22.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:32836 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbbK3TKp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Nov 2015 14:10:45 -0500
Content-Disposition: inline
In-Reply-To: <1448435910.15712.22.camel@localhost>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Wed, Nov 25, 2015 at 07:16:08AM +0000, Chen, Yu C wrote:
> Hi,
> On Tue, 2015-11-24 at 20:07 -0800, Eduardo Valentin wrote:
> > Instead of changing the monitoring setup every time after
> > handling each trip, this patch simplifies the monitoring
> > setup by moving the setup call to a place where all
> > trips have been treated already.
> > 
> > Cc: Zhang Rui <rui.zhang@intel.com>
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
> > ---
> >  drivers/thermal/thermal_core.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> > index d9e525c..6debb54 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -457,11 +457,6 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
> >  		handle_critical_trips(tz, trip, type);
> >  	else
> >  		handle_non_critical_trips(tz, trip, type);
> > -	/*
> > -	 * Alright, we handled this trip successfully.
> > -	 * So, start monitoring again.
> > -	 */
> > -	monitor_thermal_zone(tz);
> >  }
> >  
> >  /**
> > @@ -547,6 +542,12 @@ void thermal_zone_device_update(struct thermal_zone_device *tz)
> >  
> >  	for (count = 0; count < tz->trips; count++)
> >  		handle_thermal_trip(tz, count);
> > +
> > +	/*
> > +	 * Alright, we handled this trip successfully.
> s/these trips ?

Yeah, I can amend this.

> > +	 * So, start monitoring again.
> > +	 */
> > +	monitor_thermal_zone(tz);
> >  }
> >  EXPORT_SYMBOL_GPL(thermal_zone_device_update);
> >  
> BTW, thermal_notify_framework might need be affected? 

Well, the original code does not call thermal_notify_framework. Calling
it would require a different patch. This one is just to simplify the
monitoring setup.

BR,

> 
> thanks,
> Yu
