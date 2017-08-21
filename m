From: Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH 2/2] cpufreq: dt: add support for rockchip rv1108
Date: Mon, 21 Aug 2017 17:10:24 +0800
Message-ID: <1503306624-28937-1-git-send-email-andy.yan@rock-chips.com>
References: <1503306404-28876-1-git-send-email-andy.yan@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503306404-28876-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, heiko@sntech.de, Andy Yan <andy.yan@rock-chips.com>
List-Id: linux-pm@vger.kernel.org

Add the compatible string to support the generic device tree
cpufreq-dt driver on rockchip rv1108 soc.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 1c26292..2d71c09 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -69,6 +69,7 @@ static const struct of_device_id machines[] __initconst = {
 	{ .compatible = "renesas,r8a7794", },
 	{ .compatible = "renesas,sh73a0", },
 
+	{ .compatible = "rockchip,rv1108", },
 	{ .compatible = "rockchip,rk2928", },
 	{ .compatible = "rockchip,rk3036", },
 	{ .compatible = "rockchip,rk3066a", },
-- 
2.7.4
