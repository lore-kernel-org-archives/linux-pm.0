From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [PATCH] extcon: class: Add NULL pointer checking for removing notifier
 block.
Date: Fri, 14 Jun 2013 11:11:37 +0900
Message-ID: <1371175897-3001-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Jonghwa Lee <jonghwa3.lee@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch adds NULL pointer checking of extcon device to 'extcon_unregister
_interest' which unregisters extcon notifier block.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
---
 drivers/extcon/extcon-class.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/extcon/extcon-class.c b/drivers/extcon/extcon-class.c
index 8c69803..23f11ea 100644
--- a/drivers/extcon/extcon-class.c
+++ b/drivers/extcon/extcon-class.c
@@ -491,7 +491,7 @@ EXPORT_SYMBOL_GPL(extcon_register_interest);
  */
 int extcon_unregister_interest(struct extcon_specific_cable_nb *obj)
 {
-	if (!obj)
+	if (!obj || !obj->edev)
 		return -EINVAL;
 
 	return raw_notifier_chain_unregister(&obj->edev->nh, &obj->internal_nb);
-- 
1.7.9.5
