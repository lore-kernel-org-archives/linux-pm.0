From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] powercap/rapl: Do not load in virtualized environments
Date: Tue, 17 May 2016 07:34:05 -0400
Message-ID: <1463484845-9839-1-git-send-email-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44347 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241AbcEQLed (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 17 May 2016 07:34:33 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jacob Jun Pan <jacob.jun.pan@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

intel_rapl is currently not supported in virtualized environments.  When
booting the warning message

intel_rapl: no valid rapl domains found in package 0

is output for every virtual core.

This patch stops the driver from being loaded in virtual boots.

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jacob Jun Pan <jacob.jun.pan@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 drivers/powercap/intel_rapl.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index f2201d42a9cd..bebfbe8acccd 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -29,6 +29,7 @@
 #include <linux/sysfs.h>
 #include <linux/cpu.h>
 #include <linux/powercap.h>
+#include <asm/hypervisor.h>
 #include <asm/iosf_mbi.h>
 
 #include <asm/processor.h>
@@ -1600,6 +1601,10 @@ static int __init rapl_init(void)
 		return -ENODEV;
 	}
 
+	/* Intel RAPL is not supported on virtualized environments */
+	if (x86_hyper)
+		return -ENODEV;
+
 	rapl_defaults = (struct rapl_defaults *)id->driver_data;
 
 	cpu_notifier_register_begin();
-- 
1.7.9.3

