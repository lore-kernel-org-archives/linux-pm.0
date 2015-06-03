From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 0/3] PM / Domains: Generic PM domains for cpus
Date: Wed, 3 Jun 2015 15:53:55 +0000 (UTC)
Message-ID: <1433456946-53296-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:35658 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755224AbbFCPxS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2015 11:53:18 -0400
Received: by pdbnf5 with SMTP id nf5so10336929pdb.2
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2015 08:53:18 -0700 (PDT)
Date: Thu,  4 Jun 2015 16:29:03 -0600
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: mathieu.poirier@linaro.org, galak@codeaurora.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

This is an attempt to provide a generic PM domain for cpus, so as to allow the
cpu domain to be powered off, when all the cpus are in power down state during
cpuidle. The rationale behind the change is that newer SoCs can power down the
cpus for very short sleep times to save on leakage power. The domain which
usually has the cpus, a second level cache and some peripheral hardware is
powered by a rail that can also be turned off when the cpus are not in use.
Devices for each cpu, L2 and other related blocks could be attached to the
domain and when there are no uses of these devices (device idle) the domain
could also be powered off. Generic PM domains provides all the backend needed
for such an organization.

In the first 2 patches, I make genpd usable in atomic context as well. CPUIdle
runs with irqs disabled and therefore use of mutexes in the current genpd
implementation is a limitation. But, not all PM domains need to operate in irq
safe context, those that need to can specify explicitly the irq safe
requirement of the genpd at init. Devices and sub-domains that attach to an irq
safe genpd also have to be irq safe.

The third patch, adds a generic PM domain for the cpus. GenPD provider can be
specified in the DT and individual cpus that are part of the domain would be
the domain consumers. A new API pm_cpu_domain_init() has been introduced that
would initialize the genpd and attach cpus specified as consumers in the DT to
the domain. When the cpus enter their idle state cpu_pm notifications are sent
out for that cpu. The last cpu to send cpu_pm notification would trigger the
domain power_off callback and the first cpu to come up would trigger the genpd
power_on callback.  Generally, the power_off callback is where the caches are
flushed in preparation for a power down and the domain hardware configured to
power down when the cpu finishes execution. In the power_on callback, the
domain hardware is reset to a state to allow cpus to be active or entire idle
states individually.

A future addition to this feature, could be a new genpd governor for the
specific case of the cpu domain.  The governor may look up the time available
to sleep between the last cpu down and the first cpu up, in determining if it
would be more efficient to just keep the domain powered on.

This patch is based on Ulf's patch for simplifying domain power down states
[1], which removes a bunch of complexity in genpd, simplifying atomic genpd.

I have tested this on QCOM 8916, 8084 boards. The dependencies for those
restrict the addition of the platform code to the series. An example of changes
needed to add cpu domain could looks like this.

CPU as the domain consumer (only cpu0 is provided as the example here) - 

CPU0: cpu@0 {
        device_type = "cpu";
        compatible = "arm,cortex-a53", "arm,armv8";
        reg = <0x0>;
        enable-method = "qcom,arm-cortex-acc";
        qcom,acc = <&acc0>;
        next-level-cache = <&L2_0>;
        qcom,saw = <&saw0>;
        cpu-idle-states = <&CPU_SPC>;
        power-domains = <&saw_l2>;
};

Power controller for the L2 Cache is also the domain provider -

saw_l2: power-controller@B012000 {
        compatible = "qcom,msm8916-saw2-v3.0-l2";
        reg = <0xB012000 0x1000>, <0xB009000 0x1000>;
        #power-domain-cells = <0>;
};

The platform driver for the power-controller -

{
	...
	genpd.name = kstrdup("cpu-domain", GFP_KERNEL);
	genpd.power_on = cpu_pd_power_on;
	genpd.power_off = cpu_pd_power_off;
	ret = pm_cpu_domain_init(&genpd, pdev->dev.of_node);
	...
}

[1]. https://patches.linaro.org/49014/

Lina Iyer (3):
  PM / Domains: Allocate memory outside domain locks
  PM / Domains: Support atomic PM domains
  PM / Domains: Introduce generic PM domain for cpu domain

 drivers/base/power/Makefile     |   1 +
 drivers/base/power/cpu_domain.c | 187 +++++++++++++++++++++++++++++++++
 drivers/base/power/domain.c     | 225 +++++++++++++++++++++++++++++-----------
 include/linux/pm_domain.h       |  23 +++-
 kernel/power/Kconfig            |  12 +++
 5 files changed, 388 insertions(+), 60 deletions(-)
 create mode 100644 drivers/base/power/cpu_domain.c

-- 
2.1.4

