From: Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH v2] x86: Load __USER_DS into DS/ES after resume
Date: Sun, 14 Jun 2015 10:22:32 -0400
Message-ID: <CAMzpN2he6J12HjRsGX+GzZNkmu4GF4apRgNputewEJji8JQ4VA@mail.gmail.com>
References: <20150612075013.GA8759@gmail.com>
	<A58C5D0E-A557-4406-9317-442D78E4700B@zytor.com>
	<20150612083625.GA22760@gmail.com>
	<CAMzpN2gHpsW9ZMBdOR8+VuMNkYyi_THVeX5W4JLukmFK95GjZQ@mail.gmail.com>
	<20150613070359.GB26502@gmail.com>
	<CALCETrX_goAyqMVdkZTnJwDCJgfz2osVVsNAt8Gv3ZqZMX85ZQ@mail.gmail.com>
	<CAMzpN2jyQWTEWd4sZosfkocDabu=CxiEVncp94+P+vHYjpicTw@mail.gmail.com>
	<20150614065635.GA5294@gmail.com>
	<CA+55aFzB9dYidEf_7Hs47FOF7WPPJnJQwj_RiwL--c5Gb1uqyw@mail.gmail.com>
	<20150614074922.GA30290@gmail.com>
	<20150614085735.GA22174@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:33461 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342AbbFNOWc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 14 Jun 2015 10:22:32 -0400
Received: by obcej4 with SMTP id ej4so49168814obc.0
        for <linux-pm@vger.kernel.org>; Sun, 14 Jun 2015 07:22:32 -0700 (PDT)
In-Reply-To: <20150614085735.GA22174@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Ingo Molnar <mingo@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Denys Vlasenko <dvlasenk@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, the arch/x86 maintainers <x86@kernel.org>, linux-pm <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@amacapital.net>, Peter Anvin <hpa@zytor.com>

On Sun, Jun 14, 2015 at 4:57 AM, Pavel Machek <pavel@ucw.cz> wrote:
> On Sun 2015-06-14 09:49:22, Ingo Molnar wrote:
>>
>> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>
>> > On Jun 13, 2015 8:56 PM, "Ingo Molnar" <mingo@kernel.org> wrote:
>> > >
>> > > Ok, so something like the patch below, right?
>> > >
>> > >         movw    $__KERNEL_DS, %ax
>> > >         movw    %ax, %ss
>> > > -       movw    %ax, %ds
>> > > -       movw    %ax, %es
>> > >         movw    %ax, %fs
>> > >         movw    %ax, %gs
>> > >
>> > > +       movw    $__KERNEL_DS, %ax
>> > > +       movw    %ax, %ds
>> > > +       movw    %ax, %es
>> >
>> > .. except with less cut-and-paste bugs.
>> >
>> > That second KERNEL should be USER.
>>
>> Yeah, doh :-/ Updated patch below.
>
> Do we want similar patch for 64-bit, too?
>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>
> diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
> index ae693b5..2ac2bc7 100644
> --- a/arch/x86/kernel/acpi/wakeup_64.S
> +++ b/arch/x86/kernel/acpi/wakeup_64.S
> @@ -18,10 +18,12 @@ ENTRY(wakeup_long64)
>         cmpq    %rdx, %rax
>         jne     bogus_64_magic
>
> -       movw    $__KERNEL_DS, %ax
> -       movw    %ax, %ss
> +       movw    $__USER_DS, %ax
>         movw    %ax, %ds
>         movw    %ax, %es
> +
> +       movw    $__KERNEL_DS, %ax
> +       movw    %ax, %ss
>         movw    %ax, %fs
>         movw    %ax, %gs
>         movq    saved_rsp, %rsp

64-bit is a different animal.  DS/ES are ignored in 64-bit mode, so
they are always userspace-owned, and only matter for 32-bit user
processes.  64-bit does currently save/restore these in
x86/power/cpu.c.

--
Brian Gerst
