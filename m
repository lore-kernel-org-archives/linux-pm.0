From: Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH] x86: General protection fault after STR (32 bit systems only)
Date: Fri, 12 Jun 2015 11:48:22 -0400
Message-ID: <CAMzpN2gHpsW9ZMBdOR8+VuMNkYyi_THVeX5W4JLukmFK95GjZQ@mail.gmail.com>
References: <1434066338-6619-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	<20150612060747.GA25024@gmail.com>
	<CALCETrUfrbLeJoOeNQU2vK+jAmNBazB5rmfD5M11tv6NVeppmg@mail.gmail.com>
	<20150612075013.GA8759@gmail.com>
	<A58C5D0E-A557-4406-9317-442D78E4700B@zytor.com>
	<20150612083625.GA22760@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f195.google.com ([209.85.214.195]:35053 "EHLO
	mail-ob0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbbFLPsW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 12 Jun 2015 11:48:22 -0400
In-Reply-To: <20150612083625.GA22760@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@amacapital.net>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, X86 ML <x86@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Denys Vlasenko <dvlasenk@redhat.com>, Borislav Petkov <bp@alien8.de>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, Jun 12, 2015 at 4:36 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * H. Peter Anvin <hpa@zytor.com> wrote:
>
>> %es is used implicitly by string instructions.
>
> Ok, so we are probably better off reloading ES as well early, right
> when we return from the firmware, just in case something does
> a copy before we hit the ES restore in restore_processor_state(),
> which is a generic C function?
>
> Something like the patch below?
>
> I also added FS/GS/SS reloading to make it complete. If this (or a variant
> thereof, it's still totally untested) works then we can remove the segment
> save/restore layer in __save/restore_processor_state().
>
> Thanks,
>
>         Ingo
>
> ===========>
>  arch/x86/kernel/acpi/wakeup_32.S | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
> index 665c6b7d2ea9..1376a7fc21b7 100644
> --- a/arch/x86/kernel/acpi/wakeup_32.S
> +++ b/arch/x86/kernel/acpi/wakeup_32.S
> @@ -61,6 +61,19 @@ ENTRY(wakeup_pmode_return)
>
>
>  restore_registers:
> +       /*
> +        * In case the BIOS corrupted our segment descriptors,
> +        * reload them to clear out any shadow descriptor
> +        * state:
> +        */
> +       movl    $__USER_DS, %eax
> +       movl    %eax, %ds
> +       movl    %eax, %es
> +       movl    %eax, %fs
> +       movl    %eax, %gs
> +       movl    $__KERNEL_DS, %eax
> +       movl    %eax, %ss
> +
>         movl    saved_context_ebp, %ebp
>         movl    saved_context_ebx, %ebx
>         movl    saved_context_esi, %esi

If you follow the convoluted flow of the calls in this file,
wakeup_pmode_return is the first thing called from the trampoline on
resume, and that loads the data segments with __KERNEL_DS.  The better
fix would be to set ds/es to __USER_DS there.  Also since we are in
the kernel, fs is fixed at __KERNEL_PERCPU, and gs is either
__KERNEL_STACK_CANARY or user's gs.

--
Brian Gerst
