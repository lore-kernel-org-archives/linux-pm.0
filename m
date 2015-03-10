From: Michael Scott <michael.scott@linaro.org>
Subject: [PATCH v3.10-stable] PM / QoS: remove duplicate call to pm_qos_update_target
Date: Tue, 10 Mar 2015 13:15:02 -0700
Message-ID: <1426018502-16010-1-git-send-email-michael.scott@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pavel@ucw.cz, rjw@sisk.pl, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-stable@vger.kernel.org, linux-pm@vger.kernel.org, Michael Scott <michael.scott@linaro.org>
List-Id: linux-pm@vger.kernel.org

In 3.10.y backport patch 1dba303727f52ea062580b0a9b3f0c3b462769cf,
the logic to call pm_qos_update_target was moved to __pm_qos_update_request.
However, the original code was left in function pm_qos_update_request.

Currently, if pm_qos_update_request is called where new_value !=
req->node.prio then pm_qos_update_target will be called twice in a row.
Once in pm_qos_update_request and then again in the following call to
_pm_qos_update_request.

Removing the left over code from pm_qos_update_request stops this second
call to pm_qos_update_target where the work of removing / re-adding the
new_value in the constraints list would be duplicated.

Signed-off-by: Michael Scott <michael.scott@linaro.org>
---
 kernel/power/qos.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 25cf89b..8703fc7 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -369,12 +369,6 @@ void pm_qos_update_request(struct pm_qos_request *req,
 	}
 
 	cancel_delayed_work_sync(&req->work);
-
-	if (new_value != req->node.prio)
-		pm_qos_update_target(
-			pm_qos_array[req->pm_qos_class]->constraints,
-			&req->node, PM_QOS_UPDATE_REQ, new_value);
-
 	__pm_qos_update_request(req, new_value);
 }
 EXPORT_SYMBOL_GPL(pm_qos_update_request);
-- 
2.1.4
