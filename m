From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [RFC PATCH 5/5] net: macb: Use clk_round_rate_nearest() API
Date: Wed, 14 May 2014 15:30:55 -0700
Message-ID: <1400106655-22465-6-git-send-email-soren.brinkmann@xilinx.com>
References: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:35813 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754059AbaENWdR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 May 2014 18:33:17 -0400
In-Reply-To: <1400106655-22465-1-git-send-email-soren.brinkmann@xilinx.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Russell King <linux@arm.linux.org.uk>
Cc: Michal Simek <michal.simek@xilinx.com>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Soren Brinkmann <soren.brinkmann@xilinx.com>

The current way of rounding clock frequencies always rounds down and
doesn't allow deviations above the requested frequency. For the Ethernet
case though, it is more important to minimize deviations than not
exceeding the requested frequency.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---

---
 drivers/net/ethernet/cadence/macb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb.c b/drivers/net/ethernet/cadence/macb.c
index e9daa072ebb4..4fdbfcbc38bc 100644
--- a/drivers/net/ethernet/cadence/macb.c
+++ b/drivers/net/ethernet/cadence/macb.c
@@ -223,7 +223,7 @@ static void macb_set_tx_clk(struct clk *clk, int speed, struct net_device *dev)
 		return;
 	}
 
-	rate_rounded = clk_round_rate(clk, rate);
+	rate_rounded = clk_round_rate_nearest(clk, rate);
 	if (rate_rounded < 0)
 		return;
 
-- 
1.9.3.1.ga73a6ad

