From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v8 8/9] PCC: Disable compilation by default
Date: Wed,  5 Aug 2015 09:40:31 -0400
Message-ID: <cb33fd802a64bb7ba977ac9c3b3745966b14c00d.1438781668.git.ashwin.chaugule@linaro.org>
References: <cover.1438781668.git.ashwin.chaugule@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:32855 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753283AbbHENlF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2015 09:41:05 -0400
Received: by ykoo205 with SMTP id o205so35351017yko.0
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2015 06:41:04 -0700 (PDT)
In-Reply-To: <cover.1438781668.git.ashwin.chaugule@linaro.org>
In-Reply-To: <cover.1438781668.git.ashwin.chaugule@linaro.org>
References: <cover.1438781668.git.ashwin.chaugule@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, jaswinder.singh@linaro.org
Cc: sudeep.holla@arm.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, viresh.kumar@linaro.org, rwells@codeaurora.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>

PCC is made selectable only by clients which use it. e.g. CPPC
Default it to disabled so that it is not included accidentally on
platforms which dont use it.

Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Reviewed-by: Al Stone <al.stone@linaro.org>
---
 drivers/mailbox/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index e269f08..bbec500 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -46,6 +46,7 @@ config OMAP_MBOX_KFIFO_SIZE
 config PCC
 	bool "Platform Communication Channel Driver"
 	depends on ACPI
+	default n
 	help
 	  ACPI 5.0+ spec defines a generic mode of communication
 	  between the OS and a platform such as the BMC. This medium
-- 
1.9.1

