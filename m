From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 3/3] cpupower: Enable disabled Cstates if they are below max latency
Date: Thu, 22 Oct 2015 17:17:07 +0200
Message-ID: <1445527027-2764-4-git-send-email-trenn@suse.de>
References: <1445527027-2764-1-git-send-email-trenn@suse.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60381 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751290AbbJVPRP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 22 Oct 2015 11:17:15 -0400
In-Reply-To: <1445527027-2764-1-git-send-email-trenn@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, prarit@redhat.com, jtanenba@redhat.com, Thomas Renninger <trenn@suse.de>

cpupower idle-set -D <latency>
currently only disables all C-states that have a higher latency than the
specified <latency>. But if deep sleep states were already disabled and
have a lower latency, they should get enabled again.

For example:
This call:
cpupower idle-set -D 30
disables all C-states with a higher or equal latency than 30.
If one then calls:
cpupower idle-set -D 100
C-states with a latency between 30-99 will get enabled again with this patch
now. It is ensured that only C-states with a latency of 100 and higher are
disabled.

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 tools/power/cpupower/man/cpupower-idle-set.1 |  4 +++-
 tools/power/cpupower/utils/cpuidle-set.c     | 17 +++++++++++++----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/power/cpupower/man/cpupower-idle-set.1 b/tools/power/cpupower/man/cpupower-idle-set.1
index 3e6799d..580c4e3 100644
--- a/tools/power/cpupower/man/cpupower-idle-set.1
+++ b/tools/power/cpupower/man/cpupower-idle-set.1
@@ -20,7 +20,9 @@ Disable a specific processor sleep state.
 Enable a specific processor sleep state.
 .TP
 \fB\-D\fR \fB\-\-disable-by-latency\fR <LATENCY>
-Disable all idle states with a equal or higher latency than <LATENCY>
+Disable all idle states with a equal or higher latency than <LATENCY>.
+
+Enable all idle states with a latency lower than <LATENCY>.
 .TP
 \fB\-E\fR \fB\-\-enable-all\fR
 Enable all idle states if not enabled already.
diff --git a/tools/power/cpupower/utils/cpuidle-set.c b/tools/power/cpupower/utils/cpuidle-set.c
index 9a9b7a3..eaea130 100644
--- a/tools/power/cpupower/utils/cpuidle-set.c
+++ b/tools/power/cpupower/utils/cpuidle-set.c
@@ -148,12 +148,21 @@ int cmd_idle_set(int argc, char **argv)
 					(cpu, idlestate);
 				state_latency = sysfs_get_idlestate_latency
 					(cpu, idlestate);
-				if (disabled == 1 || latency > state_latency)
+				if (disabled == 1) {
+					if (latency > state_latency){
+						ret = sysfs_idlestate_disable
+							(cpu, idlestate, 0);
+						if (ret == 0)
+		printf(_("Idlestate %u enabled on CPU %u\n"),  idlestate, cpu);
+					}
 					continue;
-				ret = sysfs_idlestate_disable
-					(cpu, idlestate, 1);
-				if (ret == 0)
+				}
+				if (latency <= state_latency){
+					ret = sysfs_idlestate_disable
+						(cpu, idlestate, 1);
+					if (ret == 0)
 		printf(_("Idlestate %u disabled on CPU %u\n"), idlestate, cpu);
+				}
 			}
 			break;
 		case 'E':
-- 
2.1.4

