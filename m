From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V7 0/2] PM / Domains: Power domain performance states
Date: Wed, 17 May 2017 12:32:41 +0530
Message-ID: <cover.1495003720.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34926 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753375AbdEQHCs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 May 2017 03:02:48 -0400
Received: by mail-pg0-f53.google.com with SMTP id q125so2619898pgq.2
        for <linux-pm@vger.kernel.org>; Wed, 17 May 2017 00:02:48 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, sudeep.holla@arm.com, Viresh Kumar <viresh.kumar@linaro.org>

Hi,

Here is the 7th version of the series and it looks very different from
whatever is sent until now. Almost a rewrite.


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


Solution:

Kevin suggested in V6 that we should wait for a while before introducing
any new binding (power-domain-opp) to the OPP table for this stuff and
translate the device requirements into a performance index from within
the power domain driver as it already knows which devices it supports.

If we do that, then there is also no need to represent the performance
states of the power domains in the DT. Keep that as well in the driver
for now.

This simplified things a lot and we can make things work with just two
patches. The first one updates the genpd framework to supply new APIs
and the second patch uses them from the OPP core. Its quite straight
forward and simple.

The ideal way is still to get the relation between device and domain
states via the DT instead of platform code, but that can be done
incrementally later once we have some users for it. It would be much
simpler to get these two patches merged. The code never got any real
reviews in the last 6 versions as we were stuck with bindings :)

This is tested currently by hacking the kernel a bit with virtual
power-domains for the dual A15 exynos platform.

Driver code:
------------

Here is some sample power-domain driver code that I have. It only
supports a single device for now, CPU.

int pd_get_performance(struct device *dev, unsigned long rate)
{
	struct device *cpu_dev = get_cpu_device(0);

	if (cpu_dev != dev)
		return -EINVAL;

	if (rate <= 500000000)
		return 1;
	else if (rate <= 700000000)
		return 2;
	else if (rate <= 900000000)
		return 3;
	else if (rate <= 1200000000)
		return 4;
	else if (rate <= 1600000000)
		return 5;
	else
		return 6;
}

static int pd_set_performance(struct generic_pm_domain *domain, unsigned int state)
{
	/* Set performance of the domain in platform dependent way */

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

		pd.get_performance_state = pd_get_performance;
		pd.set_performance_state = pd_set_performance;

               pm_genpd_init(&pd, NULL, false);
               of_genpd_add_provider_simple(np, &pd);
       }

       ret = dev_pm_domain_attach(dev, false);

       return ret;
}


Pushed here as well:

https://git.linaro.org/people/viresh.kumar/linux.git/log/?h=opp/genpd-performance-state

Rebased on: pm/linux-next +  some OPP cleanups (https://marc.info/?l=linux-kernel&m=149499607030364&w=2)

V6->V7:
- Almost a rewrite, only two patches against 9 in earlier version.
- No bindings updated now and domain's performance state aren't passed
  via DT for now (until we know how users are going to use it).
- We also skipped the QoS framework completely and new APIs are provided
  directly by genpd.

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

Viresh Kumar (2):
  PM / Domains: Add support to select performance-state of domains
  PM / OPP: Support updating performance state of device's power domains

 drivers/base/power/domain.c   | 172 ++++++++++++++++++++++++++++++++++++++++++
 drivers/base/power/opp/core.c |  48 +++++++++++-
 drivers/base/power/opp/opp.h  |   2 +
 include/linux/pm_domain.h     |  19 +++++
 4 files changed, 240 insertions(+), 1 deletion(-)

-- 
2.13.0.303.g4ebf3021692d
