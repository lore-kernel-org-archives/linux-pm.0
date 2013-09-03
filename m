From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 01/27] olpc_xo15_sci: convert acpi_evaluate_object() to acpi_execute_simple_method()
Date: Tue,  3 Sep 2013 08:31:49 +0800
Message-ID: <1378168335-22556-2-git-send-email-rui.zhang@intel.com>
References: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:15036 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759183Ab3ICAbE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 2 Sep 2013 20:31:04 -0400
In-Reply-To: <1378168335-22556-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Daniel Drake <dsd@laptop.org>, "H. Peter Anvin" <hpa@linux.intel.com>

acpi_execute_simple_method() is a new ACPI API introduced to invoke
an ACPI control method that has single integer parameter and no return value.

Convert acpi_evaluate_object() to acpi_execute_simple_method()
in arch/x86/platform/olpc/olpc-xo15-sci.c

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
CC: Daniel Drake <dsd@laptop.org>
CC: H. Peter Anvin <hpa@linux.intel.com>
---
 arch/x86/platform/olpc/olpc-xo15-sci.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/platform/olpc/olpc-xo15-sci.c b/arch/x86/platform/olpc/olpc-xo15-sci.c
index fef7d0b..649a12b 100644
--- a/arch/x86/platform/olpc/olpc-xo15-sci.c
+++ b/arch/x86/platform/olpc/olpc-xo15-sci.c
@@ -40,16 +40,9 @@ static bool				lid_wake_on_close;
  */
 static int set_lid_wake_behavior(bool wake_on_close)
 {
-	struct acpi_object_list arg_list;
-	union acpi_object arg;
 	acpi_status status;
 
-	arg_list.count		= 1;
-	arg_list.pointer	= &arg;
-	arg.type		= ACPI_TYPE_INTEGER;
-	arg.integer.value	= wake_on_close;
-
-	status = acpi_evaluate_object(NULL, "\\_SB.PCI0.LID.LIDW", &arg_list, NULL);
+	status = acpi_execute_simple_method(NULL, "\\_SB.PCI0.LID.LIDW", wake_on_close);
 	if (ACPI_FAILURE(status)) {
 		pr_warning(PFX "failed to set lid behavior\n");
 		return 1;
-- 
1.8.1.2

