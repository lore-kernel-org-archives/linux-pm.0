From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 2/3] cpupower: Remove debug message when using cpupower idle-set -D switch
Date: Thu, 22 Oct 2015 17:17:06 +0200
Message-ID: <1445527027-2764-3-git-send-email-trenn@suse.de>
References: <1445527027-2764-1-git-send-email-trenn@suse.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60380 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756613AbbJVPRP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 22 Oct 2015 11:17:15 -0400
In-Reply-To: <1445527027-2764-1-git-send-email-trenn@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, prarit@redhat.com, jtanenba@redhat.com, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 tools/power/cpupower/utils/cpuidle-set.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/power/cpupower/utils/cpuidle-set.c b/tools/power/cpupower/utils/cpuidle-set.c
index d45d8d7..9a9b7a3 100644
--- a/tools/power/cpupower/utils/cpuidle-set.c
+++ b/tools/power/cpupower/utils/cpuidle-set.c
@@ -148,8 +148,6 @@ int cmd_idle_set(int argc, char **argv)
 					(cpu, idlestate);
 				state_latency = sysfs_get_idlestate_latency
 					(cpu, idlestate);
-				printf("CPU: %u - idlestate %u - state_latency: %llu - latency: %llu\n",
-				       cpu, idlestate, state_latency, latency);
 				if (disabled == 1 || latency > state_latency)
 					continue;
 				ret = sysfs_idlestate_disable
-- 
2.1.4

