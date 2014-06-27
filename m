From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH 01/16] ARM: mvebu: Sort the headers of pmsu.c in alphabetic order
Date: Fri, 27 Jun 2014 15:22:42 +0200
Message-ID: <1403875377-940-2-git-send-email-gregory.clement@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:42036 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752367AbaF0NXr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 27 Jun 2014 09:23:47 -0400
In-Reply-To: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

Sorting the headers in alphabetic order will help to reduce the
conflict when adding new headers later.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index a1d407c0febe..5584d35b8e88 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -19,13 +19,13 @@
 #define pr_fmt(fmt) "mvebu-pmsu: " fmt
 
 #include <linux/cpu_pm.h>
-#include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/of_address.h>
+#include <linux/kernel.h>
 #include <linux/io.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
-#include <linux/smp.h>
 #include <linux/resource.h>
+#include <linux/smp.h>
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
 #include <asm/smp_plat.h>
-- 
1.8.1.2

