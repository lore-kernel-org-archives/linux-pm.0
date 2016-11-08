From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv2 42/49] thermal: core: small style fix when checking for __find_governor()
Date: Mon,  7 Nov 2016 21:09:20 -0800
Message-ID: <1478581767-7009-43-git-send-email-edubezval@gmail.com>
References: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34030 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbcKHF0F (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Nov 2016 00:26:05 -0500
In-Reply-To: <1478581767-7009-1-git-send-email-edubezval@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

Remove style issue:
CHECK: Comparison to NULL could be written "!__find_governor"
+	if (__find_governor(governor->name) == NULL) {

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/thermal_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 09d521a..f19fe03 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -136,7 +136,7 @@ int thermal_register_governor(struct thermal_governor *governor)
 	mutex_lock(&thermal_governor_lock);
 
 	err = -EBUSY;
-	if (__find_governor(governor->name) == NULL) {
+	if (!__find_governor(governor->name)) {
 		err = 0;
 		list_add(&governor->governor_list, &thermal_governor_list);
 		if (!def_governor && !strncmp(governor->name,
@@ -182,7 +182,7 @@ void thermal_unregister_governor(struct thermal_governor *governor)
 
 	mutex_lock(&thermal_governor_lock);
 
-	if (__find_governor(governor->name) == NULL)
+	if (!__find_governor(governor->name))
 		goto exit;
 
 	mutex_lock(&thermal_list_lock);
-- 
2.1.4

