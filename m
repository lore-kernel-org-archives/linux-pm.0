From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] cpupower: Fix no-rounding MHz frequency output
Date: Fri,  3 Mar 2017 06:26:46 -0500
Message-ID: <1488540406-13738-1-git-send-email-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751445AbdCCL2T (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Mar 2017 06:28:19 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Thomas Renninger <trenn@suse.com>, Stafford Horne <shorne@gmail.com>, Shuah Khan <shuah@kernel.org>

'cpupower frequency-info -ln' returns kHz values on systems with MHz range
minimum CPU frequency range.  For example, on a 800MHz to 4.20GHz system
the command returns

hardware limits: 800000 MHz - 4.200000 GHz

The value of speed passed into print_speed is in kHz, so divide speed by
1000 in the MHz else-if section to get MHz.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Thomas Renninger <trenn@suse.com>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>
---
 tools/power/cpupower/utils/cpufreq-info.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index 3e701f0e9c14..fe7c25147b3a 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -94,7 +94,7 @@ static void print_speed(unsigned long speed)
 			printf("%u.%06u GHz", ((unsigned int) speed/1000000),
 				((unsigned int) speed%1000000));
 		else if (speed > 100000)
-			printf("%u MHz", (unsigned int) speed);
+			printf("%u MHz", (unsigned int) speed/1000);
 		else if (speed > 1000)
 			printf("%u.%03u MHz", ((unsigned int) speed/1000),
 				(unsigned int) (speed%1000));
-- 
1.7.9.3
