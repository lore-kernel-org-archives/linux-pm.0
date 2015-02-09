From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 2/2] ab8500_fg: use jiffies_to_msecs for jiffies conversion
Date: Mon,  9 Feb 2015 12:21:05 -0500
Message-ID: <1423502465-31298-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: linux-pm@vger.kernel.org

Converting jiffies to milliseconds by "val * 1000 / HZ" is technically
OK but jiffies_to_msecs(val) is the cleaner solution and handles all
corner cases correctly. This is a minor API consolidation only and
should make things more readable.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Patch was only compile tested with u8500_defconfig + CONFIG_AB8500_BM=y

Patch is against 3.19.0-rc7 (localversion-next is -next-20150209)

 drivers/power/ab8500_fg.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/ab8500_fg.c b/drivers/power/ab8500_fg.c
index eee4493..d6d4223 100644
--- a/drivers/power/ab8500_fg.c
+++ b/drivers/power/ab8500_fg.c
@@ -629,7 +629,7 @@ int ab8500_fg_inst_curr_finalize(struct ab8500_fg *di, int *res)
 			&di->ab8500_fg_complete,
 			INS_CURR_TIMEOUT);
 		dev_dbg(di->dev, "Finalize time: %d ms\n",
-			((INS_CURR_TIMEOUT - timeout) * 1000) / HZ);
+			jiffies_to_msecs(INS_CURR_TIMEOUT - timeout));
 		if (!timeout) {
 			ret = -ETIME;
 			disable_irq(di->irq);
@@ -731,7 +731,7 @@ int ab8500_fg_inst_curr_blocking(struct ab8500_fg *di)
 			&di->ab8500_fg_started,
 			INS_CURR_TIMEOUT);
 		dev_dbg(di->dev, "Start time: %d ms\n",
-			((INS_CURR_TIMEOUT - timeout) * 1000) / HZ);
+			jiffies_to_msecs(INS_CURR_TIMEOUT - timeout));
 		if (!timeout) {
 			ret = -ETIME;
 			dev_err(di->dev, "completion timed out [%d]\n",
-- 
1.7.10.4
