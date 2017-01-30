From: Fabian Frederick <fabf@skynet.be>
Subject: [PATCH 11/14] PM: use atomic_dec_not_zero()
Date: Mon, 30 Jan 2017 19:48:21 +0100
Message-ID: <20170130184821.18943-1-fabf@skynet.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, linux-pm@vger.kernel.org, Fabian Frederick <fabf@skynet.be>
List-Id: linux-pm@vger.kernel.org

instead of atomic_add_unless(value, -1, 0)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 kernel/power/user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/user.c b/kernel/power/user.c
index 22df9f7..c478572 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -54,7 +54,7 @@ static int snapshot_open(struct inode *inode, struct file *filp)
 
 	lock_system_sleep();
 
-	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
+	if (!atomic_dec_not_zero(&snapshot_device_available)) {
 		error = -EBUSY;
 		goto Unlock;
 	}
-- 
2.9.3
