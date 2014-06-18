From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: [PATCH] cpuidle: mvebu: Fix the name of the states
Date: Wed, 18 Jun 2014 14:37:43 +0200
Message-ID: <1403095063-22843-1-git-send-email-gregory.clement@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:53047 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S966138AbaFRMhz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Jun 2014 08:37:55 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Gregory CLEMENT <gregory.clement@free-electrons.com>

The length name of the states 2 was too long to fit in the allocated
string (limited to 16 bytes). This lead to improper string displayed
through sysfs.

This patch shorten the name by removing the reference to Marvell and
to the CPU as both are implicit. For coherency the same change have
been done for the states 1.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
Hi,

This fix should be merged in 3.16.

Thanks,
Gregory

 drivers/cpuidle/cpuidle-armada-370-xp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-armada-370-xp.c b/drivers/cpuidle/cpuidle-armada-370-xp.c
index 28587d0f3947..a5fba0287bfb 100644
--- a/drivers/cpuidle/cpuidle-armada-370-xp.c
+++ b/drivers/cpuidle/cpuidle-armada-370-xp.c
@@ -55,7 +55,7 @@ static struct cpuidle_driver armada_370_xp_idle_driver = {
 		.power_usage		= 50,
 		.target_residency	= 100,
 		.flags			= CPUIDLE_FLAG_TIME_VALID,
-		.name			= "MV CPU IDLE",
+		.name			= "Idle",
 		.desc			= "CPU power down",
 	},
 	.states[2]		= {
@@ -65,7 +65,7 @@ static struct cpuidle_driver armada_370_xp_idle_driver = {
 		.target_residency	= 1000,
 		.flags			= CPUIDLE_FLAG_TIME_VALID |
 						ARMADA_370_XP_FLAG_DEEP_IDLE,
-		.name			= "MV CPU DEEP IDLE",
+		.name			= "Deep idle",
 		.desc			= "CPU and L2 Fabric power down",
 	},
 	.state_count = ARMADA_370_XP_MAX_STATES,
-- 
1.8.1.2

