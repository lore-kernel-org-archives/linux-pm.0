From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC v3 3/3] Documentation: arm: define DT idle states
 bindings
Date: Fri, 14 Feb 2014 11:27:56 +0000
Message-ID: <20140214112756.GA25043@e102568-lin.cambridge.arm.com>
References: <1392128273-8614-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1392128273-8614-4-git-send-email-lorenzo.pieralisi@arm.com>
 <20140213013153.18853.21632@capellas-linux>
 <20140213124731.GD26329@e102568-lin.cambridge.arm.com>
 <20140214002926.1014.3599@capellas-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140214002926.1014.3599@capellas-linux>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Capella <sebastian.capella@linaro.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Mike Turquette <mturquette@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Dave P Martin <Dave.Martin@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, "pveerapa@broadcom.com" <pveerapa@broadcom.com>, Peter De Schrijver <pdeschrijver@nvidia.>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 14, 2014 at 12:29:26AM +0000, Sebastian Capella wrote:
> Quoting Lorenzo Pieralisi (2014-02-13 04:47:32)
> 
> > Such as ? "idle-states" ?
> 
> That sounds good to me.  Our preference is for idle-states to be used
> for name of the idle-states.txt node.

Ok, so s/cpu-idle-state/idle-state everywhere, inclusive of state nodes
compatible properties ("arm,cpu-idle-state" becomes "arm,idle-state") ?

> > > During last connect, we'd discussed that the small set of
> > > states here could apply to a single node, which can represent a cpu, a
> > > cluster with cache etc.  Then the complexities of the system power state
> > > would be represented using a heirarchy, with each node in the
> > > tree having its own state from the list above.  This would allow
> > > a fairly rich system state while having just a few power states defined
> > > at each level.  Is this how you're intending these bindings to go?
> >
> > Yes, CPUs point at states that can be reached by that CPU (eg a CPU core
> > gating state is represented by a single node pointed at by all CPUs in the
> > system - it the same state data, different power domains though).
> > 
> > States are hierarchical, which means that a parent state implies entry on all
> > substates that's how cluster states are defined.
> 
> The cpu 0 node, in its cpu-idle-state array is also pointing at a cluster
> node right?  STATE0 -> power-domains refers to <pd_clusters 0>.  Is it
> correct that if the cpu's workload is such that it tolerates the
> 500/1000/2500 entry/exit latency/min-residency, it will call the
> entry-method with the psci-power-state of 0x10100000 matching that node?

Yes. As we know, since it is a cluster state, that might happen or not
depending on the state of other CPUs.

> > > Also, would it be nice to have a name field for each state?
> > 
> > There is:
> > 
> > "The state node name shall be "stateN", where N = {0, 1, ...} is
> > the node number; state nodes which are siblings within a single
> > common parent node must be given a unique and sequential N value,
> > starting from 0."
> > I can remove the rule and allow people to call states as they wish
> > since they already have a compatible property to match them.
> > 
> > Actually, states can be called with any name, provided it is unique.
> 
> Sorry, I was referring to a descriptive name string property.  Something
> that can be useful to help a human understand what's going on.  Naming
> the nodes might work too.

I do not like that, but I can remove the naming scheme and let people
find a naming scheme that complies with DT rules (nodes within a parent
must have a unique name). Not sure this would make dts more readable, but
I do not think it is a problem either.

> > > > +       A state node can contain state child nodes. A state node with
> > > > +       children represents a hierarchical state, which is a superset of
> > > > +       the child states. Hierarchical states require all CPUs on which
> > > > +       they are valid to request the state in order for it to be entered.
> > > 
> > > Is it possible for a cpu to request a deeper state and unblock other cpus
> > > from entering this state?
> > 
> > That's not DT bindings business, hierarchical states define states that
> > require all CPUs on which they are valid to enter that state for it to
> > be considered "enabled".
> > 
> > It is a hard nut to crack. In x86 this stuff does not exist and it is
> > managed in HW, basically an idle state is always per-cpu (but it might
> > end up becoming a package state when all CPUs in a package enter that
> > state). On ARM, we want to define hierarchical states explicitly to
> > link resources (ie caches) to them.
> > 
> > CPUs are not prevented from requesting a hierarchical state, but the
> > state only becomes "enabled" when all CPUs on which it is valid request
> > it.
> 
> The way we've seen it work, is a cpu tries to enter the lowest state it can
> tolerate (including for eg. cluster off).  The system level code then looks
> at the allowable states from all the cpus and selects the lowest power
> state permissible for the heirarchies.
> 
> Eg. this way, the last cpu preventing a cluster from going to sleep enters
> cluster sleep state (where peer cpu's have already voted for cluster
> sleep) and the cluster will sleep.  Alternately if the same cpu cannot
> tolerate the additional latency of the cluster sleeping, it will vote
> only for cpu-sleep, then the cluster remains in a state where all cpu's are
> sleeping but the cluster remains up.

That's exactly what these bindings are meant to describe too and I think they
do. There is also loads of information that can be used for tuning (what
caches are affected by an idle state, what CPUs "share" an idle-state
and so on).

> > I cannot think of any other way of to express this properly but still in
> > a compact way.
> 
> You're doing a great job by the way!  Thanks! :)

Thank you, we are almost there.

> > > "all CPUs on which they are valid" is this determined by seeing which
> > > state's phandle is in each cpu->cpu-idle-states?
> > 
> > Yes, does it make sense ?
> 
> Yup, maybe adding a little parenthetical text like below may help others
> as well?
> 
> Hierarchical states require all CPUs on which they are valid (ie. CPU nodes
> containing cpu-idle-state arrays having a phandle reference to the state)
> to request the state in order for it to be entered.

OK, applied.

> > 
> > > Definition: It represents an idle state index.
> > > 
> > >         Index 0 and 1 shall not be specified and are reserved for ARM
> > >         states where index 0 is running, and index 1 is idle_standby
> > >         entered by executing a wfi instruction (SBSA,[3])
> > > 
> > > What mechanism is used to order the power states WRT power consumption?
> > 
> > I think we should use index for that. The higher the index the lower the
> > power consumption.
> 
> Ok, I think I get it now.
> If we decouple index and SBSA states, do we really need to reserve index
> 0 and 1 then?

What I will do: move the entry-method to top-level cpu-idle-states node
(soon to be idle-states node) and add a property there:

"arm,has-idlewfi"

which allows me to prevent people from adding an explicit state that just
executes the wfi instruction on entry.

This way we can have a *global* entry-method, and we can also detect if the
platform supports wfi in its bare form.

Yes, index can start from 0, disallowing 0 and 1 was a (odd) way to prevent
people from adding wfi to DT. If the platform supports simple idlestandby
(ie wfi) it has to add the boolean property above.

How does that sound ?

> > > Can this field be used to combine both psci and non-psci states in any order?
> > 
> > No. I will enforce a unique entry method.
> 
> So a single entry-method for all  states in idle-states node?
> Should this be specified once only then?

Yes, see above.

> Should we not allow more flexibility here to mix methods where some
> states use one method and some use others?  Is this mostly a security
> concern?  What if a vendor wants to introduce a state between wfi and
> cpu-sleep?

entry-method-param is the way to differentiate. One interface/entry-method
(PSCI or vendor specific), different state parameters.

We are not installing multiple back-ends to enter different idle states,
are we ? That would be awkward.

ACK ?

> > > I assume psci will be turning off the powerdomains not Linux right?
> > 
> > This is not a PSCI only document, and even if it was, we still need to deal
> > with devices. Which means we need to know what we have to save/restore (PMU,
> > arch timer, GIC), and power domains help us detect that.
> 
> > > > +
> > > > +cpus {
> > > > +       #size-cells = <0>;
> > > > +       #address-cells = <2>;
> > > > +
> > > > +       cpu-idle-states {
> > > > +
> > > > +               STATE0: state0 {
> > > > +                       compatible = "arm,cpu-idle-state";
> > > > +                       index = <3>;
> > > 
> > > Are the index fields of nested states independent of each other or
> > > sequential?
> > ...
> > I understand index is misleading and either I remove it, or I
> > leave it there to define power savings scale as you mentioned.
> 
> I like index, but I was confused.  You cleared it up pretty quick with
> your earlier comment.  Removing the numbering may help, but I think
> keeping the index is useful.

I will leave the index to sort the states according to power consumption.

Thanks !
Lorenzo
