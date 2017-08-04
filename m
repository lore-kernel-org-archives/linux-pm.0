From: Finley Xiao <finley.xiao@rock-chips.com>
Subject: [PATCH] cpufreq: dt: Add rk3328 compatible to use generic cpufreq driver
Date: Fri,  4 Aug 2017 09:52:31 +0800
Message-ID: <1501811551-39168-1-git-send-email-finley.xiao@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.140]:33375 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751916AbdHDByv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Aug 2017 21:54:51 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: heiko@sntech.de, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, jay.xu@rock-chips.com, huangtao@rock-chips.coms, tony.xie@rock-chips.com, cl@rock-chips.com, Finley Xiao <finley.xiao@rock-chips.com>

This patch adds the rk3328 compatible string for supporting
the generic cpufreq driver on RK3328.

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 096aea7..13c0c47 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -76,6 +76,7 @@ static const struct of_device_id machines[] __initconst = {
 	{ .compatible = "rockchip,rk3188", },
 	{ .compatible = "rockchip,rk3228", },
 	{ .compatible = "rockchip,rk3288", },
+	{ .compatible = "rockchip,rk3328", },
 	{ .compatible = "rockchip,rk3366", },
 	{ .compatible = "rockchip,rk3368", },
 	{ .compatible = "rockchip,rk3399", },
-- 
2.7.4
