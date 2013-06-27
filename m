From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH V2] ARM: cpuidle: davinci: Fix target residency
Date: Thu, 27 Jun 2013 17:10:00 +0200
Message-ID: <1372345800-26792-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:57823 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067Ab3F0PJr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2013 11:09:47 -0400
Received: by mail-we0-f179.google.com with SMTP id w59so652121wes.24
        for <linux-pm@vger.kernel.org>; Thu, 27 Jun 2013 08:09:46 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: nsekhar@ti.com, khilman@deeprootsystems.com
Cc: sergei.shtylyov@cogentembedded.com, rjw@sisk.pl, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, linaro-kernel@lists.linaro.org

The commit 19976c2a88d125aec16b9255c7197c297bbdd637 changed the target
residency to 100000, assuming this is a careless mistake.

commit 19976c2a88d125aec16b9255c7197c297bbdd637
Author: Robert Lee <rob.lee@linaro.org>
Date:   Tue Mar 20 15:22:45 2012 -0500

    ARM: davinci: Consolidate time keeping and irq enable

    Enable core cpuidle timekeeping and irq enabling and remove that
    handling from this code.

    Signed-off-by: Robert Lee <rob.lee@linaro.org>
    Reviewed-by: Kevin Hilman <khilman@ti.com>
    Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
    Acked-by: Jean Pihet <j-pihet@ti.com>
    Signed-off-by: Len Brown <len.brown@intel.com>

The same happened to the at91's cpuidle driver.

Fix it by putting the initial value to 10000.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/mach-davinci/cpuidle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/cpuidle.c b/arch/arm/mach-davinci/cpuidle.c
index 36aef3a..f1ac1c9 100644
--- a/arch/arm/mach-davinci/cpuidle.c
+++ b/arch/arm/mach-davinci/cpuidle.c
@@ -65,7 +65,7 @@ static struct cpuidle_driver davinci_idle_driver = {
 	.states[1]		= {
 		.enter			= davinci_enter_idle,
 		.exit_latency		= 10,
-		.target_residency	= 100000,
+		.target_residency	= 10000,
 		.flags			= CPUIDLE_FLAG_TIME_VALID,
 		.name			= "DDR SR",
 		.desc			= "WFI and DDR Self Refresh",
-- 
1.7.9.5

