From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: suspend to ram problem
Date: Sun, 03 Feb 2008 19:40:40 +0100
Message-ID: <47A60AA8.8050407__10812.1695615866$1202141044$gmane$org@free.fr>
References: <47A5C399.7010405@free.fr> <47A5DE60.1080402@free.fr>
	<200802031839.02397.rjw@sisk.pl> <20080203181855.GB1629@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080906030506040505070008"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080203181855.GB1629@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------080906030506040505070008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Pavel Machek wrote:
> On Sun 2008-02-03 18:39:01, Rafael J. Wysocki wrote:

>>> So the hang seems located in wakeup_start.
>> Hm.  Can you add unconditional BEEP after "jne bogus_real_magic" in
>> arch/x86/kernel/acpi/wakeup.S and see if it beeps?
I rewrite the beep tracer to generate small beep (I should clean the 
patch and try to submit it), and I only hear 2 beep.

So it crash when clearing the flags.

> 
> Hmm, maybe I know where problem could be. Try
> 
>         movl     $(wakeup_stack - wakeup_code), %esp              # Private stack is needed for ASUS bo\
> 
> instead of existing stack setup. That helped on one of my test-boxes
Thanks, I will try that.
Because clearing the flags imply pop/push in the stack it could be the 
problem

Matthieu

--------------080906030506040505070008
Content-Type: text/x-patch;
 name="beep_tracer.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="beep_tracer.diff"

--- /home/mat/tmp/wakeup.S	2008-02-03 19:20:26.000000000 +0100
+++ arch/i386/kernel/acpi/wakeup.S	2008-02-03 19:30:20.000000000 +0100
@@ -13,20 +13,47 @@
 # cs = 0x1234, eip = 0x05
 # 
 
+/* one ISA cycle @8Mhz */
+#define PAUSE outb %al, $0x80
+#define WAIT_100MS \
+	movl $800000, %eax; \
+	2: \
+	PAUSE; \
+	dec %eax; \
+	jne 2b
+
+/* What's the PIT rate */
+#define COUNT 0xf89
 #define BEEP \
-	inb	$97, %al; 	\
-	outb	%al, $0x80; 	\
-	movb	$3, %al; 	\
-	outb	%al, $97; 	\
-	outb	%al, $0x80; 	\
-	movb	$-74, %al; 	\
-	outb	%al, $67; 	\
-	outb	%al, $0x80; 	\
-	movb	$-119, %al; 	\
-	outb	%al, $66; 	\
-	outb	%al, $0x80; 	\
-	movb	$15, %al; 	\
-	outb	%al, $66;
+	/* enable counter 2 */ \
+	inb		$0x61, %al; 	\
+	PAUSE; 	\
+	orb	$3, %al; \
+	outb	%al, $0x61; 	\
+	PAUSE; 	\
+	/* set command for counter 2, 2 byte write */ \
+	movb	$0xB6, %al; 	\
+	outb	%al, $0x43; 	\
+	PAUSE; 	\
+	/* select desired HZ */ \
+	movb	$(COUNT & 0xff), %al; \
+	outb	%al, $0x42; 	\
+	PAUSE; 	\
+	movb	$(COUNT >> 8), %al; 	\
+	outb	%al, $0x42; \
+	WAIT_100MS; \
+	/* disable counter 2 */ \
+	inb		$0x61, %al; 	\
+	PAUSE; 	\
+	andb	$0xFC, %al; \
+	outb	%al, $0x61; \
+	WAIT_100MS
+
+#define CBEEP \
+	testl   $4, realmode_flags - wakeup_code; \
+	jz      1f; \
+	BEEP; \
+1:
 
 ALIGN
 	.align	4096
@@ -37,7 +64,8 @@
 
  	movw	$0xb800, %ax
 	movw	%ax,%fs
-	movw	$0x0e00 + 'L', %fs:(0x10)
+	#movw	$0x0e00 + 'L', %fs:(0x10)
+	CBEEP
 
 	cli
 	cld
@@ -47,19 +75,18 @@
 	movw	%ax, %ds					# Make ds:0 point to wakeup_start
 	movw	%ax, %ss
 
-	testl   $4, realmode_flags - wakeup_code
-	jz      1f
-	BEEP
-1:
 	mov	$(wakeup_stack - wakeup_code), %sp		# Private stack is needed for ASUS board
-	movw	$0x0e00 + 'S', %fs:(0x12)
+	#movw	$0x0e00 + 'S', %fs:(0x12)
+	CBEEP
 
 	pushl	$0						# Kill any dangerous flags
 	popfl
+	CBEEP
 
 	movl	real_magic - wakeup_code, %eax
 	cmpl	$0x12345678, %eax
 	jne	bogus_real_magic
+	CBEEP
 
 	testl	$1, realmode_flags - wakeup_code
 	jz	1f
@@ -79,6 +106,7 @@
 	movl	$swsusp_pg_dir-__PAGE_OFFSET, %eax
 	movl	%eax, %cr3
 
+	CBEEP
 	testl	$1, real_efer_save_restore - wakeup_code
 	jz	4f
 	# restore efer setting
@@ -87,12 +115,14 @@
 	mov     $0xc0000080, %ecx
 	wrmsr
 4:
+	CBEEP
 	# make sure %cr4 is set correctly (features, etc)
 	movl	real_save_cr4 - wakeup_code, %eax
 	movl	%eax, %cr4
 	movw	$0xb800, %ax
 	movw	%ax,%fs
-	movw	$0x0e00 + 'i', %fs:(0x12)
+	#movw	$0x0e00 + 'i', %fs:(0x12)
+	CBEEP
 	
 	# need a gdt -- use lgdtl to force 32-bit operands, in case
 	# the GDT is located past 16 megabytes.
@@ -102,15 +132,14 @@
 	movl	%eax, %cr0
 	jmp 1f
 1:
-	movw	$0x0e00 + 'n', %fs:(0x14)
+	#movw	$0x0e00 + 'n', %fs:(0x14)
+	CBEEP
 
 	movl	real_magic - wakeup_code, %eax
 	cmpl	$0x12345678, %eax
 	jne	bogus_real_magic
 
-	testl   $8, realmode_flags - wakeup_code
-	jz      1f
-	BEEP
+	CBEEP
 1:
 	ljmpl	$__KERNEL_CS, $wakeup_pmode_return
 
@@ -128,7 +157,8 @@
 real_save_efer_eax: 	.long 0
 
 bogus_real_magic:
-	movw	$0x0e00 + 'B', %fs:(0x12)
+	BEEP
+	#movw	$0x0e00 + 'B', %fs:(0x12)
 	jmp bogus_real_magic
 
 /* This code uses an extended set of video mode numbers. These include:
@@ -194,7 +224,7 @@
 	movw	%ax, %es
 	movw	%ax, %fs
 	movw	%ax, %gs
-	movw	$0x0e00 + 'u', 0xb8016
+	#movw	$0x0e00 + 'u', 0xb8016
 
 	# reload the gdt, as we need the full 32 bit address
 	lgdt	saved_gdt
@@ -218,7 +248,7 @@
 	jmp	*%eax
 
 bogus_magic:
-	movw	$0x0e00 + 'B', 0xb8018
+	#movw	$0x0e00 + 'B', 0xb8018
 	jmp	bogus_magic
 
 

--------------080906030506040505070008
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080906030506040505070008--
