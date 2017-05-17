From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 4/4] PM / OPP: Don't create debugfs "supply-0" directory unnecessarily
Date: Wed, 17 May 2017 10:10:35 +0530
Message-ID: <4365d55b97974c12a51e32b35c2832d664b928b6.1494995911.git.viresh.kumar@linaro.org>
References: <cover.1494995911.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1494995911.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1494995911.git.viresh.kumar@linaro.org>
References: <cover.1494995911.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

We create "supply-0" debugfs directory even if the device doesn't do
voltage scaling. That looks confusing, as if the regulator is found but
we never managed to get voltage levels for it.

Avoid creating such a directory unnecessarily.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/opp/debugfs.c b/drivers/base/power/opp/debugfs.c
index 95f433db4ac7..ce6f4832946b 100644
--- a/drivers/base/power/opp/debugfs.c
+++ b/drivers/base/power/opp/debugfs.c
@@ -40,11 +40,11 @@ static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
 				      struct dentry *pdentry)
 {
 	struct dentry *d;
-	int i = 0;
+	int i = -1;
 	char *name;
 
 	/* Always create at least supply-0 directory */
-	do {
+	while (++i < opp_table->regulator_count) {
 		name = kasprintf(GFP_KERNEL, "supply-%d", i);
 
 		/* Create per-opp directory */
@@ -70,7 +70,7 @@ static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
 		if (!debugfs_create_ulong("u_amp", S_IRUGO, d,
 					  &opp->supplies[i].u_amp))
 			return false;
-	} while (++i < opp_table->regulator_count);
+	}
 
 	return true;
 }
-- 
2.13.0.303.g4ebf3021692d
