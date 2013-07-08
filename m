From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC PATCH 3/6] Thermal: fix step_wise handling of
 THERMAL_TREND_DROPPING
Date: Mon, 08 Jul 2013 10:32:25 +0800
Message-ID: <1373250745.2038.15.camel@rzhang1-mobl4>
References: <1371475468-5351-1-git-send-email-rui.zhang@intel.com>
	 <1371475468-5351-4-git-send-email-rui.zhang@intel.com>
	 <51D33EA9.7090005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:26965 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753375Ab3GHCca (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 7 Jul 2013 22:32:30 -0400
In-Reply-To: <51D33EA9.7090005@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-pm@vger.kernel.org, durgadoss.r@intel.com, shawn.guo@linaro.org, ruslan.ruslichenko@ti.com

On Tue, 2013-07-02 at 16:57 -0400, Eduardo Valentin wrote:
> On 17-06-2013 09:24, Zhang Rui wrote:
> > Fixes two problems in the THERMAL_TREND_DROPPING
> > handling code in step_wise governor.
> > 1. When the temperature is higher than the trip point,
> > we should not deactivate the thermal instance.
> 
> When temperature is higher than trip point, should it then get the
> actions of the next trip point?
> 
no, a thermal instance is only activated when the temperature is above
the trip point.
The thermal instance may still be active for a while even if the
temperature gets lower than the trip point, and then be deactivated when
the instance->target is set to THERMAL_NO_TARGET.
Say, instance->lower is 3, upper is 6, and the cooling device is in
cooling state 6. When the temperature drops below the trip point,
step_wise governor should reduce the target to 5, then 4, then 3, and
then THERMAL_NO_TARGET.

> Does it mean that with this patch, all thermal instances assigned to
> trip points below the cur temperature would be activated, right?
> 
No, the instance will keep active only if its target is not
THERMAL_NO_TARGET.

> > 2. When the temperature is lower than the trip point,
> > we should not activate the thermal instance.
> > 
> 
> When would they get activated then?
> 
It is activated when the temperature aboves the trip point, and
deactivated when the instance->target is set to THERMAL_NO_TARGET by the
cooling algorithm.

thanks,
rui
> 
> > Also rephrase the code a bit to make it more readable.
> > 
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/thermal/step_wise.c |   18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> > index d89e781..f0cc5e5 100644
> > --- a/drivers/thermal/step_wise.c
> > +++ b/drivers/thermal/step_wise.c
> > @@ -75,13 +75,19 @@ static unsigned long get_target_state(struct thermal_instance *instance,
> >  			next_target = instance->upper;
> >  		break;
> >  	case THERMAL_TREND_DROPPING:
> > -		if (cur_state == instance->lower) {
> > -			if (!throttle)
> > -				next_target = THERMAL_NO_TARGET;
> > +		if (throttle) {
> > +			if (cur_state <= instance->lower)
> > +				next_target = instance->lower;
> > +			else
> > +				next_target = cur_state > instance->upper ?
> > +					instance->upper : cur_state - 1;
> >  		} else {
> > -			next_target = cur_state - 1;
> > -			if (next_target > instance->upper)
> > -				next_target = instance->upper;
> > +			if (cur_state <= instance->lower ||
> > +			    instance->target == THERMAL_NO_TARGET)
> > +				next_target = THERMAL_NO_TARGET;
> > +			else
> > +				next_target = cur_state > instance->upper ?
> > +					instance->upper : cur_state - 1;
> >  		}
> >  		break;
> >  	case THERMAL_TREND_DROP_FULL:
> > 
> 
> 


