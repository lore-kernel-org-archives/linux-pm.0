From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 1/2] cpufreq: mvebu: Free the clock reference in the normal path
Date: Wed, 13 Dec 2017 18:29:13 +0100
Message-ID: <20171213172914.6148-2-gregory.clement@free-electrons.com>
References: <20171213172914.6148-1-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:42548 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753406AbdLMR3Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Dec 2017 12:29:25 -0500
In-Reply-To: <20171213172914.6148-1-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@free-electrons.com>

In case of error the clock reference was freed but not in normal path
once it was nor more used. This patch fixes it.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/cpufreq/mvebu-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/mvebu-cpufreq.c b/drivers/cpufreq/mvebu-cpufreq.c
index ed915ee85dd9..c043aad8e3a0 100644
--- a/drivers/cpufreq/mvebu-cpufreq.c
+++ b/drivers/cpufreq/mvebu-cpufreq.c
@@ -99,6 +99,7 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
 		if (ret)
 			dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n",
 				__func__, ret);
+		clk_put(clk);
 	}
 
 	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
-- 
2.15.1
