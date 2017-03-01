From: Len Brown <lenb@kernel.org>
Subject: [PATCH 43/44] tools/power turbostat: bugfix: --add u32 was printed as u64
Date: Wed,  1 Mar 2017 00:27:47 -0500
Message-ID: <5f3aea57773dc7f788e374994636ffc0234a355f.1488345270.git.len.brown@intel.com>
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

When the "u32" keyword is used with --add, it means that
the output should be truncated to 32-bits.  This was not
happening and all 64-bits were printed.

Also, when no column name was used for an added MSR,
The default column name was in deximal, eg. MSR16.
Users report that they tend to use hex MSR numbers,
so print them in hex.  To always fit into the columns,
use the syntax M0x10.  Note that the user can always
supply any column header that they want.

eg --add msr0x10,MY_TSC

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 2d758abecd56..5216549957f4 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -834,7 +834,7 @@ int format_counters(struct thread_data *t, struct core_data *c,
 	for (i = 0, mp = sys.tp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 32)
-				outp += sprintf(outp, "%s0x%08lx", (printed++ ? delim : ""), (unsigned long) t->counter[i]);
+				outp += sprintf(outp, "%s0x%08x", (printed++ ? delim : ""), (unsigned int) t->counter[i]);
 			else
 				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), t->counter[i]);
 		} else if (mp->format == FORMAT_DELTA) {
@@ -876,7 +876,7 @@ int format_counters(struct thread_data *t, struct core_data *c,
 	for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 32)
-				outp += sprintf(outp, "%s0x%08lx", (printed++ ? delim : ""), (unsigned long) c->counter[i]);
+				outp += sprintf(outp, "%s0x%08x", (printed++ ? delim : ""), (unsigned int) c->counter[i]);
 			else
 				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), c->counter[i]);
 		} else if (mp->format == FORMAT_DELTA) {
@@ -967,7 +967,7 @@ int format_counters(struct thread_data *t, struct core_data *c,
 	for (i = 0, mp = sys.pp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 32)
-				outp += sprintf(outp, "%s0x%08lx", (printed++ ? delim : ""), (unsigned long) p->counter[i]);
+				outp += sprintf(outp, "%s0x%08x", (printed++ ? delim : ""), (unsigned int) p->counter[i]);
 			else
 				outp += sprintf(outp, "%s0x%016llx", (printed++ ? delim : ""), p->counter[i]);
 		} else if (mp->format == FORMAT_DELTA) {
@@ -4732,22 +4732,10 @@ void parse_add_command(char *add_command)
 
 	/* generate default column header */
 	if (*name_buffer == '\0') {
-		if (format == FORMAT_RAW) {
-			if (width == 32)
-				sprintf(name_buffer, "msr%d", msr_num);
-			else
-				sprintf(name_buffer, "MSR%d", msr_num);
-		} else if (format == FORMAT_DELTA) {
-			if (width == 32)
-				sprintf(name_buffer, "cnt%d", msr_num);
-			else
-				sprintf(name_buffer, "CNT%d", msr_num);
-		} else if (format == FORMAT_PERCENT) {
-			if (width == 32)
-				sprintf(name_buffer, "msr%d%%", msr_num);
-			else
-				sprintf(name_buffer, "MSR%d%%", msr_num);
-		}
+		if (width == 32)
+			sprintf(name_buffer, "M0x%x%s", msr_num, format == FORMAT_PERCENT ? "%" : "");
+		else
+			sprintf(name_buffer, "M0X%x%s", msr_num, format == FORMAT_PERCENT ? "%" : "");
 	}
 
 	if (add_counter(msr_num, path, name_buffer, width, scope, type, format, 0))
-- 
2.11.0.161.g6610af872
