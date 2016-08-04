From: Brendan Jackman <brendan.jackman@arm.com>
Subject: Re: [PATCH v2 02/14] dt/bindings: update binding for PM domain idle
 states
Date: Thu, 4 Aug 2016 16:24:53 +0100
Message-ID: <20160804152453.GB1732@brendan-thinkstation>
References: <1469829385-11511-1-git-send-email-lina.iyer@linaro.org>
 <1469829385-11511-3-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:51900 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751820AbcHDPZp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 4 Aug 2016 11:25:45 -0400
Content-Disposition: inline
In-Reply-To: <1469829385-11511-3-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>, devicetree@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>, Mark Rutland <mark.rutland@arm.com>

Hi Lina,

These bindings are the reason for my interest in this patchset; I'm hoping to be
able to do some work based on them in order to generically describe the cost of
idle states for use in the Energy Aware Scheduling (EAS)[1] energy model.

Mark Rutland expressed concern [2] in the thread for the previous version of
this patchset that there are now two possible locations for the list of idle
states; that hasn't been addressed. My own instinct is that this is OK: in the
real world, power domain (e.g. cluster) idle states are a property of the power
domain and not of the CPU it contains - the DT should reflect this.

However, since there are existing platform DTs with cluster-level suspend states
(which are platform-coordinated rather than OS-initiated) in cpu-idle-states, do
we have a backwards-compatibility issue? e.g. say we have a platform with a DT
like this:

	cpu@0 {
		/*...*/
		cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
	};

	idle-states {
		CPU_SLEEP: cpu-sleep {
			/*...*/
		};
		CLUSTER_SLEEP: cluster-sleep {
			/*...*/
		};
	};

and in order to enable OS-initiated cluster suspend it changes to this:

	cpu@0 {
		/*...*/
		cpu-idle-states = <&CPU_SLEEP>;
		power-domains = <CPU_PD>;
	};

	idle-states {
		CPU_SLEEP: cpu-sleep {
			/*...*/
		};
	};

	/*... elsewhere ... */

	CLUSTER_SLEEP: cluster-sleep {
		/*...*/
	};

	CPU_PD {
	/*...*/
		idle-states = <&CLUSTER_SLEEP>;
	};

Then old kernels which don't have CPU PM Domains will lose the ability to
suspend clusters. I've phrased this as a question because I'm not clear on what
we require in terms of backwards/forwards compatibility with DTs - excuse my
ignorance. What are your thoughts on this?

A couple of notes:

On Fri, Jul 29, 2016 at 03:56:13PM -0600, Lina Iyer wrote:
> +Example 3:
> +
> +	pm-domains {
> +		a57_pd: a57_pd@ {
> +			/* will have a57 platform ARM_PD_METHOD_OF_DECLARE*/
> +			compatible = "arm,pd","arm,cortex-a57";
> +			#power-domain-cells = <0>;
> +			idle-states = <&CLUSTER_SLEEP_0>;
> +		};
> +
> +		a53_pd: a53_pd@ {
> +			/* will have a a53 platform ARM_PD_METHOD_OF_DECLARE*/
> +			compatible = "arm,pd","arm,cortex-a53";
> +			#power-domain-cells = <0>;
> +			idle-states = <&CLUSTER_SLEEP_0>, <&CLUSTER_SLEEP_1>;
> +		};
> +
> +		CLUSTER_SLEEP_0: idle-state@0 {
> +			compatible = "arm,idle-state";
> +			entry-latency-us = <1000>;
> +			exit-latency-us = <2000>;
> +			residency-us = <10000>;
> +		};
> +
> +		CLUSTER_SLEEP_1: idle-state@1 {
> +			compatible = "arm,idle-state";
> +			entry-latency-us = <5000>;
> +			exit-latency-us = <5000>;
> +			residency-us = <100000>;
> +		};

I'm confused about the location of the idle state nodes. In this example,
they're under the pm-domains node which seems wrong to me. In your later patch
for msm8916.dsti they come under cpu-domain-states. I'm inexperienced here so
please excuse me again if I'm being ignorant.

idle-states.txt (to which this file refers) says that idle state nodes must come
under /cpus/idle-states. I don't think power domain idle states belong there, so
the documentation should be updated to reflect that.

> +	};
> +
> +
>  The nodes above define two power controllers: 'parent' and 'child'.
>  Domains created by the 'child' power controller are subdomains of '0' power
>  domain provided by the 'parent' power controller.

This block refers to Example 2 - the hunk you added should be below.

[1] https://lwn.net/Articles/650426/
[2] https://patchwork.kernel.org/patch/9193651/

Regards,
Brendan
