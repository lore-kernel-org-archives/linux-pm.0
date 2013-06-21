From: kpark3469@gmail.com
Subject: [PATCH v2 4/4] Documentation: Add pm_qos and dev_pm_qos to events-power.txt
Date: Fri, 21 Jun 2013 11:12:31 +0900
Message-ID: <1371780751-16576-4-git-send-email-kpark3469@gmail.com>
References: <1371780751-16576-1-git-send-email-kpark3469@gmail.com>
 <1371780751-16576-2-git-send-email-kpark3469@gmail.com>
 <1371780751-16576-3-git-send-email-kpark3469@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:37030 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161377Ab3FUCNN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jun 2013 22:13:13 -0400
Received: by mail-bk0-f54.google.com with SMTP id it16so3103811bkc.41
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2013 19:13:12 -0700 (PDT)
In-Reply-To: <1371780751-16576-3-git-send-email-kpark3469@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: keun-o.park@windriver.com, len.brown@intel.com, rjw@sisk.pl, rostedt@goodmis.org

From: Sahara <keun-o.park@windriver.com>

Add PM QOS events section and description to events-power.txt.

Signed-off-by: Sahara <keun-o.park@windriver.com>
---
 Documentation/trace/events-power.txt |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/Documentation/trace/events-power.txt b/Documentation/trace/events-power.txt
index e1498ff..90ebab6 100644
--- a/Documentation/trace/events-power.txt
+++ b/Documentation/trace/events-power.txt
@@ -63,3 +63,34 @@ power_domain_target	"%s state=%lu cpu_id=%lu"
 The first parameter gives the power domain name (e.g. "mpu_pwrdm").
 The second parameter is the power domain target state.
 
+4. PM QOS events
+================
+The pm qos events are used for qos add/update/remove request and for
+target/flags update.
+
+pm_qos_add_request                 "pm_qos_class=%s value=%d"
+pm_qos_update_request              "pm_qos_class=%s value=%d"
+pm_qos_remove_request              "pm_qos_class=%s value=%d"
+pm_qos_update_request_timeout      "pm_qos_class=%s value=%d, timeout_us=%ld"
+
+The first parameter gives the qos class name (e.g. "CPU_DMA_LATENCY").
+The second parameter is value to be added/updated/removed.
+The third parameter is timeout value in usec.
+
+pm_qos_update_target               "action=%s prev_value=%d curr_value=%d"
+pm_qos_update_flags                "action=%s prev_value=0x%x curr_value=0x%x"
+
+The first parameter gives the qos action name (e.g. "ADD_REQ").
+The second parameter is the previous qos value.
+The third parameter is the current qos value to update.
+
+And, there are also events used for device pm qos add/update/remove request.
+
+dev_pm_qos_add_request             "device=%s type=%s new_value=%d"
+dev_pm_qos_update_request          "device=%s type=%s new_value=%d"
+dev_pm_qos_remove_request          "device=%s type=%s new_value=%d"
+
+The first parameter gives the device name which tries to add/update/remove
+qos requests.
+The second parameter gives the request type (e.g. "DEV_PM_QOS_LATENCY").
+The third parameter is value to be added/updated/removed.
-- 
1.7.1

