From: Pravin Shedge <pravin.shedge4linux@gmail.com>
Subject: [PATCH 20/45] drivers: thermal: remove duplicate includes
Date: Wed,  6 Dec 2017 22:10:05 +0530
Message-ID: <1512578405-4904-1-git-send-email-pravin.shedge4linux@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: edubezval@gmail.com, linux-kernel@vger.kernel.org, pravin.shedge4linux@gmail.com
List-Id: linux-pm@vger.kernel.org

These duplicate includes have been found with scripts/checkincludes.pl but
they have been removed manually to avoid removing false positives.

Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
---
 drivers/thermal/of-thermal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/of-thermal.c b/drivers/thermal/of-thermal.c
index d04ec3b..e09f035 100644
--- a/drivers/thermal/of-thermal.c
+++ b/drivers/thermal/of-thermal.c
@@ -30,7 +30,6 @@
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/string.h>
-#include <linux/thermal.h>
 
 #include "thermal_core.h"
 
-- 
2.7.4
