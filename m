From: shrikant.maurya@techveda.org
Subject: [PATCH] drivers: base: power: Fix GFP_KERNEL in spinlock context
Date: Tue, 12 Dec 2017 19:15:42 +0530
Message-ID: <1513086342-3581-1-git-send-email-shrikant.maurya@techveda.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, sunil.m@techveda.org, karthik@techveda.org, raghu@techveda.org, Shrikant Maurya <shrikant.maurya@techveda.org>
List-Id: linux-pm@vger.kernel.org

From: Shrikant Maurya <shrikant.maurya@techveda.org>

As reported by Jia-Ju Bai (https://lkml.org/lkml/2017/12/11/872):
API's are using GFP_KERNEL to allocate memory which may sleep.

To ensure atomicity such allocations must be avoided in critical
sections under spinlock.
Fixed by replacing GFP_KERNEL to GFP_ATOMIC.

Reported-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: Shrikant Maurya <shrikant.maurya@techveda.org>
Signed-off-by: Suniel Mahesh <sunil.m@techveda.org>
Signed-off-by: Raghu Bharadwaj <raghu@techveda.org>
Signed-off-by: Karthik Tummala <karthik@techveda.org>
---
Note:
- Patch was compile tested and built(ARCH=arm) on linux-next
  (latest).
- No build issues reported.
---
 drivers/base/power/wakeup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 38559f0..de56952 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -92,11 +92,11 @@ struct wakeup_source *wakeup_source_create(const char *name)
 {
 	struct wakeup_source *ws;
 
-	ws = kmalloc(sizeof(*ws), GFP_KERNEL);
+	ws = kmalloc(sizeof(*ws), GFP_ATOMIC);
 	if (!ws)
 		return NULL;
 
-	wakeup_source_prepare(ws, name ? kstrdup_const(name, GFP_KERNEL) : NULL);
+	wakeup_source_prepare(ws, name ? kstrdup_const(name, GFP_ATOMIC) : NULL);
 	return ws;
 }
 EXPORT_SYMBOL_GPL(wakeup_source_create);
-- 
1.9.1
