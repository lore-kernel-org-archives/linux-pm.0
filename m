From: Mason <slash.tmp@free.fr>
Subject: [PATCH] cpufreq: tango: Use generic platdev driver
Date: Mon, 2 May 2016 15:39:25 +0200
Message-ID: <5727588D.5090105@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:21511 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753704AbcEBNjn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 May 2016 09:39:43 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm <linux-pm@vger.kernel.org>, arm-soc <arm@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Sebastian Frias <sf84@laposte.net>

From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

Add tango4 compatible string to the list.

Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index ac4a0ba87c12..3646b143bbf5 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -66,6 +66,8 @@ static const struct of_device_id machines[] __initconst = {
 	{ .compatible = "rockchip,rk3368", },
 	{ .compatible = "rockchip,rk3399", },
 
+	{ .compatible = "sigma,tango4" },
+
 	{ .compatible = "ti,omap2", },
 	{ .compatible = "ti,omap3", },
 	{ .compatible = "ti,omap4", },
-- 
2.8.1
