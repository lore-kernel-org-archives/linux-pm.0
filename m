From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [RFC PATCH 4/6] Thermal: fix step_wise handling of
 THERMAL_TREND_DROP_EFULL
Date: Mon, 08 Jul 2013 10:35:34 +0800
Message-ID: <1373250934.2038.18.camel@rzhang1-mobl4>
References: <1371475468-5351-1-git-send-email-rui.zhang@intel.com>
	 <1371475468-5351-5-git-send-email-rui.zhang@intel.com>
	 <51D341F5.8080905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:53418 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753375Ab3GHCfv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 7 Jul 2013 22:35:51 -0400
In-Reply-To: <51D341F5.8080905@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>
Cc: linux-pm@vger.kernel.org, durgadoss.r@intel.com, shawn.guo@linaro.org, ruslan.ruslichenko@ti.com

On Tue, 2013-07-02 at 17:11 -0400, Eduardo Valentin wrote:
> On subject s/THERMAL_TREND_DROP_EFULL/THERMAL_TREND_DROP_FULL/g
> 
agreed.

> On 17-06-2013 09:24, Zhang Rui wrote:
> > Change the step_wise cooling algorithm to handle
> > THERMAL_TREND_DROP_FULL a bit differently.
> > 
> > When the temperature is higher than the trip point,
> > we should always use the instance->lower as the next target state.
> > When the temperature is lower than the trip point,
> > we should always deactive the thermal instance.
> 
> s/deactive/deactivate/g
> 
agreed.

thanks,
rui
> 
> Are you expecting to optimize the system in which way by doing this
> change? In which situation we would need to set to instance->lower if we
> are at a state which trend is dropping fully?
> 
> > 
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/thermal/step_wise.c |   12 +++++-------
> >  1 file changed, 5 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/thermal/step_wise.c b/drivers/thermal/step_wise.c
> > index f0cc5e5..84d6e90 100644
> > --- a/drivers/thermal/step_wise.c
> > +++ b/drivers/thermal/step_wise.c
> > @@ -42,9 +42,8 @@
> >   *       state for this trip point, if the cooling state already
> >   *       equals lower limit, deactivate the thermal instance
> >   *    c. if the trend is THERMAL_TREND_RAISE_FULL, do nothing
> > - *    d. if the trend is THERMAL_TREND_DROP_FULL, use lower limit,
> > - *       if the cooling state already equals lower limit,
> > - *       deactive the thermal instance
> > + *    d. if the trend is THERMAL_TREND_DROP_FULL, deactive
> > + *	 the thermal instance
> >   */
> >  static unsigned long get_target_state(struct thermal_instance *instance,
> >  				enum thermal_trend trend, bool throttle)
> > @@ -91,11 +90,10 @@ static unsigned long get_target_state(struct thermal_instance *instance,
> >  		}
> >  		break;
> >  	case THERMAL_TREND_DROP_FULL:
> > -		if (cur_state == instance->lower) {
> > -			if (!throttle)
> > -				next_target = THERMAL_NO_TARGET;
> > -		} else
> > +		if (throttle)
> >  			next_target = instance->lower;
> > +		else
> > +			next_target = THERMAL_NO_TARGET;
> >  		break;
> >  	default:
> >  		break;
> > 
> 
> 


