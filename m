From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] x86 suspend: Sanitize wakeup_64.S
Date: Sun, 26 Oct 2008 20:42:19 +0100
Message-ID: <200810262042.20295.rjw__2985.39906875721$1225050092$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: Ingo Molnar <mingo@elte.hu>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

Hi,

Please queue as .29 material.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: x86 suspend: Sanitize wakeup_64.S

Segment registers are already set by head_64.S, which jumps into
wakeup_64.S, to the same values that wakeup_64.S wants them to
contain.  Remove the unnecessary initialization of segment registers
from wakeup_64.S.

Add hlt into the endless loop under bogus_64_magic.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86/kernel/acpi/wakeup_64.S |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index bcc2934..0c5bf2f 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -19,12 +19,6 @@ wakeup_long64:
 	cmpq	%rdx, %rax
 	jne	bogus_64_magic
 
-	movw	$__KERNEL_DS, %ax
-	movw	%ax, %ss	
-	movw	%ax, %ds
-	movw	%ax, %es
-	movw	%ax, %fs
-	movw	%ax, %gs
 	movq	saved_rsp, %rsp
 
 	movq	saved_rbx, %rbx
@@ -36,6 +30,7 @@ wakeup_long64:
 	jmp	*%rax
 
 bogus_64_magic:
+	hlt
 	jmp	bogus_64_magic
 
 	.align 2
-- 
1.5.6
