From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 7/9] cpupower: cpupower info -b should return 0 on success, not the perf bias value
Date: Tue, 13 May 2014 12:41:44 +0200
Message-ID: <1399977706-50854-8-git-send-email-trenn@suse.de>
References: <1399977706-50854-1-git-send-email-trenn@suse.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51397 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760658AbaEMKlx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 13 May 2014 06:41:53 -0400
In-Reply-To: <1399977706-50854-1-git-send-email-trenn@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.de>

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 tools/power/cpupower/utils/cpupower-info.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/utils/cpupower-info.c b/tools/power/cpupower/utils/cpupower-info.c
index 3f68632..0ac2577 100644
--- a/tools/power/cpupower/utils/cpupower-info.c
+++ b/tools/power/cpupower/utils/cpupower-info.c
@@ -125,11 +125,12 @@ int cmd_info(int argc, char **argv)
 		if (params.perf_bias) {
 			ret = msr_intel_get_perf_bias(cpu);
 			if (ret < 0) {
-				printf(_("Could not read perf-bias value\n"));
-				break;
+				fprintf(stderr,
+			_("Could not read perf-bias value[%d]\n"), ret);
+				exit(EXIT_FAILURE);
 			} else
 				printf(_("perf-bias: %d\n"), ret);
 		}
 	}
-	return ret;
+	return 0;
 }
-- 
1.7.6.1

