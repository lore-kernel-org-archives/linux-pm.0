From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH v3] thermal: cut the spaces when user sets policy
Date: Mon, 20 May 2013 15:10:08 +0000
Message-ID: <744357E9AAD1214791ACBA4B0B9092630110234F@SHSMSX101.ccr.corp.intel.com>
References: <1368791522-12231-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <519625D5.7030002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60272 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755331Ab3ETPKf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2013 11:10:35 -0400
In-Reply-To: <519625D5.7030002@ti.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>



> -----Original Message-----
> From: Eduardo Valentin [mailto:eduardo.valentin@ti.com]
> Sent: Friday, May 17, 2013 8:43 PM
> To: Andy Shevchenko
> Cc: Zhang, Rui; Eduardo Valentin; linux-pm@vger.kernel.org
> Subject: Re: [PATCH v3] thermal: cut the spaces when user sets policy
> Importance: High
> 
> On 17-05-2013 07:52, Andy Shevchenko wrote:
> > Setting policy results in invalid value error.
> > 	% echo "step_wise" > policy
> > 	% echo: write error: Invalid argument
> >
> > Need clean up of the buffer which "echo" may add based on the
> > arguments, before comparing aganist list of governor names.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Reported-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>
> Tested-by: Eduardo Valentin <eduardo.valentin@ti.com>
> 
> Tested on panda OMAP4430. As this is not platform dependent, I am fine
> with the test I did.
> 
Applied to thermal -next.

Thanks,
rui
> > ---
> > Since v2:
> >  - fix typo in variable definition block
> > drivers/thermal/thermal_core.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/thermal/thermal_core.c
> > b/drivers/thermal/thermal_core.c index d755440..1067fb0 100644
> > --- a/drivers/thermal/thermal_core.c
> > +++ b/drivers/thermal/thermal_core.c
> > @@ -33,6 +33,7 @@
> >  #include <linux/idr.h>
> >  #include <linux/thermal.h>
> >  #include <linux/reboot.h>
> > +#include <linux/string.h>
> >  #include <net/netlink.h>
> >  #include <net/genetlink.h>
> >
> > @@ -713,10 +714,13 @@ policy_store(struct device *dev, struct
> device_attribute *attr,
> >  	int ret = -EINVAL;
> >  	struct thermal_zone_device *tz = to_thermal_zone(dev);
> >  	struct thermal_governor *gov;
> > +	char name[THERMAL_NAME_LENGTH];
> > +
> > +	snprintf(name, sizeof(name), "%s", buf);
> >
> >  	mutex_lock(&thermal_governor_lock);
> >
> > -	gov = __find_governor(buf);
> > +	gov = __find_governor(strim(name));
> >  	if (!gov)
> >  		goto exit;
> >
> >
> 

