From: Chen Yu <yu.c.chen@intel.com>
Subject: [v2 RFC PATCH] tools/power turbostat: fix parameter passing for forked command
Date: Fri, 24 Jul 2015 14:05:52 +0800
Message-ID: <1437717952-12322-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:24022 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751050AbbGXGCi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 24 Jul 2015 02:02:38 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: len.brown@intel.com, rafael.j.wysocki@intel.com, rui.zhang@intel.com, Chen Yu <yu.c.chen@intel.com>

turbostat supports forked command when sampling cpu state. However,
the forked command is not allowed to be executed with options, otherwise
turbostat might regard these options as invalid turbostat options.
For example:

./turbostat stress -c 4 -t 10
./turbostat: unrecognized option '-t'

This patch solves this problem by pre-pending a '+' to getopt_long's
optstring to prevent it from permuting the arguments.

Suggested-by: Len Brown <lenb@kernel.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 323b65e..c71cce3 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3042,7 +3042,7 @@ void cmdline(int argc, char **argv)
 
 	progname = argv[0];
 
-	while ((opt = getopt_long_only(argc, argv, "C:c:Ddhi:JM:m:PpST:v",
+	while ((opt = getopt_long_only(argc, argv, "+C:c:Ddhi:JM:m:PpST:v",
 				long_options, &option_index)) != -1) {
 		switch (opt) {
 		case 'C':
-- 
1.9.1

