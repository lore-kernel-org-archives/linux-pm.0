From: Lucas Stach <dev@lynxeye.de>
Subject: [PATCH] cpupower: fix breakage from libpci API change
Date: Mon, 13 Apr 2015 22:24:01 +0200
Message-ID: <1428956641-7765-1-git-send-email-dev@lynxeye.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ns.lynxeye.de ([87.118.118.114]:37558 "EHLO lynxeye.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754742AbbDMUai (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 Apr 2015 16:30:38 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

libpci 3.3.0 introduced an additional member in the pci_filter struct
which needs to be initialized to -1 to get the same behavior as before
the API change. The libpci internal helpers got updated accordingly,
but as the cpupower pci helpers initialized the struct themselves the
behavior changed.

Use the libpci helper pci_filter_init() to fix this and guard against
similar breakages in the future.

This fixes probing of the AMD fam12h/14h cpuidle monitor on systems
with libpci >= 3.3.0.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
---
 tools/power/cpupower/utils/helpers/pci.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/power/cpupower/utils/helpers/pci.c b/tools/power/cpupower/utils/helpers/pci.c
index 9690798..8b27898 100644
--- a/tools/power/cpupower/utils/helpers/pci.c
+++ b/tools/power/cpupower/utils/helpers/pci.c
@@ -25,14 +25,21 @@
 struct pci_dev *pci_acc_init(struct pci_access **pacc, int domain, int bus,
 			     int slot, int func, int vendor, int dev)
 {
-	struct pci_filter filter_nb_link = { domain, bus, slot, func,
-					     vendor, dev };
+	struct pci_filter filter_nb_link;
 	struct pci_dev *device;
 
 	*pacc = pci_alloc();
 	if (*pacc == NULL)
 		return NULL;
 
+	pci_filter_init(*pacc, &filter_nb_link);
+	filter_nb_link.domain	= domain;
+	filter_nb_link.bus	= bus;
+	filter_nb_link.slot	= slot;
+	filter_nb_link.func	= func;
+	filter_nb_link.vendor	= vendor;
+	filter_nb_link.device	= dev;
+
 	pci_init(*pacc);
 	pci_scan_bus(*pacc);
 
-- 
2.1.0

