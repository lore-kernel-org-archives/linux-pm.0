From: Sedat Dilek <sedat.dilek@googlemail.com>
Subject: [PATCH] x86: Fix ACPI wakeup build failure
Date: Tue,  8 Mar 2011 22:39:24 +0100
Message-ID: <1299620364-21644-1-git-send-email-sedat.dilek__26062.7252785072$1299620450$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
Cc: Alexander van Heukelum <heukelum@fastmail.fm>, Len Brown <len.brown@intel.com>, "H.J. Lu" <hjl.tools@gmail.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-next@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Sedat Dilek <sedat.dilek@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

This fixes the following breakage in linux-next (next-20110308):
  AS      arch/x86/kernel/acpi/wakeup_rm.o
  arch/x86/kernel/acpi/wakeup_rm.S: Assembler messages:
  arch/x86/kernel/acpi/wakeup_rm.S:12: Error: .size expression with symbol `wakeup_code_start' does not evaluate to a constant

The issue was introduced by commit d1ee433539ea5963a8f946f3428b335d1c5fdb20:
"x86, trampoline: Use the unified trampoline setup for ACPI wakeup"

The problem was discovered while using Debian's binutils (2.21.0.20110302-1)
and experimenting with binutils from upstream.

Thanks Alexander and H.J. for the vital help.

CC: Alexander van Heukelum <heukelum@fastmail.fm>
CC: "H.J. Lu" <hjl.tools@gmail.com>
CC: Len Brown <len.brown@intel.com>
CC: Pavel Machek <pavel@ucw.cz>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: "H. Peter Anvin" <hpa@zytor.com>
CC: x86@kernel.org
CC: linux-pm@lists.linux-foundation.org
CC: linux-kernel@vger.kernel.org
CC: linux-next@vger.kernel.org
Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 arch/x86/kernel/acpi/wakeup_rm.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_rm.S b/arch/x86/kernel/acpi/wakeup_rm.S
index 6ce81ee..63b8ab5 100644
--- a/arch/x86/kernel/acpi/wakeup_rm.S
+++ b/arch/x86/kernel/acpi/wakeup_rm.S
@@ -9,4 +9,4 @@
 	.globl	acpi_wakeup_code
 acpi_wakeup_code:
 	.incbin	"arch/x86/kernel/acpi/realmode/wakeup.bin"
-	.size	wakeup_code_start, .-wakeup_code_start
+	.size	acpi_wakeup_code, .-acpi_wakeup_code
-- 
1.7.4.1
