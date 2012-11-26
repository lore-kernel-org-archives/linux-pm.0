From: Jonghwa Lee <jonghwa3.lee@samsung.com>
Subject: [RESEND PATCH] MAINTAINERS: Add maintainers for exynos thermal driver
Date: Mon, 26 Nov 2012 13:45:51 +0900
Message-ID: <1353905151-20735-1-git-send-email-jonghwa3.lee@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:41207 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab2KZEqB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 25 Nov 2012 23:46:01 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Zhang Rui <rui.zhang@intel.com>, Durgadoss R <durgadoss.r@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Amit Dinel Kachhap <amit.kachhap@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Jonghwa Lee <jonghwa3.lee@samsung.com>

Add Amit and I as maintainers for exynos thermal driver.

Signed-off-by: Jonghwa Lee <jonghwa3.lee@samsung.com>
---
 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 59203e7..e839fb8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2960,6 +2960,13 @@ S:	Maintained
 F:	drivers/video/exynos/exynos_mipi*
 F:	include/video/exynos_mipi*
 
+EXYNOS THERMAL DRIVER
+M:	Jonghwa Lee <jonghwa3.lee@samsung.com>
+M:	Amit Daniel Kachhap <amit.kachhap@linaro.org>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	drivers/thermal/exynos_thermal.c
+
 F71805F HARDWARE MONITORING DRIVER
 M:	Jean Delvare <khali@linux-fr.org>
 L:	lm-sensors@lm-sensors.org
-- 
1.7.4.1

