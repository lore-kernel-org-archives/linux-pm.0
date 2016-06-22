From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH 00/14] PM: SoC idle support using PM domains
Date: Wed, 22 Jun 2016 13:36:35 -0600
Message-ID: <1466624209-27432-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, andy.gross@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi all,

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

 .../devicetree/bindings/power/power_domain.txt     |  70 ++++
 Documentation/power/cpu_domains.txt                |  79 +++++
 Documentation/power/devices.txt                    |  12 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  49 +++
 drivers/base/power/Makefile                        |   1 +
 drivers/base/power/cpu_domains.c                   | 366 +++++++++++++++++++++
 drivers/base/power/domain.c                        | 300 ++++++++++++++---
 drivers/cpuidle/cpuidle-arm.c                      |  55 ++++
 drivers/firmware/psci.c                            |  92 +++++-
 include/linux/cpu_domains.h                        |  37 +++
 include/linux/pm_domain.h                          |  16 +-
 include/linux/tick.h                               |  10 +
 include/uapi/linux/psci.h                          |   5 +
 kernel/time/tick-sched.c                           |  13 +
 14 files changed, 1054 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/power/cpu_domains.txt
 create mode 100644 drivers/base/power/cpu_domains.c
 create mode 100644 include/linux/cpu_domains.h

-- 
2.7.4
