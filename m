From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCHv3 02/16] ARM: mvebu: sort the #include of pmsu.c in alphabetic order
Date: Wed, 23 Jul 2014 15:00:39 +0200
Message-ID: <1406120453-29291-3-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1406120453-29291-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:40672 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752259AbaGWNA6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jul 2014 09:00:58 -0400
In-Reply-To: <1406120453-29291-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>
Cc: Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

Sorting the headers in alphabetic order will help to reduce conflicts
when adding new headers later.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 5fda549..9e18cce 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -19,13 +19,13 @@
 #define pr_fmt(fmt) "mvebu-pmsu: " fmt
 
 #include <linux/cpu_pm.h>
-#include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/of_address.h>
 #include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/of_address.h>
 #include <linux/platform_device.h>
-#include <linux/smp.h>
 #include <linux/resource.h>
+#include <linux/smp.h>
 #include <asm/cacheflush.h>
 #include <asm/cp15.h>
 #include <asm/smp_plat.h>
-- 
2.0.0

