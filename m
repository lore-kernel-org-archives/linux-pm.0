From: Len Brown <lenb@kernel.org>
Subject: [PATCH 1/7] tools/power turbostat: Repair Segmentation fault when using -i option
Date: Wed, 14 Nov 2012 15:43:18 -0500
Message-ID: <39300ffb9b6666714c60735cf854e1280e4e75f4.1352925508.git.len.brown@intel.com>
References: <1352925804-6746-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352925804-6746-1-git-send-email-lenb@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Fix regression caused by commit 8e180f3cb6b7510a3bdf14e16ce87c9f5d86f102
(tools/power turbostat: add [-d MSR#][-D MSR#] options to print counter
deltas)

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 2655ae9..9942dee 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1594,7 +1594,7 @@ void cmdline(int argc, char **argv)
 
 	progname = argv[0];
 
-	while ((opt = getopt(argc, argv, "+pPSvisc:sC:m:M:")) != -1) {
+	while ((opt = getopt(argc, argv, "+pPSvi:sc:sC:m:M:")) != -1) {
 		switch (opt) {
 		case 'p':
 			show_core_only++;
-- 
1.8.0
