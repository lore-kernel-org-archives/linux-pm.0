From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [RFC v2 0/6] Managing cluser-level c-states with generic power domains
Date: Tue, 13 Oct 2015 16:10:12 -0700
Message-ID: <7hr3kyz7or.fsf@deeprootsystems.com>
References: <20151006022702.GA78570@linaro.org>
	<1444141665-18534-1-git-send-email-mtitinger+renesas@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34441 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033AbbJMXKP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2015 19:10:15 -0400
Received: by pabws5 with SMTP id ws5so3330575pab.1
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2015 16:10:14 -0700 (PDT)
In-Reply-To: <1444141665-18534-1-git-send-email-mtitinger+renesas@baylibre.com>
	(Marc Titinger's message of "Tue, 6 Oct 2015 16:27:39 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marc Titinger <mtitinger@baylibre.com>
Cc: rjw@rjwysocki.net, lina.iyer@linaro.org, ahaslam@baylibre.com, bcousson@baylibre.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Marc Titinger <mtitinger+renesas@baylibre.com>

Hi Marc,

Sorry for the lag in reviewing this.  I've been on the road for a couple
weeks of conference related travel.  I did have a look through this on
the plane, but didn't have time to reply until now, and then had to
rework my thoughts a bit since Lina already said some of the things I
was thinking.   Anyways, some overall thoughts below...

Marc Titinger <mtitinger@baylibre.com> writes:

> v2: 
>  - rebase on Lina Iyer's latest series
>  - remove unnecessary dependency on perf-state patches from Axel Haslam
>
> -----------------------
>
> Summary
>
> 1) DESCRIPTION
> 2) DEPENDENCIES
> 3) URL
> ------------------------
>
>
> 1) DESCRIPTION
>
>
> 	This patch set's underlying idea is that cluster-level c-states can be managed

nit: can we drop the use of C-states throughout and just refer to idle
states.  C-states is technically an ACPI specific term.

> by the power domain, building upon Lina Iyers recent work on CPU-domain, and Axel Haslam's
> genpd multiple states. The power domain may contain CPU devices and non-CPU devices.

@Axel: any plans to repost your series now that we have a little more
momentum here?

> Non-CPU Devices may expose latency constraints by registering intermediate power-states upon
> probing, for instance shallower states than the deepest cluster-off state. The generic
> power domain governor may chose a device retention state in place of the cluster-sleep
> state demanded by the menu governor, and call the platform specific handling to enter/leave
> that retention state.
>
>
> power-states
> -----------
>
>
> The proposed way how cluster-level c-states are declared as manageable by the
> power domain, rather than through the cpuidle-ops, relies on the introduction of
> "power-states", consistent with c-states. Here is an example of the DT bindings,
> the c-state CLUSTER_SLEEP_0 is exposed as a power-state in the compatible property:
>
> juno.dts:           idle-states {
>                         entry-method = "arm,psci";
>
>                         CPU_SLEEP_0: cpu-sleep-0 {
>                                 compatible = "arm,idle-state";
>                                 arm,psci-suspend-param = <0x0010000>;
>                                 local-timer-stop;
>                                 entry-latency-us = <100>;
>                                 exit-latency-us = <250>;
>                                 min-residency-us = <2000>;
>                         };
>
>                         CLUSTER_SLEEP_0: cluster-sleep-0 {
>                                 compatible = "arm,power-state";
>                                 arm,psci-suspend-param = <0x1010000>;
>                                 local-timer-stop;
>                                 entry-latency-us = <800>;
>                                 exit-latency-us = <700>;
>                                 min-residency-us = <2500>;
>                         };
> 		}
>
> This will tell cpuidle runtime_put/get the CPU devices for this c-state. Eventually, the
> actual platform handlers may be called from the genpd platform ops (in place of cpuidle_ops).
>
> "drivers/cpuidle/cpuidle-arm.c":
>
> static const struct of_device_id arm_idle_state_match[] __initconst = {
>         {.compatible = "arm,idle-state",
>          .data = arm_enter_idle_state},
>         {.compatible = "arm,power-state",
>          .data = arm_enter_power_state},
> };
>
>
> In case of a power-state, arm_enter_power_state will only call pm_runtime_put/get_sync
> The power doamin will handle the power off, 

I'm not crazy about this part of the design.  Essentially it delegates
the cluster level decision making to the CPUidle driver.  IMO, all of
the decision making should be at the domain level.

> currently this patch set lacks the final
> call to the psci interface to have a fully fonctionnal setup
> (and there are some genpd_lock'ing issues if put/get actually suspend the CPU device.)

> Ultimately, we would like the Power Domain's simple governor to being able to chose
> the cluster power-state based on the c-states defered to it (power-states) and constraints
> added by the devices. Consequently, we need to "soak" those power-states into the
> power-domain intermediate states from Axel. Since power-states are declared and handled
> the same manner than c-states (idle-states in DT), these patches add a soaking used when
> attaching to a genpd, where power-states are parsed from the DT into the genpd states:
>
>
> "drivers/base/power/domain.c":
>
> static const struct of_device_id power_state_match[] = {
>         {.compatible = "arm,power-state",
>          },
> };
>
> int of_genpd_device_parse_states(struct device_node *np,
>                                  struct generic_pm_domain *genpd)

This approach results in some strange (IMO) sharing of the
responsibility, as can be seen because both the genpd and the cpuidle
driver end up parsing the new arm,power-state states.

IMO, the CPUidle driver should not have to be aware of what cluster
states are availble, nor what other devices may or may not be in the
same domain as a given CPU.

Maybe another way to differentiate between CPU idle states and cluster
idle states is to associate them with a power-domain node in the DT
(instead of a CPU node as is done currently.)  Then there would also not
be a need for another compatible string.  As Lina pointed out, your
arm,power-state has identical properties to an arm,idle-state so doesn't
really justify a new compatible.

> debugfs addition
> ---------------
>
> To easy debug, this patch set adds a seq-file names "states" to the pm_genpd debugfs:
>
>     cat /sys/kernel/debug/pm_genpd/*
>
>       Domain             State name        Enter (ns) / Exit (ns)
>     -------------------------------------------------------------
>     a53_pd               cluster-sleep-0      1500000 / 800000
>     a57_pd               cluster-sleep-0      1500000 / 800000

I guess this should probably be part of Axel's "multiple state" series.

> And also a seq-file "timings", to help visualize the constrains of the non-CPU
> devices in a cluster PD.
>
>     Domain Devices, Timings in ns
>                        Stop/Start Save/Restore, Effective
> ----------------------------------------------------  ---
> a57_pd
>     /cpus/cpu@0          800   /740    1320  /1720  ,0 (cached stop)
>     /cpus/cpu@1          800   /740    1420  /1780  ,0 (cached stop)
>     /D1                  660   /580    16560 /6080  ,2199420 (cached stop)

Nice!

> Device power-states
> -------------------
>
> some devices, like L2 caches, may feature a shallower retention mode, between CPU_SLEEP_0
> and CLUSTER_SLEEP_0, in which mode the L2 memory is not powered off, leading to faster
> resume than CLUSTER_SLEEP_0.
>
> One way to handle device constrains and retention features in the power-domain, is to
> allow devices to register a new power-state (consistent with a c-state).

The problem with this is that the power-state is not technically a
property of the device.  It's a property of the power domain.

> idle-states:
>
>                         D1_RETENTION: d1-retention {
>                                 compatible = "arm,power-state";
>                                 /*leave the psci param, for demo/testing:
>                                 * the psci cpuidle driver will not currently
>                                 * understand that a c-state shall not have it's
>                                 * table entry with a firmware command.
>                                 * the actual .power_on/off would be registered
>                                 * by the DECLARE macro for a given domain*/
>                                 arm,psci-suspend-param = <0x1010000>;
>                                 local-timer-stop;
>                                 entry-latency-us = <800>;
>                                 exit-latency-us = <200>;
>                                 min-residency-us = <2500>;
>                         };
>
>
>         D1 {
>                 compatible = "fake,fake-driver";
>                 name = "D1";
>                 constraint = <30000>;
>                 power-domains = <&a53_pd>;
> 		power-states =<&D1_RETENTION>;
>         };
>
>
> The genpd simple governor can now upon suspend of the last-man CPU chose a shallower
> retention state than CLUSTER_SLEEP_0.
>
> In order to achieve this, this patch set added the power-state parsing during the
> genpd_dev_pm_attach call. Multiple genpd states are now inserted in a sorted manner
> according to their depth: see pm_genpd_insert_state in "drivers/base/power/domain.c".

As mentioned elsewhere, I think the ability to dynamically add (and
presumably remove) genpd states is a bit overkill right now.  I think
the list of power states should be statically defined along with the
power-domain itself, and then it should simply rely on the runtime PM
usage of all the devices in the domain (as well as the genpd governors)
to select the right state.

Kevin
