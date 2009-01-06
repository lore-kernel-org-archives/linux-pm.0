From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/2] kprobes: check CONFIG_FREEZER instead of
	CONFIG_PM
Date: Tue, 6 Jan 2009 21:15:32 +0100
Message-ID: <200901062115.33286.rjw__11067.8286677741$1231273218$gmane$org@sisk.pl>
References: <200901062112.29227.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901062112.29227.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Cheng Renquan <crquan@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Masami Hiramatsu <mhiramat@redhat.com>
List-Id: linux-pm@vger.kernel.org

From: Masami Hiramatsu <mhiramat@redhat.com>

Check CONFIG_FREEZER instead of CONFIG_PM because kprobe booster
depends on freeze_processes() and thaw_processes() when CONFIG_PREEMPT=y.

This fixes a linkage error which occurs when CONFIG_PREEMPT=y, CONFIG_PM=y
and CONFIG_FREEZER=n.

Reported-by: Cheng Renquan <crquan@gmail.com>
Signed-off-by: Masami Hiramatsu <mhiramat@redhat.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/ia64/kernel/kprobes.c |    2 +-
 arch/x86/kernel/kprobes.c  |    2 +-
 kernel/kprobes.c           |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/arch/ia64/kernel/kprobes.c
===================================================================
--- linux-2.6.orig/arch/ia64/kernel/kprobes.c
+++ linux-2.6/arch/ia64/kernel/kprobes.c
@@ -868,7 +868,7 @@ static int __kprobes pre_kprobes_handler
 		return 1;
 
 ss_probe:
-#if !defined(CONFIG_PREEMPT) || defined(CONFIG_PM)
+#if !defined(CONFIG_PREEMPT) || defined(CONFIG_FREEZER)
 	if (p->ainsn.inst_flag == INST_FLAG_BOOSTABLE && !p->post_handler) {
 		/* Boost up -- we can execute copied instructions directly */
 		ia64_psr(regs)->ri = p->ainsn.slot;
Index: linux-2.6/arch/x86/kernel/kprobes.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/kprobes.c
+++ linux-2.6/arch/x86/kernel/kprobes.c
@@ -445,7 +445,7 @@ void __kprobes arch_prepare_kretprobe(st
 static void __kprobes setup_singlestep(struct kprobe *p, struct pt_regs *regs,
 				       struct kprobe_ctlblk *kcb)
 {
-#if !defined(CONFIG_PREEMPT) || defined(CONFIG_PM)
+#if !defined(CONFIG_PREEMPT) || defined(CONFIG_FREEZER)
 	if (p->ainsn.boostable == 1 && !p->post_handler) {
 		/* Boost up -- we can execute copied instructions directly */
 		reset_current_kprobe();
Index: linux-2.6/kernel/kprobes.c
===================================================================
--- linux-2.6.orig/kernel/kprobes.c
+++ linux-2.6/kernel/kprobes.c
@@ -122,7 +122,7 @@ static int collect_garbage_slots(void);
 static int __kprobes check_safety(void)
 {
 	int ret = 0;
-#if defined(CONFIG_PREEMPT) && defined(CONFIG_PM)
+#if defined(CONFIG_PREEMPT) && defined(CONFIG_FREEZER)
 	ret = freeze_processes();
 	if (ret == 0) {
 		struct task_struct *p, *q;
