From: Chander Kashyap <chander.kashyap@linaro.org>
Subject: [PATCH v5 1/6] driver: cpuidle-big-little: add of_device_id structure
Date: Wed, 14 May 2014 13:33:52 +0530
Message-ID: <1400054637-21505-2-git-send-email-chander.kashyap@linaro.org>
References: <ANuQgHGSPJ45tbrVppAVpOqF0OfHacPWfX=S5mOVxTPr66f7vg@mail.gmail.com>
 <1400054637-21505-1-git-send-email-chander.kashyap@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f52.google.com ([209.85.160.52]:61427 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752981AbaENIET (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 May 2014 04:04:19 -0400
Received: by mail-pb0-f52.google.com with SMTP id rr13so1378759pbb.25
        for <linux-pm@vger.kernel.org>; Wed, 14 May 2014 01:04:19 -0700 (PDT)
In-Reply-To: <1400054637-21505-1-git-send-email-chander.kashyap@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: daniel.lezcano@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, kgene.kim@samsung.com, Chander Kashyap <chander.kashyap@linaro.org>, Chander Kashyap <k.chander@samsung.com>

This driver will be used by many big.Little Soc's. As of now it does
string matching of hardcoded compatible string to init the driver. This
comparison list will keep on growing with addition of new SoC's.
Hence add of_device_id structure to collect the compatible strings of
SoC's using this driver.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
Signed-off-by: Chander Kashyap <k.chander@samsung.com>
---
 drivers/cpuidle/cpuidle-big_little.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-big_little.c b/drivers/cpuidle/cpuidle-big_little.c
index b45fc62..4cd02bd 100644
--- a/drivers/cpuidle/cpuidle-big_little.c
+++ b/drivers/cpuidle/cpuidle-big_little.c
@@ -163,14 +163,23 @@ static int __init bl_idle_driver_init(struct cpuidle_driver *drv, int cpu_id)
 	return 0;
 }
 
+static const struct of_device_id compatible_machine_match[] = {
+	{ .compatible = "arm,vexpress,v2p-ca15_a7" },
+	{},
+};
+
 static int __init bl_idle_init(void)
 {
 	int ret;
+	struct device_node *root = of_find_node_by_path("/");
+
+	if (!root)
+		return -ENODEV;
 
 	/*
 	 * Initialize the driver just for a compliant set of machines
 	 */
-	if (!of_machine_is_compatible("arm,vexpress,v2p-ca15_a7"))
+	if (!of_match_node(compatible_machine_match, root))
 		return -ENODEV;
 	/*
 	 * For now the differentiation between little and big cores
-- 
1.7.9.5

