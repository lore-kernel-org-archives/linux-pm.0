From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/5] ACPI / PM: Update file information and the
	list of includes in nvs.c
Date: Fri, 7 Jan 2011 01:44:28 +0100
Message-ID: <201101070144.28641.rjw__20825.9994783022$1294362747$gmane$org@sisk.pl>
References: <201101070141.02951.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101070141.02951.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

The file information and the list of include in drivers/acpi/nvs.c
are outdated, so update them.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/acpi/nvs.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/acpi/nvs.c
===================================================================
--- linux-2.6.orig/drivers/acpi/nvs.c
+++ linux-2.6/drivers/acpi/nvs.c
@@ -1,7 +1,7 @@
 /*
- * linux/kernel/power/hibernate_nvs.c - Routines for handling NVS memory
+ * nvs.c - Routines for saving and restoring ACPI NVS memory region
  *
- * Copyright (C) 2008,2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
+ * Copyright (C) 2008-2011 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
  *
  * This file is released under the GPLv2.
  */
@@ -11,7 +11,7 @@
 #include <linux/list.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
-#include <linux/suspend.h>
+#include <linux/acpi.h>
 
 /*
  * Platforms, like ACPI, may want us to save some memory used by them during
