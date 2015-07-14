From: Daniel Kurtz <djkurtz@chromium.org>
Subject: Re: [RFC PATCH v2 1/1] drivers: cpuidle: cpuidle-arm: heterogeneous
 systems extension
Date: Tue, 14 Jul 2015 12:52:48 +0800
Message-ID: <CAGS+omBtraNBH43qsFn_YgO3ePbFav9VtwgqDUinbOBMPwOGXA@mail.gmail.com>
References: <1429200617-9546-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1429200617-9546-2-git-send-email-lorenzo.pieralisi@arm.com>
 <554771D3.5010701@linaro.org> <20150505155615.GA23106@red-moon> <20150512130339.GB15131@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:33719 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbbGNExI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2015 00:53:08 -0400
Received: by ykeo3 with SMTP id o3so213234320yke.0
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2015 21:53:07 -0700 (PDT)
In-Reply-To: <20150512130339.GB15131@red-moon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Rutland <Mark.Rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Howard Chen <howard.chen@linaro.org>, Kevin Hilman <khilman@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Lina Iyer <lina.iyer@linaro.org>, Ricky Liang <jcliang@chromium.org>, =?UTF-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= <eddie.huang@mediatek.com>, Joseph Lo <josephl@nvidia.com>, Benson Leung <bleung@chromium.org>

Hi Lorenzo,

On Tue, May 12, 2015 at 9:03 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> On Tue, May 05, 2015 at 04:56:15PM +0100, Lorenzo Pieralisi wrote:
>> On Mon, May 04, 2015 at 02:19:15PM +0100, Daniel Lezcano wrote:
>> > On 04/16/2015 06:10 PM, Lorenzo Pieralisi wrote:
>>
>> <snip>
>>
>> > >   /*
>> > > - * arm_idle_init
>> > > + * Compare idle states phandle properties
>> > >    *
>> > > - * Registers the arm specific cpuidle driver with the cpuidle
>> > > - * framework. It relies on core code to parse the idle states
>> > > - * and initialize them using driver data structures accordingly.
>> > > + * Return true if properties are valid and equal, false otherwise
>> >
>> > Just a detail. Would be more consistent to return zero when valid and
>> > equal ?
>>
>> Consistent with memcmp you mean ? Yes, I can change it.
>>
>> > >    */
>> > > -static int __init arm_idle_init(void)
>> > > +static bool __init idle_states_cmp(struct property *states1,
>> > > +                                struct property *states2)
>> > > +{
>> > > +     /*
>> > > +      * NB: Implemented through code from drivers/of/unittest.c
>> > > +      *     Function is generic and can be moved to generic OF code
>> > > +      *     if needed
>> > > +      */
>> > > +     return states1 && states2 &&
>> > > +            (states1->length == states2->length) &&
>> > > +            states1->value && states2->value &&
>> > > +            !memcmp(states1->value, states2->value, states1->length);
>> > > +}
>> > > +
>> > > +static int __init arm_idle_init_driver(struct cpuidle_driver *drv)
>> > >   {
>> > > -     int cpu, ret;
>> > > -     struct cpuidle_driver *drv = &arm_idle_driver;
>> > > +     int ret, cpu;
>> > >       struct cpuidle_device *dev;
>> > > +     struct property *curr_idle_states, *idle_states = NULL;
>> > > +     struct device_node *cpu_node;
>> > > +
>> > > +     for_each_cpu(cpu, drv->cpumask) {
>> > > +             cpu_node = of_cpu_device_node_get(cpu);
>> > > +             curr_idle_states = of_find_property(cpu_node,
>> > > +                                                 "cpu-idle-states", NULL);
>> > > +             of_node_put(cpu_node);
>> > > +
>> > > +             /*
>> > > +              * Stash the first valid idle states phandle in the cpumask.
>> > > +              * If curr_idle_states is NULL assigning it to idle_states
>> > > +              * is harmless and it is managed by idle states comparison
>> > > +              * code. Keep track of first valid phandle so that
>> > > +              * subsequent cpus can compare against it.
>> > > +              */
>> > > +             if (!idle_states)
>> > > +                     idle_states = curr_idle_states;
>> > > +
>> > > +             /*
>> > > +              * If idle states phandles are not equal, remove the
>> > > +              * cpu from the driver mask since a CPUidle driver
>> > > +              * is only capable of managing uniform idle states.
>> > > +              *
>> > > +              * Comparison works also when idle_states and
>> > > +              * curr_idle_states are the same property, since
>> > > +              * they can be == NULL so the cpu must be removed from
>> > > +              * the driver mask in that case too (ie cpu has no idle
>> > > +              * states).
>> > > +              */
>> > > +             if (!idle_states_cmp(idle_states, curr_idle_states))
>> > > +                     cpumask_clear_cpu(cpu, drv->cpumask);
>> > > +     }
>> > > +
>> > > +     /*
>> > > +      *  If there are no valid states for this driver we rely on arch
>> > > +      *  default idle behaviour, bail out
>> > > +      */
>> > > +     if (!idle_states)
>> > > +             return -ENODEV;
>> > >
>> > >       /*
>> > >        * Initialize idle states data, starting at index 1.
>> > > @@ -117,7 +173,7 @@ static int __init arm_idle_init(void)
>> > >        * Call arch CPU operations in order to initialize
>> > >        * idle states suspend back-end specific data
>> > >        */
>> > > -     for_each_possible_cpu(cpu) {
>> > > +     for_each_cpu(cpu, drv->cpumask) {
>> > >               ret = arm_cpuidle_init(cpu);
>> > >
>> > >               /*
>> > > @@ -157,7 +213,77 @@ out_fail:
>> > >       }
>> > >
>> > >       cpuidle_unregister_driver(drv);
>> > > +     return ret;
>> > > +}
>> > > +
>> > > +/*
>> > > + * arm_idle_init
>> > > + *
>> > > + * Registers the arm specific cpuidle driver(s) with the cpuidle
>> > > + * framework. It relies on core code to parse the idle states
>> > > + * and initialize them using driver data structures accordingly.
>> > > + */
>> > > +static int __init arm_idle_init(void)
>> > > +{
>> > > +     int i, ret = -ENODEV;
>> > > +     struct cpuidle_driver *drv;
>> > > +     cpumask_var_t tmpmask;
>> > > +
>> > > +     /*
>> > > +      * These drivers require DT idle states to be present.
>> > > +      * If no idle states are detected there is no reason to
>> > > +      * proceed any further hence we return early.
>> > > +      */
>> > > +     if (!of_find_node_by_name(NULL, "idle-states"))
>> > > +             return -ENODEV;
>> > > +
>> > > +     if (!alloc_cpumask_var(&tmpmask, GFP_KERNEL))
>> > > +             return -ENOMEM;
>> > > +
>> > > +     /*
>> > > +      * We need to vet idle states to create CPUidle drivers
>> > > +      * that share a common set of them. Create a tmp mask
>> > > +      * that we use to keep track of initialized cpus.
>> > > +      * Start off by initializing the mask with all possible
>> > > +      * cpus, we clear it as we go, till either all cpus
>> > > +      * have a CPUidle driver initialized or there are some
>> > > +      * CPUs that have no idle states or a parsing error
>> > > +      * occurs.
>> > > +      */
>> > > +     cpumask_copy(tmpmask, cpu_possible_mask);
>> > > +
>> > > +     for (i = 0; !cpumask_empty(tmpmask); i++) {
>> > > +             if (i == ARM_CPUIDLE_MAX_DRIVERS) {
>> > > +                     pr_warn("number of drivers exceeding static allocation\n");
>> > > +                     break;
>> > > +             }
>> > > +
>> > > +             drv = &arm_idle_drivers[i];
>> > > +             drv->cpumask = kzalloc(cpumask_size(), GFP_KERNEL);
>> > > +             if (!drv->cpumask) {
>> > > +                     ret = -ENOMEM;
>> > > +                     break;
>> > > +             }
>> > > +             /*
>> > > +              * Force driver mask, arm_idle_init_driver()
>> > > +              * will tweak it by vetting idle states.
>> > > +              */
>> > > +             cpumask_copy(drv->cpumask, tmpmask);
>> >
>> > Why do you need to copy tmpmask ? Isn't simpler to have a zero-ed
>> > cpumask and let the arm_idle_init_driver function to set a bit instead
>> > of clearing it ?
>>
>> No, because we need to keep track of logical cpus that have been
>> already parsed, we need a tmpmask to keep track of that, how could
>> we do it otherwise ? We can have more than two cpumask sets.
>>
>> >
>> > > +             ret = arm_idle_init_driver(drv);
>> > > +             if (ret) {
>> > > +                     kfree(drv->cpumask);
>> > > +                     break;
>> > > +             }
>> > > +             /*
>> > > +              * Remove the cpus that were part of the registered
>> > > +              * driver from the mask of cpus to be initialized
>> > > +              * and restart.
>> > > +              */
>> > > +             cpumask_andnot(tmpmask, tmpmask, drv->cpumask);
>> >
>> > If there is a DT definition with just a cluster with the cpuidle driver
>> > set and another one without any idle state, we will have always a
>> > pr_warn because i == ARM_CPUIDLE_MAX_DRIVERS due to tmpmask being never
>> > equal to a zero mask. Is it the purpose to detect such cases ?
>>
>> Not really, because arm_idle_init_driver() would return -ENODEV when
>> it detects cpus with no idle states and the loop will break before warning.
>>
>> If we had two cluster of cpus with an idle-states set per cluster plus
>> some cpus with no idle states the warning would be hit, because
>> in actual facts we have more cpuidle sets than drivers (I know, a cpu
>> set with no idle states falls back to default idle, but I think
>> that's a detail that is easy to sort out).
>>
>> I can create idle drivers dynamically so that the ARM_CPUIDLE_MAX_DRIVERS
>> check can be removed or relaxed (but the code becomes slightly more complex).
>>
>> Thanks for having a look, apart from these comments do we think it is
>> a reasonable approach ?
>
> Any further comments ? I can post a v2 with an updated idle_states_cmp()
> return value, if we think the multiple drivers approach is valid.

Can you post v2?
>From the silence on the list, I guess there is no strong objection to
your approach.
So, perhaps it is time to remove the "RFC" as well so this can get on
track to be merged.

-Dan


>
> Thanks a lot,
> Lorenzo
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
