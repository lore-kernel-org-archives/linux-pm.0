From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH RFC v3 3/3] Documentation: arm: define DT idle states
 bindings
Date: Wed, 12 Feb 2014 17:31:53 -0800
Message-ID: <20140213013153.18853.21632@capellas-linux>
References: <1392128273-8614-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1392128273-8614-4-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1392128273-8614-4-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Mike Turquette <mturquette@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@linaro.org>, Dave Martin <dave.martin@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Kevin Hilman <khilman@linaro.org>, linux-pm@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, pveerapa@broadcom.com, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>, Mark Brown <broonie@kernel.org>, Santos
List-Id: linux-pm@vger.kernel.org

Quoting Lorenzo Pieralisi (2014-02-11 06:17:53)
> +       - cpu-idle-states
> +               Usage: Optional
> +               Value type: <prop-encoded-array>
> +               Definition:
> +                       # List of phandles to cpu idle state nodes supported
> +                         by this cpu [1].
> +

Should cpu idle be hyphenated in the definition like:
  "List of phandles to cpu-idle state nodes supported"

Is anything implied in the ordering of this list?
Or is this a non-ordered array of phandles?

Would it be a good idea to select a different name for this property vs.
the node?  It seems to get confusing sometimes.


> +According to the Server Base System Architecture document (SBSA, [3]), the
> +power states an ARM CPU can be put into are identified by the following list:
> +
> +1 - Running
> +2 - Idle_standby
> +3 - Idle_retention
> +4 - Sleep
> +5 - Off

Are these states used in the state->index value?
Might it be helpful to number these starting with 0?

> +ARM platforms implement the power states specified in the SBSA through power
> +management schemes that allow an OS PM implementation to put the processor in
> +different idle states (which include states 1 to 4 above; "off" state is not
> +an idle state since it does not have wake-up capabilities, hence it is not
> +considered in this document).

Might an implementation have both sleep and off states where they have
different latencies in the case a cpu can wake itself vs. a coprocessor
waking the cpu?

> +
> +Idle state parameters (eg entry latency) are platform specific and need to be
> +characterized with bindings that provide the required information to OSPM
> +code so that it can build the required tables and use them at runtime.
> +
> +The device tree binding definition for ARM idle states is the subject of this
> +document.

During last connect, we'd discussed that the small set of
states here could apply to a single node, which can represent a cpu, a
cluster with cache etc.  Then the complexities of the system power state
would be represented using a heirarchy, with each node in the
tree having its own state from the list above.  This would allow
a fairly rich system state while having just a few power states defined
at each level.  Is this how you're intending these bindings to go?

> +===========================================
> +2 - state node
> +===========================================

should the section numbering be incremented here?  Or is this a
subsection?  2.1?

Also, would it be nice to have a name field for each state?

> +       A state node can contain state child nodes. A state node with
> +       children represents a hierarchical state, which is a superset of
> +       the child states. Hierarchical states require all CPUs on which
> +       they are valid to request the state in order for it to be entered.

Is it possible for a cpu to request a deeper state and unblock other cpus
from entering this state?

"all CPUs on which they are valid" is this determined by seeing which
state's phandle is in each cpu->cpu-idle-states?

> +
> +       A state node defines the following properties:
...
> +       - index
> +               Usage: Required
> +               Value type: <u32>
> +               Definition: It represents an idle state index, starting from 2.
> +                           Index 0 represents the processor state "running"
> +                           and index 1 represents processor mode
> +                           "idle_standby", entered by executing a wfi
> +                           instruction (SBSA,[3]); indexes 0 and 1 are
> +                           standard ARM states that need not be described.

Do you think maybe something like this might be clearer?

Definition: It represents an idle state index.

	Index 0 and 1 shall not be specified and are reserved for ARM
	states where index 0 is running, and index 1 is idle_standby 
	entered by executing a wfi instruction (SBSA,[3])

What mechanism is used to order the power states WRT power consumption?

> +       - entry-method
> +               Usage: Required
> +               Value type: <stringlist>
> +               Definition: Describes the method by which a CPU enters the
> +                           idle state. This property is required and must be
> +                           one of:
> +
> +                           - "arm,psci-cpu-suspend"
> +                             ARM PSCI firmware interface, CPU suspend
> +                             method[2].

Can psci-cpu-suspend be assumed if entry-method is omitted?

Can this field be used to combine both psci and non-psci states in any order?

> +       - power-state
> +               Usage: See definition.
> +               Value type: <u32>
> +               Definition: Depends on the entry-method property value.
> +                           If entry-method is "arm,psci-cpu-suspend":
> +                               # Property is required and represents
> +                                 psci-power-state parameter. Please refer to
> +                                 [2] for PSCI bindings definition.

Examples use psci-power-state..

If we call this something like entry-method-param rather than power-state,
would this allow the field to be more flexible?  Is flexibility here a goal?

	- power-state
		Usage: See definition.
		Value type: <u32>
		Definition:  Parameter to pass to the entry method when
			this state is being entered.
			If entry-method is "arm,psci-cpu-suspend",
			this parameter represents the psci-power-state
			parameter. Please refer to [2] for PSCI bindings
			definition.

> +       - power-domains
> +               Usage: Optional
> +               Value type: <prop-encoded-array>
> +               Definition: List of power domain specifiers ([1]) describing
> +                           the power domains that are affected by the idle
> +                           state entry.

How do you expect this information should be used?

I assume psci will be turning off the powerdomains not Linux right?
If so, is the structure above helpful for psci to associate the cpu
requesting a state to the specific power domain in the power-domains list?
Or is this all encoded in the parameter to PSCI suspend?  In that case,
what is the utility?

> +       - cache-state-retained
> +               Usage: See definition
> +               Value type: <none>
> +               Definition: if present cache memory is retained on power down,
> +                           otherwise it is lost.
> +
> +       - processor-state-retained
> +               Usage: See definition
> +               Value type: <none>
> +               Definition: if present CPU processor logic is retained on
> +                           power down, otherwise it is lost.

I don't see a good example of these two retained state properties.
Isn't this the purpose of idle_retained state?  In the explanations, is
the term 'power down' the same as sleep or off?

> +
> +cpus {
> +       #size-cells = <0>;
> +       #address-cells = <2>;
> +
> +       cpu-idle-states {
> +
> +               STATE0: state0 {
> +                       compatible = "arm,cpu-idle-state";
> +                       index = <3>;

Are the index fields of nested states independent of each other or
sequential?

ie: 
  -  does index=3 here mean pd_cluster is sleep state, and index=2
     below mean the cpu cluster is idle_retention? (both SBSA states)
  -  Or does index=3 here mean this state is the next cpu-idle state after
     STATE0_1 below, which has index=2?  In this case, are the indexes
     implied to be increasing in order of most power savings?

> +                       entry-method = "arm,psci-cpu-suspend";
> +                       psci-power-state = <0x1010000>;
> +                       entry-latency = <500>;
> +                       exit-latency = <1000>;
> +                       min-residency = <2500>;
> +                       power-domains = <&pd_clusters 0>;
> +                       STATE0_1: state0 {

Should this be STATE0_0?

> +                               compatible = "arm,cpu-idle-state";
> +                               index = <2>;
> +                               entry-method = "arm,psci-cpu-suspend";
> +                               psci-power-state = <0x0010000>;
> +                               entry-latency = <200>;
> +                               exit-latency = <400>;
> +                               min-residency = <300>;
> +                               power-domains = <&pd_cores 0>,
> +                                               <&pd_cores 1>,
                                                  ...
> +                                               <&pd_cores 7>;
> +                       };
> +               };

Would it be possible to add an example illustrating more
complex cluster/cpu power states?  Maybe where both the cpus and
cluster have multiple states (sleep/retention)?

The current example seems to show just the cpu idle_retention state,
and the cluster off state.

Maybe an example of how you'd represent something like this with the new
bindings:

(in increasing order of power saving)
+-----------------+--------------------+-----------------------------------+
|      cpu        |      cluster       |        Notes
+-----------------+--------------------+-----------------------------------+
|    running      |      running       |      not specified running
|  idle_standby   |      running       |      not specified WFI
| idle_retention  |      running       |
| idle_retention  |   idle_retention   |
|     sleep       |   idle_retention   |
|     sleep       |       sleep        |
+-----------------|--------------------+-----------------------------------+

The CPU has 4 states: running, idle standby, idle_retention and sleep.
the first two are not specified per the instructions.

Then the cluster has 3 states: running, retention and sleep.

Maybe a complex case like this would be helpful to understand how the
bindings should be used.

Thanks,

Sebastian
