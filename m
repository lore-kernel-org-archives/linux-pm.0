From: Marc Titinger <mtitinger@baylibre.com>
Subject: [RFC 0/7] Managing cluser-level c-states with generic power domains
Date: Fri, 25 Sep 2015 15:04:02 +0200
Message-ID: <1443186249-14596-1-git-send-email-mtitinger+renesas@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: khilman@kernel.org, rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, ahaslam@baylibre.com, bcousson@baylibre.com, lina.iyer@linaro.org, Marc Titinger <mtitinger+renesas@baylibre.com>
List-Id: linux-pm@vger.kernel.org

-----------------------

Summary

1) DESCRIPTION
2) DEPENDENCIES
3) URL
------------------------


1) DESCRIPTION


	This patch set's underlying idea is that cluster-level c-states can be managed
by the power domain, building upon Lina Iyers recent work on CPU-domain, and Axel Haslam's
genpd multiple states. The power domain may contain CPU devices and non-CPU devices.

Non-CPU Devices may expose latency constraints by registering intermediate power-states upon
probing, for instance shallower states than the deepest cluster-off state. The generic
power domain governor may chose a device retention state in place of the cluster-sleep
state demanded by the menu governor, and call the platform specific handling to enter/leave
that retention state.


power-states
-----------


The proposed way how cluster-level c-states are declared as manageable by the
power domain, rather than through the cpuidle-ops, relies on the introduction of
"power-states", consistent with c-states. Here is an example of the DT bindings,
the c-state CLUSTER_SLEEP_0 is exposed as a power-state in the compatible property:

juno.dts:           idle-states {
                        entry-method = "arm,psci";

                        CPU_SLEEP_0: cpu-sleep-0 {
                                compatible = "arm,idle-state";
                                arm,psci-suspend-param = <0x0010000>;
                                local-timer-stop;
                                entry-latency-us = <100>;
                                exit-latency-us = <250>;
                                min-residency-us = <2000>;
                        };

                        CLUSTER_SLEEP_0: cluster-sleep-0 {
                                compatible = "arm,power-state";
                                arm,psci-suspend-param = <0x1010000>;
                                local-timer-stop;
                                entry-latency-us = <800>;
                                exit-latency-us = <700>;
                                min-residency-us = <2500>;
                        };
		}

This will tell cpuidle runtime_put/get the CPU devices for this c-state. Eventually, the
actual platform handlers may be called from the genpd platform ops (in place of cpuidle_ops).

"drivers/cpuidle/cpuidle-arm.c":

static const struct of_device_id arm_idle_state_match[] __initconst = {
        {.compatible = "arm,idle-state",
         .data = arm_enter_idle_state},
        {.compatible = "arm,power-state",
         .data = arm_enter_power_state},
};


In case of a power-state, arm_enter_power_state will only call pm_runtime_put/get_sync
The power doamin will handle the power off, currently this patch set lacks the final
call to the psci interface to have a fully fonctionnal setup
(and there are some genpd_lock'ing issues if put/get actually suspend the CPU device.)

Ultimately, we would like the Power Domain's simple governor to being able to chose
the cluster power-state based on the c-states defered to it (power-states) and constraints
added by the devices. Consequently, we need to "soak" those power-states into the
power-domain intermediate states from Axel. Since power-states are declared and handled
the same manner than c-states (idle-states in DT), these patches add a soaking used when
attaching to a genpd, where power-states are parsed from the DT into the genpd states:


"drivers/base/power/domain.c":

static const struct of_device_id power_state_match[] = {
        {.compatible = "arm,power-state",
         },
};

int of_genpd_device_parse_states(struct device_node *np,
                                 struct generic_pm_domain *genpd)

debugfs addition
---------------

To easy debug, this patch set adds a seq-file names "states" to the pm_genpd debugfs:

    cat /sys/kernel/debug/pm_genpd/*

      Domain             State name        Enter (ns) / Exit (ns)
    -------------------------------------------------------------
    a53_pd               cluster-sleep-0      1500000 / 800000
    a57_pd               cluster-sleep-0      1500000 / 800000

And also a seq-file "timings", to help visualize the constrains of the non-CPU
devices in a cluster PD.

    Domain Devices, Timings in ns
                       Stop/Start Save/Restore, Effective
----------------------------------------------------  ---
a57_pd
    /cpus/cpu@0          800   /740    1320  /1720  ,0 (cached stop)
    /cpus/cpu@1          800   /740    1420  /1780  ,0 (cached stop)
    /D1                  660   /580    16560 /6080  ,2199420 (cached stop)


Device power-states
-------------------

some devices, like L2 caches, may feature a shallower retention mode, between CPU_SLEEP_0
and CLUSTER_SLEEP_0, in which mode the L2 memory is not powered off, leading to faster
resume than CLUSTER_SLEEP_0.

One way to handle device constrains and retention features in the power-domain, is to
allow devices to register a new power-state (consistent with a c-state).

idle-states:

                        D1_RETENTION: d1-retention {
                                compatible = "arm,power-state";
                                /*leave the psci param, for demo/testing:
                                * the psci cpuidle driver will not currently
                                * understand that a c-state shall not have it's
                                * table entry with a firmware command.
                                * the actual .power_on/off would be registered
                                * by the DECLARE macro for a given domain*/
                                arm,psci-suspend-param = <0x1010000>;
                                local-timer-stop;
                                entry-latency-us = <800>;
                                exit-latency-us = <200>;
                                min-residency-us = <2500>;
                        };


        D1 {
                compatible = "fake,fake-driver";
                name = "D1";
                constraint = <30000>;
                power-domains = <&a53_pd>;
		power-states =<&D1_RETENTION>;
        };


The genpd simple governor can now upon suspend of the last-man CPU chose a shallower
retention state than CLUSTER_SLEEP_0.

In order to achieve this, this patch set added the power-state parsing during the
genpd_dev_pm_attach call. Multiple genpd states are now inserted in a sorted manner
according to their depth: see pm_genpd_insert_state in "drivers/base/power/domain.c".



2) DEPENDENCIES

	This patch set applies over linux-4.2rc5 plus the following ordered dependencies:

 * Ulf Hansson:

6637131 New          [V4] PM / Domains: Remove intermediate states from the power off sequence

 * Lina Iyer's patch series:

6945201 New          [1/9] PM / Domains: Allocate memory outside domain locks
6945221 New          [2/9] PM / Domains: Remove dev->driver check for runtime PM
6945231 New          [3/9] PM / Domains: Support IRQ safe PM domains
6945211 New          [4/9] kernel/cpu_pm: fix cpu_cluster_pm_exit comment
6945251 New          [5/9] ARM: common: Introduce PM domains for CPUs/clusters
6945281 New          [6/9] ARM: domain: Add platform handlers for CPU PM domains
6945261 New          [7/9] ARM: cpuidle: Add runtime PM support for CPU idle
6945241 New          [8/9] ARM64: smp: Add runtime PM support for CPU hotplug
6945271 New          [9/9] ARM: smp: Add runtime PM support for CPU hotplug

 * John Medhurst:

6303671 New          arm64: dts: Add idle-states for Juno

 * Axel Haslam:

7b4eda6 ARM: imx6: pm: declare pm domain latency on power_state struct.
e65789a PM / Domains: make governor select deepest state
8b22b90 PM / Domains: core changes for multiple states
84af098 PM / Domains: prepare for multiple states

2) URL

playable from https://github.com/mtitinger/linux-pm.git

by adding the "fake driver D1" and launching the test-dev-state.sh script.
this will show the power domain suspending to an intermediate state, based on the
device constraints.

    domain                      status pstate     slaves
           /device                                      runtime status
-----------------------------------------------------------------------------------
a53_pd                          on
    /devices/system/cpu/cpu0                            active
    /devices/system/cpu/cpu3                            suspended
    /devices/system/cpu/cpu4                            suspended
    /devices/system/cpu/cpu5                            suspended
a57_pd                          d1-retention
    /devices/system/cpu/cpu1                            suspended
    /devices/system/cpu/cpu2                            suspended
    /devices/platform/D1

----------------------------------------------------------------------

Marc Titinger (7):
  arm64: pm/domains: try mutualize CPU domains init between arm/arm64
  arm64: Juno: declare generic power domains for both clusters.
  PM / Domains: prepare for devices that might register a power state
  PM / Domains: introduce power-states consistent with c-states.
  PM / Domains: succeed & warn when attaching non-irqsafe devices to an
    irq-safe domain.
  arm: cpuidle: let genpd handle the cluster power transition with
    'power-states'
  PM / Domains: add debugfs 'states' and 'timings' seq files

 .../devicetree/bindings/arm/idle-states.txt        |  21 +-
 .../devicetree/bindings/power/power_domain.txt     |  29 ++
 arch/arm/common/domains.c                          |   9 +-
 arch/arm64/Kconfig                                 |   1 +
 arch/arm64/boot/dts/arm/juno.dts                   |  25 +-
 arch/arm64/include/asm/arm-pd.h                    |   1 +
 arch/arm64/kernel/Makefile                         |   6 +
 arch/arm64/kernel/domains.c                        |   1 +
 drivers/base/power/domain.c                        | 418 +++++++++++++++------
 drivers/cpuidle/cpuidle-arm.c                      |  50 ++-
 include/linux/pm_domain.h                          |  21 +-
 11 files changed, 452 insertions(+), 130 deletions(-)
 create mode 120000 arch/arm64/include/asm/arm-pd.h
 create mode 120000 arch/arm64/kernel/domains.c

-- 
1.9.1
