From: Sriram Dash <dash.sriram@gmail.com>
Subject: [PATCH 5/5] base: power: wakeup.c: Fixed a typo error
Date: Wed, 27 May 2015 00:17:17 +0530
Message-ID: <1432666037-24944-1-git-send-email-dash.sriram@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, trivial@kernel.org, dashsriram <dash.sriram@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: dashsriram <dash.sriram@gmail.com>

Fixed a typo error in the file

Signed-off-by: Sriram Dash <dash.sriram@gmail.com>
---
 drivers/base/power/wakeup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 7726200..19a216e 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -528,7 +528,7 @@ static void wakeup_source_deactivate(struct wakeup_source *ws)
 
 	/*
 	 * Increment the counter of registered wakeup events and decrement the
-	 * couter of wakeup events in progress simultaneously.
+	 * counter of wakeup events in progress simultaneously.
 	 */
 	cec = atomic_add_return(MAX_IN_PROGRESS, &combined_event_count);
 	trace_wakeup_source_deactivate(ws->name, cec);
-- 
2.4.1
