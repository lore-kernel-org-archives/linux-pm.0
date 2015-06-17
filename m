From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH, DEBUG] x86/32: Add small delay after resume
Date: Wed, 17 Jun 2015 12:33:50 -0400
Message-ID: <20150617163350.GA7250@l.oracle.com>
References: <1434066338-6619-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <20150612060747.GA25024@gmail.com>
 <1434125724.2353.19.camel@spandruv-DESK3.jf.intel.com>
 <20150613071547.GA27446@gmail.com>
 <1434384627.2353.47.camel@spandruv-DESK3.jf.intel.com>
 <55809616.80204@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55809616.80204@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, mingo@redhat.com, tglx@linutronix.de, pavel@ucw.cz, rjw@rjwysocki.net, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Denys Vlasenko <dvlasenk@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Borislav Petkov <bp@alien8.de>, Brian Gerst <brgerst@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Kleen, Andi" <andi.kleen@intel.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 16, 2015 at 02:33:10PM -0700, H. Peter Anvin wrote:
> On 06/15/2015 09:10 AM, Srinivas Pandruvada wrote:
> >>
> >> So is it true that we always execute wakeup_pmode_return first after we return 
> >> from the BIOS?
> >>
> >> If so then the BIOS touching DS cannot be an issue, as we re-initialize all 
> >> segment selectors, which reloads the descriptors:
> >>
> >> ENTRY(wakeup_pmode_return)
> >> wakeup_pmode_return:
> >>         movw    $__KERNEL_DS, %ax
> >>         movw    %ax, %ss
> >>         movw    %ax, %ds
> >>         movw    %ax, %es
> >>         movw    %ax, %fs
> >>         movw    %ax, %gs
> >>
> >>         # reload the gdt, as we need the full 32 bit address
> >>         lidt    saved_idt
> >>         lldt    saved_ldt
> >>         ljmp    $(__KERNEL_CS), $1f
> >>
> 
> Where does the GDT get initialized?
> 
> 	-hpa

mit 84e70971e67d97bc2db18a4e76d42846272a54bd
Author: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date:   Fri Apr 5 16:42:22 2013 -0400

    x86-32, gdt: Store/load GDT for ACPI S3 or hibernation/resume path is not needed

> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
