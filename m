From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 03/19] x86: unify power/cpu_(32|64) global
	variables
Date: Thu, 11 Jun 2009 22:34:58 +0000 (UTC)
Message-ID: <S4AoGnG.A.aF.zaYMKB@chimera>
References: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Date: Thu Jun 11 23:25:58 CEST 2009
In-Reply-To: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM List <linux-pm@lists.linux-foundation.org>
Cc: Sergio Luis <sergio@larces.uece.br>, Lauro Salmito <laurosalmito@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Magnus Damm <damm@igel.co.jp>, Ingo Molnar <mingo@elte.hu>, Wu Fengguang <fengguang.wu@intel.com>, Jaswinder Singh Rajput <jaswinder@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Sergio Luis <sergio@larces.uece.br>

Aiming total unification of cpu_32.c and cpu_64.c, in this step
we do unify the global variables and existing forward declarations
for such files.

Signed-off-by: Sergio Luis <sergio@larces.uece.br>
Signed-off-by: Lauro Salmito <laurosalmito@gmail.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86/power/cpu_32.c |    7 +++++++
 arch/x86/power/cpu_64.c |   10 ++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/x86/power/cpu_32.c b/arch/x86/power/cpu_32.c
index 12a9c87..de1a86b 100644
--- a/arch/x86/power/cpu_32.c
+++ b/arch/x86/power/cpu_32.c
@@ -18,12 +18,19 @@
 #include <asm/xcr.h>
 #include <asm/suspend.h>
 
+#ifdef CONFIG_X86_32
 static struct saved_context saved_context;
 
 unsigned long saved_context_ebx;
 unsigned long saved_context_esp, saved_context_ebp;
 unsigned long saved_context_esi, saved_context_edi;
 unsigned long saved_context_eflags;
+#else
+/* CONFIG_X86_64 */
+static void fix_processor_context(void);
+
+struct saved_context saved_context;
+#endif
 
 static void __save_processor_state(struct saved_context *ctxt)
 {
diff --git a/arch/x86/power/cpu_64.c b/arch/x86/power/cpu_64.c
index 39b27b7..6ce0eca 100644
--- a/arch/x86/power/cpu_64.c
+++ b/arch/x86/power/cpu_64.c
@@ -19,9 +19,19 @@
 #include <asm/xcr.h>
 #include <asm/suspend.h>
 
+#ifdef CONFIG_X86_32
+static struct saved_context saved_context;
+
+unsigned long saved_context_ebx;
+unsigned long saved_context_esp, saved_context_ebp;
+unsigned long saved_context_esi, saved_context_edi;
+unsigned long saved_context_eflags;
+#else
+/* CONFIG_X86_64 */
 static void fix_processor_context(void);
 
 struct saved_context saved_context;
+#endif
 
 /**
  *	__save_processor_state - save CPU registers before creating a
-- 
1.5.2.4
