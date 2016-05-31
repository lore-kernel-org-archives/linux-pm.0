From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCHv4 42/48] thermal: core: small style fix when checking for __find_governor()
Date: Mon, 30 May 2016 23:18:49 -0700
Message-ID: <1464675535-2433-43-git-send-email-edubezval@gmail.com>
References: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464675535-2433-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Keerthy <a0393675@ti.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

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
index f653090..cbc5954 100644
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
