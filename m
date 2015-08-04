From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 0/9] ARM: PM / Domains: Generic PM domains for CPUs/Clusters
Date: Tue,  4 Aug 2015 17:35:30 -0600
Message-ID: <1438731339-58317-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34496 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754567AbbHDXgE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 4 Aug 2015 19:36:04 -0400
Received: by pawu10 with SMTP id u10so19633086paw.1
        for <linux-pm@vger.kernel.org>; Tue, 04 Aug 2015 16:36:03 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@linaro.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Changes since RFC v2 [2]:

- Fix memory not released on error in pm_genpd_add_subdomain()
- Reworded commit texts and documentation
- Add Documentation for CPU PM domain and device tree
- Clean up CPU PD initialization code
- Add runtime PM support for CPU idle and hotplug instead of notifications
- Allow platform drivers to register for CPU PD callbacks 
- Send CPU_PM notifications for cluster from the common code.
- Not including platform code as part of this series. Will submit separately.
- Rebased on top of linux-next
- Minor fix to comment in CPU_PM

Changes since RFC v1 [1]:

- Address review comments on v1.
- Incorporate Kevin's arch/arm/domain.c changes
- Drop drivers/base/power/cpu_domain.c
- Rebase on top of linux-next (to date)
- Reference implementation added.

This patchset fashions CPU clusters as generic PM domains. CPUs in most new
SOCs are grouped together as clusters, along with some supporting hardware,
GIC, L2 caches etc. When the CPUs in the cluster are powered off, these
hardware may also be powered off.

Generic PM domain  framework provides the necessary backend to build a cluster
hierarchy through devices, domains and nested domains. When devices and
sub-domains of a genpd are suspended, the genpd may also be suspended and
resumed before the first of the devices resumes. This works well for devices
and domains that operate in process context.

CPU idle operates with IRQs disabled. IRQs are disabled early in the CPU idle
operation and therefore any activity related to CPU's idle cannot sleep. The
cluster hardware has to support atomic operations if they are to be powered
on/off, along with the CPU. The limitation in using genpd framework for cluster
idle, is that genpd inherently uses mutexes for locking PM domains during
runtime suspend and resume and therefore may sleep during these operations. If
this limitation were to be removed, CPU clusters can be represented as devices
attached to a PM domain and when the CPUs are in runtime idle, the PM domain
can also be suspended.

The approach here is simple, allow genpd domains to specify the type of locking
the domain would use. A genpd that can suspend and resume in an IRQ safe
context, would initialize a spinlock as the genpd lock instead of a mutex.
Therefore, IRQ safe devices may initiate a genpd suspend when the last active
device goes idle. In a CPU domain, the last CPU powering down, may now program
the domain hardware to suspend, when the CPU enters idle. Thus when all the
CPUs are in idle, the domain and therefore the caches, VFP, GIC, Coresight,
power controller and other peripheral hardware may also be in a low power
state. This can save a considerable amount of runtime power.

The ARM common code defines generic PM domains for all domains that are
compatible with arm,pd. CPUs that are consumers of those domains are attached
to the genpd. When the last of the CPU notifies runtime PM of suspend, the
genpd may also be suspended. The common code currently notifies CPU_PM of
cpu_cluster_pm_enter and cpu_cluster_pm_exit, when any CPU resumes from idle.

With the help of __init section macro, platform drivers may register their
platform specific handlers for the domain power on/off callback. Match is made
when a domain provider with the same compatible flag and supporting arm,pd is
found in the DT. The common code will relay genpd power_on and power_off
callbacks to the platform for architecture specific operations.

Thanks,
Lina

[1]. http://www.spinics.net/lists/arm-kernel/msg423430.html
[2]. http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/352787.html

Lina Iyer (9):
  PM / Domains: Allocate memory outside domain locks
  PM / Domains: Remove dev->driver check for runtime PM
  PM / Domains: Support IRQ safe PM domains
  kernel/cpu_pm: fix cpu_cluster_pm_exit comment
  ARM: common: Introduce PM domains for CPUs/clusters
  ARM: domain: Add platform handlers for CPU PM domains
  ARM: cpuidle: Add runtime PM support for CPU idle
  ARM64: smp: Add runtime PM support for CPU hotplug
  ARM: smp: Add runtime PM support for CPU hotplug

 Documentation/arm/cpu-domains.txt                  |  75 +++++++
 .../devicetree/bindings/arm/cpudomains.txt         |  23 ++
 Documentation/power/devices.txt                    |  11 +-
 arch/arm/common/Makefile                           |   1 +
 arch/arm/common/domains.c                          | 203 ++++++++++++++++++
 arch/arm/include/asm/arm-pd.h                      |  30 +++
 arch/arm/kernel/smp.c                              |  18 +-
 arch/arm64/kernel/smp.c                            |  16 ++
 drivers/base/power/domain.c                        | 232 +++++++++++++++------
 drivers/cpuidle/cpuidle-arm.c                      |  10 +
 include/asm-generic/vmlinux.lds.h                  |   2 +
 include/linux/pm_domain.h                          |  11 +-
 kernel/cpu_pm.c                                    |   2 +-
 13 files changed, 571 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/arm/cpu-domains.txt
 create mode 100644 Documentation/devicetree/bindings/arm/cpudomains.txt
 create mode 100644 arch/arm/common/domains.c
 create mode 100644 arch/arm/include/asm/arm-pd.h

-- 
2.1.4

