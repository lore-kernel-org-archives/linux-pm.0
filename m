From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3] thermal: cpu_cooling: Add MAINTAINERS entry
Date: Thu, 20 Aug 2015 08:10:08 +0530
Message-ID: <898726e0b847fa46a5efec40578324b1b5051ac5.1440038267.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:35656 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbbHTCkZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2015 22:40:25 -0400
Received: by pacdd16 with SMTP id dd16so8151786pac.2
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2015 19:40:25 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, amit.daniel@samsung.com, linux-pm@vger.kernel.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>, open list <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>

None of the patches are reaching Viresh or Daniel directly as
get_maintainers doesn't report us as maintainers. Looks like file header
or history of commits isn't able to do that properly.

Add a separate entry for cpu_cooling driver in MAINTAINERS.

Acked-by: Eduardo Valentin <edubezval@gmail.com>
Acked-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
Acked-by: Amit Daniel Kachhap <amit.kachhap@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2->V3:
- Updated Amit's email address

 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d8ab5c06c4f..e733bd6272b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10298,6 +10298,15 @@ F:	include/uapi/linux/thermal.h
 F:	include/linux/cpu_cooling.h
 F:	Documentation/devicetree/bindings/thermal/
 
+THERMAL/CPU_COOLING
+M:	Amit Daniel Kachhap <amit.kachhap@gmail.com>
+M:	Viresh Kumar <viresh.kumar@linaro.org>
+L:	linux-pm@vger.kernel.org
+S:	Supported
+F:	Documentation/thermal/cpu-cooling-api.txt
+F:	drivers/thermal/cpu_cooling.c
+F:	include/linux/cpu_cooling.h
+
 THINGM BLINK(1) USB RGB LED DRIVER
 M:	Vivien Didelot <vivien.didelot@savoirfairelinux.com>
 S:	Maintained
-- 
2.4.0

