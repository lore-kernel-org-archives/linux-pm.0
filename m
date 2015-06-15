From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH, DEBUG] x86/32: Add small delay after resume
Date: Mon, 15 Jun 2015 09:10:27 -0700
Message-ID: <1434384627.2353.47.camel@spandruv-DESK3.jf.intel.com>
References: <1434066338-6619-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	 <20150612060747.GA25024@gmail.com>
	 <1434125724.2353.19.camel@spandruv-DESK3.jf.intel.com>
	 <20150613071547.GA27446@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:21232 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754052AbbFOQMc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 15 Jun 2015 12:12:32 -0400
In-Reply-To: <20150613071547.GA27446@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, pavel@ucw.cz, rjw@rjwysocki.net, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Denys Vlasenko <dvlasenk@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Kleen, Andi" <andi.kleen@intel.com>

On Sat, 2015-06-13 at 09:15 +0200, Ingo Molnar wrote:
> * Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> 
> > >  Also, could you please describe how the failure triggers in your system: how 
> > > many times do you have to suspend/resume to trigger the segfaults, and is 
> > > there anything that makes the failures less or more likely?
> >
> > It is very random. Sometimes only few hundred trys reproduce this issue. Some 
> > other times it requires thousands of trys (sometimes not reproducible at all for 
> > days) It is very time sensitive.
> 
> So the very same kernel image will produce different crash patterns depending on 
> the time of day? That suggests heat/hardware problems.
> 
> > [...] A small delay or some debug code in resume path prevents this to crash.
> 
> Fun...
> 
> > The BIOS folks created special version to check if they are corrupting any DS, 
> > but they were not able to catch any corruption. [...]
> 
> So is it true that we always execute wakeup_pmode_return first after we return 
> from the BIOS?
> 
> If so then the BIOS touching DS cannot be an issue, as we re-initialize all 
> segment selectors, which reloads the descriptors:
> 
> ENTRY(wakeup_pmode_return)
> wakeup_pmode_return:
>         movw    $__KERNEL_DS, %ax
>         movw    %ax, %ss
>         movw    %ax, %ds
>         movw    %ax, %es
>         movw    %ax, %fs
>         movw    %ax, %gs
> 
>         # reload the gdt, as we need the full 32 bit address
>         lidt    saved_idt
>         lldt    saved_ldt
>         ljmp    $(__KERNEL_CS), $1f
> 
> > [...] Since these are special deployed systems running critical application, 
> > need to request the tests again with your changes. May take long time.
> 
> So my second patch is clearly broken as per Brian Gerst's comments.
> 
> What I would suggest is to try a patch that adds just 100 NOPs or so - attached 
> below. This patch will add a small delay without any side effects (other than 
> changing the kernel image layout).
> 
> If that makes the crash go away, then I'd say the likelihood that it's hardware 
> related increases substantially: maybe a PLL has not stabilized yet sufficiently 
> after resume, or there's some latent heat sensitivity and the fan has not started 
> up yet, etc.

> ( You can then use this simple delay generating patch in production systems as 
>   well, to work around the problem. Maybe convince the BIOS folks to add a delay 
>   like this to their resume path before they call Linux. )
This was already experimented. They added delay in BIOS before handing
over to OS, the crash still occurred.
We were thinking that BIOS SMI handler responsible for suspend/wake up
corrupted the DS even after control passed over to OS. But couldn't
prove it.
Thanks for your valuable debugging suggestions.

Thanks,
Srinivas
 
> 
> Thanks,
> 
> 	Ingo
> 
> =================>
> 
>  arch/x86/kernel/acpi/wakeup_32.S | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
> index 665c6b7d2ea9..ef26999da80a 100644
> --- a/arch/x86/kernel/acpi/wakeup_32.S
> +++ b/arch/x86/kernel/acpi/wakeup_32.S
> @@ -10,6 +10,12 @@
>  
>  ENTRY(wakeup_pmode_return)
>  wakeup_pmode_return:
> +
> +	/* Timing delay of a few dozen cycles: give the hardware some time to recover */
> +	.rept 100
> +	nop
> +	.endr
> +
>  	movw	$__KERNEL_DS, %ax
>  	movw	%ax, %ss
>  	movw	%ax, %ds


