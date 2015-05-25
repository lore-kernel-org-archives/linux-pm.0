From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v5 1/6] PCC: Initialize PCC Mailbox earlier at boot
Date: Mon, 25 May 2015 17:50:10 -0400
Message-ID: <1432590610-8968-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yh0-f54.google.com ([209.85.213.54]:36048 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929AbbEYVuS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 May 2015 17:50:18 -0400
Received: by yhrr66 with SMTP id r66so25575106yhr.3
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2015 14:50:17 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, jaswinder.singh@linaro.org
Cc: linux-pm@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, viresh.kumar@linaro.org, sudeep.holla@arm.com, Ashwin Chaugule <ashwin.chaugule@linaro.org>

This change initializes the PCC Mailbox earlier than
the ACPI processor driver. This enables drivers introduced
in follow up patches (e.g. CPPC) to be probed via the ACPI
processor driver interface. The CPPC probe requires the PCC
channel to be initialized for it to query each CPUs performance
capabilites.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/mailbox/pcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
index 7e91d68..8809587 100644
--- a/drivers/mailbox/pcc.c
+++ b/drivers/mailbox/pcc.c
@@ -352,4 +352,4 @@ static int __init pcc_init(void)
 
 	return 0;
 }
-device_initcall(pcc_init);
+postcore_initcall(pcc_init);
-- 
1.9.1

