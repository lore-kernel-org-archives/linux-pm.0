From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v1 0/2] drivers/qcom/rpmh: program wakeup timer
Date: Wed,  3 Oct 2018 15:26:33 +0530
Message-ID: <1538560595-6275-1-git-send-email-rplsssn@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

The patches in this series were reviewed as part of "add additional
functionality to RPMH"[1]. These patches are independent of other
patches in the original series.

Changes done:
  - Minor update to commit text for first patch[2].
  - squashed two related "write PDC" patches[3][4] into single patch.

Please consider reviewing this patch set.

[1] https://patchwork.kernel.org/cover/10546863/
[2] https://patchwork.kernel.org/patch/10546859/
[3] https://patchwork.kernel.org/patch/10546855/
[4] https://patchwork.kernel.org/patch/10546857/

This series is based on https://patchwork.kernel.org/patch/10589385/

Lina Iyer (1):
  drivers: qcom: rpmh: write PDC data

Raju P.L.S.S.S.N (1):
  drivers: qcom: rpmh-rsc: clear active mode configuration for wake TCS

 drivers/soc/qcom/rpmh-internal.h |   4 +-
 drivers/soc/qcom/rpmh-rsc.c      | 112 +++++++++++++++++++++++++++++----------
 drivers/soc/qcom/rpmh.c          |  28 ++++++++++
 include/soc/qcom/rpmh.h          |   7 +++
 4 files changed, 121 insertions(+), 30 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.
