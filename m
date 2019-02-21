From: "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Subject: [PATCH RESEND v3 0/3] add some more functionality to RPMH
Date: Thu, 21 Feb 2019 17:48:24 +0530
Message-ID: <20190221121827.32427-1-rplsssn@codeaurora.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Cc: rnayak@codeaurora.org, bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, sboyd@kernel.org, evgreen@chromium.org, dianders@chromium.org, mka@chromium.org, ilina@codeaurora.org, "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Resending the patches. Kindly review.

Changes in v3:
 - Simplify TCS locking - added a new patch
 - Add lock check to avoid potential race as suggested by Matthias
 - Add functionality to RSC controller to disallow active requests
   if solver mode is not set 
 - Removed independent patches and posted as separate series[2]

Changes in v2:
 - Remove unnecessary EXPORT_SYMBOL in rpmh-rsc

This set of patches add additional functionality to RPMH drivers[1].

PM drivers can choose to disallow idle modes when RSC controller is busy
sending or processing requests. The patches add necessary functions to
query the controller status.

The controllers may be in 'solver' state, where they could be in autonomous
mode executing low power modes for their hardware and as such are not
available for sending active votes. Functionality to get notified about
such state and disallow requests for state change in that case is added
in these patches.

Please consider reviewing this patchset.

This series is based on other patchset[2] 


v1:https://lkml.org/lkml/2018/7/19/213
v2:https://patchwork.kernel.org/cover/10546863/


[1] https://lkml.org/lkml/2018/6/20/519
[2] https://lkml.org/lkml/2019/2/18/714


Lina Iyer (2):
  drivers: qcom: rpmh-rsc: return if the controller is idle
  drivers: qcom: rpmh: disallow active requests in solver mode

Raju P.L.S.S.S.N (1):
  drivers: qcom: rpmh-rsc: simplify TCS locking

 drivers/soc/qcom/rpmh-internal.h |  8 ++-
 drivers/soc/qcom/rpmh-rsc.c      | 91 +++++++++++++++++++++++---------
 drivers/soc/qcom/rpmh.c          | 84 ++++++++++++++++++++++++-----
 include/soc/qcom/rpmh.h          | 10 ++++
 4 files changed, 155 insertions(+), 38 deletions(-)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of the Code Aurora Forum, hosted by The Linux Foundation.
