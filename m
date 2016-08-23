From: ahaslam@baylibre.com
Subject: [PATCH 1/2] PM / QoS: Fix check for invalid request
Date: Tue, 23 Aug 2016 15:43:46 +0200
Message-ID: <1471959827-19837-1-git-send-email-ahaslam@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:37154 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753111AbcHWNny (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Aug 2016 09:43:54 -0400
Received: by mail-wm0-f51.google.com with SMTP id i5so196503996wmg.0
        for <linux-pm@vger.kernel.org>; Tue, 23 Aug 2016 06:43:53 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: Axel Haslam <ahaslam@baylibre.com>

From: Axel Haslam <ahaslam@baylibre.com>

The check for a invalid request is using the "type" member
of the request pointer which is not yet set when this function
is called at the start of __dev_pm_qos_add_request.

Fix this by passing a type directly, and not the request
pointer.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 drivers/base/power/qos.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 7f3646e..0bd03e6 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -291,9 +291,9 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
 }
 
 static bool dev_pm_qos_invalid_request(struct device *dev,
-				       struct dev_pm_qos_request *req)
+				       enum dev_pm_qos_req_type type)
 {
-	return !req || (req->type == DEV_PM_QOS_LATENCY_TOLERANCE
+	return (type == DEV_PM_QOS_LATENCY_TOLERANCE
 			&& !dev->power.set_latency_tolerance);
 }
 
@@ -303,7 +303,7 @@ static int __dev_pm_qos_add_request(struct device *dev,
 {
 	int ret = 0;
 
-	if (!dev || dev_pm_qos_invalid_request(dev, req))
+	if (!dev || !req || dev_pm_qos_invalid_request(dev, type))
 		return -EINVAL;
 
 	if (WARN(dev_pm_qos_request_active(req),
-- 
2.7.1

