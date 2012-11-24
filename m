From: Cesar Eduardo Barros <cesarb@cesarb.net>
Subject: [PATCH 16/24] MAINTAINERS: remove arch/x86/platform/mrst/pmu.*
Date: Fri, 23 Nov 2012 22:26:40 -0200
Message-ID: <1353716808-16375-17-git-send-email-cesarb@cesarb.net>
References: <1353716808-16375-1-git-send-email-cesarb@cesarb.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353716808-16375-1-git-send-email-cesarb@cesarb.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Cesar Eduardo Barros <cesarb@cesarb.net>, Alan Cox <alan@linux.intel.com>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

These files were removed by commit 1a8359e (x86/mid: Remove Intel
Moorestown).

Cc: Alan Cox <alan@linux.intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Cesar Eduardo Barros <cesarb@cesarb.net>
---
 MAINTAINERS | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a09993..e7a2349 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3968,12 +3968,6 @@ F:	Documentation/networking/ixgbe.txt
 F:	Documentation/networking/ixgbevf.txt
 F:	drivers/net/ethernet/intel/
 
-INTEL MRST PMU DRIVER
-M:	Len Brown <len.brown@intel.com>
-L:	linux-pm@vger.kernel.org
-S:	Supported
-F:	arch/x86/platform/mrst/pmu.*
-
 INTEL PRO/WIRELESS 2100, 2200BG, 2915ABG NETWORK CONNECTION SUPPORT
 M:	Stanislav Yakovlev <stas.yakovlev@gmail.com>
 L:	linux-wireless@vger.kernel.org
-- 
1.7.11.7
