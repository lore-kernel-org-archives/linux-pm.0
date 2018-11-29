From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] Documentation: admin-guide: PM: Add cpuidle document
Date: Thu, 29 Nov 2018 19:03:09 +0100
Message-ID: <CAPDyKFqE8PqEnvYkz=VwBrOtqrsCJLvjLsVvV60MDdUjbMWpew@mail.gmail.com>
References: <9986634.fXZiTbRPzQ@aspire.rjw.lan> <CAPDyKFp_1nCF7nn0dXYbm_kJDo+0rp8O1nGPFH+NrS3wz8RW1Q@mail.gmail.com>
 <CAJZ5v0gkJMYQEqVScOY_9_MWpWKfw_Ji1csEoiRu+YVy24BrTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0gkJMYQEqVScOY_9_MWpWKfw_Ji1csEoiRu+YVy24BrTg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jonathan Corbet <corbet@lwn.net>, Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, jacob.jun.pan@linux.intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, ggherdovich@suse.cz, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 29 Nov 2018 at 11:28, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Nov 29, 2018 at 9:07 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Wed, 28 Nov 2018 at 12:47, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > Important information is missing from user/admin cpuidle documentation
> > > available today, so add a new user/admin document for cpuidle containing
> > > current and comprehensive information to admin-guide and drop the old
> > > .txt documents it is replacing.
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > ---
> >
> > Wow! Great work!
> >
> > [...]
> >
> > > +.. _idle-states-representation:
> > > +
> > > +Representation of Idle States
> > > +=============================
> > > +
> > > +For the CPU idle time management purposes all of the physical idle states
> > > +supported by the processor have to be represented as a one-dimensional array of
> > > +|struct cpuidle_state| objects each allowing an individual (logical) CPU to ask
> > > +the processor hardware to enter an idle state of certain properties.  If there
> > > +is a hierarchy of units in the processor, one |struct cpuidle_state| object can
> > > +cover a combination of idle states supported by the units at different levels of
> > > +the hierarchy.  In that case, the `target residency and exit latency parameters
> > > +of it <idle-loop_>`_, must reflect the properties of the idle state at the
> > > +deepest level (i.e. the idle state of the unit containing all of the other
> > > +units).
> > > +
> > > +For example, take a processor with two cores in a larger unit referred to as
> > > +a "module" and suppose that asking the hardware to enter a specific idle state
> > > +(say "X") at the "core" level by one core will trigger the module to try to
> > > +enter a specific idle state of its own (say "MX") if the other core is in idle
> > > +state "X" already.  In other words, asking for idle state "X" at the "core"
> > > +level gives the hardware a license to go as deep as to idle state "MX" at the
> > > +"module" level, but there is no guarantee that this is going to happen (the core
> > > +asking for idle state "X" may just end up in that state by itself instead).
> >
> > This is a good description of a HW like x86 and ARM64 (using PSCI in
> > platform coordinated mode).
> >
> > However, for "legacy" ARM products, having at least two cores in a
> > module, this description does in many cases *not* match how the HW
> > works. I wonder about other architectures.
>
> Well, this is an example and it is very clearly presented this way IMO
> (it says "for example" upfront and then "suppose" etc).
>
> Basically, the purpose of it is to explain that the parameters shown
> in sysfs may be effective.
>
> > My point is, I think it would be fair to mention that the above
> > description is specific to certain HWs. In other words, for HWs that
> > leaves the entire state synchronization of the last man standing
> > algorithm to be managed by a FW, the cpuidle framework plays well. But
> > for others it has limitations.
>
> I can add it after this entire paragraph I think.  Something like
>
> "There are processors without direct coordination between different
> levels of the hierarchy of units inside them, however.  In those cases
> asking for an idle state at the "core" level does not automatically
> affect the "module" level, for example, in any way and the CPUIdle
> driver is responsible for the entire handling of the hierarchy.  Then,
> the definition of the idle state objects is entirely up to the driver,
> but still the physical properties of the idle state that the processor
> hardware finally goes into must always follow the parameters used by
> the governor for idle state selection (for instance, the actual exit
> latency of that idle state must not exceed the exit latency parameter
> of the idle state object selected by the governor)."

I like this! This leaves some room for understanding that cpuidle has
limitations when in comes down to these kind of platforms, which seems
like reasonable statement to include.

With that, feel free to add:
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

>
> >
> > > +Then, the target residency of the |struct cpuidle_state| object representing
> > > +idle state "X" must reflect the minimum time to spend in idle state "MX" of
> > > +the module (including the time needed to enter it), because that is the minimum
> > > +time the CPU needs to be idle to save any energy in case the hardware enters
> > > +that state.  Analogously, the exit latency parameter of that object must cover
> > > +the exit time of idle state "MX" of the module (and usually its entry time too),
> > > +because that is the maximum delay between a wakeup signal and the time the CPU
> > > +will start to execute the first new instruction (assuming that both cores in the
> > > +module will always be ready to execute instructions as soon as the module
> > > +becomes operational as a whole).
> >
> > For the HW working as you described, this is a nice clarification, thanks!
> >
> > [...]
> >
> > > +
> > > +.. _cpu-pm-qos:
> > > +
> > > +Power Management Quality of Service for CPUs
> > > +============================================
> > > +
> > > +The power management quality of service (PM QoS) framework in the Linux kernel
> > > +allows kernel code and user space processes to set constraints on various
> > > +energy-efficiency features of the kernel to prevent performance from dropping
> > > +below a required level.  The PM QoS constraints can be set globally, in
> > > +predefined categories referred to as PM QoS classes, or against individual
> > > +devices.
> > > +
> > > +CPU idle time management can be affected by PM QoS in two ways, through the
> > > +global constraint in the ``PM_QOS_CPU_DMA_LATENCY`` class and through the
> >
> > No objections to the description, it's really nice! However, the
> > naming of this QOS class, is to me, rather confusing.
>
> Yes, it is confusing.
>
> > I realize renaming the sysfs node is not an option,
>
> That is a device special file, but yes, renaming it is not an option.
> And since the name of the PM QoS class reflects the name of the device
> special file associated with it, I'd rather not rename the class
> either, as that would just move the confusion point, so to speak.

Okay.

>
> > but maybe we should make a tree wide change to rename the class to something more
> > descriptive. What do you think?
>
> IMO it would be fine to introduce an alternative symbol, say
>
> #define PM_QOS_CPU_WAKEUP_LATENCY PM_QOS_CPU_DMA_LATENCY
>
> and use the alternative (PM_QOS_CPU_WAKEUP_LATENCY in this case) in
> the cpuidle subsystem.
>
> But that's just cosmetics. :-)

Yes, so then we just rather keep it as is. :-)

Kind regards
Uffe
