From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] powercap: Remove reassignment
Date: Sat, 11 Nov 2017 23:17:26 +0530
Message-ID: <00329a239c8b1640a9e491b6a90a5b20fd45e42c.1510422357.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:50097 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbdKKRrh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Nov 2017 12:47:37 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

It is not necessary to reassignment of 'result'.
Here, result is being initialized zero and then updated with
seed_constraint_attributes().
class_register is enough to return successful and error value.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/powercap/powercap_sys.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
index 5b10b50..64b2b25 100644
--- a/drivers/powercap/powercap_sys.c
+++ b/drivers/powercap/powercap_sys.c
@@ -673,15 +673,13 @@ EXPORT_SYMBOL_GPL(powercap_unregister_control_type);
 
 static int __init powercap_init(void)
 {
-	int result = 0;
+	int result;
 
 	result = seed_constraint_attributes();
 	if (result)
 		return result;
 
-	result = class_register(&powercap_class);
-
-	return result;
+	return class_register(&powercap_class);
 }
 
 device_initcall(powercap_init);
-- 
2.7.4
