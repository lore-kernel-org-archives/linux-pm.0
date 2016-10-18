From: Stephen Boyd <stephen.boyd@linaro.org>
Subject: [PATCH v5 0/2] qcom OTG regulator support
Date: Mon, 17 Oct 2016 17:42:49 -0700
Message-ID: <20161018004251.28733-1-stephen.boyd@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, "Bird, Tim" <tim.bird@sonymobile.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Andy Gross <andy.gross@linaro.org>
List-Id: linux-pm@vger.kernel.org

This is a resend/resurrection of Tim's patches to add support
for the OTG regulator on some of qcom's PMICs[1]. I've made
some minor modifications to the driver to make it work, but
otherwise it works fine with my USB otg testing. Changes
are noted in a maintainer tag.

Tim, did you want to me to fix the name? I pulled these from patchwork
and it seems you sent it as "Bird, Tim" which may have not been 
intentional.

https://patchwork.kernel.org/patch/7857021/

Bird, Tim (2):
  dt-binding: power: Add otg regulator binding
  power: qcom_smbb: Add otg regulator for control of vbus

 .../devicetree/bindings/power/supply/qcom_smbb.txt | 19 ++++++
 drivers/power/supply/qcom_smbb.c                   | 70 ++++++++++++++++++++++
 2 files changed, 89 insertions(+)

-- 
2.10.0.297.gf6727b0
