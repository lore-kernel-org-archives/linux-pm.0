From: Len Brown <lenb@kernel.org>
Subject: [PATCH 44/44] tools/power turbostat: version 17.02.24
Date: Wed,  1 Mar 2017 00:27:48 -0500
Message-ID: <e3942ed8c66bcff496abee5182422cd542962d9e.1488345270.git.len.brown@intel.com>
References: <20170301052748.27810-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170301052748.27810-1-lenb@kernel.org>
In-Reply-To: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
References: <678a3bd1b3de6d2ebf604e7d708bc8150bb667e9.1488345270.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

The turbostat before this last set of changes is obsolete.
This new version can do a lot more, but it also has
some different defaults, that might catch some off-guard.
So it seems a good time to give a new version number.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 5216549957f4..828dccd3f01e 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4578,7 +4578,7 @@ int get_and_dump_counters(void)
 }
 
 void print_version() {
-	fprintf(outf, "turbostat version 4.17 10 Jan 2017"
+	fprintf(outf, "turbostat version 17.02.24"
 		" - Len Brown <lenb@kernel.org>\n");
 }
 
-- 
2.11.0.161.g6610af872
