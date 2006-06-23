From: Andrew Morton <akpm@osdl.org>
Subject: Re: swsusp regression [Was: 2.6.17-mm1]
Date: Fri, 23 Jun 2006 12:57:06 -0700
Message-ID: <20060623125706.69dafffd.akpm@osdl.org>
References: <20060621034857.35cfe36f.akpm@osdl.org>
	<4499BE99.6010508@gmail.com>
	<20060621221445.GB3798@inferi.kami.home>
	<20060622061905.GD15834@kroah.com>
	<20060622004648.f1912e34.akpm@osdl.org>
	<20060622160403.GB2539@slug>
	<20060622092506.da2a8bf4.akpm@osdl.org>
	<20060623090206.GA2234@slug> <20060623091016.GE4940@elf.ucw.cz>
	<20060623121210.GB2234@slug> <20060623125658.GB8048@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060623125658.GB8048@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: deweerdt@free.fr, linux-kernel@vger.kernel.org, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Fri, 23 Jun 2006 14:57:01 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> > Stack: c0229b71 00000046 00000000 00000286 c0383ca7 f6cb9ecc c013b242 0=
0000003
> >         00000000 00000003 f6cb9ee0 c013b2e8 00000003 c0436890 f6c9a003 =
f6cb9f08
> >         c013b481 00000003 00000003 00000246 c1788b00 00000003 c04368a0 =
c043692c
> > Call Trace:
> >  <c0103eea> show_stack_log_lvl+0x92/0xb7  <c0104100> show_registers+0x1=
a3/0x21b
> >  <c0104319> die+0x117/0x230  <c03627a6> do_page_fault+0x39c/0x72a
> >  <c0103b2f> error_code+0x4f/0x54  <c013b242> suspend_enter+0x2f/0x52
> >  <c013b2e8> enter_state+0x4b/0x8d  <c013b481> state_store+0xa0/0xa2
> >  <c01a5151> subsys_attr_store+0x37/0x41  <c01a53d2> flush_write_buffer+=
0x3c/0x46
> >  <c01a5443> sysfs_write_file+0x67/0x8b  <c0166bb6> vfs_write+0x1b9/0x1be
> >  <c0166c7b> sys_write+0x4b/0x75  <c010300f> sysenter_past_esp+0x54/0x75
> > =

> > Code: 05 c4 42 43 c0 31 43 43 c0 c3 8b 2d 68 6e 54 c0 8b 1d 60 6e 54 c0=
 8b 35 6c 6e 54 c0 8b 3d 70 6d 54 c0 ff 35 74 6e 54 c0 9d c3 90 <e8> 6d 38 =
ea ff e8 a2 ff ff ff 6a 03 e8 ec b6 de ff 83 c4 04 c3
> > EIP: [c043431c>] do_suspend_lowlevel+0x0/0x15 SS:ESP 0068:f6cb6ea4
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> =

> Ha, wait a moment, this is interesting line. Can you trace down which
> instruction causes this?
> =

> We recently changed pagetable handling during swsusp, perhaps thats
> it? It went to Linus few minutes ago...

That's a good possibility.  It does appear to be oopsing at the first
instruction of arch/i386/kernel/acpi/wakeup.S:do_suspend_lowlevel(). =

Perhaps there's enough info in that oops trace to tell us whether it was
the instruction fetch which oopsed.

One wonders whether this will help...

--- a/arch/i386/kernel/acpi/wakeup.S~a
+++ a/arch/i386/kernel/acpi/wakeup.S
@@ -270,6 +270,7 @@ ALIGN
 ENTRY(saved_magic)	.long	0
 ENTRY(saved_eip)	.long	0
 =

+.text
 save_registers:
 	leal	4(%esp), %eax
 	movl	%eax, saved_context_esp
@@ -304,6 +305,7 @@ ret_point:
 	call	restore_processor_state
 	ret
 =

+.data
 ALIGN
 # saved registers
 saved_gdt:	.long	0,0
_
