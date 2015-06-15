From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v6 6/7] PCC: Enable PCC only when needed
Date: Mon, 15 Jun 2015 16:09:10 -0400
Message-ID: <56fc29c35e139eaa1733c9c29073339fabf93956.1434398373.git.ashwin.chaugule@linaro.org>
References: <cover.1434398373.git.ashwin.chaugule@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36057 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517AbbFOUJd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 16:09:33 -0400
Received: by pabqy3 with SMTP id qy3so71740890pab.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2015 13:09:32 -0700 (PDT)
In-Reply-To: <cover.1434398373.git.ashwin.chaugule@linaro.org>
In-Reply-To: <cover.1434398373.git.ashwin.chaugule@linaro.org>
References: <cover.1434398373.git.ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, jaswinder.singh@linaro.org
Cc: linux-pm@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, linux-acpi@vger.kernel.org, viresh.kumar@linaro.org, sudeep.holla@arm.com, Ashwin Chaugule <ashwin.chaugule@linaro.org>

CPPC is the first client to make use of the PCC Mailbox channel. So
enable it only when CPPC is also enabled.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Reviewed-by: Al Stone <al.stone@linaro.org>
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

