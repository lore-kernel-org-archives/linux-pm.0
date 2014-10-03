From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 1/3] thermal: step_wise: fix: Prevent from binary overflow
 when trend is dropping
Date: Fri, 03 Oct 2014 09:26:29 +0200
Message-ID: <20141003092629.01afdab7@amdc2363>
References: <1411547232-21493-1-git-send-email-l.majewski@samsung.com>
 <1411547232-21493-2-git-send-email-l.majewski@samsung.com>
 <20141002211325.GA5016@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:11435 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751257AbaJCH0g (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Oct 2014 03:26:36 -0400
In-reply-to: <20141002211325.GA5016@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org

Hi Eduardo,

> Hello Lukasz,
> 
> On Wed, Sep 24, 2014 at 10:27:10AM +0200, Lukasz Majewski wrote:
> > It turns out that some boards can have instance->lower greater than
> > 0 and when thermal trend is dropping it results with next_target
> > equal to -1.
> > 
> > Since the next_target is defined as unsigned long it is interpreted
> > as 0xFFFFFFFF and larger than instance->upper.
> > As a result the next_target is set to instance->upper which ramps
> > up to maximal cooling device target when the temperature is
> > steadily decreasing.
> > 
> 
> Thanks for finding a problem and sending a fix.
> 
> Can you please explain a little more on how next_target reaches -1
> when lower is greater than 0?

During testing I've created a fan based cooling device with
"instance->lower" = 1 and "instance->upper" = 3.

On the system the ordinary cpu_cooling device is also present.

With step_wise.c it happens that at "THERMAL_TREND_DROPPING" the
cur_state = 0, so the first if condition is false (line 80) and
cur_state, which is defined as unsigned long, is decremented. This
means that next_target equals to 0xFFFFFFFF because it also is defined
as unsigned long.
Such value is apparently bigger than "instance->upper" (line 85) and
therefore the maximal cooling state is chosen. As a result, even when
the thermal trend is dropping, the cooling device increase the cooling
state to maximum.

This behavior has been discovered during my work on adapting exynos
thermal driver to reuse the of-thermal. I will send patches for this
work after the weekend.

> 
> 
> > Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> > ---
> >  drivers/thermal/step_wise.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/thermal/step_wise.c
> > b/drivers/thermal/step_wise.c index 3b54c2c..fdd1f52 100644
> > --- a/drivers/thermal/step_wise.c
> > +++ b/drivers/thermal/step_wise.c
> > @@ -77,7 +77,7 @@ static unsigned long get_target_state(struct
> > thermal_instance *instance, next_target = instance->upper;
> >  		break;
> >  	case THERMAL_TREND_DROPPING:
> > -		if (cur_state == instance->lower) {
> > +		if (cur_state <= instance->lower) {
> >  			if (!throttle)
> >  				next_target = THERMAL_NO_TARGET;
> >  		} else {
> > -- 
> > 2.0.0.rc2
> > 
> 
> 
> Eduardo



-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
