From: <cl@rock-chips.com>
Subject: [PATCH v1 2/3] cpufreq: rockchip: add support for rk3328 soc
Date: Wed, 23 Aug 2017 16:40:31 +0800
Message-ID: <1503477632-9661-3-git-send-email-cl@rock-chips.com>
References: <1503477632-9661-1-git-send-email-cl@rock-chips.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.137]:54956 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753501AbdHWIgS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Aug 2017 04:36:18 -0400
In-Reply-To: <1503477632-9661-1-git-send-email-cl@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: heiko@sntech.de
Cc: robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, shawnguo@kernel.org, rocky.hao@rock-chips.com, afaerber@suse.de, fabio.estevam@nxp.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, kever.yang@rock-chips.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, Liang Chen <cl@rock-chips.com>

From: Liang Chen <cl@rock-chips.com>

Add compatible rockchip,rk3328 to the machines table to
launch cpufreq-dt driver for rk3328 soc.

Signed-off-by: Liang Chen <cl@rock-chips.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 1c26292..f16c3ba 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -76,6 +76,7 @@
 	{ .compatible = "rockchip,rk3188", },
 	{ .compatible = "rockchip,rk3228", },
 	{ .compatible = "rockchip,rk3288", },
+	{ .compatible = "rockchip,rk3328", },
 	{ .compatible = "rockchip,rk3366", },
 	{ .compatible = "rockchip,rk3368", },
 	{ .compatible = "rockchip,rk3399", },
-- 
1.9.1
