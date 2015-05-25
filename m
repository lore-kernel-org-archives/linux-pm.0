From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v5 6/6] PCC: Enable PCC only when needed
Date: Mon, 25 May 2015 17:52:11 -0400
Message-ID: <1432590731-9194-1-git-send-email-ashwin.chaugule@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33108 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbbEYVwR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 May 2015 17:52:17 -0400
Received: by ykfr66 with SMTP id r66so22906777ykf.0
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2015 14:52:16 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, jaswinder.singh@linaro.org
Cc: linux-pm@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, viresh.kumar@linaro.org, sudeep.holla@arm.com, Ashwin Chaugule <ashwin.chaugule@linaro.org>

CPPC is the first client to make use of the PCC Mailbox channel. So
enable it only when CPPC is also enabled.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
---
 drivers/mailbox/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 84b0a2d..60c8da6 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -45,7 +45,7 @@ config OMAP_MBOX_KFIFO_SIZE
 
 config PCC
 	bool "Platform Communication Channel Driver"
-	depends on ACPI
+	depends on ACPI && ACPI_CPPC
 	help
 	  ACPI 5.0+ spec defines a generic mode of communication
 	  between the OS and a platform such as the BMC. This medium
-- 
1.9.1

