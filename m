From: Vivek Gautam <vivek.gautam@codeaurora.org>
Subject: [PATCH 1/1] base: power: runtime: Export pm_runtime_get/put_suppliers
Date: Fri,  8 Dec 2017 18:00:47 +0530
Message-ID: <1512736247-16538-1-git-send-email-vivek.gautam@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43572 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752546AbdLHMbK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Dec 2017 07:31:10 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, sboyd@codeaurora.org, robdclark@gmail.com, robin.murphy@arm.com, will.deacon@arm.com, linux-arm-msm@vger.kernel.org, Vivek Gautam <vivek.gautam@codeaurora.org>

The device link allows the pm framework to tie the supplier and
consumer. So, whenever the consumer is powered-on, the supplier
is powered-on first.

There are however cases in which the consumer wants to power-on
the supplier, but not itself.
E.g., A Graphics or multimedia driver wants to power-on the SMMU
to unmap a buffer and finish the TLB operations without powering
on itself. Some of these unmap requests are coming from the
user space when the controller itself is not powered-up, and it
can be huge penalty in terms of power and latency to power-up
the graphics/mm controllers.
There can be an argument that the supplier should handle this case
on its own and there should not be a need for the consumer to
power-on the supplier. But as discussed on the thread [1] about
ARM-SMMU runtime pm, we don't want to introduce runtime pm calls
in atomic paths, such as in arm_smmu_unmap.

[1] https://patchwork.kernel.org/patch/9827825/

Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
---
 drivers/base/power/runtime.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 027d159ac381..af169304ca13 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1578,6 +1578,7 @@ void pm_runtime_get_suppliers(struct device *dev)
 
 	device_links_read_unlock(idx);
 }
+EXPORT_SYMBOL_GPL(pm_runtime_get_suppliers);
 
 /**
  * pm_runtime_put_suppliers - Drop references to supplier devices.
@@ -1596,6 +1597,7 @@ void pm_runtime_put_suppliers(struct device *dev)
 
 	device_links_read_unlock(idx);
 }
+EXPORT_SYMBOL_GPL(pm_runtime_put_suppliers);
 
 void pm_runtime_new_link(struct device *dev)
 {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
