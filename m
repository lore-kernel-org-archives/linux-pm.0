From: Quentin Perret <quentin.perret@arm.com>
Subject: [RFC PATCH] PM / OPP: Always expose one supply in debugfs
Date: Mon, 10 Dec 2018 11:32:47 +0000
Message-ID: <20181210113247.11412-1-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: vireshk@kernel.org, nm@ti.com, sboyd@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On some platforms, the opp_table->regulator_count field is kept at zero
even though opp->supplies is always allocated. However, the loop used to
display the supplies in the debugfs doesn't deal correctly with this,
which results in the supplies not being displayed in debugfs on those
platforms.

Fix this by making sure to always display at least once supply in
debugfs.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>

---

This has been observed on Juno r2 which uses SCPI and Hikey960 which
uses DT. I am not particularly familiar with that part of the code, so
I'm not sure if this is even remotely correct (hence the RFC tag).

I first thought setting opp_table->regulator_count to 1 would be the
right fix but that causes other issues. This fix seems to work OK on
Juno and Hikey960, at least.

Feedback is welcome :-)

Thanks,
Quentin
---
 drivers/opp/debugfs.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/opp/debugfs.c b/drivers/opp/debugfs.c
index e6828e5f81b0..2c14564575cb 100644
--- a/drivers/opp/debugfs.c
+++ b/drivers/opp/debugfs.c
@@ -40,9 +40,9 @@ static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
 				      struct dentry *pdentry)
 {
 	struct dentry *d;
-	int i;
+	int i = 0;
 
-	for (i = 0; i < opp_table->regulator_count; i++) {
+	do {
 		char name[15];
 
 		snprintf(name, sizeof(name), "supply-%d", i);
@@ -68,7 +68,9 @@ static bool opp_debug_create_supplies(struct dev_pm_opp *opp,
 		if (!debugfs_create_ulong("u_amp", S_IRUGO, d,
 					  &opp->supplies[i].u_amp))
 			return false;
-	}
+
+		i++;
+	} while (i < opp_table->regulator_count);
 
 	return true;
 }
-- 
2.19.2
