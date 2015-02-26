From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH] cpuidle: mvebu: Fix the CPU PM notifier usage
Date: Thu, 26 Feb 2015 18:20:48 +0100
Message-ID: <1424971248-29076-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:45761 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753539AbbBZRVD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Feb 2015 12:21:03 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>

As stated in kernel/cpu_pm.c, "Platform is responsible for ensuring
that cpu_pm_enter is not called twice on the same CPU before
cpu_pm_exit is called.". In the current code in case of failure when
calling mvebu_v7_cpu_suspend, the function cpu_pm_exit() is never
called whereas cpu_pm_enter() was called just before.

This patch moves the cpu_pm_exit() in order to balance the
cpu_pm_enter() calls.

Reported-by: Fulvio Benini <fbf@libero.it>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 drivers/cpuidle/cpuidle-mvebu-v7.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-mvebu-v7.c b/drivers/cpuidle/cpuidle-mvebu-v7.c
index 38e68618513a..cefa07438ae1 100644
--- a/drivers/cpuidle/cpuidle-mvebu-v7.c
+++ b/drivers/cpuidle/cpuidle-mvebu-v7.c
@@ -37,11 +37,11 @@ static int mvebu_v7_enter_idle(struct cpuidle_device *dev,
 		deepidle = true;
 
 	ret = mvebu_v7_cpu_suspend(deepidle);
+	cpu_pm_exit();
+
 	if (ret)
 		return ret;
 
-	cpu_pm_exit();
-
 	return index;
 }
 
-- 
2.1.0

