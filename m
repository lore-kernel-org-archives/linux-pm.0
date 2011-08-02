From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/2] tools/power turbostat: fit output into 80
	columns on snb-ep
Date: Tue, 02 Aug 2011 18:36:07 -0400
Message-ID: <d30c4b7a87e8b19583d5ef1402d9b38f51e30f44.1312324497.git.len.brown@intel.com>
References: <1312324567-4374-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1312324567-4374-1-git-send-email-lenb@kernel.org>
In-reply-to: <e4c0d0e22ce5cf84b3993b5af6c2dac08d52f06b.1312324497.git.len.brown@intel.com>
References: <e4c0d0e22ce5cf84b3993b5af6c2dac08d52f06b.1312324497.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

Reduce columns for package number to 1.
If you can afford more than 9 packages,
you can also afford a terminal with more than 80 columns:-)

Also shave a column also off the package C-states

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c |   46 ++++++++++++++++----------------
 1 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 6d8ef4a..8b2d37b 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -128,34 +128,34 @@ unsigned long long get_msr(int cpu, off_t offset)
 void print_header(void)
 {
 	if (show_pkg)
-		fprintf(stderr, "pkg ");
+		fprintf(stderr, "pk");
 	if (show_core)
-		fprintf(stderr, "core");
+		fprintf(stderr, " cr");
 	if (show_cpu)
 		fprintf(stderr, " CPU");
 	if (do_nhm_cstates)
-		fprintf(stderr, "   %%c0 ");
+		fprintf(stderr, "    %%c0 ");
 	if (has_aperf)
-		fprintf(stderr, "  GHz");
+		fprintf(stderr, " GHz");
 	fprintf(stderr, "  TSC");
 	if (do_nhm_cstates)
-		fprintf(stderr, "   %%c1 ");
+		fprintf(stderr, "    %%c1");
 	if (do_nhm_cstates)
-		fprintf(stderr, "   %%c3 ");
+		fprintf(stderr, "    %%c3");
 	if (do_nhm_cstates)
-		fprintf(stderr, "   %%c6 ");
+		fprintf(stderr, "    %%c6");
 	if (do_snb_cstates)
-		fprintf(stderr, "   %%c7 ");
+		fprintf(stderr, "    %%c7");
 	if (do_snb_cstates)
-		fprintf(stderr, "  %%pc2 ");
+		fprintf(stderr, "  %%pc2");
 	if (do_nhm_cstates)
-		fprintf(stderr, "  %%pc3 ");
+		fprintf(stderr, "  %%pc3");
 	if (do_nhm_cstates)
-		fprintf(stderr, "  %%pc6 ");
+		fprintf(stderr, "  %%pc6");
 	if (do_snb_cstates)
-		fprintf(stderr, "  %%pc7 ");
+		fprintf(stderr, "  %%pc7");
 	if (extra_msr_offset)
-		fprintf(stderr, "       MSR 0x%x ", extra_msr_offset);
+		fprintf(stderr, "        MSR 0x%x ", extra_msr_offset);
 
 	putc('\n', stderr);
 }
@@ -194,14 +194,14 @@ void print_cnt(struct counters *p)
 	/* topology columns, print blanks on 1st (average) line */
 	if (p == cnt_average) {
 		if (show_pkg)
-			fprintf(stderr, "    ");
+			fprintf(stderr, " ");
 		if (show_core)
 			fprintf(stderr, "    ");
 		if (show_cpu)
 			fprintf(stderr, "    ");
 	} else {
 		if (show_pkg)
-			fprintf(stderr, "%4d", p->pkg);
+			fprintf(stderr, "%d", p->pkg);
 		if (show_core)
 			fprintf(stderr, "%4d", p->core);
 		if (show_cpu)
@@ -241,22 +241,22 @@ void print_cnt(struct counters *p)
 		if (!skip_c1)
 			fprintf(stderr, "%7.2f", 100.0 * p->c1/p->tsc);
 		else
-			fprintf(stderr, "   ****");
+			fprintf(stderr, "  ****");
 	}
 	if (do_nhm_cstates)
-		fprintf(stderr, "%7.2f", 100.0 * p->c3/p->tsc);
+		fprintf(stderr, " %6.2f", 100.0 * p->c3/p->tsc);
 	if (do_nhm_cstates)
-		fprintf(stderr, "%7.2f", 100.0 * p->c6/p->tsc);
+		fprintf(stderr, " %6.2f", 100.0 * p->c6/p->tsc);
 	if (do_snb_cstates)
-		fprintf(stderr, "%7.2f", 100.0 * p->c7/p->tsc);
+		fprintf(stderr, " %6.2f", 100.0 * p->c7/p->tsc);
 	if (do_snb_cstates)
-		fprintf(stderr, "%7.2f", 100.0 * p->pc2/p->tsc);
+		fprintf(stderr, " %5.2f", 100.0 * p->pc2/p->tsc);
 	if (do_nhm_cstates)
-		fprintf(stderr, "%7.2f", 100.0 * p->pc3/p->tsc);
+		fprintf(stderr, " %5.2f", 100.0 * p->pc3/p->tsc);
 	if (do_nhm_cstates)
-		fprintf(stderr, "%7.2f", 100.0 * p->pc6/p->tsc);
+		fprintf(stderr, " %5.2f", 100.0 * p->pc6/p->tsc);
 	if (do_snb_cstates)
-		fprintf(stderr, "%7.2f", 100.0 * p->pc7/p->tsc);
+		fprintf(stderr, " %5.2f", 100.0 * p->pc7/p->tsc);
 	if (extra_msr_offset)
 		fprintf(stderr, "  0x%016llx", p->extra_msr);
 	putc('\n', stderr);
-- 
1.7.6.396.ge0613
