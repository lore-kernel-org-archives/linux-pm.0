From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v7 2/8] Documentation: arm: define DT idle states bindings
Date: Wed, 13 Aug 2014 23:11:01 +0100
Message-ID: <20140813221101.GA32697@e102568-lin.cambridge.arm.com>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20140813192533.GA32624@ilina-mac.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140813192533.GA32624@ilina-mac.local>
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
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Tomasz Figa <t.figa@samsung.com>, Chander Kashyap <k.chander@samsung.com>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Paul Walmsley <paul@pwsan.com>, Geoff Levand <geoff@infradead.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Amit
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 13, 2014 at 08:25:36PM +0100, Lina Iyer wrote:
> Hi Lorenzo,
> 
> On Wed, Aug 13, 2014 at 04:52:01PM +0100, Lorenzo Pieralisi wrote:
> >+===========================================
> >+4 - Examples
> >+===========================================
> >+
> >+Example 1 (ARM 64-bit, 16-cpu system, PSCI enable-method):
> >+
> >+cpus {
> >+	#size-cells = <0>;
> >+	#address-cells = <2>;
> >+
> >+	CPU0: cpu@0 {
> >+		device_type = "cpu";
> >+		compatible = "arm,cortex-a57";
> >+		reg = <0x0 0x0>;
> >+		enable-method = "psci";
> >+		cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
> >+				   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
> >+	};
> Sorry for jumping in late. I havent gone through all the patches yet or
> followed on previous discussions, if somebody could answer this or point
> me to the discussion, it would be great.
> Why is the cpu defining the possible cluster idle states? Would it be
> better that cluster states form a separate node, something like this -
> 
> 	CLUSTER0: cluster@0 {
> 		...
> 		cpus = <&CPU0 &CPU1 &CPU2 &CPU3>;
> 		cluster-idle-states = <&CLUTER_RETENTION_0, &CLUSTER_SLEEP_0>;
> 		};
> 	};	
> 		
> Allowing for something like this to be defined - 
> 
> 	super_cluster0: cluster@101 {
> 		...
> 		clusters = <&CLUSTER0  &CLUSTER1>;
> 		cluster-idle-states = <&SOC_RETENTION, &SOC_SLEEP>;
> 		};
> 	};
> 
> And each cluster-idle-state follows the general idle definition as
> provided in this document, and an indicator what the compising
> components should idle at, for this idle state to be available.
> 
> 	CLUSTER_SLEEP_0: cluster-sleep@0 {
> 		...
> 		/* sleep definition for cluster0's retention */
> 		min-idle-state = <CPU_SLEEP_0>;
> 	};
> 
> 	SOC_SLEEP: cluster-sleep@101 {
> 		...
> 		min-idle-state = <&CLUSTER_SLEEP_0>;
> 	};
> 		
> 
> Opens up the idle state for a lot of heirarchical possibilities, which
> if you think, is generally how the SoC is. 

We have been thinking for 7 patch versions + some more for this specific
document, which is ready to go after extensive debate.

It is probably better to have a look at archives first since honestly it
is impossible to summarize 6 months worth of discussions in few lines.

I think the hierarchy you mention should be implemented using power
domains, which is how the SoC implements power management and that's
what defines idle states hierarchy.

To be 100% precise, I would like to detect what cpus are affected by an
idle state entry by defining for each idle state what power domain
(which can be hierarchical) is affected, not by grouping them under
a tag "cluster" "supercluster" or whatchamacallit.

I removed power domains to simplify the current proposal which is sufficient
as a starting point, but they are next on my TODO list and were part of the
initial bindings, consider yourself welcome to help us define the way forward
keeping this document as a starting point.

Lorenzo
