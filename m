From: Brendan Jackman <brendan.jackman@arm.com>
Subject: Re: [PATCH v2 02/14] dt/bindings: update binding for PM domain idle
 states
Date: Thu, 4 Aug 2016 19:15:00 +0100
Message-ID: <20160804181500.GE1732@brendan-thinkstation>
References: <1469829385-11511-1-git-send-email-lina.iyer@linaro.org>
 <1469829385-11511-3-git-send-email-lina.iyer@linaro.org>
 <20160804152453.GB1732@brendan-thinkstation>
 <20160804162844.GC1207@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160804162844.GC1207@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, Axel Haslam <ahaslam+renesas@baylibre.com>, devicetree@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 04, 2016 at 10:28:44AM -0600, Lina Iyer wrote:
> Hi Brenden,
>
> On Thu, Aug 04 2016 at 09:24 -0600, Brendan Jackman wrote:
> >Hi Lina,
> >
> >These bindings are the reason for my interest in this patchset; I'm hoping to be
> >able to do some work based on them in order to generically describe the cost of
> >idle states for use in the Energy Aware Scheduling (EAS)[1] energy model.
> >
> I think that's a fair idea - idle states accounting their own cost.
>
> >Mark Rutland expressed concern [2] in the thread for the previous version of
> >this patchset that there are now two possible locations for the list of idle
> >states; that hasn't been addressed. My own instinct is that this is OK: in the
> >real world, power domain (e.g. cluster) idle states are a property of the power
> >domain and not of the CPU it contains - the DT should reflect this.
> >
> Absolutely.
>
> >However, since there are existing platform DTs with cluster-level suspend states
> >(which are platform-coordinated rather than OS-initiated) in cpu-idle-states, do
> >we have a backwards-compatibility issue? e.g. say we have a platform with a DT
> >like this:
> >
> Your concern is very valid and this is the exactly the difference
> between Platform coordinated (PC) mode and OS-Initiated (OSI) mode. In
> PC, the domain state is an extension of the CPU state and rightful place
> for that is the cpu-idle-states property. Just like the example you
> have.
>
> >	cpu@0 {
> >		/*...*/
> >		cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> >	};
> >
> >	idle-states {
> >		CPU_SLEEP: cpu-sleep {
> >			/*...*/
> >		};
> >		CLUSTER_SLEEP: cluster-sleep {
> >			/*...*/
> >		};
> >	};
> >
> >and in order to enable OS-initiated cluster suspend it changes to this:
> >
> Platforms that have OSI will have this format you mention below. If the
> platform supports the OSI it will respond to the PSCI_FEATURES and
> PSCI_SET_SUSPEND mode (patch 10 of this series). If the OSI mode is
> available snd if the DT has the domains defined for the CPU, then the
> OSI mode is chosen otherwise, it reverts to using PC mode. This code
> snippet from my patches does exactly that -
>
> if (psci_has_osi_pd) {
>        int ret;
>        const struct cpu_pd_ops psci_pd_ops = {
>                .populate_state_data = psci_pd_populate_state_data,
>                .power_off = psci_pd_power_off,
>        };
>
>        ret = of_setup_cpu_pd_single(cpu, &psci_pd_ops);
>        if (!ret)
>                ret = psci_set_suspend_mode_osi(true);
>        if (ret)
>                pr_warn("CPU%d: Error setting PSCI OSI mode\n", cpu);
> }
>
> >	cpu@0 {
> >		/*...*/
> >		cpu-idle-states = <&CPU_SLEEP>;
> >		power-domains = <CPU_PD>;
> >	};
> >
> >	idle-states {
> >		CPU_SLEEP: cpu-sleep {
> >			/*...*/
> >		};
> >	};
> >
> >	/*... elsewhere ... */
> >
> >	CLUSTER_SLEEP: cluster-sleep {
> >		/*...*/
> >	};
> >
> >	CPU_PD {
> >	/*...*/
> >		idle-states = <&CLUSTER_SLEEP>;
> >	};
> >
> >Then old kernels which don't have CPU PM Domains will lose the ability to
> >suspend clusters. I've phrased this as a question because I'm not clear on what
> >we require in terms of backwards/forwards compatibility with DTs - excuse my
> >ignorance. What are your thoughts on this?
> >
> So, if the DT has only support for cluster modes in cpu-idle-states and
> not the OSI specific representation, then it would continue to use only
> PC mode to power down the cluster, even though the firmware may have
> been updated to support OSI.
>
> That means, all the existing platforms will continue to work the way
> they do even with these patches in place.
>
> Moreover, the way the PSCI state ids are for PC and OS intiated fall in
> line with how we represent in the DT. PC cluster states are represented
> in the original format and the OSI follow the extended state format. The
> composite is made by an OR of the CPU state and the cluster idle state.
>

OK, this makes sense - I understand that these patches will not affect the
behaviour if the DT stays the same. My question, though is what happens when a
new DT with the new OSI structure is given to an older kernel without these
patches applied.

Example: right now we support PC cluster suspend on the Juno platform (see
juno*.dts). Let's say Juno's firmware comes to support OSI suspend and we want
to use that in Linux. We apply these patches then update the .dts, adding a CPU
power domain tree, removing CLUSTER_SLEEP_0 from cpu-idle-states and adding it
to the relevant power domain node's idle-states. Now we have OSI suspend on
Juno. But then if we take our new DTB and feed it to a v4.7 kernel it will not
be able to enter CLUSTER_SLEEP_0 because it is not in cpu-idle-states. Before we
modified the DTB, v4.7 kernels were capable of entering CLUSTER_SLEEP_0 in PC
mode.

Does that make sense - do we expect newer DTBs to be compatible with older
kernels, and if so how can we add OSI support to existing platforms without
breaking older kernels?

Thanks,
Brendan
