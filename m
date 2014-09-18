From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 07/19] ACPI / fan: remove unused macro
Date: Thu, 18 Sep 2014 09:53:38 +0800
Message-ID: <1411005230-2227-8-git-send-email-rui.zhang@intel.com>
References: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46477 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932119AbaIRBy2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Sep 2014 21:54:28 -0400
In-Reply-To: <1411005230-2227-1-git-send-email-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, lenb@kernel.org, eduardo.valentin@ti.com, Aaron Lu <aaron.lu@intel.com>, Zhang Rui <rui.zhang@intel.com>

From: Aaron Lu <aaron.lu@intel.com>

The _COMPONENT, ACPI_MODULE_NAME(name) and ACPI_FAN_FILE_STATE are not
used anywhere so remove them.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/fan.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/acpi/fan.c b/drivers/acpi/fan.c
index 8acf53e..562d5f3 100644
--- a/drivers/acpi/fan.c
+++ b/drivers/acpi/fan.c
@@ -34,10 +34,6 @@
 #define PREFIX "ACPI: "
 
 #define ACPI_FAN_CLASS			"fan"
-#define ACPI_FAN_FILE_STATE		"state"
-
-#define _COMPONENT		ACPI_FAN_COMPONENT
-ACPI_MODULE_NAME("fan");
 
 MODULE_AUTHOR("Paul Diefenbaugh");
 MODULE_DESCRIPTION("ACPI Fan Driver");
-- 
1.8.3.2

