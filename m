From: Rob Herring <robh@kernel.org>
Subject: [PATCH] power/reset: Convert to using %pOF instead of full_name
Date: Tue, 18 Jul 2017 16:43:24 -0500
Message-ID: <20170718214339.7774-44-robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Now that we have a custom printf format specifier, convert users of
full_name to use %pOF instead. This is preparation to remove storing
of the full path string for each node.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
---
 drivers/power/reset/at91-sama5d2_shdwc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/reset/at91-sama5d2_shdwc.c b/drivers/power/reset/at91-sama5d2_shdwc.c
index 55fce8b75245..31080c254124 100644
--- a/drivers/power/reset/at91-sama5d2_shdwc.c
+++ b/drivers/power/reset/at91-sama5d2_shdwc.c
@@ -171,8 +171,8 @@ static u32 at91_shdwc_get_wakeup_input(struct platform_device *pdev,

 	for_each_child_of_node(np, cnp) {
 		if (of_property_read_u32(cnp, "reg", &wk_input)) {
-			dev_warn(&pdev->dev, "reg property is missing for %s\n",
-				 cnp->full_name);
+			dev_warn(&pdev->dev, "reg property is missing for %pOF\n",
+				 cnp);
 			continue;
 		}

--
2.11.0
