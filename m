From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] thermal: intel_pch_thermal: constify pci_device_id.
Date: Wed,  2 Aug 2017 23:28:40 +0530
Message-ID: <c05199b0e83a76e5ca8e5e94f207aabf419f618d.1501696637.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34285 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751988AbdHBR6u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Aug 2017 13:58:50 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

pci_device_id are not supposed to change at runtime. All functions
working with pci_device_id provided by <linux/pci.h> work with
const pci_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/thermal/intel_pch_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel_pch_thermal.c b/drivers/thermal/intel_pch_thermal.c
index 2b49e8d..0bdce3e 100644
--- a/drivers/thermal/intel_pch_thermal.c
+++ b/drivers/thermal/intel_pch_thermal.c
@@ -387,7 +387,7 @@ static int intel_pch_thermal_resume(struct device *device)
 	return ptd->ops->resume(ptd);
 }
 
-static struct pci_device_id intel_pch_thermal_id[] = {
+static const struct pci_device_id intel_pch_thermal_id[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_HSW_1),
 		.driver_data = board_hsw, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCH_THERMAL_DID_HSW_2),
-- 
2.7.4
