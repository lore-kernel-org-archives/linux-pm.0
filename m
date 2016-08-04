From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v2 02/14] dt/bindings: update binding for PM domain idle
 states
Date: Thu, 4 Aug 2016 10:28:44 -0600
Message-ID: <20160804162844.GC1207@linaro.org>
References: <1469829385-11511-1-git-send-email-lina.iyer@linaro.org>
 <1469829385-11511-3-git-send-email-lina.iyer@linaro.org>
 <20160804152453.GB1732@brendan-thinkstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160804152453.GB1732@brendan-thinkstation>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Brendan Jackman <brendan.jackman@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, ulf.hansson@linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, khilman@kernel.org, rjw@rjwysocki.net, Axel Haslam <ahaslam+renesas@baylibre.com>, Marc Titinger <mtitinger+renesas@baylibre.com>, linux-arm-msm@vger.kernel.org, andy.gross@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Brenden,

On Thu, Aug 04 2016 at 09:24 -0600, Brendan Jackman wrote:
>Hi Lina,
>
>These bindings are the reason for my interest in this patchset; I'm hoping to be
>able to do some work based on them in order to generically describe the cost of
>idle states for use in the Energy Aware Scheduling (EAS)[1] energy model.
>
I think that's a fair idea - idle states accounting their own cost.

>Mark Rutland expressed concern [2] in the thread for the previous version of
>this patchset that there are now two possible locations for the list of idle
>states; that hasn't been addressed. My own instinct is that this is OK: in the
>real world, power domain (e.g. cluster) idle states are a property of the power
>domain and not of the CPU it contains - the DT should reflect this.
>
Absolutely.

>However, since there are existing platform DTs with cluster-level suspend states
>(which are platform-coordinated rather than OS-initiated) in cpu-idle-states, do
>we have a backwards-compatibility issue? e.g. say we have a platform with a DT
>like this:
>
Your concern is very valid and this is the exactly the difference
between Platform coordinated (PC) mode and OS-Initiated (OSI) mode. In
PC, the domain state is an extension of the CPU state and rightful place
for that is the cpu-idle-states property. Just like the example you
have.

>	cpu@0 {
>		/*...*/
>		cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
>	};
>
>	idle-states {
>		CPU_SLEEP: cpu-sleep {
>			/*...*/
>		};
>		CLUSTER_SLEEP: cluster-sleep {
>			/*...*/
>		};
>	};
>
>and in order to enable OS-initiated cluster suspend it changes to this:
>
Platforms that have OSI will have this format you mention below. If the
platform supports the OSI it will respond to the PSCI_FEATURES and
PSCI_SET_SUSPEND mode (patch 10 of this series). If the OSI mode is
available snd if the DT has the domains defined for the CPU, then the
OSI mode is chosen otherwise, it reverts to using PC mode. This code
snippet from my patches does exactly that -

if (psci_has_osi_pd) {
        int ret;
        const struct cpu_pd_ops psci_pd_ops = {
                .populate_state_data = psci_pd_populate_state_data,
                .power_off = psci_pd_power_off,
        };

        ret = of_setup_cpu_pd_single(cpu, &psci_pd_ops);
        if (!ret)
                ret = psci_set_suspend_mode_osi(true);
        if (ret)
                pr_warn("CPU%d: Error setting PSCI OSI mode\n", cpu);
}

>	cpu@0 {
>		/*...*/
>		cpu-idle-states = <&CPU_SLEEP>;
>		power-domains = <CPU_PD>;
>	};
>
>	idle-states {
>		CPU_SLEEP: cpu-sleep {
>			/*...*/
>		};
>	};
>
>	/*... elsewhere ... */
>
>	CLUSTER_SLEEP: cluster-sleep {
>		/*...*/
>	};
>
>	CPU_PD {
>	/*...*/
>		idle-states = <&CLUSTER_SLEEP>;
>	};
>
>Then old kernels which don't have CPU PM Domains will lose the ability to
>suspend clusters. I've phrased this as a question because I'm not clear on what
>we require in terms of backwards/forwards compatibility with DTs - excuse my
>ignorance. What are your thoughts on this?
>
So, if the DT has only support for cluster modes in cpu-idle-states and
not the OSI specific representation, then it would continue to use only
PC mode to power down the cluster, even though the firmware may have
been updated to support OSI.

That means, all the existing platforms will continue to work the way
they do even with these patches in place.

Moreover, the way the PSCI state ids are for PC and OS intiated fall in
line with how we represent in the DT. PC cluster states are represented
in the original format and the OSI follow the extended state format. The
composite is made by an OR of the CPU state and the cluster idle state.

>A couple of notes:
>
>On Fri, Jul 29, 2016 at 03:56:13PM -0600, Lina Iyer wrote:
>> +Example 3:
>> +
>> +	pm-domains {
>> +		a57_pd: a57_pd@ {
>> +			/* will have a57 platform ARM_PD_METHOD_OF_DECLARE*/
>> +			compatible = "arm,pd","arm,cortex-a57";
>> +			#power-domain-cells = <0>;
>> +			idle-states = <&CLUSTER_SLEEP_0>;
>> +		};
>> +
>> +		a53_pd: a53_pd@ {
>> +			/* will have a a53 platform ARM_PD_METHOD_OF_DECLARE*/
>> +			compatible = "arm,pd","arm,cortex-a53";
>> +			#power-domain-cells = <0>;
>> +			idle-states = <&CLUSTER_SLEEP_0>, <&CLUSTER_SLEEP_1>;
>> +		};
>> +
>> +		CLUSTER_SLEEP_0: idle-state@0 {
>> +			compatible = "arm,idle-state";
>> +			entry-latency-us = <1000>;
>> +			exit-latency-us = <2000>;
>> +			residency-us = <10000>;
>> +		};
>> +
>> +		CLUSTER_SLEEP_1: idle-state@1 {
>> +			compatible = "arm,idle-state";
>> +			entry-latency-us = <5000>;
>> +			exit-latency-us = <5000>;
>> +			residency-us = <100000>;
>> +		};
>
>I'm confused about the location of the idle state nodes. In this example,
>they're under the pm-domains node which seems wrong to me. In your later patch
>for msm8916.dsti they come under cpu-domain-states. I'm inexperienced here so
>please excuse me again if I'm being ignorant.
>
Valid question. These patches are intended to support CPU domains that
are controlled by Linux (ARM v7 style) and the PSCI way as well. The
example here is for a ARM v7 style domain where the domain controller
code exists in Linux.

The way my patches evolve the kernel is build up a generic CPU PM
domains framework and then PSCI firmware becomes a driver for platforms
that support OSI and the DT has domain definitions.

Your confusion should be resolved, if you look at the broader scope of
the CPU domain - domains that may be controlled in Linux and domains
outside Linux.

>idle-states.txt (to which this file refers) says that idle state nodes must come
>under /cpus/idle-states. I don't think power domain idle states belong there, so
>the documentation should be updated to reflect that.
>
Absolutely right. This should be fixed.

>> +	};
>> +
>> +
>>  The nodes above define two power controllers: 'parent' and 'child'.
>>  Domains created by the 'child' power controller are subdomains of '0' power
>>  domain provided by the 'parent' power controller.
>
>This block refers to Example 2 - the hunk you added should be below.
>
OK. Thanks.

-- Lina

>[1] https://lwn.net/Articles/650426/
>[2] https://patchwork.kernel.org/patch/9193651/
>
>Regards,
>Brendan
