From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v7 1/8] PCC: Initialize PCC Mailbox earlier at boot
Date: Thu,  9 Jul 2015 14:04:17 -0400
Message-ID: <e5f53a07775cfb896688051b31acb2261ec1d3a2.1436464513.git.ashwin.chaugule@linaro.org>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:35656 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753851AbbGISEc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jul 2015 14:04:32 -0400
Received: by qkbp125 with SMTP id p125so191102277qkb.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2015 11:04:32 -0700 (PDT)
In-Reply-To: <cover.1436464513.git.ashwin.chaugule@linaro.org>
In-Reply-To: <cover.1436464513.git.ashwin.chaugule@linaro.org>
References: <cover.1436464513.git.ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, jaswinder.singh@linaro.org
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, viresh.kumar@linaro.org, sudeep.holla@arm.com, Ashwin Chaugule <ashwin.chaugule@linaro.org>

This change initializes the PCC Mailbox earlier than
the ACPI processor driver. This enables drivers introduced
in follow up patches (e.g. CPPC) to be probed via the ACPI
processor driver interface. The CPPC probe requires the PCC
channel to be initialized for it to query each CPUs performance
capabilities.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Reviewed-by: Al Stone <al.stone@linaro.org>
---
 drivers/mailbox/pcc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 7e91d68..fcda63e 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -352,4 +352,10 @@ static int __init pcc_init(void)
 
 	return 0;
 }
-device_initcall(pcc_init);
+
+/*
+ * Make pcc init postcore so that users of this mailbox
+ * such as the ACPI Processor driver have it available
+ * at their init.
+ */
+postcore_initcall(pcc_init);
-- 
1.9.1

