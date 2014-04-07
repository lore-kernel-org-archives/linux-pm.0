From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC v5 3/3] Documentation: arm: define DT idle states
 bindings
Date: Mon, 7 Apr 2014 12:52:53 +0100
Message-ID: <20140407115252.GA25563@e102568-lin.cambridge.arm.com>
References: <1395142132-20788-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1395142132-20788-4-git-send-email-lorenzo.pieralisi@arm.com>
 <20140404155622.GA4061@e102568-lin.cambridge.arm.com>
 <CADHgK6v-t69qLYTcez+m2rE1tRecVsKfgwDdPrNPJOKPbmL-nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CADHgK6v-t69qLYTcez+m2rE1tRecVsKfgwDdPrNPJOKPbmL-nA@mail.gmail.com>
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, Mike Turquette <mturquette@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Dave P Martin <Dave.Martin@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Amit
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 04, 2014 at 11:01:06PM +0100, Sebastian Capella wrote:
> Hi Lorenzo,
> 
> I like this :)
> 
> I was going to suggest linking the tree upside down (starting with the
> leaves such that walking the list takes you back to the root node
> (system sleep), but I don't think it matters as long as the
> relationship is established (which this does).  I tend to think of
> these states in that order, starting from the leaf(shallowest idle
> state) and working back to the root(system sleep) since it provides a
> simple linear view of the sleep states from the cpu perspective, yet
> keeps the heirarchy.

Copied the bindings here for the sake of this discussion.

I think it is more natural to have deeper states pointing at their
subnodes instead of the other way around. When you are in eg
cluster-sleep-0 below you want to check what subnodes the current
state "contains", not the other way around (eg in cluster-sleep-0, by
checking all subnodes we can span the power-domains and check what needs
saving/restoring).

It would be awkward to be forced to check, for every state, all state
nodes pointing at it, the dependency is better defined in the state
itself.

Furthermore, this approch gets closer to what we will do with ACPI,
where state nodes will become ACPI objects returned by AML methods (which
avoids duplication, as phandles do).

Should I go for this approach and leave the ordering to the DT idle state
nodes flat declaration order ? Or we still want to define a property for
that ?

Please, let me know what you think, thanks.

Lorenzo

idle-states {
       entry-method = "arm,psci-cpu-suspend";

	CPU_RETENTION_0: cpu-retention-0 {
		       compatible = "arm,idle-state";
		       cache-state-retained;
		       entry-method-param = <0x0010000>;
		       entry-latency-us = <20>;
		       exit-latency-us = <40>;
		       min-residency-us = <30>;
		       power-domains = <&pd_cores 0>,
				       <&pd_cores 1>,
				       <&pd_cores 2>,
				       <&pd_cores 3>,
	};

	CPU_SLEEP_0: cpu-sleep-0 {
		       /* cpu sleep */
		       compatible = "arm,idle-state";
		       entry-method-param = <0x0010000>;
		       entry-latency-us = <250>;
		       exit-latency-us = <500>;
		       min-residency-us = <350>;
		       power-domains = <&pd_cores 0>,
				       <&pd_cores 1>,
				       <&pd_cores 2>,
				       <&pd_cores 3>,
	};

	CPU_SLEEP_1: cpu-sleep-1 {
		       /* cpu sleep */
		       compatible = "arm,idle-state";
		       entry-method-param = <0x0010000>;
		       entry-latency-us = <250>;
		       exit-latency-us = <500>;
		       min-residency-us = <350>;
				       <&pd_cores 4>,
				       <&pd_cores 5>,
				       <&pd_cores 6>,
				       <&pd_cores 7>;
	};

	CLUSTER_RETENTION_0: cluster-retention-0 {
	       compatible = "arm,idle-state";
	       logic-state-retained;
	       cache-state-retained;
	       entry-method-param = <0x1010000>;
	       entry-latency-us = <50>;
	       exit-latency-us = <800>;
	       min-residency-us = <2400>;
	       power-domains = <&pd_clusters 0>;
	       substates = <&CPU_SLEEP_0>;
	};

	CLUSTER_SLEEP_0: cluster-sleep-0 {
	       compatible = "arm,idle-state";
	       entry-method-param = <0x1010000>;
	       entry-latency-us = <600>;
	       exit-latency-us = <1100>;
	       min-residency-us = <2700>;
	       power-domains = <&pd_clusters 0>;
	       substates = <&CPU_SLEEP_0>;
	};

	CLUSTER_SLEEP_1: cluster-sleep-1 {
	       compatible = "arm,idle-state";
	       entry-method-param = <0x1010000>;
	       entry-latency-us = <600>;
	       exit-latency-us = <1100>;
	       min-residency-us = <2700>;
	       power-domains = <&pd_clusters 1>;
	       substates = <&CPU_SLEEP_1>;
	};

	SYSTEM_SLEEP_0: system-sleep-0 {
	       compatible = "arm,idle-state";
	       entry-method-param = <0x2010000>;
	       entry-latency-us = <6000>;
	       exit-latency-us = <10000>;
	       min-residency-us = <30000>;
	       power-domains = <&pd_system 0>;
	       substates = <&CLUSTER_SLEEP_0>, <&CLUSTER_SLEEP_1>;
	};
};
