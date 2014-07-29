From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 3/3] cpupower: Remove redundant error check
Date: Tue, 29 Jul 2014 18:12:20 +0200
Message-ID: <1406650340-38644-3-git-send-email-trenn@suse.de>
References: <2377922.j9jRKZAKtD@vostro.rjw.lan>
 <1406650340-38644-1-git-send-email-trenn@suse.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48925 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063AbaG2QMw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 29 Jul 2014 12:12:52 -0400
In-Reply-To: <1406650340-38644-1-git-send-email-trenn@suse.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, Peter Senna Tschudin <peter.senna@gmail.com>, Thomas Renninger <trenn@suse.de>

From: Peter Senna Tschudin <peter.senna@gmail.com>

Remove double checks, and move the call to print_error to the
first check. Replace break by return, and return 0 on success.
The simplified version of the coccinelle semantic patch that
fixes this issue is as follows:

// <smpl>
@@
expression E; identifier pr; expression list es;
@@
for(...;...;...){
...
-	if (E) break;
+	if (E){
+		pr(es);
+		break;
+	}
...
}
- if(E) pr(es);
// </smpl>

Untested.

Signed-off-by: Peter Senna Tschudin <peter.senna@gmail.com>
Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 tools/power/cpupower/utils/cpufreq-set.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/utils/cpufreq-set.c b/tools/power/cpupower/utils/cpufreq-set.c
index a416de8..f656e58 100644
--- a/tools/power/cpupower/utils/cpufreq-set.c
+++ b/tools/power/cpupower/utils/cpufreq-set.c
@@ -320,12 +320,11 @@ int cmd_freq_set(int argc, char **argv)
 
 		printf(_("Setting cpu: %d\n"), cpu);
 		ret = do_one_cpu(cpu, &new_pol, freq, policychange);
-		if (ret)
-			break;
+		if (ret) {
+			print_error();
+			return ret;
+		}
 	}
 
-	if (ret)
-		print_error();
-
-	return ret;
+	return 0;
 }
-- 
1.7.6.1

