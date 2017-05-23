From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 4/4] PM / OPP: Don't create debugfs "supply-0" directory unnecessarily
Date: Tue, 23 May 2017 09:32:13 +0530
Message-ID: <0381fc50b84535fcb7964eaa345d2501c5c903b3.1495511998.git.viresh.kumar@linaro.org>
References: <b9f67b2be37d5e9740a5e1ed85b0e8b4e5c0eb91.1495511998.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b9f67b2be37d5e9740a5e1ed85b0e8b4e5c0eb91.1495511998.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1495511998.git.viresh.kumar@linaro.org>
References: <cover.1495511998.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

We create "supply-0" debugfs directory even if the device doesn't do
voltage scaling. That looks confusing, as if the regulator is found but
we never managed to get voltage levels for it.

Avoid creating such a directory unnecessarily.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/debugfs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/opp/debugfs.c b/drivers/base/power/opp/debugfs.c
index 95f433db4ac7..81cf120fcf43 100644
--- a/drivers/base/power/opp/debugfs.c
+++ b/drivers/base/power/opp/debugfs.c
@@ -40,11 +40,10 @@ static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
 				      struct dentry *pdentry)
 {
 	struct dentry *d;
-	int i = 0;
+	int i;
 	char *name;
 
-	/* Always create at least supply-0 directory */
-	do {
+	for (i = 0; i < opp_table->regulator_count; i++) {
 		name = kasprintf(GFP_KERNEL, "supply-%d", i);
 
 		/* Create per-opp directory */
@@ -70,7 +69,7 @@ static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
 		if (!debugfs_create_ulong("u_amp", S_IRUGO, d,
 					  &opp->supplies[i].u_amp))
 			return false;
-	} while (++i < opp_table->regulator_count);
+	}
 
 	return true;
 }
-- 
2.13.0.70.g6367777092d9
