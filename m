From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC v2 00/16] PM / Domains: Generic PM domains for CPUs
Date: Fri, 26 Jun 2015 21:02:20 -0600
Message-ID: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36230 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbbF0DCn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Jun 2015 23:02:43 -0400
Received: by paceq1 with SMTP id eq1so77109917pac.3
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2015 20:02:43 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Changes since v1 [1]:

- Address review comments on v1.
- Incorporate Kevin's arch/arm/domain.c changes
- Drop drivers/base/power/cpu_domain.c 
- Rebase on top of linux-next (to date)
- Reference implemantation added.

This patchset fashions CPU clusters as generic PM domains. CPUs in most new
SOCs are grouped together as a cluster, along with some supporting hardware,
GIC, L2 caches etc. When all these devices in a cluster is powered off, the
power domain may also be powered off. 

GenPD framework provides the necessary backend to build a cluster hierarchy
through devices, domains and nested domains. When devices and sub-domains of a
genpd are suspended, the genpd may also be suspended and resumed before the
first of the devices resumes. This works well for most devices and domains.
However, not all devices operate in a process context. Devices that suspend and
resume when IRQs are disabled, are defined as IRQ safe devices and domains that
have IRQ safe devices are never powered off. The reason being, genpd uses
mutexes to lock domains and IRQ safe devices may operate in atomic contexts,
therefore cannot sleep. So even when all the devices are suspended, the domain
remains powered on.

Since CPUIdle frameworks calls the CPU's idle functions with IRQs disabled, the
CPU devices have to be IRQ safe. A cluster fashioned as genpd be attached to
IRQ safe CPU devices and possibly other devices that may or may not be IRQ
safe. However, even when all these devices are suspended, the genpd would never
be powered off. This is a significant part of the cluster's idle power
consumption.

These patches attempt to save some runtime idle power of CPU clusters by
allowing the genpd to suspend even when the attached devices are IRQ safe. The
approach here is simple, allow genpd domains to specify the type of locking the
domain would use. A genpd that can suspend and resume in an IRQ safe context,
would initialize a spinlock as the genpd lock instead of a mutex. Therefore,
IRQ safe devices may initiate a genpd suspend when the last active device goes
idle. In a CPU domain, the last CPU powering down, may now program the domain
hardware to suspend, when the CPU enters idle. Thus when all the CPUs, caches,
peripheral cluster hardware are in idle, the cluster domain would also be in a
low power state.

These patches also bring in a generalized way to represent CPU clusters on an
ARM platform. Platform drivers specify the CPU domain providers in their DT and
a genpd is initialized for every domain provider specified for the CPU.
Optionally, the platform may register their callback to perform SoC specific
functions when the domains are suspended/resumed. Currently, only CPU devices
are attached to the CPU genpd by default. Devices representing L2, GIC,
peripheral hardware that depend on the PM domain, may also be attached to the
genpd in the future.

This RFC is based on Ulf's clean up of genpd intermediate states [2] and
Kevin's WIP on generic PM domains for ARM CPU cluster. CPU domain definition
for the QCOM DB platform is provided as reference (patch 11/16 onwards).

Thanks,
Lina

[1]. http://www.spinics.net/lists/arm-kernel/msg423430.html
[2]. https://patches.linaro.org/50047/


Kevin Hilman (1):
  WIP: ARM: PM domains for CPUs/clusters

Lina Iyer (15):
  PM / Domains: Allocate memory outside domain locks
  PM / Domains: Remove dev->driver check for runtime PM
  PM / Domains: Support IRQ safe PM domains
  arm: domain: Remove hack to add dev->driver.
  arm: domain: Make CPU genpd IRQ safe
  arm: domain: Synchronize CPU device runtime PM usage with idle state
  arm: domain: Handle CPU online reference counting
  arm: domain: Add platform callbacks for domain power on/off
  drivers: cpuidle: Add runtime PM support for CPUIdle
  drivers: qcom: spm: Support cache and coherency SPMs
  drivers: qcom: spm: Enable runtime suspend/resume of CPU PM domain
  drivers: qcom: spm: Add 8084 L2 SPM register data
  arm: dts: Add L2 power-controller device bindings for APQ8084
  arm: dts: Add power domain device bindings for APQ8084
  drivers: qcom: Enable genpd on selecting QCOM_PM

 .../devicetree/bindings/arm/msm/qcom,saw2.txt      |   1 +
 Documentation/power/devices.txt                    |  11 +-
 arch/arm/boot/dts/exynos5420.dtsi                  |  18 ++
 arch/arm/boot/dts/qcom-apq8084.dtsi                |  10 +-
 arch/arm/include/asm/cpu.h                         |   1 -
 arch/arm/include/asm/pm_domain.h                   |  27 +++
 arch/arm/kernel/Makefile                           |   1 +
 arch/arm/kernel/domains.c                          | 243 +++++++++++++++++++++
 drivers/base/power/domain.c                        | 230 ++++++++++++++-----
 drivers/cpuidle/cpuidle-arm.c                      |  11 +
 drivers/soc/qcom/Kconfig                           |   3 +
 drivers/soc/qcom/spm.c                             | 156 ++++++++++++-
 include/linux/pm_domain.h                          |  11 +-
 13 files changed, 649 insertions(+), 74 deletions(-)
 create mode 100644 arch/arm/include/asm/pm_domain.h
 create mode 100644 arch/arm/kernel/domains.c

-- 
2.1.4

