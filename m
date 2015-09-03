From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v2 0/7] PM / Domains: Generic PM domains for CPUs/Clusters
Date: Thu,  3 Sep 2015 13:58:27 -0600
Message-ID: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34788 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750779AbbICT6o (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2015 15:58:44 -0400
Received: by padfa1 with SMTP id fa1so273930pad.1
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2015 12:58:44 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, geert@linux-m68k.org, k.kozlowski@samsung.com, linux-arm-kernel@lists.infradead.org, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, Lina Iyer <lina.iyer@linaro.org>

Changes since v1 [3]:
- Remove compatible for CPU PM domains, platform explicity calls an API to
  create and register a CPU PD.
- Remove init section initialization of platform callbacks.
- Review comments addressed in domain.c
- Move cpu-pd.c and cpu-pd.h out of ARM. However, changes to hotplug and
  cpuidle has only be made for ARM at this time.
- Define CPU devices as IRQ safe at init
- Prevent lockdep RCU false warnings
- Added Reviewed, Ack tags

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

Thanks,
Lina

[1]. http://www.spinics.net/lists/arm-kernel/msg423430.html
[2]. http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/352787.html
[3]. https://lwn.net/Articles/653579/

Lina Iyer (7):
  PM / Domains: Allocate memory outside domain locks
  PM / Domains: Support IRQ safe PM domains
  drivers: cpu: Define CPU devices as IRQ safe
  PM / Domains: Introduce PM domains for CPUs/clusters
  ARM: cpuidle: Add runtime PM support for CPU idle
  ARM64: smp: Add runtime PM support for CPU hotplug
  ARM: smp: Add runtime PM support for CPU hotplug

 Documentation/arm/cpu-domains.txt |  56 +++++++++
 Documentation/power/devices.txt   |  11 +-
 arch/arm/kernel/smp.c             |  18 ++-
 arch/arm64/kernel/smp.c           |  16 +++
 drivers/base/cpu.c                |   6 +-
 drivers/base/power/Makefile       |   2 +-
 drivers/base/power/cpu-pd.c       | 206 ++++++++++++++++++++++++++++++++
 drivers/base/power/domain.c       | 242 +++++++++++++++++++++++++++++---------
 drivers/cpuidle/cpuidle-arm.c     |  11 ++
 include/linux/cpu-pd.h            |  35 ++++++
 include/linux/pm_domain.h         |  11 +-
 11 files changed, 550 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/arm/cpu-domains.txt
 create mode 100644 drivers/base/power/cpu-pd.c
 create mode 100644 include/linux/cpu-pd.h

-- 
2.1.4

