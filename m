From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC] drivers: sh: Handle PM_GENERIC_DOMAINS_OF=n with new r8a7795 CPG/MSSR driver
Date: Thu, 29 Oct 2015 12:25:14 +0100
Message-ID: <1446117914-6392-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>, Magnus Damm <damm+renesas@opensource.se>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-pm@vger.kernel.org

If CONFIG_PM=n (and thus PM_GENERIC_DOMAINS_OF=n), the CPG/MSSR driver
doesn't install its Clock Domain. Make sure the needed module clocks are
still enabled by using the Legacy Clock Domain.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
I'd be happy to make CONFIG_PM=y mandatory for new SoCs/DTS, so we can
drop this patch.

Thoughts?

For your convenience, I have push this patch to the
topic/r8a7795-drivers-sh-v1 branch of my renesas-drivers repository.  A
full integration for R-Car Gen3 is available in the topic/gen3-latest
branch.
---
 drivers/sh/pm_runtime.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/sh/pm_runtime.c b/drivers/sh/pm_runtime.c
index 91a003011acfacb2..5eeed1db1bb3f9d8 100644
--- a/drivers/sh/pm_runtime.c
+++ b/drivers/sh/pm_runtime.c
@@ -32,17 +32,26 @@ static struct pm_clk_notifier_block platform_bus_notifier = {
 	.con_ids = { NULL, },
 };
 
+static const struct of_device_id clk_domain_matches[] = {
+	{ .compatible = "renesas,cpg-mstp-clocks", },
+	{ .compatible = "renesas,r8a7795-cpg-mssr", },
+	{ /* sentinel */ }
+};
+
 static int __init sh_pm_runtime_init(void)
 {
 	if (IS_ENABLED(CONFIG_ARCH_SHMOBILE)) {
-		if (!of_find_compatible_node(NULL, NULL,
-					     "renesas,cpg-mstp-clocks"))
+		if (!of_find_matching_node(NULL, clk_domain_matches))
 			return 0;
+
 		if (IS_ENABLED(CONFIG_PM_GENERIC_DOMAINS_OF) &&
-		    of_find_node_with_property(NULL, "#power-domain-cells"))
+		    of_find_node_with_property(NULL, "#power-domain-cells")) {
+			pr_debug("Using DT Clock Domain\n");
 			return 0;
+		}
 	}
 
+	pr_debug("Using Legacy Clock Domain\n");
 	pm_clk_add_notifier(&platform_bus_type, &platform_bus_notifier);
 	return 0;
 }
-- 
1.9.1

