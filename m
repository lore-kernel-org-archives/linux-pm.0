From: Len Brown <lenb@kernel.org>
Subject: [PATCH 05/18] x86 idle: deprecate "no-hlt" cmdline param
Date: Sat, 02 Apr 2011 02:22:47 -0400
Message-ID: <e0077c3d7a17abee4911ddd83d4d968fd1c0203d.1301724243.git.len.brown__39423.3565465131$1301725820$gmane$org@intel.com>
References: <alpine.LFD.2.02.1104010020280.2797@x980>
	<1301725380-10579-1-git-send-email-lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1301725380-10579-1-git-send-email-lenb@kernel.org>
In-reply-to: <c82cf78992a66bfa7f0c82aeb20ba6922127463b.1301724243.git.len.brown@intel.com>
References: <c82cf78992a66bfa7f0c82aeb20ba6922127463b.1301724243.git.len.brown@intel.com>
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
Cc: Len Brown <len.brown@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Len Brown <len.brown@intel.com>

We'd rather that modern machines not check if HLT works on
every entry into idle, for the benefit of machines that had
marginal electricals 15-years ago.  If those machines are still running
the upstream kernel, they can use "idle=poll".  The only difference
will be that they'll now invoke HLT in machine_hlt().

cc: x86@kernel.org
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/feature-removal-schedule.txt |   11 +++++++++++
 arch/x86/kernel/cpu/bugs.c                 |    1 +
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index bab1acb..f587159 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -24,6 +24,17 @@ Who:	Len Brown <len.brown@intel.com>
 
 ----------------------------
 
+What:	x86_32 "no-hlt" cmdline param
+When:	2.6.40
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
1.7.5.rc0
