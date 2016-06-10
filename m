From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: PROBLEM: Resume form hibernate broken by setting NX on gap
Date: Fri, 10 Jun 2016 23:27:29 +0200
Message-ID: <34107887.ATgOLutrT1@vostro.rjw.lan>
References: <573DF82D.50006@deltatee.com> <575A3E95.5090100@deltatee.com> <CAGXu5jK15P5CAQd09NzG31YMPEKJGXbhXiYDQ2sRC=WBhAFTrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:55535 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753208AbcFJVX1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jun 2016 17:23:27 -0400
In-Reply-To: <CAGXu5jK15P5CAQd09NzG31YMPEKJGXbhXiYDQ2sRC=WBhAFTrA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Logan Gunthorpe <logang@deltatee.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>, Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>, the arch/x86 maintainers <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, Denys Vlasenko <dvlasenk@redhat.com>, Brian Gerst <brgerst@gmail.com>

On Friday, June 10, 2016 11:09:22 AM Kees Cook wrote:
> On Thu, Jun 9, 2016 at 9:14 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> > Hey,
> >
> > I've still be trying to figure this out as I have time.
> >
> > I tried printing a couple restore addresses and nothing I can find seems
> > anywhere near the rodata/ex_table boundary.
> >
> > I tried with the (badly formatted) below and got the following. Nothing too
> > surprising. I've attached a kallsyms that matches the kernel for reference.
> >
> > restore_code: ffff880157c3b000
> > jump_addr: ffffffff81446be0
> >
> >
> > diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.c
> > index 009947d..6efedb7 100644
> > --- a/arch/x86/power/hibernate_64.c
> > +++ b/arch/x86/power/hibernate_64.c
> > @@ -92,6 +92,9 @@ int swsusp_arch_resume(void)
> >         memcpy(relocated_restore_code, &core_restore_code,
> >                &restore_registers - &core_restore_code);
> >
> > +       pr_info("restore_code: %p\n", relocated_restore_code);
> > +       pr_info("jump_addr: %lx\n", restore_jump_address);
> > +
> 
> Also interesting would be the "relocated_restore_code" address, as
> well as a dump of /sys/kernel/debug/kernel_page_tables (from
> CONFIG_X86_PTDUMP).
> 
> I'm baffled by the problem, but the best I can understand is the the
> relocated_restore_code range isn't executable (which should be visible
> from finding it in /sys/kernel/debug/kernel_page_tables), but I don't
> see how to solve that since my original patch didn't work.
> 
> Rafael, is this something you have time to look at quickly?

Well, not really, but I'll do my best to look at it in the next few days.

Thanks,
Rafael

