From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 4/6] power: supply: charger-manager: Make code more readable
Date: Fri, 16 Nov 2018 19:01:11 +0800
Message-ID: <12b1b583c3da503be4ad7bed01e7b07a0a2b2126.1542362262.git.baolin.wang@linaro.org>
References: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
In-Reply-To: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
References: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org, linus.walleij@linaro.org
List-Id: linux-pm@vger.kernel.org

Make code more readable.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/charger-manager.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index a52bc77..dc0c9a6 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -1520,19 +1520,19 @@ static struct charger_desc *of_cm_parse_desc(struct device *dev)
 	/* chargers */
 	of_property_read_u32(np, "cm-num-chargers", &num_chgs);
 	if (num_chgs) {
+		int i;
+
 		/* Allocate empty bin at the tail of array */
 		desc->psy_charger_stat = devm_kcalloc(dev,
 						      num_chgs + 1,
 						      sizeof(char *),
 						      GFP_KERNEL);
-		if (desc->psy_charger_stat) {
-			int i;
-			for (i = 0; i < num_chgs; i++)
-				of_property_read_string_index(np, "cm-chargers",
-						i, &desc->psy_charger_stat[i]);
-		} else {
+		if (!desc->psy_charger_stat)
 			return ERR_PTR(-ENOMEM);
-		}
+
+		for (i = 0; i < num_chgs; i++)
+			of_property_read_string_index(np, "cm-chargers",
+						      i, &desc->psy_charger_stat[i]);
 	}
 
 	of_property_read_string(np, "cm-fuel-gauge", &desc->psy_fuel_gauge);
-- 
1.7.9.5
