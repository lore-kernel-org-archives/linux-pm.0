Return-Path: <SRS0=Ttsr=4X=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F775C10DCE
	for <linux-pm@archiver.kernel.org>; Fri,  6 Mar 2020 10:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8932070A
	for <linux-pm@archiver.kernel.org>; Fri,  6 Mar 2020 10:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgCFKMz (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:12:55 -0500
Received: from mga17.intel.com ([192.55.52.151]:26192 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbgCFKMz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Mar 2020 05:12:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 02:12:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,521,1574150400"; 
   d="scan'208";a="230020025"
Received: from unknown (HELO linuxpc.iind.intel.com) ([10.223.107.108])
  by orsmga007.jf.intel.com with ESMTP; 06 Mar 2020 02:12:52 -0800
From:   Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
To:     rui.zhang@intel.com, srinivas.pandruvada@linux.intel.com,
        daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Subject: [PATCH V2] thermal: int340x: processor_thermal: Add Tiger Lake support
Date:   Fri,  6 Mar 2020 15:49:12 +0530
Message-Id: <1583489952-29612-1-git-send-email-sumeet.r.pawnikar@intel.com>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Added new PCI id for Tiger Lake processor thermal device along with
MMIO RAPL support.

Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
---
 .../int340x_thermal/processor_thermal_device.c     |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index b1fd345..297db1d 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -45,6 +45,9 @@
 /* JasperLake thermal reporting device */
 #define PCI_DEVICE_ID_PROC_JSL_THERMAL	0x4503
 
+/* TigerLake thermal reporting device */
+#define PCI_DEVICE_ID_PROC_TGL_THERMAL	0x9A03
+
 #define DRV_NAME "proc_thermal"
 
 struct power_config {
@@ -728,6 +731,8 @@ static int proc_thermal_resume(struct device *dev)
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_ICL_THERMAL),
 		.driver_data = (kernel_ulong_t)&rapl_mmio_hsw, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_JSL_THERMAL)},
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_PROC_TGL_THERMAL),
+		.driver_data = (kernel_ulong_t)&rapl_mmio_hsw, },
 	{ 0, },
 };
 
-- 
1.7.9.5

