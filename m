From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH] cpuidle: arm: make enter idle operation a bit more
 efficient
Date: Fri, 25 Mar 2016 21:20:23 +0800
Message-ID: <20160325212023.4d7440b8@xhacker>
References: <1458796038-6062-1-git-send-email-jszhang@marvell.com>
	<20160324160600.GA21749@red-moon>	<20160325142513.6814ee41@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160325142513.6814ee41@xhacker>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, rjw@rjwysocki.net, daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Lorenzo,

On Fri, 25 Mar 2016 14:25:13 +0800 Jisheng Zhang wrote:

> Hi Lorenzo,
> 
> On Thu, 24 Mar 2016 16:06:00 +0000 Lorenzo Pieralisi wrote:
> 
> > On Thu, Mar 24, 2016 at 01:07:18PM +0800, Jisheng Zhang wrote:  
> > > Currently, entering idle need to check the idx every time to choose the
> > > real entering idle routine. But this check could be avoided by pointing
> > > the idle enter function pointer of each idle states to the routines
> > > suitable for each states directly.
> > > 
> > > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > > ---
> > >  drivers/cpuidle/cpuidle-arm.c | 14 ++++++++------
> > >  1 file changed, 8 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
> > > index 545069d..48a620f 100644
> > > --- a/drivers/cpuidle/cpuidle-arm.c
> > > +++ b/drivers/cpuidle/cpuidle-arm.c
> > > @@ -23,6 +23,13 @@
> > >  
> > >  #include "dt_idle_states.h"
> > >  
> > > +static int arm_enter_wfi_state(struct cpuidle_device *dev,
> > > +			       struct cpuidle_driver *drv, int idx)
> > > +{
> > > +	cpu_do_idle();
> > > +	return 0;
> > > +}
> > > +
> > >  /*
> > >   * arm_enter_idle_state - Programs CPU to enter the specified state
> > >   *
> > > @@ -38,11 +45,6 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
> > >  {
> > >  	int ret;
> > >  
> > > -	if (!idx) {
> > > -		cpu_do_idle();
> > > -		return idx;
> > > -	}    
> > 
> > Mmm...if I wanted to paint your bikeshed I would say idx is in a
> > register and you are removing a simple comparison to exchange it
> > with a function that adds to code footprint and may even make
> > performance worse instead of improving anything.
> > 
> > I am not sure this patch makes anything more efficient, happy to be
> > proven wrong, with significant data.  
> 
> Thanks for pointing this out. I'll do some measurement and get back to you
> 

I have done the measurement, the fact shows you are correct!

If there's nothing running in the system, the change improve performance by
about 2.8%

while if there's something running, I saw performance regression.

so let's drop this patch.

Thanks for your reviewing,
Jisheng
