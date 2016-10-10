From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH 3/6] clk: pxa: b bit of clkcfg means fast bus
Date: Mon, 10 Oct 2016 22:09:06 +0200
Message-ID: <1476130149-31834-4-git-send-email-robert.jarzmik@free.fr>
References: <1476130149-31834-1-git-send-email-robert.jarzmik@free.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1476130149-31834-1-git-send-email-robert.jarzmik@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>
List-Id: linux-pm@vger.kernel.org

The meaning of this bit was inverted :
 - when set to 0, system bus clock is half of the CPU run clock
 - when set to 1, system bus clock is the CPU run clock

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 drivers/clk/pxa/clk-pxa27x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/pxa/clk-pxa27x.c b/drivers/clk/pxa/clk-pxa27x.c
index 3930053543a3..3b36e8d0f81e 100644
--- a/drivers/clk/pxa/clk-pxa27x.c
+++ b/drivers/clk/pxa/clk-pxa27x.c
@@ -291,9 +291,9 @@ static unsigned long clk_pxa27x_system_bus_get_rate(struct clk_hw *hw,
 	if (osc_forced)
 		return parent_rate;
 	if (b)
-		return parent_rate / 2;
-	else
 		return parent_rate;
+	else
+		return parent_rate / 2;
 }
 
 static u8 clk_pxa27x_system_bus_get_parent(struct clk_hw *hw)
-- 
2.1.4
