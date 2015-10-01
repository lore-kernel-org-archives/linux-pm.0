From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH v2 0/2] Make oxili GDSC parent of oxili_cx GDSC
Date: Thu,  1 Oct 2015 12:22:52 -0700
Message-ID: <1443727374-1539-1-git-send-email-sboyd@codeaurora.org>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@gmail.com>, Rajendra Nayak <rnayak@codeaurora.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

I'd like to take these patches through clk tree for v4.4, so PM
maintainers please ack patch 1.

Changes from v1:
 * New patch to export symbols
 * Remove subdomain on driver remove

Cc: Rob Clark <robdclark@gmail.com>
Cc: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

Stephen Boyd (2):
  PM / Domains: Make pm_genpd_{add,remove}_subdomain() available to
    modules
  clk: qcom: Make oxili GDSC parent of oxili_cx GDSC

 drivers/base/power/domain.c     |  2 ++
 drivers/clk/qcom/mmcc-msm8974.c | 11 ++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

