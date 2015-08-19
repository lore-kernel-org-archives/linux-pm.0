From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2] thermal: cpu_cooling: Add MAINTAINERS entry
Date: Wed, 19 Aug 2015 23:36:30 +0530
Message-ID: <feea0ded7e436bb9408d7f3d89c95d3e0ba7049d.1440007527.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, amit.daniel@samsung.com, linux-pm@vger.kernel.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>, open list <linux-kernel@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>
List-Id: linux-pm@vger.kernel.org

None of the patches are reaching Viresh or Daniel directly as
get_maintainers doesn't report us as maintainers. Looks like file header
or history of commits isn't able to do that properly.

Add a separate entry for cpu_cooling driver in MAINTAINERS.

Acked-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2:
- Add cpu-cooling-api.txt as well
- Add Ack received from Eduardo

 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d8ab5c06c4f..9dc3f73e5341 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10298,6 +10298,15 @@ F:	include/uapi/linux/thermal.h
 F:	include/linux/cpu_cooling.h
 F:	Documentation/devicetree/bindings/thermal/
 
+THERMAL/CPU_COOLING
+M:	Amit Daniel Kachhap <amit.daniel@samsung.com>
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
