From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 07/14] PM / RUNTIME: use atomic_dec_not_zero()
Date: Mon, 30 Jan 2017 19:47:43 +0100
Message-ID: <20170130184743.18402-1-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, Fabian Frederick <fabf@skynet.be>
List-Id: linux-pm@vger.kernel.org

instead of atomic_add_unless(value, -1, 0)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/base/power/runtime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 872eac4..8ed435f 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -603,7 +603,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 
 	if (dev->parent) {
 		parent = dev->parent;
-		atomic_add_unless(&parent->power.child_count, -1, 0);
+		atomic_dec_not_zero(&parent->power.child_count);
 	}
 	wake_up_all(&dev->power.wait_queue);
 
@@ -1116,7 +1116,7 @@ int __pm_runtime_set_status(struct device *dev, unsigned int status)
 		}
 
 		if (parent) {
-			atomic_add_unless(&parent->power.child_count, -1, 0);
+			atomic_dec_not_zero(&parent->power.child_count);
 			notify_parent = !parent->power.ignore_children;
 		}
 		goto out_set;
-- 
2.9.3
