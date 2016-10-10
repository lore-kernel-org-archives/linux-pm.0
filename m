From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH 2/6] clk: pxa: core pll is not affected by t bit
Date: Mon, 10 Oct 2016 22:09:05 +0200
Message-ID: <1476130149-31834-3-git-send-email-robert.jarzmik@free.fr>
References: <1476130149-31834-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:59378 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752078AbcJJUJt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2016 16:09:49 -0400
In-Reply-To: <1476130149-31834-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>

The t bit of clkfcfg doesn't affect the core pll clock, but it makes core
clock select between core pll clock and core run clock.

As such remove it from the core pll rate reporting function, while it
remains in clk_pxa27x_core_get_parent().

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/clk/pxa/clk-pxa25x.c | 4 +---
 drivers/clk/pxa/clk-pxa27x.c | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/pxa/clk-pxa25x.c b/drivers/clk/pxa/clk-pxa25x.c
index a98b98e2a9e4..3bb603a27f2b 100644
--- a/drivers/clk/pxa/clk-pxa25x.c
+++ b/drivers/clk/pxa/clk-pxa25x.c
@@ -182,9 +182,7 @@ static unsigned long clk_pxa25x_cpll_get_rate(struct clk_hw *hw,
 	m = M_clk_mult[(cccr >> 5) & 0x03];
 	n2 = N2_clk_mult[(cccr >> 7) & 0x07];
 
-	if (t)
-		return m * l * n2 * parent_rate / 2;
-	return m * l * parent_rate;
+	return m * l * n2 * parent_rate / 2;
 }
 PARENTS(clk_pxa25x_cpll) = { "osc_3_6864mhz" };
 RATE_RO_OPS(clk_pxa25x_cpll, "cpll");
diff --git a/drivers/clk/pxa/clk-pxa27x.c b/drivers/clk/pxa/clk-pxa27x.c
index afc395b4148e..3930053543a3 100644
--- a/drivers/clk/pxa/clk-pxa27x.c
+++ b/drivers/clk/pxa/clk-pxa27x.c
@@ -162,7 +162,7 @@ static unsigned long clk_pxa27x_cpll_get_rate(struct clk_hw *hw,
 	L  = l * parent_rate;
 	N  = (L * n2) / 2;
 
-	return t ? N : L;
+	return N;
 }
 PARENTS(clk_pxa27x_cpll) = { "osc_13mhz" };
 RATE_RO_OPS(clk_pxa27x_cpll, "cpll");
-- 
2.1.4

