From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH] PM / devfreq: tegra: Set freq in rate callback
Date: Thu, 21 Jan 2016 08:52:26 +0100
Message-ID: <1453362746-9310-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:37409 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492AbcAUHxf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jan 2016 02:53:35 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Tyler Baker <tyler.baker@linaro.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org

As per the documentation of the devfreq_dev_profile.target callback, set
the freq argument to the new frequency before returning.

This caused endless messages like this after recent changes in the core:

devfreq 6000c800.actmon: Couldn't update frequency transition information.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Reported-by: Tyler Baker <tyler.baker@linaro.org>
---
 drivers/devfreq/tegra-devfreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/devfreq/tegra-devfreq.c b/drivers/devfreq/tegra-devfreq.c
index 848b93ee930f..fe9dce0245bf 100644
--- a/drivers/devfreq/tegra-devfreq.c
+++ b/drivers/devfreq/tegra-devfreq.c
@@ -500,6 +500,8 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 	clk_set_min_rate(tegra->emc_clock, rate);
 	clk_set_rate(tegra->emc_clock, 0);
 
+	*freq = rate;
+
 	return 0;
 }
 
-- 
2.5.0

