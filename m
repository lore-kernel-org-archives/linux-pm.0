From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFT] x86 acpi: normalize segment descriptor
	register on resume
Date: Sat, 12 Jul 2008 20:51:24 +0200
Message-ID: <200807122051.25634.rjw__21381.7756194205$1215888678$gmane$org@sisk.pl>
References: <200807010148.02135.rjw@sisk.pl> <486A96C1.2020106@firstfloor.org>
	<48784F51.1010407@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <48784F51.1010407@myrealbox.com>
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
To: Andy Lutomirski <luto@myrealbox.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, kernel-testers@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Saturday, 12 of July 2008, Andy Lutomirski wrote:
> My Lenovo X61s fails to resume if I suspend it from within X, on both 
> 2.6.26-rc9 and recent wireless-testing.  2.6.26-rc8 is fine, as is 
> wireless-testing with 4b4f7280 reverted.  My in-progress bisect between 
> -rc8 and -rc9 is also consistent with this being the problem.
> 
> The symptom is that, when I push the power button to resume, the hard 
> drive light turns on, the fan turns on, then the hard drive light turns 
> off, the sleep light stays on, and the fan keeps running.  Sometimes the 
> battery light will blink off very briefly (1/4 sec, maybe) every few 
> seconds.  The system is locked hard at this point.
> 
> I'm using Ubuntu Hardy userspace.

Well, that's bad.

There is the bugzilla entry at http://bugzilla.kernel.org/show_bug.cgi?id=11064
for this bug and you've just confirmed my suspicion that this particular
commit is to blame.

Can you please see if the appended patch changes anything?

Thanks,
Rafael

---
From: H. Peter Anvin <hpa@zytor.com>
Date: Mon, 30 Jun 2008 23:48:35 -0700
Subject: [PATCH] x86 acpi: on wakeup, ljmp directly after writing CR0.PE

Impact: possible resume failures on AMD Elan, others?

Intel documents that writing cr0 should be immediately followed by a
ljmp, and that "failures are readily seen" if the processor enters SMM
at this point.  We believe this has been observed on the AMD Elan, so
stick strictly to the script and do an ljmp immediately after a change
to CR0.PE in all circumstances.

Signed-off-by: H. Peter Anvin <hpa@zytor.com>
---
 arch/x86/kernel/acpi/realmode/wakeup.S |   11 ++++-------
 arch/x86/kernel/acpi/realmode/wakeup.h |    6 ++----
 arch/x86/kernel/acpi/sleep.c           |    4 +++-
 3 files changed, 9 insertions(+), 12 deletions(-)

Index: linux-next/arch/x86/kernel/acpi/realmode/wakeup.S
===================================================================
--- linux-next.orig/arch/x86/kernel/acpi/realmode/wakeup.S
+++ linux-next/arch/x86/kernel/acpi/realmode/wakeup.S
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
Index: linux-next/arch/x86/kernel/acpi/realmode/wakeup.h
===================================================================
--- linux-next.orig/arch/x86/kernel/acpi/realmode/wakeup.h
+++ linux-next/arch/x86/kernel/acpi/realmode/wakeup.h
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
Index: linux-next/arch/x86/kernel/acpi/sleep.c
===================================================================
--- linux-next.orig/arch/x86/kernel/acpi/sleep.c
+++ linux-next/arch/x86/kernel/acpi/sleep.c
@@ -34,6 +34,7 @@ static char temp_stack[10240];
 int acpi_save_state_mem(void)
 {
 	struct wakeup_header *header;
+	u16 *wakeup_seg;
 
 	if (!acpi_realmode) {
 		printk(KERN_ERR "Could not allocate memory during boot, "
@@ -43,6 +44,7 @@ int acpi_save_state_mem(void)
 	memcpy((void *)acpi_realmode, &wakeup_code_start, WAKEUP_SIZE);
 
 	header = (struct wakeup_header *)(acpi_realmode + HEADER_OFFSET);
+	wakeup_seg = (u16 *)(acpi_realmode + header->wakeup_seg_ptr);
 	if (header->signature != 0x51ee1111) {
 		printk(KERN_ERR "wakeup header does not match\n");
 		return -EINVAL;
@@ -50,7 +52,7 @@ int acpi_save_state_mem(void)
 
 	header->video_mode = saved_video_mode;
 
-	header->wakeup_jmp_seg = acpi_wakeup_address >> 4;
+	*wakeup_seg = acpi_wakeup_address >> 4;
 	/* GDT[0]: GDT self-pointer */
 	header->wakeup_gdt[0] =
 		(u64)(sizeof(header->wakeup_gdt) - 1) +
