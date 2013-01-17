From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH RESEND 4/4] thermal: check for invalid trip setup when
 registering thermal device
Date: Thu, 17 Jan 2013 15:10:37 +0800
Message-ID: <1358406637.20319.4.camel@rzhang1-mobl4>
References: <1357140582-8151-1-git-send-email-eduardo.valentin@ti.com>
	  <1357140582-8151-5-git-send-email-eduardo.valentin@ti.com>
	 <1358304336.2252.27.camel@rzhang1-mobl4> <50F6B7B0.90804@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41859 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927Ab3AQHKk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 17 Jan 2013 02:10:40 -0500
In-Reply-To: <50F6B7B0.90804@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: durgadoss.r@intel.com, linux-pm@lists.linux-foundation.org, linux-pm@vger.kernel.org

On Wed, 2013-01-16 at 16:22 +0200, Eduardo Valentin wrote:
> On 16-01-2013 04:45, Zhang Rui wrote:
> > On Wed, 2013-01-02 at 17:29 +0200, Eduardo Valentin wrote:
> >> This patch adds an extra check in the data structure while registering
> >> a thermal device. The check is to avoid registering zones with a number
> >> of trips greater than zero, but with no .get_trip_temp nor .get_trip_type
> >> callbacks. Receiving such data structure may end in wrong data access.
> >>
> >> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> >> ---
> >>   drivers/thermal/thermal_sys.c |    3 +++
> >>   1 files changed, 3 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/drivers/thermal/thermal_sys.c b/drivers/thermal/thermal_sys.c
> >> index fba27c3..0a1bf6b 100644
> >> --- a/drivers/thermal/thermal_sys.c
> >> +++ b/drivers/thermal/thermal_sys.c
> >> @@ -1530,6 +1530,9 @@ struct thermal_zone_device *thermal_zone_device_register(const char *type,
> >>   	if (!ops || !ops->get_temp)
> >>   		return ERR_PTR(-EINVAL);
> >>
> >> +	if (trips > 0 && !ops->get_trip_type)
> >> +		return ERR_PTR(-EINVAL);
> >> +
> > Hmmm, I do not think we need this.
> >
> > the sysfs I/F trip_point_X_type already does this check.
> 
> Well that's not the point. If you trust only the sysfs handling, fine. 
> The fix is very punctual. If you pass wrong parameters to 
> thermal_zone_device_register, it will crash.
> 
> Of course, in either case, with or without his patch, it won't register 
> the device, so you won't get to the sysfs handling part. At least with 
> this fix, the crash won't happen and the driver writer will receive an 
> error code to treat.
> 
> Ok. being specific, what happens is that there are accesses to 
> ops->get_trip_type, even if trips > 0 and if .get_trip_type is NULL, 
> right below inside the register function. Instead of checking for 
> .get_trip_type every time before using it, this patch adds a single 
> constraint, so that, if you have trips, you must specify their types.. 
> To me sounds reasonable enough.
> 
agreed.

applied to thermal -next.

thanks,
rui


