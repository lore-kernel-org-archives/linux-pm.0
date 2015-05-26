From: Sriram Dash <dash.sriram@gmail.com>
Subject: [PATCH 3/3] base: power: qos.c: Fixed a typo error
Date: Wed, 27 May 2015 00:08:19 +0530
Message-ID: <1432665499-24622-1-git-send-email-dash.sriram@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org, dashsriram <dash.sriram@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: dashsriram <dash.sriram@gmail.com>

Fixed a typo error in the file

Signed-off-by: Sriram Dash <dash.sriram@gmail.com>
---
 drivers/base/power/qos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index e56d538..d23ea4b 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -25,7 +25,7 @@
  *    API. The notification chain data is stored in a static variable.
  *
  * Note about the per-device constraint data struct allocation:
- * . The per-device constraints data struct ptr is tored into the device
+ * . The per-device constraints data struct ptr is stored into the device
  *    dev_pm_info.
  * . To minimize the data usage by the per-device constraints, the data struct
  *   is only allocated at the first call to dev_pm_qos_add_request.
-- 
2.4.1
