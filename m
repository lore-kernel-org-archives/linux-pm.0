From: Steven Noonan <steven@uplinklabs.net>
Subject: [PATCH] cpupower: fix bench check for online CPUs
Date: Sun,  4 Sep 2016 15:59:23 -0700
Message-ID: <20160904225923.27993-1-steven@uplinklabs.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:36024 "EHLO
        mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752034AbcIDW72 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Sep 2016 18:59:28 -0400
Received: by mail-pa0-f67.google.com with SMTP id ez1so8351526pab.3
        for <linux-pm@vger.kernel.org>; Sun, 04 Sep 2016 15:59:28 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.com>, Steven Noonan <steven@uplinklabs.net>

Another case of incorrectly assuming the same return values as
'cpufreq_cpu_exists' (which used to return 0 on success).

Signed-off-by: Steven Noonan <steven@uplinklabs.net>
---
 tools/power/cpupower/bench/system.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/bench/system.c b/tools/power/cpupower/bench/system.c
index c25a74a..b05a979 100644
--- a/tools/power/cpupower/bench/system.c
+++ b/tools/power/cpupower/bench/system.c
@@ -61,9 +61,9 @@ int set_cpufreq_governor(char *governor, unsigned int cpu)
 
 	dprintf("set %s as cpufreq governor\n", governor);
 
-	if (cpupower_is_cpu_online(cpu) != 0) {
-		perror("cpufreq_cpu_exists");
-		fprintf(stderr, "error: cpu %u does not exist\n", cpu);
+	if (cpupower_is_cpu_online(cpu) != 1) {
+		perror("cpufreq_is_cpu_online");
+		fprintf(stderr, "error: cpu %u is not online\n", cpu);
 		return -1;
 	}
 
-- 
2.9.3

