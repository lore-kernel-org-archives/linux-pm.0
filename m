From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH] MAINTAINERS: AVS is not maintained via power supply tree
Date: Fri, 24 Jul 2015 23:11:28 +0200
Message-ID: <1437772288-22825-1-git-send-email-sre@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ring0.de ([5.45.105.125]:47502 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754552AbbGXVLu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 24 Jul 2015 17:11:50 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

The adaptive voltage scaling framework is not maintained
via the power supply tree and has its own entry in the
MAINTAINERS file, so add an exception in the power supply
entry.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8133cef..243f76f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8049,6 +8049,7 @@ T:	git git://git.infradead.org/battery-2.6.git
 S:	Maintained
 F:	include/linux/power_supply.h
 F:	drivers/power/
+X:	drivers/power/avs/
 
 PNP SUPPORT
 M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
-- 
2.1.4

