From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH] cpufreq/CPPC: Add MODULE_DEVICE_TABLE for cppc_cpufreq driver
Date: Fri, 14 Oct 2016 12:00:23 -0600
Message-ID: <1476468023-6917-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48370 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751337AbcJNSAq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Oct 2016 14:00:46 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Hoan Tran <hotran@apm.com>, Christopher Covington <cov@codeaurora.org>, Al Stone <ahs3@redhat.com>, Prashanth Prakash <pprakash@codeaurora.org>

MODULE_DEVICE_TABLE is added so that CPPC cpufreq module can be
automatically loaded when we have a acpi processor device with
"ACPI0007" hid.

Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 4852d9e..e82bb3c 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -247,3 +247,10 @@ MODULE_DESCRIPTION("CPUFreq driver based on the ACPI CPPC v5.0+ spec");
 MODULE_LICENSE("GPL");
 
 late_initcall(cppc_cpufreq_init);
+
+static const struct acpi_device_id cppc_acpi_ids[] = {
+	{ACPI_PROCESSOR_DEVICE_HID, },
+	{}
+};
+
+MODULE_DEVICE_TABLE(acpi, cppc_acpi_ids);
-- 
Qualcomm Datacenter Technologies on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

