From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC v4 3/3] Documentation: arm: define DT idle states
 bindings
Date: Tue, 11 Mar 2014 12:51:42 +0000
Message-ID: <20140311125142.GA25796@e102568-lin.cambridge.arm.com>
References: <1392724051-11950-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1392724051-11950-4-git-send-email-lorenzo.pieralisi@arm.com>
 <CAL_JsqJR52KGtBJsbZ51bDmWHnnd-uKAgnRp4TLXna3DkSJJbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_JsqJR52KGtBJsbZ51bDmWHnnd-uKAgnRp4TLXna3DkSJJbw@mail.gmail.com>
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
To: Rob Herring <robherring2@gmail.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Mike Turquette <mturquette@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Russell King <linux@arm.linux.org.uk>, Sebastian Capella <sebastian.capella@linaro.org>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Dave P Martin <Dave.Martin@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Peter De Schrijver <pdeschrijver@nvidia>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 10, 2014 at 07:13:04PM +0000, Rob Herring wrote:
> On Tue, Feb 18, 2014 at 5:47 AM, Lorenzo Pieralisi
> <lorenzo.pieralisi@arm.com> wrote:
> > ARM based platforms implement a variety of power management schemes that
> > allow processors to enter idle states at run-time.
> > The parameters defining these idle states vary on a per-platform basis forcing
> > the OS to hardcode the state parameters in platform specific static tables
> > whose size grows as the number of platforms supported in the kernel increases
> > and hampers device drivers standardization.
> >
> > Therefore, this patch aims at standardizing idle state device tree bindings for
> > ARM platforms. Bindings define idle state parameters inclusive of entry methods
> > and state latencies, to allow operating systems to retrieve the configuration
> > entries from the device tree and initialize the related power management
> > drivers, paving the way for common code in the kernel to deal with idle
> > states and removing the need for static data in current and previous kernel
> > versions.
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > ---
> >  Documentation/devicetree/bindings/arm/cpus.txt        |  10 +
> >  Documentation/devicetree/bindings/arm/idle-states.txt | 781 +++++
> >  2 files changed, 791 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/cpus.txt b/Documentation/devicetree/bindings/arm/cpus.txt
> > index 9130435..fd1fd8d 100644
> > --- a/Documentation/devicetree/bindings/arm/cpus.txt
> > +++ b/Documentation/devicetree/bindings/arm/cpus.txt
> > @@ -191,6 +191,13 @@ nodes to be present and contain the properties described below.
> >                           property identifying a 64-bit zero-initialised
> >                           memory location.
> >
> > +       - cpu-idle-states
> > +               Usage: Optional
> > +               Value type: <prop-encoded-array>
> > +               Definition:
> > +                       # List of phandles to idle state nodes supported
> > +                         by this cpu [1].
> > +
> >  Example 1 (dual-cluster big.LITTLE system 32-bit):
> >
> >         cpus {
> > @@ -382,3 +389,6 @@ cpus {
> >                 cpu-release-addr = <0 0x20000000>;
> >         };
> >  };
> > +
> > +[1] ARM Linux kernel documentation - idle states bindings
> > +    Documentation/devicetree/bindings/arm/idle-states.txt
> > diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Documentation/devicetree/bindings/arm/idle-states.txt
> > new file mode 100644
> > index 0000000..f9a48a1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/idle-states.txt
> > @@ -0,0 +1,781 @@
> > +==========================================
> > +ARM idle states binding description
> > +==========================================
> > +
> > +==========================================
> > +1 - Introduction
> > +==========================================
> > +
> > +ARM systems contain HW capable of managing power consumption dynamically,
> > +where cores can be put in different low-power states (ranging from simple
> > +wfi to power gating) according to OSPM policies. The CPU states representing
> > +the range of dynamic idle states that a processor can enter at run-time, can be
> > +specified through device tree bindings representing the parameters required
> > +to enter/exit specific idle states on a given processor.
> > +
> > +According to the Server Base System Architecture document (SBSA, [4]), the
> > +power states an ARM CPU can be put into are identified by the following list:
> > +
> > +- Running
> > +- Idle_standby
> > +- Idle_retention
> > +- Sleep
> > +- Off
> > +
> > +The power states described in the SBSA document define the basic CPU states on
> > +top of which ARM platforms implement power management schemes that allow an OS
> > +PM implementation to put the processor in different idle states (which include
> > +states listed above; "off" state is not an idle state since it does not have
> > +wake-up capabilities, hence it is not considered in this document).
> 
> Is your only target SBSA compliant systems? If so, we obviously don't
> need this since those will all be using ACPI. :)

SBSA defines nomenclature "on top of which ARM platforms implement power
management schemes". I think that's proper wording, ACPI or DT.

> Either way I'd like to see some real usage of this binding. We
> continue to add more and more complexity to cpu related DT bindings
> with very little actual use. We don't need bindings for how ARM thinks
> h/w should work. We need bindings for how h/w actually works.

That's great and that's what these bindings are meant for.
If you and other reviewers out there spot inconsinstencies with how
"h/w actually works (TM)", flag this up. I am not posting these bindings
to define how ARM thinks h/w should work, I really do not understand
why you think that's the case.

I will be posting a generic PSCI based CPU idle driver soon.

> I continue to be confused why we added cpu topology bindings yet don't
> add information that applies to certain levels in the topology. This
> makes me think the topology should just be built into /cpus.

And how is that different from cpu-map ?

Are you referring to OPPs ? What do you mean by "built into /cpus" ?

The first reason why we defined the cpu-map was to override MPIDR
configurations. If we want to use that for other reasons (use phandle to
topology nodes to group CPUs) that's still fine.

I told you already, it was not an easy decision to make and I am
always open to suggestions, if you have a solution in mind post it.

> > +
> > +Idle state parameters (eg entry latency) are platform specific and need to be
> > +characterized with bindings that provide the required information to OSPM
> > +code so that it can build the required tables and use them at runtime.
> > +
> > +The device tree binding definition for ARM idle states is the subject of this
> > +document.
> > +
> > +===========================================
> > +2 - idle-states node
> > +===========================================
> > +
> > +ARM processor idle states are defined within the idle-states node, which is
> > +a direct child of the cpus node and provides a container where the processor
> > +idle states, defined as device tree nodes, are listed.
> > +
> > +- idle-states node
> > +
> > +       Usage: Optional - On ARM systems, is a container of processor idle
> > +                         states nodes. If the system does not provide CPU
> > +                         power management capabilities or the processor just
> > +                         supports idle_standby an idle-states node is not
> > +                         required.
> > +
> > +       Description: idle-states node is a container node, where its
> > +                    subnodes describe the CPU idle states.
> > +
> > +       Node name must be "idle-states".
> > +
> > +       The idle-states node's parent node must be the cpus node.
> > +
> > +       The idle-states node's child nodes can be:
> > +
> > +       - one or more state nodes
> > +
> > +       Any other configuration is considered invalid.
> > +
> > +       An idle-states node defines the following properties:
> > +
> > +       - entry-method
> > +               Usage: Required
> > +               Value type: <stringlist>
> > +               Definition: Describes the method by which a CPU enters the
> > +                           idle states. This property is required and must be
> > +                           one of:
> > +
> > +                           - "arm,psci-cpu-suspend"
> > +                             ARM PSCI firmware interface, CPU suspend
> > +                             method[3].
> > +
> > +                           - "[vendor],[method]"
> > +                             An implementation dependent string with
> > +                             format "vendor,method", where vendor is a string
> > +                             denoting the name of the manufacturer and
> > +                             method is a string specifying the mechanism
> > +                             used to enter the idle state.
> > +
> > +The nodes describing the idle states (state) can only be defined within the
> > +idle-states node.
> > +
> > +Any other configuration is consider invalid and therefore must be ignored.
> > +
> > +===========================================
> > +3 - state node
> > +===========================================
> > +
> > +A state node represents an idle state description and must be defined as
> > +follows:
> > +
> > +- state node
> > +
> > +       Description: must be child of either the idle-states node or
> > +                    a state node.
> > +
> > +       The state node name shall follow standard device tree naming
> > +       rules ([6], 2.2.1 "Node names"), in particular state nodes which
> > +       are siblings within a single common parent must be given a unique name.
> > +
> > +       The idle state entered by executing the wfi instruction (idle_standby
> > +       SBSA,[4][5]) is considered standard on all ARM platforms and therefore
> > +       must not be listed.
> > +
> > +       A state node can contain state child nodes. A state node with
> > +       children represents a hierarchical state, which is a superset of
> > +       the child states. Hierarchical states require all CPUs on which
> > +       they are valid (ie cpu nodes [1] containing cpu-idle-states arrays
> > +       having a phandle to the state) to request the state in order for it
> > +       to be entered.
> > +
> > +       A state node defines the following properties:
> > +
> > +       - compatible
> > +               Usage: Required
> > +               Value type: <stringlist>
> > +               Definition: Must be "arm,idle-state".
> > +
> > +       - index
> > +               Usage: Required
> > +               Value type: <u32>
> > +               Definition: It represents the idle state index.
> > +                           An increasing index value implies less power
> > +                           consumption. Index must be given a sequential
> > +                           value = {0, 1, ....}, starting from 0.
> > +                           Phandles in the cpu nodes [1] cpu-idle-states
> > +                           array property are not allowed to point at idle
> > +                           state nodes having the same index value.
> 
> Generally, we don't do indexes in DT. Why is this not just the order
> of states defined in the DT.

Because I need a way to order states in terms of power consumption.

> cpuidle wants to know the power consumption for a state as well as
> latencies. While I'm not for just putting what Linux wants into DT,
> that does seem like a h/w property. How do you plan to handle that?

Linux does not require power consumption for a state anymore. Ordering
is needed (Linux and possibly other OS) that's what index is supposed to do,
increasing indices meaning less power consumption.

Adding a h/w property for power consumption is extremely hard to define
because it depends on loads of parameters and buys us nothing. Ordering
is important, though.

> Maybe it is deemed to not really be useful information. After all, I
> just made shit up for highbank.

That's great to read, maybe we should NAK this patch and made all data
up in the kernel for the upcoming CPU idle drivers.

Or we improve it and get it in the kernel to revert that status quo.

> > +
> > +       - logic-state-retained
> > +               Usage: See definition
> > +               Value type: <none>
> > +               Definition: if present logic is retained on state entry,
> > +                           otherwise it is lost.
> > +
> > +       - cache-state-retained
> > +               Usage: See definition
> > +               Value type: <none>
> > +               Definition: if present cache memory is retained on state entry,
> > +                           otherwise it is lost.
> > +
> > +       - entry-method-param
> > +               Usage: See definition.
> > +               Value type: <u32>
> > +               Definition: Depends on the idle-states node entry-method
> > +                           property value. Refer to the entry-method bindings
> > +                           for this property value definition.
> > +
> > +       - entry-latency
> > +               Usage: Required
> > +               Value type: <prop-encoded-array>
> > +               Definition: u32 value representing worst case latency
> > +                           in microseconds required to enter the idle state.
> 
> Append times with the unit. "-us" in this case.

Ok.

> 
> > +
> > +       - exit-latency
> > +               Usage: Required
> > +               Value type: <prop-encoded-array>
> > +               Definition: u32 value representing worst case latency
> > +                           in microseconds required to exit the idle state.
> 
> ditto
> 
> > +
> > +       - min-residency
> > +               Usage: Required
> > +               Value type: <prop-encoded-array>
> > +               Definition: u32 value representing time in microseconds
> > +                           required for the CPU to be in the idle state to
> > +                           break even in power consumption terms compared
> > +                           to idle state idle_standby ([4][5]).
> 
> ditto
> 
> > +
> > +       - power-domains
> > +               Usage: Optional
> > +               Value type: <prop-encoded-array>
> > +               Definition: List of power domain specifiers ([2]) describing
> > +                           the power domains that are affected by the idle
> > +                           state entry. All devices whose power-domain phandle
> > +                           points at one of the power domains listed in this
> > +                           property are affected by the idle state entry.
> > +
> > +
> > +===========================================
> > +4 - Examples
> > +===========================================
> > +
> > +Example 1 (ARM 64-bit, 16-cpu system):
> > +
> > +pd_clusters: power-domain-clusters@80002000 {
> > +       compatible = "arm,power-controller";
> > +       reg = <0x0 0x80002000 0x0 0x1000>;
> > +       #power-domain-cells = <1>;
> > +       #address-cells = <2>;
> > +       #size-cells = <2>;
> > +
> > +       pd_cores: power-domain-cores@80000000 {
> > +               compatible = "arm,power-controller";
> > +               reg = <0x0 0x80000000 0x0 0x1000>;
> > +               #power-domain-cells = <1>;
> > +       };
> > +};
> > +
> > +cpus {
> > +       #size-cells = <0>;
> > +       #address-cells = <2>;
> > +
> > +       idle-states {
> > +               entry-method = "arm,psci-cpu-suspend";
> > +
> > +               CLUSTER_RET_0: cluster-ret-0 {
> > +                       /* cluster retention */
> > +                       compatible = "arm,idle-state";
> > +                       index = <2>;
> > +                       logic-state-retained;
> > +                       cache-state-retained;
> > +                       entry-method-param = <0x1010000>;
> > +                       entry-latency = <50>;
> > +                       exit-latency = <100>;
> > +                       min-residency = <250>;
> > +                       power-domains = <&pd_clusters 0>;
> > +                       CPU_RET_0_0: cpu-ret-0 {
> 
> As I pointed out, here we have topology definition and it is
> independent of the cpu topology binding.

Early version of the patches used cpu-map here to define on which CPUs
the state is valid. I can remove the cpu-idle-states list of phandles
from the cpu nodes and define a phandle in every idle state pointing at
topology nodes to describe on which CPUs that state is valid.

Is that what you want to see ? BTW, this is the only reason why I have
not posted the generic idle code yet, I want to understand if there is a
dependency on cpu-map parsing code first.

There is another and more important reason: what if the power domain layout
does not follow the topology (a power domain for only two cores in a
cluster of 4) ? Weird, but possible. I am just trying to cater for all
sensible cases from the beginning, and not as an afterthought.

> I'd prefer to see retention spelled out.

Both node name and tag ? That's cumbersome, but I will do it.

> 
> > +                               /* cpu retention */
> 
> then the comment wouldn't be needed.
> 
> > +                               compatible = "arm,idle-state";
> > +                               index = <0>;
> > +                               cache-state-retained;
> > +                               entry-method-param = <0x0010000>;
> > +                               entry-latency = <20>;
> > +                               exit-latency = <40>;
> > +                               min-residency = <30>;
> > +                               power-domains = <&pd_cores 0>,
> > +                                               <&pd_cores 1>,
> > +                                               <&pd_cores 2>,
> > +                                               <&pd_cores 3>,
> > +                                               <&pd_cores 4>,
> > +                                               <&pd_cores 5>,
> > +                                               <&pd_cores 6>,
> > +                                               <&pd_cores 7>;
> 
> I don't like this. The power domain phandle for a core belongs with the core.

The power domains list define all power domains affected by the idle
state entry. In that specific case, it is a core power-gating state valid on
some of the CPUs, and the list defines all power domains affected.
If we have a separate power domain for caches, or CPU peripherals this
allows us to define what "CPU" components are affected by the idle state
entry.

A CPU becomes just another device, attached to a list of power domains.

And in the process, it avoids replicating the same idle state for every
given CPU.

> What if you have groups of 2 cores in 1 domain? It doesn't work and
> that's a very common scenario in current h/w.

You define an idle state, attach it to that domain and the two cores point
at it in their cpu-idle-states phandle list. Or if you prefer, the idle
state points at a node in the cpu-map defining the two cores (but please
see my comment above).

I just need to fix a discrepancy related to the definition of hierarchical
states, whch cpus are affected by what state can be detected by using
power domains phandles in the cpu node.

Thanks for having a look,
Lorenzo
