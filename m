From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH v3 1/4] cpufreq: pxa: use generic platdev driver for device-tree
Date: Mon, 31 Oct 2016 20:54:53 +0100
Message-ID: <1477943696-23477-2-git-send-email-robert.jarzmik@free.fr>
References: <1477943696-23477-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477943696-23477-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rafael J Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

For device-tree based pxa25x and pxa27x platforms, cpufreq-dt driver is
doing the job as well as pxa2xx-cpufreq, so add these platforms to the
compatibility list.

This won't work for legacy non device-tree platforms where
pxa2xx-cpufreq is still required.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 71267626456b..bc683d6feca8 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -34,6 +34,8 @@ static const struct of_device_id machines[] __initconst = {
 	{ .compatible = "fsl,imx7d", },
 
 	{ .compatible = "marvell,berlin", },
+	{ .compatible = "marvell,pxa250", },
+	{ .compatible = "marvell,pxa270", },
 
 	{ .compatible = "samsung,exynos3250", },
 	{ .compatible = "samsung,exynos4210", },
-- 
2.1.4
