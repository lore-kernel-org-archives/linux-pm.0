From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V4 0/9] PM / Domains: Implement domain performance states
Date: Mon, 20 Mar 2017 15:02:12 +0530
Message-ID: <cover.1490001099.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The main feedback I got for the V3 series came from Kevin, who suggested
that we should reuse OPP tables for genpd devices as well, instead of
creating a new table type. And that's what this version is trying to do.

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
hardware for which this work is getting done. And so this version should
work as well.

Here is sample DT and C code we need to write for platforms:

DT:
---

/ {
	domain_opp_table: opp_table0 {
		compatible = "operating-points-v2";

		opp@1 {
			domain-performance-state = <1>;
			opp-microvolt = <975000 970000 985000>;
		};
		opp@2 {
			domain-performance-state = <2>;
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

		opp@1000000000 {
			opp-hz = /bits/ 64 <1000000000>;
			domain-performance-state = <1>;
		};
		opp@1100000000 {
			opp-hz = /bits/ 64 <1100000000>;
			domain-performance-state = <2>;
		};
		opp@1200000000 {
			opp-hz = /bits/ 64 <1200000000>;
			domain-performance-state = <2>;
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

	opp = dev_pm_opp_find_dps(&domain->dev, state, true);

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
  PM / OPP: Allow OPP table to be used for power-domains
  PM / Domains: Use OPP tables for power-domains
  PM / QOS: Keep common notifier list for genpd constraints
  PM / QOS: Add DEV_PM_QOS_PERFORMANCE request
  PM / OPP: Add support to parse OPP table for power-domains
  PM / OPP: Add dev_pm_opp_find_dps() helper
  PM / domain: Register for PM QOS performance notifier
  PM / Domain: Add struct device to genpd
  PM / Domain: Add support to parse domain's OPP table

 Documentation/devicetree/bindings/opp/opp.txt      |  73 ++++++-
 .../devicetree/bindings/power/power_domain.txt     |  42 ++++
 Documentation/power/pm_qos_interface.txt           |   2 +-
 drivers/base/power/domain.c                        | 183 ++++++++++++++--
 drivers/base/power/opp/core.c                      | 229 +++++++++++++++++++--
 drivers/base/power/opp/debugfs.c                   |   9 +-
 drivers/base/power/opp/of.c                        |  80 ++++++-
 drivers/base/power/opp/opp.h                       |  14 ++
 drivers/base/power/qos.c                           |  36 +++-
 include/linux/pm_domain.h                          |   6 +
 include/linux/pm_opp.h                             |   8 +
 include/linux/pm_qos.h                             |  17 ++
 kernel/power/qos.c                                 |   2 +-
 13 files changed, 646 insertions(+), 55 deletions(-)

-- 
2.12.0.432.g71c3a4f4ba37
