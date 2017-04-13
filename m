From: Len Brown <lenb@kernel.org>
Subject: [PATCH 7/7] tools/power turbostat: update version number
Date: Wed, 12 Apr 2017 20:08:53 -0400
Message-ID: <5f9bf02a58f0f62d111994805212d0a775499862.1492041840.git.len.brown@intel.com>
References: <20170413000853.21648-1-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170413000853.21648-1-lenb@kernel.org>
In-Reply-To: <22048c5485503749754b3b5daf9d99ef89fcacdc.1492041840.git.len.brown@intel.com>
References: <22048c5485503749754b3b5daf9d99ef89fcacdc.1492041840.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 0ad966114e58..b11294730771 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -4578,7 +4578,7 @@ int get_and_dump_counters(void)
 }
 
 void print_version() {
-	fprintf(outf, "turbostat version 17.02.24"
+	fprintf(outf, "turbostat version 17.04.12"
 		" - Len Brown <lenb@kernel.org>\n");
 }
 
-- 
2.11.0.161.g6610af872
