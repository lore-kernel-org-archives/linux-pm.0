From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC PATCH 6/6] Thermal: step_wise: set next cooling target
 explicitly
Date: Mon, 08 Jul 2013 10:34:53 +0800
Message-ID: <1373250893.2038.17.camel@rzhang1-mobl4>
References: <1371475468-5351-1-git-send-email-rui.zhang@intel.com>
	 <1371475468-5351-7-git-send-email-rui.zhang@intel.com>
	 <51D34035.3000008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:4141 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753390Ab3GHCe5 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 7 Jul 2013 22:34:57 -0400
In-Reply-To: <51D34035.3000008@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-pm@vger.kernel.org, durgadoss.r@intel.com, shawn.guo@linaro.org, ruslan.ruslichenko@ti.com

On Tue, 2013-07-02 at 17:03 -0400, Eduardo Valentin wrote:
> On 17-06-2013 09:24, Zhang Rui wrote:
> > Set the next target state explicitly for each thermal trend,
> > in step_wise governor, to provide more readability, and to
> > follow the cooling algorithm description strictly.
> 
> 
> How about merging this one with patch 05?
> 
> > 
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/thermal/step_wise.c |    9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> > index 53b56e6..ffa553f 100644
> > --- a/drivers/thermal/step_wise.c
> > +++ b/drivers/thermal/step_wise.c
> > @@ -60,7 +60,6 @@ static unsigned long get_target_state(struct thermal_instance *instance,
> >  	 * cdev in use to determine the next_target.
> >  	 */
> >  	cdev->ops->get_cur_state(cdev, &cur_state);
> > -	next_target = instance->target;
> >  
> >  	switch (trend) {
> >  	case THERMAL_TREND_RAISING:
> > @@ -69,11 +68,14 @@ static unsigned long get_target_state(struct thermal_instance *instance,
> >  				    (cur_state + 1) : instance->upper;
> >  			if (next_target < instance->lower)
> >  				next_target = instance->lower;
> > -		}
> > +		} else
> > +			next_target = instance->target;
> >  		break;
> >  	case THERMAL_TREND_RAISE_FULL:
> >  		if (throttle)
> >  			next_target = instance->upper;
> > +		else
> > +			next_target = instance->target;
> >  		break;
> >  	case THERMAL_TREND_DROPPING:
> >  		if (throttle) {
> > @@ -99,7 +101,10 @@ static unsigned long get_target_state(struct thermal_instance *instance,
> >  		break;
> >  	case THERMAL_TREND_STABLE:
> >  		/* Do nothing */
> > +		next_target = instance->target;
> > +		break;
> >  	default:
> > +		next_target = instance->target;
> >  		break;
> 
> 
> The above could be rewritten like this:
>   	case THERMAL_TREND_STABLE:
>   		/* Do nothing */
>   	default:
>  		next_target = instance->target;
>   		break;
> 

sure I'm okay with your suggestion.
I wrote the code in this way because I want to keep the code follows the
description explicitly.

thanks,
rui
> >  	}
> >  
> > 
> 
> 


