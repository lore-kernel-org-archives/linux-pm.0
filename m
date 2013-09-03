From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 10/27] pcc_freq: convert acpi_get_handle() to acpi_has_method()
Date: Tue,  3 Sep 2013 08:31:58 +0800
Message-ID: <1378168335-22556-11-git-send-email-rui.zhang@intel.com>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15036 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759231Ab3ICAbG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Sep 2013 20:31:06 -0400
In-Reply-To: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>

acpi_has_method() is a new ACPI API introduced to check
the existence of an ACPI control method.

It can be used to replace acpi_get_handle() in the case that
1. the calling function doesn't need the ACPI handle of the control method.
and
2. the calling function doesn't care the reason why the method is unavailable.

Convert acpi_get_handle() to acpi_has_method()
in drivers/cpufreq/pcc_freq.c in this patch.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: linux-pm@vger.kernel.org
---
 drivers/cpufreq/pcc-cpufreq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index d81c4e5..70438de 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -396,15 +396,14 @@ static int __init pcc_cpufreq_probe(void)
 	struct pcc_memory_resource *mem_resource;
 	struct pcc_register_resource *reg_resource;
 	union acpi_object *out_obj, *member;
-	acpi_handle handle, osc_handle, pcch_handle;
+	acpi_handle handle, osc_handle;
 	int ret = 0;
 
 	status = acpi_get_handle(NULL, "\\_SB", &handle);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 
-	status = acpi_get_handle(handle, "PCCH", &pcch_handle);
-	if (ACPI_FAILURE(status))
+	if (!acpi_has_method(handle, "PCCH"))
 		return -ENODEV;
 
 	status = acpi_get_handle(handle, "_OSC", &osc_handle);
-- 
1.8.1.2

