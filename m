From: Thomas Renninger <trenn@suse.com>
Subject: [PATCH 5/5] cpupower: fix how "cpupower frequency-info" interprets latency
Date: Tue,  1 Dec 2015 17:14:17 +0100
Message-ID: <1448986457-12844-6-git-send-email-trenn@suse.com>
References: <1448986457-12844-1-git-send-email-trenn@suse.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49855 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755585AbbLAQOV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 1 Dec 2015 11:14:21 -0500
In-Reply-To: <1448986457-12844-1-git-send-email-trenn@suse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Jacob Tanenbaum <jtanenba@redhat.com>, Thomas Renninger <trenn@suse.com>

From: Jacob Tanenbaum <jtanenba@redhat.com>

the intel-pstate driver does not support the ondemand governor and does not
have a valid value in
/sys/devices/system/cpu/cpu[x]/cpufreq/cpuinfo_transition_latency. The
intel-pstate driver sets cpuinfo_transition_latency to CPUFREQ_ETERNAL (-1),
the value written into cpuinfo_transition_latency is defind as an unsigned
int so checking the read value against max unsigned int will determine if the
value is valid.

Signed-off-by: Jacob Tanenbaum <jtanenba@redhat.com>
Signed-off-by: Thomas Renninger <trenn@suse.com>
---
 tools/power/cpupower/utils/cpufreq-info.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-info.c b/tools/power/cpupower/utils/cpufreq-info.c
index c13bc8c..8f3f5bb 100644
--- a/tools/power/cpupower/utils/cpufreq-info.c
+++ b/tools/power/cpupower/utils/cpufreq-info.c
@@ -434,8 +434,8 @@ static int get_latency(unsigned int cpu, unsigned int human)
 	unsigned long latency = cpufreq_get_transition_latency(cpu);
 
 	printf(_("  maximum transition latency: "));
-	if (!latency) {
-		printf(_(" Cannot determine latency.\n"));
+	if (!latency || latency == UINT_MAX) {
+		printf(_(" Cannot determine or is not supported.\n"));
 		return -EINVAL;
 	}
 
-- 
2.1.4

