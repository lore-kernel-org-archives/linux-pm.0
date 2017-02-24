From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 0/7] PM / Domains: Implement domain performance states
Date: Fri, 24 Feb 2017 14:36:32 +0530
Message-ID: <cover.1487926924.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, Vincent Guittot <vincent.guittot@linaro.org>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This series contain V3 of both the bindings and the code that implement
them. They were sent separately earlier.

Some platforms have the capability to configure the performance state of
their power domains. The process of configuring the performance state is
pretty much platform dependent and we may need to work with a wide range
of configurables.  For some platforms, like Qcom, it can be a positive
integer value alone, while in other cases it can be voltage levels, etc.

The power-domain framework until now was only designed for the idle
state management of the device and this needs to change in order to
reuse the power-domain framework for active state management of the
devices.

The first 2 patches update the DT bindings of the power-domains and OPP
tables. And the other 5 patches implement the details in QoS, genpd and
OPP frameworks.

This is tested currently by hacking the kernel a bit with virtual
power-domains for the dual A15 exynos platform. The earlier version of
patches was also tested by Rajendra Nayak (Qcom) on *real* Qualcomm
hardware for which this work is getting done. And so this version should
work as well.

Here is sample DT and C code we need to write for platforms:

DT:
---

        foo: foo-power-domain@08000000 {
                compatible = "foo,genpd";
                #power-domain-cells = <0>;

                performance-states {
                        compatible = "domain-performance-state";
                        pstate@1 {
                                reg = <1>;
                                domain-microvolt = <970000 975000 985000>;
                        };
                        pstate@2 {
                                reg = <2>;
                                domain-microvolt = <1000000 1075000 1085000>;
                        };
                };
        };

        cpu0_opp_table: opp_table0 {
                compatible = "operating-points-v2";
                opp-shared;

                opp00 {
                        opp-hz = /bits/ 64 <1700000000>;
                        clock-latency-ns = <30>;
                        domain-performance-state = <2>;
                        opp-suspend;
                };
                opp01 {
                        opp-hz = /bits/ 64 <1600000000>;
                        clock-latency-ns = <300>;
                        domain-performance-state = <1>;
                };
        }

Driver code:
------------

static int pd_performance(struct generic_pm_domain *domain, unsigned int state)
{
       int i = state - 1;

       pr_info("%d: %d: %u: %u: %u\n", state,
	       states[i].performance_state, states[i].u_volt,
	       states[i].u_volt_min, states[i].u_volt_max);
       return 0;
}

static const struct of_device_id pm_domain_of_match[] __initconst = {
       { .compatible = "foo,genpd", },
       { },
};

static int __init genpd_test_init(void)
{
       struct device *dev = get_cpu_device(0);
       struct device_node *np;
       const struct of_device_id *match;
       int n;
       int ret;

       for_each_matching_node_and_match(np, pm_domain_of_match, &match) {
               pd.name = kstrdup_const(strrchr(np->full_name, '/') + 1,
                               GFP_KERNEL);
               if (!pd.name) {
                       of_node_put(np);
                       return -ENOMEM;
               }

               pd.set_performance_state = pd_performance;

               pm_genpd_init(&pd, NULL, false);
               of_genpd_parse_performance_states(np, &states, &n);
               of_genpd_add_provider_simple(np, &pd);
       }

       ret = dev_pm_domain_attach(dev, false);

       return ret;
}


V2->V3:
- Based over latest pm/linux-next
- Bindings and code are merged together
- Lots of updates in bindings
  - the performance-states node is present within the power-domain now,
    instead of its phandle.
  - performance-level property is replaced by "reg".
  - domain-performance-state property of the consumers contain an
    integer value now instead of phandle.
- Lots of updates to the code as well
  - Patch "PM / QOS: Add default case to the switch" is merged with
    other patches and the code is changed a bit as well.
  - Don't pass 'type' to dev_pm_qos_add_notifier(), rather handle all
    notifiers with a single list. A new patch is added for that.
  - The OPP framework patch can be applied now and has proper SoB from
    me.
  - Dropped "PM / domain: Save/restore performance state at runtime
    suspend/resume".
  - Drop all WARN().
  - Tested-by Rajendra nayak.

V1->V2:
- Based over latest pm/linux-next
- It is mostly a resend of what is sent earlier as this series hasn't
  got any reviews so far and Rafael suggested that its better I resend
  it.
- Only the 4/6 patch got an update, which was shared earlier as reply to
  V1 as well. It has got several fixes for taking care of power domain
  hierarchy, etc.

--
viresh

Viresh Kumar (7):
  PM / Domains: Introduce "performance-states" binding
  PM / OPP: Introduce "domain-performance-state" binding to OPP nodes
  PM / QOS: Keep common notifier list for genpd constraints
  PM / QOS: Add DEV_PM_QOS_PERFORMANCE request
  PM / domain: Register for PM QOS performance notifier
  PM / Domains: Allow domain performance states to be read from DT
  PM / OPP: Add support to parse domain-performance-state

 Documentation/devicetree/bindings/opp/opp.txt      |  64 +++++++
 .../devicetree/bindings/power/power_domain.txt     |  67 +++++++
 Documentation/power/pm_qos_interface.txt           |   2 +-
 drivers/base/power/domain.c                        | 204 ++++++++++++++++++++-
 drivers/base/power/opp/core.c                      |  73 ++++++++
 drivers/base/power/opp/debugfs.c                   |   4 +
 drivers/base/power/opp/of.c                        |  37 ++++
 drivers/base/power/opp/opp.h                       |  12 ++
 drivers/base/power/qos.c                           |  36 ++--
 include/linux/pm_domain.h                          |  19 ++
 include/linux/pm_qos.h                             |  17 ++
 kernel/power/qos.c                                 |   2 +-
 12 files changed, 517 insertions(+), 20 deletions(-)

-- 
2.7.1.410.g6faf27b
