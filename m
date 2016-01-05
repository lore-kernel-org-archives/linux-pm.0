From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] PM / OPP: Use snprintf() instead of sprintf()
Date: Tue,  5 Jan 2016 16:15:54 +0530
Message-ID: <dd64d12079ec788d337b17840e54f0fc60d3b8ce.1451990751.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar <vireshk@kernel.org>
List-Id: linux-pm@vger.kernel.org

sprintf() can access memory outside of the range of the character array,
and is risky in some situations. The driver specified prop_name string
can be longer than NAME_MAX here (only an attacker will do that though)
and so blindly copying it into the character array of size NAME_MAX
isn't safe. Instead we must use snprintf() here.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index cd230c63aee6..cf351d3dab1c 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -808,7 +808,8 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 
 	/* Search for "opp-microvolt-<name>" */
 	if (dev_opp->prop_name) {
-		sprintf(name, "opp-microvolt-%s", dev_opp->prop_name);
+		snprintf(name, sizeof(name), "opp-microvolt-%s",
+			 dev_opp->prop_name);
 		prop = of_find_property(opp->np, name, NULL);
 	}
 
@@ -849,7 +850,8 @@ static int opp_parse_supplies(struct dev_pm_opp *opp, struct device *dev,
 	/* Search for "opp-microamp-<name>" */
 	prop = NULL;
 	if (dev_opp->prop_name) {
-		sprintf(name, "opp-microamp-%s", dev_opp->prop_name);
+		snprintf(name, sizeof(name), "opp-microamp-%s",
+			 dev_opp->prop_name);
 		prop = of_find_property(opp->np, name, NULL);
 	}
 
-- 
2.7.0.rc1.186.g94414c4
