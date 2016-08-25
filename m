From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH v4 00/16] PM: SoC idle support using PM domains
Date: Thu, 25 Aug 2016 13:51:30 -0600
Message-ID: <1472154706-40119-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: lorenzo.pieralisi@arm.com, Juri.Lelli@arm.com, linux-arm-msm@vger.kernel.org, sboyd@codeaurora.org, brendan.jackman@arm.com, sudeep.holla@arm.com, andy.gross@linaro.org, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi all,

Changes since v3 [7]:
- Mostly refactoring and reorganization, no functional changes.
- Refactored DT support for CPU PM domains into a separate patch.
  (Suggested by Ulf)
- Reorganized domain idle state into DT binding, to be more in line
  with the discussions that followed the last patch submission.
  (Thanks Brendan, Sudeep, Lorenzo for some really good discussions.)

Changes since v2 [5]:
- Update PSCI documentation to define OS-Initiated PM domains.
- Nifty updates and bug fixes. Thanks Brendan!
- Define PSCI PM domains under psci node in 8916 DT.
- Documentation updates for domain definitions.
- Updated series is at [4].

Changes since v1 [6]:
- Use arm,idle-state as the DT binding for domain idle state.
- OS-Initated changes to support that and to read arm,psci-suspend-param
(Thanks Mark Rutland and Kevin Hilman)
- tick_nohz_get_next_wakeup() - suggestions from Thomas Gleixner.
- The updated series is at [3].

Changes since RFC-v3 [1]:
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

This entire series can be found at [8].

Thanks,
Lina

[1]. http://lists.infradead.org/pipermail/linux-arm-kernel/2016-March/412934.html
[2]. https://git.linaro.org/people/lina.iyer/linux-next.git/shortlog/refs/heads/genpd-psci-v1
[3]. https://git.linaro.org/people/lina.iyer/linux-next.git/shortlog/refs/heads/genpd-psci-v2
[4]. https://git.linaro.org/people/lina.iyer/linux-next.git/shortlog/refs/heads/genpd-psci-v3
[5]. https://lwn.net/Articles/695987/
[6]. https://lwn.net/Articles/675674/
[7]. http://www.spinics.net/lists/arm-kernel/msg522021.html
[8]. https://git.linaro.org/people/lina.iyer/linux-next.git/shortlog/refs/heads/genpd-psci-v4

Axel Haslam (2):
  PM / Domains: Allow domain power states to be read from DT
  dt/bindings: Update binding for PM domain idle states

Lina Iyer (14):
  PM / Domains: Abstract genpd locking
  PM / Domains: Support IRQ safe PM domains
  PM / doc: Update device documentation for devices in IRQ safe PM
    domains
  PM / cpu_domains: Setup PM domains for CPUs/clusters
  PM / cpu_domains: Initialize CPU PM domains from DT
  ARM: cpuidle: Add runtime PM support for CPUs
  timer: Export next wake up of a CPU
  PM / cpu_domains: Add PM Domain governor for CPUs
  doc / cpu_domains: Describe CPU PM domains setup and governor
  drivers: firmware: psci: Allow OS Initiated suspend mode
  drivers: firmware: psci: Support cluster idle states for OS-Initiated
  dt/bindings: Add PSCI OS-Initiated PM Domains bindings
  ARM64: dts: Add PSCI cpuidle support for MSM8916
  ARM64: dts: Define CPU power domain for MSM8916

 Documentation/devicetree/bindings/arm/psci.txt     |  79 ++++
 .../devicetree/bindings/power/power_domain.txt     |  57 +++
 Documentation/power/cpu_domains.txt                | 109 +++++
 Documentation/power/devices.txt                    |  12 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  49 +++
 drivers/base/power/Makefile                        |   1 +
 drivers/base/power/cpu_domains.c                   | 459 +++++++++++++++++++++
 drivers/base/power/domain.c                        | 308 ++++++++++++--
 drivers/cpuidle/cpuidle-arm.c                      |  55 +++
 drivers/firmware/psci.c                            | 135 +++++-
 include/linux/cpu_domains.h                        |  67 +++
 include/linux/pm_domain.h                          |  24 +-
 include/linux/tick.h                               |   7 +
 include/uapi/linux/psci.h                          |   5 +
 kernel/time/tick-sched.c                           |  11 +
 15 files changed, 1314 insertions(+), 64 deletions(-)
 create mode 100644 Documentation/power/cpu_domains.txt
 create mode 100644 drivers/base/power/cpu_domains.c
 create mode 100644 include/linux/cpu_domains.h

-- 
2.7.4
