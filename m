From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH v1 0/2] drivers: qcom: Fixes in RPMh driver
Date: Thu, 21 Feb 2019 18:10:34 +0530
Message-ID: <20190221124036.30535-1-rplsssn@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Hi,

This series consists of couple of fixes identified in RPMh driver.
Please consider reviewing the patches.


Maulik Shah (1):
  drivers: soc: qcom: rpmh-rsc: Correct check for slot number

Raju P.L.S.S.S.N (1):
  drivers: qcom: rpmh: avoid sending sleep/wake sets immediately

 drivers/soc/qcom/rpmh-rsc.c | 2 +-
 drivers/soc/qcom/rpmh.c     | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.
