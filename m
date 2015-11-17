From: Lina Iyer <lina.iyer@linaro.org>
Subject: [PATCH RFC 00/27] PM/Domains: Cluster idle support for ARM SoCs
Date: Tue, 17 Nov 2015 15:37:24 -0700
Message-ID: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@linaro.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi all,

This series is an attempt at doing an end-to-end PSCI OS initiated solution for
SoC/Cluster idle for ARM v8 SoCs. The series is based on PM domains for CPUs
[1], which lays the foundation for IRQ safe domains and CPU domains that use
the IRQ safe property of a domain to power ON/OFF the domain when the CPUs are
in idle (either cpuidle or hotplug). This patchset is superset of [1] providing
a better picture of how the CPU domains are defined and used.  

The gist of this series is that the topology of CPU and the hierarchy is
provided in the DT for an SoC. A common library of functions help parse the DT
to initialize the generic PM domains and attach sub-domains and CPU devices to
those domains. On an ARM v8 SoC, the PSCI f/w controls the domains for low
power modes when the CPUs are in idle. CPUs call runtime PM suspend when
entering idle, which calls generic PM domains (genpd) that reference counts the
domain usage by devices/sub-domains in the domain. When the last CPU in the
domain powers down, genpd calls CPU PM domain core to power down the domain,
which in turn sets up PSCI core to pass the cluster idle states along with the
CPU idle state to the f/w.

PSCI v1.0 supports Platform coordinated and OS initiated modes. Platform
coordinated PSCI lets PSCI determine the state of the cluster based on votes
from individual CPUs. This simple solution may sometimes be inefficient, as the
PSCI f/w is unaware of the CPU and cluster sleep length and the QoS requirement
laid on the CPUs. OS initiated PSCI on the other hand lets Linux determine the
state of the cluster and the coherency domain and pass them as arguments to the
PSCI call when the last CPU enters idle. The complexity of determining the
state of the cluster and last-man reference counting rests with the kernel.

By defining CPU domains using genpd, both ARM v7 and v8 based architectures can
take advantage of the last man reference counting and cluster idle state
determination in genpd to save power - by opportunistically flushing CPU
caches, turning off supplementary hardware and powering off the CPU domain.
This patchset makes it easy for ARM v8 based PSCI f/w that supports OS
initiated do all that is needed from Linux by just specifying the CPU domain
hierarchy and idle states supported by the CPU domains in DT. ARM v7 SoCs that
control domains in Linux could still use this series in setting up CPU PM
domains for the CPUs, however, they would setup the hierarchy and supply the
domain power on/off callbacks.

This patchset builds upon genpd patches for multiple idle states from Axel [2]
and Marc [3] and Lorenzo to unify cpuidle signatures across ARM 32 and 64 [4].
I made a few amends to their patches to split the key parts relevant to this
efforts and rebase on top of 4.4-rc1. I have re-based this [7] on top of
v4.4-rc1 and tested using Kumar's patches, which has since then been replaced
with [5]. This series [7] has been tested on a QCOM APQ8016 Dragonboard with a
PSCI f/w that supports OS initiated mode.
 
Key topics for focus -
1. DT definition of cluster node in topology node.
2. DT definition of domain idle states - in comparison to arm,idle-state
3. Determining the next wake up of the CPU therefore the cluster from clock events.
4. Gen PD governor for CPU clusters.
5. Some parts are currently ARM specific (like the cpuidle parts), they could be
arch agnostic.
6. Optimizations to speed up the entire series.

Concerns -
Previous patches had raise concerns with latency added to the idle path. I have
not addressed them in this series. I focused on getting the full solution in
place at this time. A previous attempt at using runtime PM and genpd without
the use of locks is here [6]. I will re-focus my effort of making this suitable
for -RT kernel and optimizing the runtime paths and integrating them into a
future version.

Thanks,
Lina

[1]. https://lwn.net/Articles/656793/
[2]. https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1001509.html
[3]. https://lwn.net/Articles/658461/
[4]. http://www.spinics.net/lists/arm-kernel/msg451502.html
[5]. https://lkml.org/lkml/2015/10/26/651
[6]. https://patches.linaro.org/54565/
[7]. https://git.linaro.org/people/lina.iyer/linux-next.git/shortlog/refs/heads/genpd-psci-3

Axel Haslam (3):
  PM / Domains: core changes for multiple states
  PM / Domains: make governor select deepest state
  PM / Domains: remove old power on/off latencies.

Kumar Gala (2):
  arm64: dts: Add Qualcomm MSM8916, MTP8916, APQ8016, SBC8016 ids
  devicetree: bindings: Document qcom,msm-id and qcom,board-id

Lina Iyer (19):
  PM / Domain: Add additional state specific param
  PM / Domains: Read domain residency from DT
  PM / Domains: Support IRQ safe PM domains
  PM / Domains: Attempt runtime suspend of IRQ safe parent domain
  drivers: power: Introduce PM domains for CPUs/clusters
  drivers: cpu: Define CPU devices as IRQ safe
  ARM: cpuidle: Add runtime PM support for CPU idle
  tick: get next wakeup event for the CPU
  PM / Domains: Add next_wakeup to device's timing data
  ARM: cpuidle: Record the next wakeup event of the CPU
  drivers: cpu-pd: Record CPUs that are part of the domain
  drivers: cpu-pd: Add PM Domain governor for CPUs
  drivers: cpu-pd: Invoke CPU PM runtime on hotplug
  Documentation: ARM: topology: 'cluster' property for cluster nodes
  drivers: cpu-pd: Parse topology to setup CPU PM domains
  drivers: firmware: PSCI: Export psci_has_ext_power_state()
  ARM64: psci: Support cluster idle states for OS-Initated
  ARM64: dts: Add PSCI cpuidle support for MSM8916
  ARM64: dts: Define CPU power domain for MSM8916

Lorenzo Pieralisi (1):
  ARM: cpuidle: remove cpu parameter from the cpuidle_ops suspend hook

Marc Titinger (2):
  PM / Domains: Allow domain power states to be read from DT
  PM / Domains: add debugfs 'states' and 'timings' seq files

 Documentation/arm/cpu-domains.txt                  |  52 ++
 Documentation/devicetree/bindings/arm/msm/ids.txt  |  65 +++
 Documentation/devicetree/bindings/arm/topology.txt |   8 +
 .../devicetree/bindings/power/power_domain.txt     |  76 +++
 Documentation/power/devices.txt                    |  11 +-
 arch/arm/include/asm/cpuidle.h                     |   2 +-
 arch/arm/kernel/cpuidle.c                          |   2 +-
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts           |   2 +
 arch/arm64/boot/dts/qcom/msm8916-mtp.dts           |   3 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |  76 +++
 arch/arm64/kernel/psci.c                           |  54 +-
 drivers/base/cpu.c                                 |   6 +-
 drivers/base/power/Makefile                        |   1 +
 drivers/base/power/cpu-pd.c                        | 507 ++++++++++++++++++
 drivers/base/power/domain.c                        | 589 +++++++++++++++++++--
 drivers/base/power/domain_governor.c               |  70 ++-
 drivers/cpuidle/cpuidle-arm.c                      |  13 +
 drivers/firmware/psci.c                            |   2 +-
 drivers/soc/qcom/spm.c                             |  10 +-
 include/dt-bindings/arm/qcom-ids.h                 |  33 ++
 include/linux/cpu-pd.h                             |  36 ++
 include/linux/pm_domain.h                          |  32 +-
 include/linux/psci.h                               |   1 +
 include/linux/tick.h                               |  10 +
 kernel/time/tick-sched.c                           |   8 +
 25 files changed, 1576 insertions(+), 93 deletions(-)
 create mode 100644 Documentation/arm/cpu-domains.txt
 create mode 100644 Documentation/devicetree/bindings/arm/msm/ids.txt
 create mode 100644 drivers/base/power/cpu-pd.c
 create mode 100644 include/dt-bindings/arm/qcom-ids.h
 create mode 100644 include/linux/cpu-pd.h

-- 
2.1.4
