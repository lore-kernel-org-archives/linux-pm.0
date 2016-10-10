From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH 1/6] clk: pxa: remove unused variables
Date: Mon, 10 Oct 2016 22:09:04 +0200
Message-ID: <1476130149-31834-2-git-send-email-robert.jarzmik@free.fr>
References: <1476130149-31834-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1476130149-31834-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: linux-pm@vger.kernel.org

This is a cleanup patch to remove unused values not used in their
respective functions.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/clk/pxa/clk-pxa27x.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/pxa/clk-pxa27x.c b/drivers/clk/pxa/clk-pxa27x.c
index c40b1804f58c..afc395b4148e 100644
--- a/drivers/clk/pxa/clk-pxa27x.c
+++ b/drivers/clk/pxa/clk-pxa27x.c
@@ -221,14 +221,12 @@ static unsigned long clk_pxa27x_core_get_rate(struct clk_hw *hw,
 					      unsigned long parent_rate)
 {
 	unsigned long clkcfg;
-	unsigned int t, ht, b, osc_forced;
+	unsigned int ht, osc_forced;
 	unsigned long ccsr = readl(CCSR);
 
 	osc_forced = ccsr & (1 << CCCR_CPDIS_BIT);
 	asm("mrc\tp14, 0, %0, c6, c0, 0" : "=r" (clkcfg));
-	t  = clkcfg & (1 << 0);
 	ht = clkcfg & (1 << 2);
-	b  = clkcfg & (1 << 3);
 
 	if (osc_forced)
 		return parent_rate;
@@ -241,7 +239,7 @@ static unsigned long clk_pxa27x_core_get_rate(struct clk_hw *hw,
 static u8 clk_pxa27x_core_get_parent(struct clk_hw *hw)
 {
 	unsigned long clkcfg;
-	unsigned int t, ht, b, osc_forced;
+	unsigned int t, ht, osc_forced;
 	unsigned long ccsr = readl(CCSR);
 
 	osc_forced = ccsr & (1 << CCCR_CPDIS_BIT);
@@ -251,7 +249,6 @@ static u8 clk_pxa27x_core_get_parent(struct clk_hw *hw)
 	asm("mrc\tp14, 0, %0, c6, c0, 0" : "=r" (clkcfg));
 	t  = clkcfg & (1 << 0);
 	ht = clkcfg & (1 << 2);
-	b  = clkcfg & (1 << 3);
 
 	if (ht || t)
 		return PXA_CORE_TURBO;
-- 
2.1.4

