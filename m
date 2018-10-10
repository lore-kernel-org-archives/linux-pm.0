From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC v1 0/8] drivers: qcom: Add cpu power domain  for SDM845
Date: Thu, 11 Oct 2018 02:50:47 +0530
Message-ID: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, rjw@rjwysocki.net, ulf.hansson@linaro.org, khilman@kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Changes in v2:
 - Create a cpu pm domain for CPUs based on Ulf Hansson's patches[5][6].
   The reference count to determine the last CPU in the system to enter
   low power mode would be taken care by genpd. The domain power off
   callback is used to perform the last-man activities.

Please note: the first three patches in this series  are taken from Ulf
Hansoon's series[8] and included here for context and completeness of
present series. They would be merged as part of their series[8].

Hi,

This is an attempt at a solution to perform activities necessary while
entering deeper low power modes supported by firmware for QCOM SoCs which
have hardened IP (Resource Power Manager Hardened - RPMH) for shared
resource management.

The shared resources that are no longer used, when processor enters deep
idle states, can be turned off or put to lower state via sleep requests.
Clients vote for lower resource state when application processor is asleep.
These votes need to be flushed only during entry to low power modes.

In addition to this, an always-on power domain wake-up timer present in PDC
(Power Domain Controller)  needs to be programmed so that RSC is up and
running by the time CPU has to wake-up. 

The kernel does not notify that the CPU powering down is the last CPU.
Therefore, in this version, we are using genpd framework based on Ulf
Hansoon's approach for reference counting to determine the last CPU in
the system to enter idle and use that to perform the last-man activities.
It would be optimal to do this than to flush whenever a core enters idle.
The current approach can be revisited in future if OS-initiated support
becomes available that enables certain actions to be taken when last core
enters deepest low power mode.

Please review these patches. Your inputs would be greatly appreciated.

Thanks,
Raju

---
Dependencies:

The current series depends on patches[1][2][3][4], which add RPMH
communication support, to send shared resource request votes by clients.
The patches[1][2][3][4] also provide functions that are expected to be
called by domain manager during low power mode entry. Apart from RPMH
related patches, the current series depends on attaching CPU devices to
genpd framework[5][6] & knowing the next wake up timer of a CPU[7] for
programing the always-on timer present in PDC


[1]. https://patchwork.kernel.org/patch/10589385/
[2]. https://patchwork.kernel.org/patch/10575721/
[3]. https://patchwork.kernel.org/project/linux-arm-msm/list/?series=26079
[4]. https://patchwork.kernel.org/project/linux-arm-msm/list/?series=28381
[5]. https://patchwork.kernel.org/patch/10478167/
[6]. https://patchwork.kernel.org/patch/10478153/
[7]. https://patchwork.kernel.org/patch/10478021/
[8]. https://lkml.org/lkml/2018/6/20/807

Lina Iyer (1):
  timer: Export next wakeup time of a CPU

Raju P.L.S.S.S.N (5):
  drivers: qcom: cpu_pd: add cpu power domain support using genpd
  dt-bindings: introduce cpu power domain bindings for Qualcomm SoCs
  drivers: qcom: cpu_pd: program next wakeup to PDC timer
  drivers: qcom: cpu_pd: Handle cpu hotplug in the domain
  arm64: dtsi: sdm845: Add cpu power domain support

Ulf Hansson (2):
  PM / Domains: Add helper functions to attach/detach CPUs to/from genpd
  kernel/cpu_pm: Manage runtime PM in the idle path for CPUs

 .../bindings/soc/qcom/cpu_power_domain.txt         |  39 ++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |  13 ++
 drivers/base/power/domain.c                        |  70 ++++++++
 drivers/soc/qcom/Kconfig                           |   9 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/cpu_pd.c                          | 200 +++++++++++++++++++++
 include/linux/cpuhotplug.h                         |   1 +
 include/linux/pm_domain.h                          |   9 +
 include/linux/tick.h                               |   8 +
 kernel/cpu_pm.c                                    |  11 ++
 kernel/time/tick-sched.c                           |  10 ++
 11 files changed, 371 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/cpu_power_domain.txt
 create mode 100644 drivers/soc/qcom/cpu_pd.c

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.
