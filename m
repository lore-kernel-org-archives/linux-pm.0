From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC 0/6] drivers: qcom: enable system low power modes for SDM845
Date: Sat, 25 Aug 2018 01:36:22 +0530
Message-ID: <1535141188-29731-1-git-send-email-rplsssn@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-pm@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com, rafael@kernel.org, drake@endlessm.com, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This is an attempt at a solution to perform activities necessary while entering
deeper low power modes supported by firmware for QCOM SoCs which have hardened
IP (Resource Power Manager Hardened - RPMH) for shared resource management.

The shared resources that are no longer used, when processor enters deep idle
states, can be turned off or put to lower state via sleep requests. Clients vote
for lower resource state when application processor is asleep. These votes need
to be flushed only during entry to low power modes.

In addition to this, an always-on power domain wake-up timer present in PDC
(Power Domain Controller)  needs to be programmed so that RSC is up and running
by the time CPU has to wake-up. 

The kernel does not notify that the CPU powering down is the last CPU.
Therefore, in this series, we are doing a reference count to determine the last
CPU in the system to enter idle and use that to perform the last-man activities.
It would be optimal to do this than to flush whenever a core enters idle. The
current approach can be revisited in future if OS-initiated support becomes
available that enables certain actions to be taken when last core enters deepest
low power mode.

Apart from idle sleep, the deeper low modes can be exercised in system suspend.
As it is expected that all other cores except the core entering system suspend
will be disabled during suspend operations, the device suspend calls are
utilized to perform the required tasks.

Please review these patches. Your inputs would be greatly appreciated.

Thanks,
Raju

Dependencies:

The current series depends on patches[1][2], which add RPMH communication
support, to send shared resource request votes by clients. The patches[1][2]
also provide functions that are expected to be called by sleep manager client
during low power mode entry. The other patches[3][4][5] which fix couple of
issues are also needed. Apart from RPMH related patches, the current series
depends on knowing the next wake up timer of a CPU[6] for programing the
always-on timer present in PDC.

[1]. https://lkml.org/lkml/2018/6/20/519
[2]. https://lkml.org/lkml/2018/7/27/326
[3]. https://lkml.org/lkml/2018/7/13/358 
[4]. https://lkml.org/lkml/2018/7/19/84
[5]. https://lkml.org/lkml/2018/8/24/641
[6]. https://lkml.org/lkml/2018/6/20/800

Raju P.L.S.S.S.N (6):
  drivers: qcom: system_pm: add system PM client for RPMH based SoCs
  dt-bindings: introduce System PM bindings for Qualcomm SoCs
  drivers: qcom: system_pm: Add power management ops
  drivers: qcom: system_pm: program next wakeup to PDC timer
  drivers: qcom: rpmh: force flush new sleep/wake requests during
    suspend
  drivers: soc: system_pm: Add suspend notifier

 .../devicetree/bindings/soc/qcom/system_pm.txt     |  28 ++++
 drivers/soc/qcom/Kconfig                           |  11 ++
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/rpmh-internal.h                   |   1 +
 drivers/soc/qcom/rpmh.c                            |  17 +++
 drivers/soc/qcom/system_pm.c                       | 168 +++++++++++++++++++++
 include/soc/qcom/rpmh.h                            |   5 +
 7 files changed, 231 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/system_pm.txt
 create mode 100644 drivers/soc/qcom/system_pm.c

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, hosted by The Linux Foundation.
