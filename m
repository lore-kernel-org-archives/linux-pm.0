From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] x86 acpi: on wakeup,
	ljmp directly after writing CR0.PE
Date: Sun, 26 Oct 2008 20:38:50 +0100
Message-ID: <200810262038.51149.rjw__3537.45351681045$1225049893$gmane$org@sisk.pl>
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
To: Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Ingo, Peter,

I have this patch in my queue, is it necessary or should I drop it?

Rafael

---
From: H. Peter Anvin <hpa@zytor.com>
Subject: x86 acpi: on wakeup, ljmp directly after writing CR0.PE

Impact: possible resume failures on AMD Elan, others?

Intel documents that writing cr0 should be immediately followed by a
ljmp, and that "failures are readily seen" if the processor enters SMM
at this point.  We believe this has been observed on the AMD Elan, so
stick strictly to the script and do an ljmp immediately after a change
to CR0.PE in all circumstances.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86/kernel/acpi/realmode/wakeup.S |   11 ++++-------
 arch/x86/kernel/acpi/realmode/wakeup.h |    6 ++----
 arch/x86/kernel/acpi/sleep.c           |    4 +++-
 3 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/acpi/realmode/wakeup.S b/arch/x86/kernel/acpi/realmode/wakeup.S
index 3355973..7e54e40 100644
--- a/arch/x86/kernel/acpi/realmode/wakeup.S
+++ b/arch/x86/kernel/acpi/realmode/wakeup.S
@@ -25,10 +25,8 @@ pmode_gdt:	.quad	0
 realmode_flags:	.long	0
 real_magic:	.long	0
 trampoline_segment:	.word 0
-_pad1:		.byte	0
-wakeup_jmp:	.byte	0xea	/* ljmpw */
-wakeup_jmp_off:	.word	3f
-wakeup_jmp_seg:	.word	0
+wakeup_seg_ptr:	.word	3f-2	/* the segment in the ljmpw */
+_pad:		.long	0
 wakeup_gdt:	.quad	0, 0, 0
 signature:	.long	0x51ee1111
 
@@ -49,8 +47,7 @@ _start:
 	movl	%cr0, %eax
 	orb	$X86_CR0_PE, %al
 	movl	%eax, %cr0
-	jmp	1f
-1:	ljmpw	$8, $2f
+	ljmpw	$8, $2f
 2:
 	movw	%cx, %ds
 	movw	%cx, %es
@@ -60,7 +57,7 @@ _start:
 
 	andb	$~X86_CR0_PE, %al
 	movl	%eax, %cr0
-	jmp	wakeup_jmp
+	ljmpw	$0, $3f
 3:
 	/* Set up segments */
 	movw	%cs, %ax
diff --git a/arch/x86/kernel/acpi/realmode/wakeup.h b/arch/x86/kernel/acpi/realmode/wakeup.h
index 69d38d0..0dcdbc7 100644
--- a/arch/x86/kernel/acpi/realmode/wakeup.h
+++ b/arch/x86/kernel/acpi/realmode/wakeup.h
@@ -24,10 +24,8 @@ struct wakeup_header {
 	u32 realmode_flags;
 	u32 real_magic;
 	u16 trampoline_segment;	/* segment with trampoline code, 64-bit only */
-	u8  _pad1;
-	u8  wakeup_jmp;
-	u16 wakeup_jmp_off;
-	u16 wakeup_jmp_seg;
+	u16 wakeup_seg_ptr;
+	u32 _pad;
 	u64 wakeup_gdt[3];
 	u32 signature;		/* To check we have correct structure */
 } __attribute__((__packed__));
diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 806b4e9..f8a12a8 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -36,6 +36,7 @@ static char temp_stack[4096];
 int acpi_save_state_mem(void)
 {
 	struct wakeup_header *header;
+	u16 *wakeup_seg;
 
 	if (!acpi_realmode) {
 		printk(KERN_ERR "Could not allocate memory during boot, "
@@ -45,6 +46,7 @@ int acpi_save_state_mem(void)
 	memcpy((void *)acpi_realmode, &wakeup_code_start, WAKEUP_SIZE);
 
 	header = (struct wakeup_header *)(acpi_realmode + HEADER_OFFSET);
+	wakeup_seg = (u16 *)(acpi_realmode + header->wakeup_seg_ptr);
 	if (header->signature != 0x51ee1111) {
 		printk(KERN_ERR "wakeup header does not match\n");
 		return -EINVAL;
@@ -52,7 +54,7 @@ int acpi_save_state_mem(void)
 
 	header->video_mode = saved_video_mode;
 
-	header->wakeup_jmp_seg = acpi_wakeup_address >> 4;
+	*wakeup_seg = acpi_wakeup_address >> 4;
 
 	/*
 	 * Set up the wakeup GDT.  We set these up as Big Real Mode,
-- 
1.5.6
