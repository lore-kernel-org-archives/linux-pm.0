From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v2 00/14] PM: SoC idle support using PM domains
Date: Fri, 29 Jul 2016 15:56:11 -0600
Message-ID: <1469829385-11511-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi all,

Changes since v1:
- Use arm,idle-state as the DT binding for domain idle state.
- OS-Initated changes to support that and to read arm,psci-suspend-param
(Thanks Mark Rutland and Kevin Hilman)
- tick_nohz_get_next_wakeup() - suggestions from Thomas Gleixner.
- The updated series is at [3].
- Rebased on top of 4.7

Changes since RFC-v3:
- Reorganize the patches. Documentations have their own patch.
- Moved code around with PSCI OS initiated so they would not have compiler
  errors in other configuration.
- Minor bug fixes with genpd power_on functionality.
- Rebased on top of 4.7-rc1

This is the submission of the SoC idle support in the kernel for CPU domains
using genpd. The patches were submitted as RFC's earlier, the last of them is
[1]. Since the RFC, multiple discussions have happened around making the
patches generic across all architectures. For now, the patches address the
needs of the ARM community, but sure enough can be extended to support other
architectures. Some of the limitations in making this patch generic is the lack
of device idle state description in the DT, but that in itself is a bigger
topic for a future discussion.
 
The patch has been tested on the 410c Dragonboard and the MTK EVB boards. Both
show good power savings when used with OS Initiated PSCI f/w.

Ulf is maintaining a branch tracking the PM/genpd changes that are in
pipleline. This series sits well on his branch. You may find the entire series
at [2].

Thanks,
Lina

[1]. http://lists.infradead.org/pipermail/linux-arm-kernel/2016-March/412934.html
[2]. https://git.linaro.org/people/lina.iyer/linux-next.git/shortlog/refs/heads/genpd-psci-v1
[3]. https://git.linaro.org/people/lina.iyer/linux-next.git/shortlog/refs/heads/genpd-psci-v2


Axel Haslam (2):
  PM / Domains: Allow domain power states to be read from DT
  dt/bindings: update binding for PM domain idle states

Lina Iyer (12):
  PM / Domains: Abstract genpd locking
  PM / Domains: Support IRQ safe PM domains
  PM / doc: update device documentation for devices in IRQ safe PM
    domains
  PM / cpu_domains: Setup PM domains for CPUs/clusters
  ARM: cpuidle: Add runtime PM support for CPUs
  timer: Export next wake up of a CPU
  PM / cpu_domains: Add PM Domain governor for CPUs
  doc / cpu_domains: Describe CPU PM domains setup and governor
  drivers: firmware: psci: Allow OS Initiated suspend mode
  drivers: firmware: psci: Support cluster idle states for OS-Initiated
  ARM64: dts: Add PSCI cpuidle support for MSM8916
  ARM64: dts: Define CPU power domain for MSM8916

 .../devicetree/bindings/power/power_domain.txt     |  39 +++
 Documentation/power/cpu_domains.txt                | 109 ++++++
 Documentation/power/devices.txt                    |  12 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  51 +++
 drivers/base/power/Makefile                        |   1 +
 drivers/base/power/cpu_domains.c                   | 388 +++++++++++++++++++++
 drivers/base/power/domain.c                        | 306 +++++++++++++---
 drivers/cpuidle/cpuidle-arm.c                      |  55 +++
 drivers/firmware/psci.c                            |  98 +++++-
 include/linux/cpu_domains.h                        |  39 +++
 include/linux/pm_domain.h                          |  23 +-
 include/linux/tick.h                               |   7 +
 include/uapi/linux/psci.h                          |   5 +
 kernel/time/tick-sched.c                           |  11 +
 14 files changed, 1092 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/power/cpu_domains.txt
 create mode 100644 drivers/base/power/cpu_domains.c
 create mode 100644 include/linux/cpu_domains.h

-- 
2.7.4
