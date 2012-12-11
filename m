From: Cesar Eduardo Barros <cesarb@cesarb.net>
Subject: [PATCH 13/19] MAINTAINERS: remove arch/x86/platform/mrst/pmu.*
Date: Tue, 11 Dec 2012 19:49:55 -0200
Message-ID: <1355262601-4263-14-git-send-email-cesarb@cesarb.net>
References: <1355262601-4263-1-git-send-email-cesarb@cesarb.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp-02.mandic.com.br ([200.225.81.133]:35243 "EHLO
	smtp-02.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820Ab2LKVuX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Dec 2012 16:50:23 -0500
In-Reply-To: <1355262601-4263-1-git-send-email-cesarb@cesarb.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>, Cesar Eduardo Barros <cesarb@cesarb.net>, Alan Cox <alan@linux.intel.com>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org

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
index 78d07f5..fbb9c06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3970,12 +3970,6 @@ F:	Documentation/networking/ixgbe.txt
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

