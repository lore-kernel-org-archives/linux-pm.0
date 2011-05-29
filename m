From: Len Brown <lenb@kernel.org>
Subject: [PATCH 7/8] x86 idle: deprecate "no-hlt" cmdline param
Date: Sun, 29 May 2011 05:41:49 -0400
Message-ID: <cdaab4a0d330f70c0e5ad8c3f7c65c2e375ea180.1306662035.git.len.brown@intel.com>
References: <1306662110-29954-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1306662110-29954-1-git-send-email-lenb@kernel.org>
In-reply-to: <7467571f4480b273007517b26297c07154c73924.1306662035.git.len.brown@intel.com>
References: <7467571f4480b273007517b26297c07154c73924.1306662035.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, x86@kernel.org.#.39.x
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

We'd rather that modern machines not check if HLT works on
every entry into idle, for the benefit of machines that had
marginal electricals 15-years ago.  If those machines are still running
the upstream kernel, they can use "idle=poll".  The only difference
will be that they'll now invoke HLT in machine_hlt().

cc: x86@kernel.org # .39.x
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/feature-removal-schedule.txt |   11 +++++++++++
 arch/x86/kernel/cpu/bugs.c                 |    1 +
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index fc505c1..f1b0eb0 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -24,6 +24,17 @@ Who:	Len Brown <len.brown@intel.com>
 
 ----------------------------
 
+What:	x86_32 "no-hlt" cmdline param
+When:	2012
+Why:	remove a branch from idle path, simplify code used by everybody.
+	This option disabled the use of HLT in idle and machine_halt()
+	for hardware that was flakey 15-years ago.  Today we have
+	"idle=poll" that removed HLT from idle, and so if such a machine
+	is still running the upstream kernel, "idle=poll" is likely sufficient.
+Who:	Len Brown <len.brown@intel.com>
+
+----------------------------
+
 What:	PRISM54
 When:	2.6.34
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index c39576c..525514c 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -19,6 +19,7 @@
 
 static int __init no_halt(char *s)
 {
+	WARN_ONCE(1, "\"no-hlt\" is deprecated, please use \"idle=poll\"\n");
 	boot_cpu_data.hlt_works_ok = 0;
 	return 1;
 }
-- 
1.7.5.3.367.ga9930.dirty
