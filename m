From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RFC 0/5] Add support for PDC timer for wake-ups
Date: Fri, 21 Dec 2018 17:29:41 +0530
Message-ID: <20181221115946.10095-1-rplsssn@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

RPMH based targets require that the next wake-up timer value needs
to be programmed to PDC (Power Domain Controller) which has its
own timer and is in an always on power domain. PDC wakes-up
the RSC and sets up the resources back in active state before the
processor is woken up by a timer interrupt. In order to query next
timer wake-up, the patch-set depends on patch - Export next wakeup
time of a CPU[1].

The kernel does not notify that the CPU powering down is the last
CPU. So in this version, next wake-up is programmed to PDC each time
when a CPU goes to power collapse. The current approach can be
revisited in future if OS-initiated support becomes available that
enables certain actions to be taken when last core enters deepest low
power mode.

Please review these patches. Your inputs would be greatly appreciated.

Thanks,
Raju.

Dependencies:
 [1].https://lore.kernel.org/patchwork/patch/1019432/

Raju P.L.S.S.S.N (5):
  drivers: qcom: rpmh-rsc: Add regmap for RSC controller
  drivers: qcom: rpmh-pdc-timer: add PDC timer support for RPMH based
    SoCs
  dt-bindings: Add PDC timer bindings for Qualcomm SoCs
  drivers: qcom: rpmh-pdc-timer: Add power management ops
  arm64: dts: msm: add PDC timer for apps_rsc for SDM845

 .../devicetree/bindings/soc/qcom/rpmh-rsc.txt |  29 +++
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   9 +
 drivers/soc/qcom/Kconfig                      |   9 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/rpmh-pdc-timer.c             | 205 ++++++++++++++++++
 drivers/soc/qcom/rpmh-rsc.c                   |  14 ++
 6 files changed, 267 insertions(+)
 create mode 100644 drivers/soc/qcom/rpmh-pdc-timer.c

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.
