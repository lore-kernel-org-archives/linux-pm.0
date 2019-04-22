Return-Path: <SRS0=/Mn0=SY=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916CAC282E1
	for <linux-pm@archiver.kernel.org>; Mon, 22 Apr 2019 09:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE422075A
	for <linux-pm@archiver.kernel.org>; Mon, 22 Apr 2019 09:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbfDVJG0 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 22 Apr 2019 05:06:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:4663 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfDVJG0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Apr 2019 05:06:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Apr 2019 02:06:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,381,1549958400"; 
   d="scan'208";a="137736777"
Received: from rzhang-dell-9360.sh.intel.com ([10.239.161.125])
  by orsmga006.jf.intel.com with ESMTP; 22 Apr 2019 02:06:25 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, bugzilla@colorremedies.com
Subject: [PATCH] thermal/int3400_thermal: lower the log level for unsupported event
Date:   Mon, 22 Apr 2019 17:06:22 +0800
Message-Id: <1555923982-22671-1-git-send-email-rui.zhang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Unsupported events for processor thermal device are seen on some machines.
Lower the log level so that it won't bother users.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/intel/int340x_thermal/processor_thermal_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 2a7cbaa..857c4eb 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -265,7 +265,7 @@ static void proc_thermal_notify(acpi_handle handle, u32 event, void *data)
 				THERMAL_DEVICE_POWER_CAPABILITY_CHANGED);
 		break;
 	default:
-		dev_err(proc_priv->dev, "Unsupported event [0x%x]\n", event);
+		dev_notice(proc_priv->dev, "Unsupported event [0x%x]\n", event);
 		break;
 	}
 }
-- 
2.7.4

