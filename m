From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH 4/6] clk: pxa: export core clocks
Date: Mon, 10 Oct 2016 22:09:07 +0200
Message-ID: <1476130149-31834-5-git-send-email-robert.jarzmik@free.fr>
References: <1476130149-31834-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp10.smtpout.orange.fr ([80.12.242.132]:53357 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751488AbcJJUQy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2016 16:16:54 -0400
In-Reply-To: <1476130149-31834-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>

pxaxxx_get_clk_frequency_khz() needs several clocks to be available
through clk_get(), ie. the cpu clocks, system bus clock and memory
clocks.

Add the missing clkdev so that their rate can be acquired.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/clk/pxa/clk-pxa25x.c |  9 ++++++---
 drivers/clk/pxa/clk-pxa27x.c | 13 ++++++++-----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/pxa/clk-pxa25x.c b/drivers/clk/pxa/clk-pxa25x.c
index 3bb603a27f2b..6a3009eec830 100644
--- a/drivers/clk/pxa/clk-pxa25x.c
+++ b/drivers/clk/pxa/clk-pxa25x.c
@@ -189,8 +189,10 @@ RATE_RO_OPS(clk_pxa25x_cpll, "cpll");
 
 static void __init pxa25x_register_core(void)
 {
-	clk_register_clk_pxa25x_cpll();
-	clk_register_clk_pxa25x_run();
+	clkdev_pxa_register(CLK_NONE, "cpll", NULL,
+			    clk_register_clk_pxa25x_cpll());
+	clkdev_pxa_register(CLK_NONE, "run", NULL,
+			    clk_register_clk_pxa25x_run());
 	clkdev_pxa_register(CLK_CORE, "core", NULL,
 			    clk_register_clk_pxa25x_core());
 }
@@ -212,7 +214,8 @@ static void __init pxa25x_base_clocks_init(void)
 {
 	pxa25x_register_plls();
 	pxa25x_register_core();
-	clk_register_clk_pxa25x_memory();
+	clkdev_pxa_register(CLK_NONE, "system_bus", NULL,
+			    clk_register_clk_pxa25x_memory());
 }
 
 #define DUMMY_CLK(_con_id, _dev_id, _parent) \
diff --git a/drivers/clk/pxa/clk-pxa27x.c b/drivers/clk/pxa/clk-pxa27x.c
index 3b36e8d0f81e..9fb40e884999 100644
--- a/drivers/clk/pxa/clk-pxa27x.c
+++ b/drivers/clk/pxa/clk-pxa27x.c
@@ -270,9 +270,10 @@ RATE_RO_OPS(clk_pxa27x_run, "run");
 
 static void __init pxa27x_register_core(void)
 {
-	clk_register_clk_pxa27x_cpll();
-	clk_register_clk_pxa27x_run();
-
+	clkdev_pxa_register(CLK_NONE, "cpll", NULL,
+			    clk_register_clk_pxa27x_cpll());
+	clkdev_pxa_register(CLK_NONE, "run", NULL,
+			    clk_register_clk_pxa27x_run());
 	clkdev_pxa_register(CLK_CORE, "core", NULL,
 			    clk_register_clk_pxa27x_core());
 }
@@ -382,8 +383,10 @@ static void __init pxa27x_base_clocks_init(void)
 {
 	pxa27x_register_plls();
 	pxa27x_register_core();
-	clk_register_clk_pxa27x_system_bus();
-	clk_register_clk_pxa27x_memory();
+	clkdev_pxa_register(CLK_NONE, "system_bus", NULL,
+			    clk_register_clk_pxa27x_system_bus());
+	clkdev_pxa_register(CLK_NONE, "memory", NULL,
+			    clk_register_clk_pxa27x_memory());
 	clk_register_clk_pxa27x_lcd_base();
 }
 
-- 
2.1.4

