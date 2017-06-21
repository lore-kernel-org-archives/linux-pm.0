From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V8 0/6] PM / Domains: Power domain performance states
Date: Wed, 21 Jun 2017 12:40:47 +0530
Message-ID: <cover.1498026827.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f45.google.com ([74.125.83.45]:34797 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbdFUHLA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 21 Jun 2017 03:11:00 -0400
Received: by mail-pg0-f45.google.com with SMTP id e187so21148424pgc.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Jun 2017 00:11:00 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, ulf.hansson@linaro.org, Kevin Hilman <khilman@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Nishanth Menon <nm@ti.com>, robh+dt@kernel.org, lina.iyer@linaro.org, rnayak@codeaurora.org, sudeep.holla@arm.com, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>

Hi,

Some platforms have the capability to configure the performance state of
their power domains. The process of configuring the performance state is
pretty much platform dependent and we may need to work with a wide range
of configurables.  For some platforms, like Qcom, it can be a positive
integer value alone, while in other cases it can be voltage levels, etc.

The power-domain framework until now was only designed for the idle
state management of the device and this needs to change in order to
reuse the power-domain framework for active state management of the
devices.

The first patch updates the genpd framework to supply new APIs to
support active state management and the second patch uses them from the
OPP core.

Rest of the patches [3-6/6] are included just to show how user drivers
would end up using the new APIs and these patches aren't there to get
merged and are marked clearly like that.

The ideal way is still to get the relation between device and domain
states via the DT instead of platform code, but that can be done
incrementally later once we have some users for it upstream.

This is currently tested by:
- me by hacking the kernel a bit with virtual power-domains for the dual
  A15 exynos platform. I have also tested the complex cases where the
  device's parent power domain doesn't have set_performance_state()
  callback set, but parents of that domains have it. Lockdep configs
  were enabled for these tests.
- Rajendra Nayak, on msm8996 platform (Qcom) with MMC controller.

Thanks Rajendra for helping me testing this out.

Pushed here as well:

https://git.linaro.org/people/viresh.kumar/linux.git/log/?h=opp/genpd-performance-state

Rebased on: 4.12-rc6 + some OPP core changes [1] and [2].

V7->V8:
- Ulf helped a lot in reviewing V7 and pointed out couple of issues,
  specially in locking while dealing with a hierarchy of power domains.
- All those locking issues are sorted out now, even for the complex
  cases.
- genpd_lookup_dev() is used in pm_genpd_has_performance_state() to make
  sure we have a valid genpd available for the device.
- Validation of performance state callbacks isn't done anymore in
  pm_genpd_init() as it gets called very early and the binding of
  subdomains to their parent domains happens later. This is handled in
  pm_genpd_has_performance_state() now, which is called from user
  drivers.
- User driver changes (not to be merged) are included for the first time
  here, to demonstrate how changes would look finally.

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

[1] https://marc.info/?l=linux-kernel&m=149499607030364&w=2
[2] https://marc.info/?l=linux-kernel&m=149795317123259&w=2

Rajendra Nayak (4):
  soc: qcom: rpmpd: Add a powerdomain driver to model cx/mx powerdomains
  soc: qcom: rpmpd: Add support for get/set performance state
  mmc: sdhci-msm: Adapt the driver to use OPPs to set clocks/performance
    state
  remoteproc: qcom: q6v5: Vote for proxy powerdomain performance state

Viresh Kumar (2):
  PM / Domains: Add support to select performance-state of domains
  PM / OPP: Support updating performance state of device's power domains

 .../devicetree/bindings/power/qcom,rpmpd.txt       |  10 +
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  39 ++
 drivers/base/power/domain.c                        | 223 +++++++++++
 drivers/base/power/opp/core.c                      |  48 ++-
 drivers/base/power/opp/opp.h                       |   2 +
 drivers/clk/qcom/gcc-msm8996.c                     |   8 +-
 drivers/mmc/host/sdhci-msm.c                       |  39 +-
 drivers/remoteproc/qcom_q6v5_pil.c                 |  20 +-
 drivers/soc/qcom/Kconfig                           |   9 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/rpmpd.c                           | 412 +++++++++++++++++++++
 include/linux/pm_domain.h                          |  22 ++
 12 files changed, 811 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/qcom,rpmpd.txt
 create mode 100644 drivers/soc/qcom/rpmpd.c

-- 
2.13.0.71.gd7076ec9c9cb
