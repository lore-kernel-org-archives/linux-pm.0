From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 13/14] clk: shmobile: mstp: Consider "zb_clk" suitable for power management
Date: Thu, 28 May 2015 20:53:38 +0200
Message-ID: <1432839219-475-14-git-send-email-geert+renesas@glider.be>
References: <1432839219-475-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1432839219-475-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

Currently the CPG Clock Domain code looks for MSTP clocks to power
manage a device.

Unfortunately, on R-Mobile APE6 (r8a73a4) and SH-Mobile AG5 (sh73a0),
the Bus State Controller (BSC) is not power-managed by an MSTP clock,
but by a plain CPG clock (zb_clk).  Add a special case to handle this,
so the clock is properly managed, and devices connected to the BSC work
as expected.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 drivers/clk/shmobile/clk-mstp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/shmobile/clk-mstp.c b/drivers/clk/shmobile/clk-mstp.c
index 619f3eccefd4884f..19e2b11953383587 100644
--- a/drivers/clk/shmobile/clk-mstp.c
+++ b/drivers/clk/shmobile/clk-mstp.c
@@ -258,6 +258,10 @@ int cpg_mstp_attach_dev(struct generic_pm_domain *domain, struct device *dev)
 					    "renesas,cpg-mstp-clocks"))
 			goto found;
 
+		/* BSC on r8a73a4/sh73a0 uses zb_clk instead of an mstp clock*/
+		if (!strcmp(clkspec.np->name, "zb_clk"))
+			goto found;
+
 		of_node_put(clkspec.np);
 		i++;
 	}
-- 
1.9.1

