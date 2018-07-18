From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: [PATCH v1 0/3] thermal: tsens: bugfixes, cleanups
Date: Wed, 18 Jul 2018 12:55:00 +0530
Message-ID: <cover.1531898088.git.amit.kucheria@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, edubezval@gmail.com, smohanad@codeaurora.org, andy.gross@linaro.org, dianders@chromium.org, mka@chromium.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Here is another series of tsens-related bugfixes and cleanups to prepare
for IRQ support, among other things. It applies on top of another series[1]
that did some code consolidation to add support for sdm845.

[1] https://lore.kernel.org/lkml/cover.1531895128.git.amit.kucheria@linaro.org/T/#t


Amit Kucheria (3):
  thermal: tsens: Rename variable
  thermal: tsens: switch from of_iomap() to devm_ioremap_resource()
  thermal: tsens: Fix negative temperature reporting

 drivers/thermal/qcom/tsens-common.c | 19 ++++++++++---------
 drivers/thermal/qcom/tsens-v2.c     | 23 ++++++++++-------------
 2 files changed, 20 insertions(+), 22 deletions(-)

-- 
2.7.4
