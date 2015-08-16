From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/7] tools/power turbostat: fix parameter passing for forked command
Date: Sat, 15 Aug 2015 23:25:45 -0400
Message-ID: <a01e72fbc41e322ed229465de8b595a7e3ec6549.1439695194.git.len.brown@intel.com>
References: <1439695548-21174-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439695548-21174-1-git-send-email-lenb@kernel.org>
In-Reply-To: <75fd7ffa7fab91c2c3234bd3e465ba4f366733f4.1439695194.git.len.brown@intel.com>
References: <75fd7ffa7fab91c2c3234bd3e465ba4f366733f4.1439695194.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

turbostat supports forked command when sampling cpu state. However,
the forked command is not allowed to be executed with options, otherwise
turbostat might regard these options as invalid turbostat options.

For example:

./turbostat stress -c 4 -t 10
./turbostat: unrecognized option '-t'

Reported-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5a793be..915eb28 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -3118,7 +3118,7 @@ void cmdline(int argc, char **argv)
 
 	progname = argv[0];
 
-	while ((opt = getopt_long_only(argc, argv, "C:c:Ddhi:JM:m:PpST:v",
+	while ((opt = getopt_long_only(argc, argv, "+C:c:Ddhi:JM:m:PpST:v",
 				long_options, &option_index)) != -1) {
 		switch (opt) {
 		case 'C':
-- 
2.5.0.330.g130be8e
