From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/14] tools/power turbostat: less verbose
	debugging
Date: Sun, 06 Nov 2011 23:11:51 -0500
Message-ID: <aeae1e92daec5a38b40ad12598b97501b675a381.1320636776.git.len.brown@intel.com>
References: <1320639124-16178-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1320639124-16178-1-git-send-email-lenb@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

dump only the counters which are active

Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 6d8ef4a..dd2d1a2 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -162,19 +162,21 @@ void print_header(void)
 
 void dump_cnt(struct counters *cnt)
 {
-	fprintf(stderr, "package: %d ", cnt->pkg);
-	fprintf(stderr, "core:: %d ", cnt->core);
-	fprintf(stderr, "CPU: %d ", cnt->cpu);
-	fprintf(stderr, "TSC: %016llX\n", cnt->tsc);
-	fprintf(stderr, "c3: %016llX\n", cnt->c3);
-	fprintf(stderr, "c6: %016llX\n", cnt->c6);
-	fprintf(stderr, "c7: %016llX\n", cnt->c7);
-	fprintf(stderr, "aperf: %016llX\n", cnt->aperf);
-	fprintf(stderr, "pc2: %016llX\n", cnt->pc2);
-	fprintf(stderr, "pc3: %016llX\n", cnt->pc3);
-	fprintf(stderr, "pc6: %016llX\n", cnt->pc6);
-	fprintf(stderr, "pc7: %016llX\n", cnt->pc7);
-	fprintf(stderr, "msr0x%x: %016llX\n", extra_msr_offset, cnt->extra_msr);
+	if (!cnt)
+		return;
+	if (cnt->pkg) fprintf(stderr, "package: %d ", cnt->pkg);
+	if (cnt->core) fprintf(stderr, "core:: %d ", cnt->core);
+	if (cnt->cpu) fprintf(stderr, "CPU: %d ", cnt->cpu);
+	if (cnt->tsc) fprintf(stderr, "TSC: %016llX\n", cnt->tsc);
+	if (cnt->c3) fprintf(stderr, "c3: %016llX\n", cnt->c3);
+	if (cnt->c6) fprintf(stderr, "c6: %016llX\n", cnt->c6);
+	if (cnt->c7) fprintf(stderr, "c7: %016llX\n", cnt->c7);
+	if (cnt->aperf) fprintf(stderr, "aperf: %016llX\n", cnt->aperf);
+	if (cnt->pc2) fprintf(stderr, "pc2: %016llX\n", cnt->pc2);
+	if (cnt->pc3) fprintf(stderr, "pc3: %016llX\n", cnt->pc3);
+	if (cnt->pc6) fprintf(stderr, "pc6: %016llX\n", cnt->pc6);
+	if (cnt->pc7) fprintf(stderr, "pc7: %016llX\n", cnt->pc7);
+	if (cnt->extra_msr) fprintf(stderr, "msr0x%x: %016llX\n", extra_msr_offset, cnt->extra_msr);
 }
 
 void dump_list(struct counters *cnt)
-- 
1.7.7.rc0.72.g4b5ea
