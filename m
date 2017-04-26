From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V6 0/9] PM / Domains: Implement domain performance states
Date: Wed, 26 Apr 2017 16:27:04 +0530
Message-ID: <cover.1493203884.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f42.google.com ([74.125.83.42]:34976 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2998834AbdDZK5Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Apr 2017 06:57:24 -0400
Received: by mail-pg0-f42.google.com with SMTP id 72so42842302pge.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Apr 2017 03:57:24 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, sudeep.holla@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

Hi,

Here is the 6th version of the series, which incorporates feedback from
Kevin and Sudeep:

- Use freq/voltage in OPP table as it is for power domain and don't
  create "domain-performance-level" property
- Take care of domain providers that provide multiple domains


Here is a brief summary of the problem I am trying to solve.

Some platforms have the capability to configure the performance state of
their power domains. The process of configuring the performance state is
pretty much platform dependent and we may need to work with a wide range
of configurables.  For some platforms, like Qcom, it can be a positive
integer value alone, while in other cases it can be voltage levels, etc.

The power-domain framework until now was only designed for the idle
state management of the device and this needs to change in order to
reuse the power-domain framework for active state management of the
devices.

This series adapts the genpd and OPP frameworks to allow OPP tables to
be used for the genpd devices as well.

The first 2 patches update the DT bindings of the power-domains and OPP
tables. And the other 7 patches implement the details in QoS, genpd and
OPP frameworks.

This is tested currently by hacking the kernel a bit with virtual
power-domains for the dual A15 exynos platform. The earlier version of
patches was also tested by Rajendra Nayak (Qcom) on *real* Qualcomm
hardware for which this work is getting done. Hope this version should
work as well.

Here is sample DT and C code we need to write for platforms:

DT:
---

/ {
        domain_opp_table: opp_table0 {
                compatible = "operating-points-v2";

		domain_opp_1: opp-1 {
			opp-hz = /bits/ 64 <1>;
			opp-microvolt = <975000 970000 985000>;
		};
		domain_opp_2: opp-2 {
			opp-hz = /bits/ 64 <2>;
			opp-microvolt = <1075000 1000000 1085000>;
		};
        };
 
        foo_domain: power-controller@12340000 {
                compatible = "foo,power-controller";
                reg = <0x12340000 0x1000>;
                #power-domain-cells = <0>;
                operating-points-v2 = <&domain_opp_table>;
        }

        cpu0_opp_table: opp_table1 {
                compatible = "operating-points-v2";
                opp-shared;

                opp-1000000000 {
                        opp-hz = /bits/ 64 <1000000000>;
			power-domain-opp = <&domain_opp_1>;
                };
                opp-1100000000 {
                        opp-hz = /bits/ 64 <1100000000>;
			power-domain-opp = <&domain_opp_2>;
                };
                opp-1200000000 {
                        opp-hz = /bits/ 64 <1200000000>;
			power-domain-opp = <&domain_opp_2>;
                };
        };

        cpus {
                #address-cells = <1>;
                #size-cells = <0>;

                cpu@0 {
                        compatible = "arm,cortex-a9";
                        reg = <0>;
                        clocks = <&clk_controller 0>;
                        clock-names = "cpu";
                        operating-points-v2 = <&cpu0_opp_table>;
                        power-domains = <&foo_domain>;
                };
        };
};

Driver code:
------------

static int pd_performance(struct generic_pm_domain *domain, unsigned int state)
{
        struct dev_pm_opp *opp;

        opp = dev_pm_opp_find_freq_exact(&domain->dev, state, true);

        /* Use OPP and state in platform specific way */

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
               of_genpd_add_provider_simple(np, &pd);
       }

       ret = dev_pm_domain_attach(dev, false);

       return ret;
}

Pushed here as well:

https://git.linaro.org/people/viresh.kumar/linux.git/log/?h=opp/genpd-performance-state

V5->V6:
- Use freq/voltage in OPP table as it is for power domain and don't
  create "domain-performance-level" property
- Create new "power-domain-opp" property for the devices.
- Take care of domain providers that provide multiple domains and extend
  "operating-points-v2" property to contain a list of phandles
- Update code according to those bindings.

V4->V5:
- Only 3 patches were resent and 2 of them are Acked from Ulf.

V3->V4:
- Use OPP table for genpd devices as well.
- Add struct device to genpd, in order to reuse OPP infrastructure.
- Based over: https://marc.info/?l=linux-kernel&m=148972988002317&w=2
- Fixed examples in DT document to have voltage in target,min,max order.

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

Viresh Kumar (9):
  PM / OPP: Introduce "power-domain-opp" property
  PM / Domains: Allow OPP table to be used for power-domains
  PM / QOS: Keep common notifier list for genpd constraints
  PM / QOS: Add DEV_PM_QOS_PERFORMANCE request
  PM / OPP: Add support to parse "power-domain-opp" property
  PM / OPP: Implement dev_pm_opp_of_add_table_indexed()
  PM / domain: Register PM QOS performance notifier
  PM / Domain: Add struct device to genpd
  PM / Domain: Add support to parse domain's OPP table

 Documentation/devicetree/bindings/opp/opp.txt      |  74 ++++++-
 .../devicetree/bindings/power/power_domain.txt     | 106 ++++++++++
 Documentation/power/pm_qos_interface.txt           |   2 +-
 drivers/base/power/domain.c                        | 222 +++++++++++++++++++--
 drivers/base/power/opp/core.c                      |  72 +++++++
 drivers/base/power/opp/debugfs.c                   |   3 +
 drivers/base/power/opp/of.c                        | 123 +++++++++++-
 drivers/base/power/opp/opp.h                       |  12 ++
 drivers/base/power/qos.c                           |  36 +++-
 include/linux/pm_domain.h                          |   6 +
 include/linux/pm_opp.h                             |   6 +
 include/linux/pm_qos.h                             |  16 ++
 kernel/power/qos.c                                 |   2 +-
 13 files changed, 641 insertions(+), 39 deletions(-)

-- 
2.12.0.432.g71c3a4f4ba37
