From: Hareesh Gundu <hareeshg@codeaurora.org>
Subject: [PATCH] power: qos: Export pm_qos_update_request_timeout()
Date: Tue,  5 Dec 2017 16:15:39 +0530
Message-ID: <1512470739-21960-1-git-send-email-hareeshg@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47016 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752911AbdLEKpv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Dec 2017 05:45:51 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
Cc: hareeshg@codeaurora.org

Add EXPORT_SYMBOL_GPL to pm_qos_update_request_timeout,
so that it can be usable from modules similar to the
pm_qos_update_request().

Signed-off-by: Hareesh Gundu <hareeshg@codeaurora.org>
---
 kernel/power/qos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 9d75039..3f501b4 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -515,6 +515,7 @@ void pm_qos_update_request_timeout(struct pm_qos_request *req, s32 new_value,
 
 	schedule_delayed_work(&req->work, usecs_to_jiffies(timeout_us));
 }
+EXPORT_SYMBOL_GPL(pm_qos_update_request_timeout);
 
 /**
  * pm_qos_remove_request - modifies an existing qos request
-- 
1.9.1
