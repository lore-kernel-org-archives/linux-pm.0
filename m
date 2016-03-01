From: Lina Iyer <lina.iyer@linaro.org>
Subject: [RFC v3 00/12] PM: SoC idle support using PM domains
Date: Tue,  1 Mar 2016 14:15:18 -0700
Message-ID: <1456866931-37851-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ulf.hansson@linaro.org, khilman@kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: geert@linux-m68k.org, k.kozlowski@samsung.com, msivasub@codeaurora.org, agross@codeaurora.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, lorenzo.pieralisi@arm.com, ahaslam@baylibre.com, mtitinger@baylibre.com, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi all,

Changes since RFC v2 [6] -
- Bug fix for NULL callbacks
- Address review comments from Stephen

Changes since RFC v1 [1] -
- genpd lock abstraction using fn ptrs. Sparse is happier.
- Removed restriction that IRQ-safe domains can only have IRQ safe parents [3]
- changes in the way CPU domains are initialized, starting from CPU now
	* cpu-map node dependency removed
	* platform driver initiate CPU PM domain setup
- smaller patchset excluding genpd multiple level changes
	* they were submitted to ML earlier [2]
- cpuidle runtime PM and hotplug changes
- PSCI changes to detect if the f/w supports OSI
- updated documentation
- this new cover description

This series allows CPU common hardware blocks to enter idle state, when the
CPUs are in idle. A lightweight but important power saving in a battery powered
device is power savings when the device is not suspended. While being active,
the CPUs can save power by entering low power states with the help of cpuidle
framework, but the hardware supporting these CPU still remain active. This is
an effort in reducing power on these h/w block around the CPU during cpuidle.

Every CPU decides for itself the deepest low power mode possible and enters
that state to be more power effecient. This is unlike coupled states, where
CPUs have to wait until the last of the CPU is ready to enter the deepest idle.
The last of the CPU that enters idle decides for the domain, the best idle
state the domain may enter. This is also a higher level than what MCPM solves.
In newer SoC's the coherency and other race conditions coming out of warm reset
are handled in the firmware. This patchset helps Linux make the right power
decision for other h/w blocks that are dependent on the CPUs.

The idea is that CPU hierarchy (represented in DT) is modelled as regular
devices attached to their PM domains, which in turn may be attached to its
parent domain. When cpuidle puts the CPU to sleep, runtime PM for the CPU
device is notified, which suspends the CPU device. This triggers a reduction in
genpd domain usage count. When the last device in a domain suspends, the domain
is powered off as part of the same call. Similarly, the domain resumes before
the first CPU device resumes from idle. To achieve this the following changes
are needed -
	- genpd to support multiple idle states (more than just on/off)
	- genpd should support suspend/resume from IRQ safe context
	- CPU devices set up for runtime PM, as IRQ safe devices
	- cpuidle calls runtime PM ops when idling
	- the genpd power downs calling into a gov to determine the deepest idle state 
	- genpd ->power_on()/->power_off() callbacks to be handled by the platform

Patches from Axel [2] allow genpd to define multiple idle states and choose the
best idle state from them.

These patches build up on top of that -

- Patches [1, 2] - Genpd changes
Sets up Generic PM domains to be called from cpuidle. Genpd uses mutexes for
synchronization. This has to be changed to spinlocks for domains that may be
called from IRQ safe contexts.

- Patch [3] - CPU PM domains
Parses DT and sets up PM domains for CPUs and builds up the hierarchy of
domains and devices. These are bunch of helper functions.

- Patch [4] - ARM cpuidle driver
Enable ARM cpuidle driver to call runtime PM. Even though this has been done
for ARM, there is nothing architecture specific about this. Currently, all idle
states other than ARM clock gating calls into runtime PM. This could also be
state specific i.e call into runtime PM only after a certain state. The changes
may be made part of cpuidle framework, but needs discussion.

- Patches [5, 6, 7] - PM domain governor for CPUs
Introduces a new genpd governor that looks into the per-CPU tick device to
identify the next CPU wakeup and determine the available sleep time for the
domain. This along with QoS is used to determine the best idle state for the
domain. A domains' wake up is determined by the first CPU in that domain to
wake up. A coherency level domain's (parent of a domain containing CPU devices)
wake up is determined by the first CPU amongst all the CPUs to wake up.
Identifying the CPUs and their wakeups are the part of these patches.

- Patches [9, 10] - ARM64 PSCI platform driver
ARM64 PSCI v1.0 specific. PSCI OS initiated mode supports powering off CPU
clusters (caches etc, by configuring separate power controllers). These patches
enable Linux to determine if the f/w supports this mode and if so, uses CPU PM
domain helper functions to create PM domains and handles the power_on/power_off
callbacks. The resulting cluster state is passed as an argument to the f/w
along with the CPU state.

- Patches [11, 12] - DTS changes for MSM8916
QCOM 410c Dragonboard/96Board specific. Enables CPUidle and cluster idle for
this SoC. A compatible f/w (in the works) is needed for this support.

Testing and results -

This patchset has been tested on a QCOM 410c Dragonboard with a quad ARM v8 A53
CPU and 512KB L2 cache. Though not accurate, I see a ~20 mA drop in current
measured at the battery outside the SoC when the SoC idle is enabled. This
needs to be redone again to get an accurate measurement. I see about ~5 us
increase before entering idle state to determine the last man down and about
~20 us while coming out of idle (in Linux) when the cache is flushed and
powered down.

This was tested on top of 4.5-rc3. My series along with patches from Axel can
be found at [4]. Note that [5] has not been published on the ML, is needed for
this series.

Thanks,
Lina

[1]. http://comments.gmane.org/gmane.linux.ports.arm.msm/16232
[2]. http://permalink.gmane.org/gmane.linux.power-management.general/71387
[3]. http://permalink.gmane.org/gmane.linux.ports.arm.msm/17279
[4]. https://git.linaro.org/people/lina.iyer/linux-next.git/shortlog/refs/heads/genpd-psci-RFC-v3
[5]. https://git.linaro.org/people/lina.iyer/linux-next.git/commit/1dfec82c8c133b0fbcd245d739dade087a1dd1fc
[6]. https://lwn.net/Articles/675674/


Lina Iyer (12):
  PM / Domains: Abstract genpd locking
  PM / Domains: Support IRQ safe PM domains
  PM / cpu_domains: Setup PM domains for CPUs/clusters
  ARM: cpuidle: Add runtime PM support for CPUs
  timer: Export next wake up of a CPU
  PM / cpu_domains: Record CPUs that are part of the domain
  PM / cpu_domains: Add PM Domain governor for CPUs
  Documentation / cpu_domains: Describe CPU PM domains setup and
    governor
  drivers: firmware: psci: Allow OS Initiated suspend mode
  ARM64: psci: Support cluster idle states for OS-Initiated
  ARM64: dts: Add PSCI cpuidle support for MSM8916
  ARM64: dts: Define CPU power domain for MSM8916

 Documentation/power/cpu_domains.txt   |  79 ++++++++
 Documentation/power/devices.txt       |  12 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi |  49 +++++
 arch/arm64/kernel/psci.c              |  46 ++++-
 drivers/base/power/Makefile           |   1 +
 drivers/base/power/cpu_domains.c      | 365 ++++++++++++++++++++++++++++++++++
 drivers/base/power/domain.c           | 210 +++++++++++++++----
 drivers/cpuidle/cpuidle-arm.c         |  55 +++++
 drivers/firmware/psci.c               |  45 ++++-
 include/linux/cpu_domains.h           |  37 ++++
 include/linux/pm_domain.h             |  14 +-
 include/linux/psci.h                  |   2 +
 include/linux/tick.h                  |  10 +
 include/uapi/linux/psci.h             |   5 +
 kernel/time/tick-sched.c              |  13 ++
 15 files changed, 896 insertions(+), 47 deletions(-)
 create mode 100644 Documentation/power/cpu_domains.txt
 create mode 100644 drivers/base/power/cpu_domains.c
 create mode 100644 include/linux/cpu_domains.h

-- 
2.1.4
