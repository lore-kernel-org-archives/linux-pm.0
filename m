From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] thermal: cpu_cooling: Add MAINTAINERS entry
Date: Wed, 19 Aug 2015 12:30:40 +0530
Message-ID: <298acc438cba5f64121d883db7ff2b860c0a9610.1439967508.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35992 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbbHSHA6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Aug 2015 03:00:58 -0400
Received: by pawq9 with SMTP id q9so54117774paw.3
        for <linux-pm@vger.kernel.org>; Wed, 19 Aug 2015 00:00:58 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: edubezval@gmail.com
Cc: linaro-kernel@lists.linaro.org, amit.daniel@samsung.com, linux-pm@vger.kernel.org, rui.zhang@intel.com, Viresh Kumar <viresh.kumar@linaro.org>

None of the patches are reaching Viresh or Daniel directly as
get_maintainers doesn't report us as maintainers. Looks like file header
or history of commits isn't able to do that properly.

Add a separate entry for cpu_cooling driver in MAINTAINERS.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Please let me know if someone has objections to this.

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d8ab5c06c4f..c85081f08516 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10298,6 +10298,14 @@ F:	include/uapi/linux/thermal.h
 F:	include/linux/cpu_cooling.h
 F:	Documentation/devicetree/bindings/thermal/
 
+THERMAL/CPU_COOLING
+M:	Amit Daniel Kachhap <amit.daniel@samsung.com>
+M:	Viresh Kumar <viresh.kumar@linaro.org>
+L:	linux-pm@vger.kernel.org
+S:	Supported
+F:	drivers/thermal/cpu_cooling.c
+F:	include/linux/cpu_cooling.h
+
 THINGM BLINK(1) USB RGB LED DRIVER
 M:	Vivien Didelot <vivien.didelot@savoirfairelinux.com>
 S:	Maintained
-- 
2.4.0

