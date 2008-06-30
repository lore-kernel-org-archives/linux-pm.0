From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFT] x86 acpi: normalize segment descriptor register on
	resume
Date: Tue, 1 Jul 2008 01:48:01 +0200
Message-ID: <200807010148.02135.rjw__44879.3701864362$1214869740$gmane$org@sisk.pl>
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
To: kernel-testers@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The appended patch fixes a regression and is considered as 2.6.26 material.
Everyone having a box with working suspend to RAM is gently requested to test
it and verify if it doesn't break things.

The patch applies to the current -git.

Thanks,
Rafael

---
From: H. Peter Anvin <hpa@zytor.com>

x86 acpi: normalize segment descriptor register on resume

Some Dell laptops enter resume with apparent garbage in the segment
descriptor registers (almost certainly the result of a botched
transition from protected to real mode.)  The only way to clean that
up is to enter protected mode ourselves and clean out the descriptor
registers.

This fixes resume on Dell XPS M1210 and Dell D620.

Reference: http://bugzilla.kernel.org/show_bug.cgi?id=10927

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
Tested-by: Kirill A. Shutemov <kirill@shutemov.name>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86/kernel/acpi/realmode/wakeup.S |   38 ++++++++++++++++++++++++++++++++-
 arch/x86/kernel/acpi/realmode/wakeup.h |    5 ++++
 arch/x86/kernel/acpi/sleep.c           |   16 +++++++++++++
 drivers/acpi/sleep/main.c              |    5 +---
 4 files changed, 59 insertions(+), 5 deletions(-)

Index: linux-2.6/arch/x86/kernel/acpi/realmode/wakeup.S
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/realmode/wakeup.S
+++ linux-2.6/arch/x86/kernel/acpi/realmode/wakeup.S
@@ -5,6 +5,7 @@
 #include <asm/msr-index.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
+#include <asm/processor-flags.h>
 
 	.code16
 	.section ".header", "a"
@@ -24,6 +25,11 @@ pmode_gdt:	.quad	0
 realmode_flags:	.long	0
 real_magic:	.long	0
 trampoline_segment:	.word 0
+_pad1:		.byte	0
+wakeup_jmp:	.byte	0xea	/* ljmpw */
+wakeup_jmp_off:	.word	3f
+wakeup_jmp_seg:	.word	0
+wakeup_gdt:	.quad	0, 0, 0
 signature:	.long	0x51ee1111
 
 	.text
@@ -34,11 +40,34 @@ _start:
 	cli
 	cld
 
+	/* Apparently some dimwit BIOS programmers don't know how to
+	   program a PM to RM transition, and we might end up here with
+	   junk in the data segment descriptor registers.  The only way
+	   to repair that is to go into PM and fix it ourselves... */
+	movw	$16, %cx
+	lgdtl	%cs:wakeup_gdt
+	movl	%cr0, %eax
+	orb	$X86_CR0_PE, %al
+	movl	%eax, %cr0
+	jmp	1f
+1:	ljmpw	$8, $2f
+2:
+	movw	%cx, %ds
+	movw	%cx, %es
+	movw	%cx, %ss
+	movw	%cx, %fs
+	movw	%cx, %gs
+
+	andb	$~X86_CR0_PE, %al
+	movl	%eax, %cr0
+	jmp	wakeup_jmp
+3:
 	/* Set up segments */
 	movw	%cs, %ax
 	movw	%ax, %ds
 	movw	%ax, %es
 	movw	%ax, %ss
+	lidtl	wakeup_idt
 
 	movl	$wakeup_stack_end, %esp
 
@@ -98,7 +127,14 @@ bogus_real_magic:
 	jmp	1b
 
 	.data
-	.balign	4
+	.balign	8
+
+	/* This is the standard real-mode IDT */
+wakeup_idt:
+	.word	0xffff		/* limit */
+	.long	0		/* address */
+	.word	0
+
 	.globl	HEAP, heap_end
 HEAP:
 	.long	wakeup_heap
Index: linux-2.6/arch/x86/kernel/acpi/realmode/wakeup.h
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/realmode/wakeup.h
+++ linux-2.6/arch/x86/kernel/acpi/realmode/wakeup.h
@@ -24,6 +24,11 @@ struct wakeup_header {
 	u32 realmode_flags;
 	u32 real_magic;
 	u16 trampoline_segment;	/* segment with trampoline code, 64-bit only */
+	u8  _pad1;
+	u8  wakeup_jmp;
+	u16 wakeup_jmp_off;
+	u16 wakeup_jmp_seg;
+	u64 wakeup_gdt[3];
 	u32 signature;		/* To check we have correct structure */
 } __attribute__((__packed__));
 
Index: linux-2.6/arch/x86/kernel/acpi/sleep.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/acpi/sleep.c
+++ linux-2.6/arch/x86/kernel/acpi/sleep.c
@@ -50,6 +50,20 @@ int acpi_save_state_mem(void)
 
 	header->video_mode = saved_video_mode;
 
+	header->wakeup_jmp_seg = acpi_wakeup_address >> 4;
+	/* GDT[0]: GDT self-pointer */
+	header->wakeup_gdt[0] =
+		(u64)(sizeof(header->wakeup_gdt) - 1) +
+		((u64)(acpi_wakeup_address +
+			((char *)&header->wakeup_gdt - (char *)acpi_realmode))
+				<< 16);
+	/* GDT[1]: real-mode-like code segment */
+	header->wakeup_gdt[1] = (0x009bULL << 40) +
+		((u64)acpi_wakeup_address << 16) + 0xffff;
+	/* GDT[2]: real-mode-like data segment */
+	header->wakeup_gdt[2] = (0x0093ULL << 40) +
+		((u64)acpi_wakeup_address << 16) + 0xffff;
+
 #ifndef CONFIG_64BIT
 	store_gdt((struct desc_ptr *)&header->pmode_gdt);
 
@@ -111,7 +125,7 @@ void __init acpi_reserve_bootmem(void)
 		return;
 	}
 
-	acpi_wakeup_address = acpi_realmode;
+	acpi_wakeup_address = virt_to_phys((void *)acpi_realmode);
 }
 
 
Index: linux-2.6/drivers/acpi/sleep/main.c
===================================================================
--- linux-2.6.orig/drivers/acpi/sleep/main.c
+++ linux-2.6/drivers/acpi/sleep/main.c
@@ -32,9 +32,8 @@ static int acpi_sleep_prepare(u32 acpi_s
 		if (!acpi_wakeup_address) {
 			return -EFAULT;
 		}
-		acpi_set_firmware_waking_vector((acpi_physical_address)
-						virt_to_phys((void *)
-							     acpi_wakeup_address));
+		acpi_set_firmware_waking_vector(
+				(acpi_physical_address)acpi_wakeup_address);
 
 	}
 	ACPI_FLUSH_CPU_CACHE();
