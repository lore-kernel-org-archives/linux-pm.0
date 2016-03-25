From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH] cpuidle: arm: make enter idle operation a bit more
 efficient
Date: Fri, 25 Mar 2016 14:25:13 +0800
Message-ID: <20160325142513.6814ee41@xhacker>
References: <1458796038-6062-1-git-send-email-jszhang@marvell.com>
	<20160324160600.GA21749@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:1928 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751809AbcCYGcA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Mar 2016 02:32:00 -0400
In-Reply-To: <20160324160600.GA21749@red-moon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: rjw@rjwysocki.net, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Lorenzo,

On Thu, 24 Mar 2016 16:06:00 +0000 Lorenzo Pieralisi wrote:

> On Thu, Mar 24, 2016 at 01:07:18PM +0800, Jisheng Zhang wrote:
> > Currently, entering idle need to check the idx every time to choose the
> > real entering idle routine. But this check could be avoided by pointing
> > the idle enter function pointer of each idle states to the routines
> > suitable for each states directly.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---
> >  drivers/cpuidle/cpuidle-arm.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
> > index 545069d..48a620f 100644
> > --- a/drivers/cpuidle/cpuidle-arm.c
> > +++ b/drivers/cpuidle/cpuidle-arm.c
> > @@ -23,6 +23,13 @@
> >  
> >  #include "dt_idle_states.h"
> >  
> > +static int arm_enter_wfi_state(struct cpuidle_device *dev,
> > +			       struct cpuidle_driver *drv, int idx)
> > +{
> > +	cpu_do_idle();
> > +	return 0;
> > +}
> > +
> >  /*
> >   * arm_enter_idle_state - Programs CPU to enter the specified state
> >   *
> > @@ -38,11 +45,6 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
> >  {
> >  	int ret;
> >  
> > -	if (!idx) {
> > -		cpu_do_idle();
> > -		return idx;
> > -	}  
> 
> Mmm...if I wanted to paint your bikeshed I would say idx is in a
> register and you are removing a simple comparison to exchange it
> with a function that adds to code footprint and may even make
> performance worse instead of improving anything.
> 
> I am not sure this patch makes anything more efficient, happy to be
> proven wrong, with significant data.

Thanks for pointing this out. I'll do some measurement and get back to you

Thanks,
Jisheng

