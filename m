From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH 1/2] ARM: cpuidle: refine failure handling in init flow
Date: Mon, 9 Oct 2017 22:24:11 +0800
Message-ID: <20171009142411.GB29855@leoy-linaro>
References: <1504507934-14218-1-git-send-email-leo.yan@linaro.org>
 <435dbae2-fc35-722e-85d5-17ca401c2e81@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <435dbae2-fc35-722e-85d5-17ca401c2e81@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>
List-Id: linux-pm@vger.kernel.org

Hi Daniel,

On Mon, Oct 09, 2017 at 02:04:40PM +0200, Daniel Lezcano wrote:
> On 04/09/2017 08:52, Leo Yan wrote:
> > After applied Stefan Wahren patch ("ARM: cpuidle: Avoid memleak if init
> > fail") there have no memleak issue, but the code is not consistent to
> > handle initialization failure between driver registration and device
> > registration. And when device registration fails, it misses to
> > unregister the driver.
> > 
> > So this patch is to refine failure handling in init flow, it adds two
> > 'goto' tags: when register device fails, it goto 'init_dev_fail' tag and
> > free 'dev' structure and unregister driver; when register driver fails,
> > it goto 'init_drv_fail' tag and free 'drv' structure.
> > 
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: Stefan Wahren <stefan.wahren@i2se.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  drivers/cpuidle/cpuidle-arm.c | 25 ++++++++++++++++---------
> >  1 file changed, 16 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
> > index 52a7505..f419f6a 100644
> > --- a/drivers/cpuidle/cpuidle-arm.c
> > +++ b/drivers/cpuidle/cpuidle-arm.c
> > @@ -86,10 +86,13 @@ static int __init arm_idle_init(void)
> >  
> >  	for_each_possible_cpu(cpu) {
> >  
> > +		drv = NULL;
> 
>      ^^^^^
> 
> This initialization is not needed.

Yeah.

> > +		dev = NULL;
> > +
> >  		drv = kmemdup(&arm_idle_driver, sizeof(*drv), GFP_KERNEL);
> >  		if (!drv) {
> >  			ret = -ENOMEM;
> > -			goto out_fail;
> > +			goto init_drv_fail;
> 
> Here we can jump directly to out_fail, no ?

Yes, can directly jump to out_fail.

> >  		}
> >  
> >  		drv->cpumask = (struct cpumask *)cpumask_of(cpu);
> > @@ -104,13 +107,13 @@ static int __init arm_idle_init(void)
> >  		ret = dt_init_idle_driver(drv, arm_idle_state_match, 1);
> >  		if (ret <= 0) {
> >  			ret = ret ? : -ENODEV;
> > -			goto init_fail;
> > +			goto init_drv_fail;
> 
> 	goto out_kfree_drv;
> 
> >  		}
> >  
> >  		ret = cpuidle_register_driver(drv);
> >  		if (ret) {
> >  			pr_err("Failed to register cpuidle driver\n");
> > -			goto init_fail;
> > +			goto init_drv_fail;
> 
> 	goto out_unregister_drv;

Just want to check again, here should be "goto out_kfree_drv"?

> etc ...
> 
> >  	return 0;
> > -init_fail:
> > +
> > +init_dev_fail:
> > +	kfree(dev);
> > +	cpuidle_unregister_driver(drv);
> > +
> > +init_drv_fail:
> >  	kfree(drv);
> > -out_fail:
> > +
> 
> So, the code should end up with:
> 
> out_kfree_dev:
> 	kfree(dev);
> out_unregister_drv:
> 	cpuidle_unregister_drv(drv);
> out_kfree_drv:
> 	kfree(drv);

Yeah, this is clearer than my patch :)

> >  	while (--cpu >= 0) {
> >  		dev = per_cpu(cpuidle_devices, cpu);
> >  		cpuidle_unregister_device(dev);
> > 
> 
> Perhaps it could nicer to create a function with the rollback embedded:
> 
> 	for_each_possible_cpu(cpu) {
> 		ret = arm_idle_init_cpu(cpu)
> 		if (ret)
> 			goto out_fail;
> 	}
> 
> 	return 0;
> 
> out_fail:
> 
> 	while (--cpu >= 0) {
> 		cpuidle_unregister_device(per_cpu(cpuidle_devices,cpu));
> 		cpuidle_unregister_driver(cpuidle_get_cpu_driver(dev));
> 		kfree(dev);
> 		kfree(drv);
> 	}
> 
> 	return ret;
> 
> And arm_idle_init_cpu(int cpu) does what is currently in the loop content.

Understood. I will split into two patches, one patch is to fix
resource releasing issue, the second patch is refactoring patch with a
'new function with the rollback embedded'.

Thanks a lot for the reviewing and suggestion.

Thanks,
Leo Yan
