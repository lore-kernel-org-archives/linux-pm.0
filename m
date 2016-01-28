From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 3/9] pinctrl: convert to use match_string() helper
Date: Thu, 28 Jan 2016 15:14:19 +0200
Message-ID: <1453986865-133572-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1453986865-133572-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453986865-133572-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

The new helper returns index of the mathing string in an array. We would use it
here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/pinmux.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 29984b3..c223a9e 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -334,7 +334,6 @@ int pinmux_map_to_setting(struct pinctrl_map const *map,
 	unsigned num_groups;
 	int ret;
 	const char *group;
-	int i;
 
 	if (!pmxops) {
 		dev_err(pctldev->dev, "does not support mux function\n");
@@ -363,19 +362,13 @@ int pinmux_map_to_setting(struct pinctrl_map const *map,
 		return -EINVAL;
 	}
 	if (map->data.mux.group) {
-		bool found = false;
 		group = map->data.mux.group;
-		for (i = 0; i < num_groups; i++) {
-			if (!strcmp(group, groups[i])) {
-				found = true;
-				break;
-			}
-		}
-		if (!found) {
+		ret = match_string(groups, num_groups, group);
+		if (ret < 0) {
 			dev_err(pctldev->dev,
 				"invalid group \"%s\" for function \"%s\"\n",
 				group, map->data.mux.function);
-			return -EINVAL;
+			return ret;
 		}
 	} else {
 		group = groups[0];
-- 
2.7.0.rc3
