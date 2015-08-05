From: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Subject: [PATCH v8 1/9] PCC: Initialize PCC Mailbox earlier at boot
Date: Wed,  5 Aug 2015 09:40:24 -0400
Message-ID: <ea93efa9429d1c59fd14cc51d1486ac013abd5ee.1438781668.git.ashwin.chaugule@linaro.org>
References: <cover.1438781668.git.ashwin.chaugule@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cover.1438781668.git.ashwin.chaugule@linaro.org>
In-Reply-To: <cover.1438781668.git.ashwin.chaugule@linaro.org>
References: <cover.1438781668.git.ashwin.chaugule@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net, jaswinder.singh@linaro.org
Cc: sudeep.holla@arm.com, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, patches@linaro.org, viresh.kumar@linaro.org, rwells@codeaurora.org, Ashwin Chaugule <ashwin.chaugule@linaro.org>
List-Id: linux-pm@vger.kernel.org

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
index 26d121d..f814313 100644
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

