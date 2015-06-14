From: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH v2] x86: Load __USER_DS into DS/ES after resume
Date: Sun, 14 Jun 2015 09:49:22 +0200
Message-ID: <20150614074922.GA30290@gmail.com>
References: <CALCETrUfrbLeJoOeNQU2vK+jAmNBazB5rmfD5M11tv6NVeppmg@mail.gmail.com>
 <20150612075013.GA8759@gmail.com>
 <A58C5D0E-A557-4406-9317-442D78E4700B@zytor.com>
 <20150612083625.GA22760@gmail.com>
 <CAMzpN2gHpsW9ZMBdOR8+VuMNkYyi_THVeX5W4JLukmFK95GjZQ@mail.gmail.com>
 <20150613070359.GB26502@gmail.com>
 <CALCETrX_goAyqMVdkZTnJwDCJgfz2osVVsNAt8Gv3ZqZMX85ZQ@mail.gmail.com>
 <CAMzpN2jyQWTEWd4sZosfkocDabu=CxiEVncp94+P+vHYjpicTw@mail.gmail.com>
 <20150614065635.GA5294@gmail.com>
 <CA+55aFzB9dYidEf_7Hs47FOF7WPPJnJQwj_RiwL--c5Gb1uqyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:34127 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbbFNHt1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 14 Jun 2015 03:49:27 -0400
Received: by wibut5 with SMTP id ut5so49463587wib.1
        for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2015 00:49:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+55aFzB9dYidEf_7Hs47FOF7WPPJnJQwj_RiwL--c5Gb1uqyw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, the arch/x86 maintainers <x86@kernel.org>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Andy Lutomirski <luto@amacapital.net>, Brian Gerst <brgerst@gmail.com>, Peter Anvin <hpa@zytor.com>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Jun 13, 2015 8:56 PM, "Ingo Molnar" <mingo@kernel.org> wrote:
> >
> > Ok, so something like the patch below, right?
> >
> >         movw    $__KERNEL_DS, %ax
> >         movw    %ax, %ss
> > -       movw    %ax, %ds
> > -       movw    %ax, %es
> >         movw    %ax, %fs
> >         movw    %ax, %gs
> >
> > +       movw    $__KERNEL_DS, %ax
> > +       movw    %ax, %ds
> > +       movw    %ax, %es
> 
> .. except with less cut-and-paste bugs.
> 
> That second KERNEL should be USER.

Yeah, doh :-/ Updated patch below.

Thanks,

	Ingo

=====
 arch/x86/kernel/acpi/wakeup_32.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
index 665c6b7d2ea9..0c26b1b44e51 100644
--- a/arch/x86/kernel/acpi/wakeup_32.S
+++ b/arch/x86/kernel/acpi/wakeup_32.S
@@ -12,11 +12,13 @@ ENTRY(wakeup_pmode_return)
 wakeup_pmode_return:
 	movw	$__KERNEL_DS, %ax
 	movw	%ax, %ss
-	movw	%ax, %ds
-	movw	%ax, %es
 	movw	%ax, %fs
 	movw	%ax, %gs
 
+	movw	$__USER_DS, %ax
+	movw	%ax, %ds
+	movw	%ax, %es
+
 	# reload the gdt, as we need the full 32 bit address
 	lidt	saved_idt
 	lldt	saved_ldt
