From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/2] tools/power turbostat: additional Haswell CPU-id
Date: Wed, 17 Apr 2013 18:42:17 -0400
Message-ID: <149c2319c6316d979de90ce2c8665e9c02d5927b.1366238380.git.len.brown@intel.com>
References: <1366238537-14443-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366238537-14443-1-git-send-email-lenb@kernel.org>
In-Reply-To: <0b15841b0bbbde75134a777c543dc51fe6187108.1366238380.git.len.brown@intel.com>
References: <0b15841b0bbbde75134a777c543dc51fe6187108.1366238380.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

There is an additional HSW CPU-id, 0x46,
which has C-states exactly like CPU-id 0x45.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 6f3214e..321e066 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1421,6 +1421,7 @@ int has_nehalem_turbo_ratio_limit(unsigned int family, unsigned int model)
 	case 0x3C:	/* HSW */
 	case 0x3F:	/* HSW */
 	case 0x45:	/* HSW */
+	case 0x46:	/* HSW */
 		return 1;
 	case 0x2E:	/* Nehalem-EX Xeon - Beckton */
 	case 0x2F:	/* Westmere-EX Xeon - Eagleton */
@@ -1515,6 +1516,7 @@ void rapl_probe(unsigned int family, unsigned int model)
 	case 0x3C:	/* HSW */
 	case 0x3F:	/* HSW */
 	case 0x45:	/* HSW */
+	case 0x46:	/* HSW */
 		do_rapl = RAPL_PKG | RAPL_CORES | RAPL_GFX;
 		break;
 	case 0x2D:
@@ -1754,6 +1756,7 @@ int is_snb(unsigned int family, unsigned int model)
 	case 0x3C:	/* HSW */
 	case 0x3F:	/* HSW */
 	case 0x45:	/* HSW */
+	case 0x46:	/* HSW */
 		return 1;
 	}
 	return 0;
@@ -2276,7 +2279,7 @@ int main(int argc, char **argv)
 	cmdline(argc, argv);
 
 	if (verbose)
-		fprintf(stderr, "turbostat v3.2 February 11, 2013"
+		fprintf(stderr, "turbostat v3.3 March 15, 2013"
 			" - Len Brown <lenb@kernel.org>\n");
 
 	turbostat_init();
-- 
1.8.2.1.422.gdcd8c09
