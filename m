From: Mohammad Merajul Islam Molla <meraj.enigma@gmail.com>
Subject: [PATCH] cpuidle: menu governor - remove unused macro STDDEV_THRESH
Date: Thu, 24 Jul 2014 21:02:01 +0600
Message-ID: <1406214121-9304-1-git-send-email-meraj.enigma@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:56321 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759184AbaGXPC1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jul 2014 11:02:27 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, daniel.lezcano@linaro.org, linux-kernel@vger.kernel.org, trivial@kernel.org, Mohammad Merajul Islam Molla <meraj.enigma@gmail.com>

STDDEV_THRESH was once defined and used in menu governor. But now its no longer
used anywhere. So removing the define.

Signed-off-by: Mohammad Merajul Islam Molla <meraj.enigma@gmail.com>
---
 drivers/cpuidle/governors/menu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index c4f80c1..c3732fa 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -35,7 +35,6 @@
 #define RESOLUTION 1024
 #define DECAY 8
 #define MAX_INTERESTING 50000
-#define STDDEV_THRESH 400
 
 
 /*
-- 
1.9.1

