From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [RFC PATCH v2 1/1] drivers: cpuidle: cpuidle-arm: heterogeneous
 systems extension
Date: Tue, 14 Jul 2015 11:23:29 +0100
Message-ID: <20150714102329.GB16165@red-moon>
References: <1429200617-9546-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1429200617-9546-2-git-send-email-lorenzo.pieralisi@arm.com>
 <554771D3.5010701@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:33518 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752812AbbGNKWz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 14 Jul 2015 06:22:55 -0400
Content-Disposition: inline
In-Reply-To: <554771D3.5010701@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Howard Chen <howard.chen@linaro.org>, Rob Herring <robh+dt@kernel.org>, Kevin Hilman <khilman@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Lina Iyer <lina.iyer@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>

Hi Daniel,

On Mon, May 04, 2015 at 02:19:15PM +0100, Daniel Lezcano wrote:
> On 04/16/2015 06:10 PM, Lorenzo Pieralisi wrote:

[...]

> >   /*
> > - * arm_idle_init
> > + * Compare idle states phandle properties
> >    *
> > - * Registers the arm specific cpuidle driver with the cpuidle
> > - * framework. It relies on core code to parse the idle states
> > - * and initialize them using driver data structures accordingly.
> > + * Return true if properties are valid and equal, false otherwise
> 
> Just a detail. Would be more consistent to return zero when valid and
> equal ?

It is a detail but I think it is clearer as it is (ie what would it
return on failure ? After all it is just used as a predicate, there
is no use for a return value other than a boolean), so unless you
have a strong feeling against it I would leave it as it is.

Thanks,
Lorenzo

> >    */
> > -static int __init arm_idle_init(void)
> > +static bool __init idle_states_cmp(struct property *states1,
> > +                                struct property *states2)
> > +{
> > +     /*
> > +      * NB: Implemented through code from drivers/of/unittest.c
> > +      *     Function is generic and can be moved to generic OF code
> > +      *     if needed
> > +      */
> > +     return states1 && states2 &&
> > +            (states1->length == states2->length) &&
> > +            states1->value && states2->value &&
> > +            !memcmp(states1->value, states2->value, states1->length);
> > +}
> > +
> > +static int __init arm_idle_init_driver(struct cpuidle_driver *drv)
> >   {
> > -     int cpu, ret;
> > -     struct cpuidle_driver *drv = &arm_idle_driver;
> > +     int ret, cpu;
> >       struct cpuidle_device *dev;
> > +     struct property *curr_idle_states, *idle_states = NULL;
> > +     struct device_node *cpu_node;
> > +
> > +     for_each_cpu(cpu, drv->cpumask) {
> > +             cpu_node = of_cpu_device_node_get(cpu);
> > +             curr_idle_states = of_find_property(cpu_node,
> > +                                                 "cpu-idle-states", NULL);
> > +             of_node_put(cpu_node);
> > +
> > +             /*
> > +              * Stash the first valid idle states phandle in the cpumask.
> > +              * If curr_idle_states is NULL assigning it to idle_states
> > +              * is harmless and it is managed by idle states comparison
> > +              * code. Keep track of first valid phandle so that
> > +              * subsequent cpus can compare against it.
> > +              */
> > +             if (!idle_states)
> > +                     idle_states = curr_idle_states;
> > +
> > +             /*
> > +              * If idle states phandles are not equal, remove the
> > +              * cpu from the driver mask since a CPUidle driver
> > +              * is only capable of managing uniform idle states.
> > +              *
> > +              * Comparison works also when idle_states and
> > +              * curr_idle_states are the same property, since
> > +              * they can be == NULL so the cpu must be removed from
> > +              * the driver mask in that case too (ie cpu has no idle
> > +              * states).
> > +              */
> > +             if (!idle_states_cmp(idle_states, curr_idle_states))
> > +                     cpumask_clear_cpu(cpu, drv->cpumask);
> > +     }
> > +
> > +     /*
> > +      *  If there are no valid states for this driver we rely on arch
> > +      *  default idle behaviour, bail out
> > +      */
> > +     if (!idle_states)
> > +             return -ENODEV;
> >
> >       /*
> >        * Initialize idle states data, starting at index 1.
> > @@ -117,7 +173,7 @@ static int __init arm_idle_init(void)
> >        * Call arch CPU operations in order to initialize
> >        * idle states suspend back-end specific data
> >        */
> > -     for_each_possible_cpu(cpu) {
> > +     for_each_cpu(cpu, drv->cpumask) {
> >               ret = arm_cpuidle_init(cpu);
> >
> >               /*
> > @@ -157,7 +213,77 @@ out_fail:
> >       }
> >
> >       cpuidle_unregister_driver(drv);
> > +     return ret;
> > +}
> > +
> > +/*
> > + * arm_idle_init
> > + *
> > + * Registers the arm specific cpuidle driver(s) with the cpuidle
> > + * framework. It relies on core code to parse the idle states
> > + * and initialize them using driver data structures accordingly.
> > + */
> > +static int __init arm_idle_init(void)
> > +{
> > +     int i, ret = -ENODEV;
> > +     struct cpuidle_driver *drv;
> > +     cpumask_var_t tmpmask;
> > +
> > +     /*
> > +      * These drivers require DT idle states to be present.
> > +      * If no idle states are detected there is no reason to
> > +      * proceed any further hence we return early.
> > +      */
> > +     if (!of_find_node_by_name(NULL, "idle-states"))
> > +             return -ENODEV;
> > +
> > +     if (!alloc_cpumask_var(&tmpmask, GFP_KERNEL))
> > +             return -ENOMEM;
> > +
> > +     /*
> > +      * We need to vet idle states to create CPUidle drivers
> > +      * that share a common set of them. Create a tmp mask
> > +      * that we use to keep track of initialized cpus.
> > +      * Start off by initializing the mask with all possible
> > +      * cpus, we clear it as we go, till either all cpus
> > +      * have a CPUidle driver initialized or there are some
> > +      * CPUs that have no idle states or a parsing error
> > +      * occurs.
> > +      */
> > +     cpumask_copy(tmpmask, cpu_possible_mask);
> > +
> > +     for (i = 0; !cpumask_empty(tmpmask); i++) {
> > +             if (i == ARM_CPUIDLE_MAX_DRIVERS) {
> > +                     pr_warn("number of drivers exceeding static allocation\n");
> > +                     break;
> > +             }
> > +
> > +             drv = &arm_idle_drivers[i];
> > +             drv->cpumask = kzalloc(cpumask_size(), GFP_KERNEL);
> > +             if (!drv->cpumask) {
> > +                     ret = -ENOMEM;
> > +                     break;
> > +             }
> > +             /*
> > +              * Force driver mask, arm_idle_init_driver()
> > +              * will tweak it by vetting idle states.
> > +              */
> > +             cpumask_copy(drv->cpumask, tmpmask);
> 
> Why do you need to copy tmpmask ? Isn't simpler to have a zero-ed
> cpumask and let the arm_idle_init_driver function to set a bit instead
> of clearing it ?
> 
> > +             ret = arm_idle_init_driver(drv);
> > +             if (ret) {
> > +                     kfree(drv->cpumask);
> > +                     break;
> > +             }
> > +             /*
> > +              * Remove the cpus that were part of the registered
> > +              * driver from the mask of cpus to be initialized
> > +              * and restart.
> > +              */
> > +             cpumask_andnot(tmpmask, tmpmask, drv->cpumask);
> 
> If there is a DT definition with just a cluster with the cpuidle driver
> set and another one without any idle state, we will have always a
> pr_warn because i == ARM_CPUIDLE_MAX_DRIVERS due to tmpmask being never
> equal to a zero mask. Is it the purpose to detect such cases ?
> 
> > +     }
> >
> > +     free_cpumask_var(tmpmask);
> >       return ret;
> >   }
> >   device_initcall(arm_idle_init);
> >
> 
> 
> --
>   <http://www.linaro.org/> Linaro.org ??? Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
