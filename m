From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 1/2] x86/msr: add on cpu read/modify/write function
Date: Sun, 20 Dec 2015 16:27:49 +0100
Message-ID: <20151220152749.GA29805@pd.tnic>
References: <1449873637-24300-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1449873637-24300-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <alpine.DEB.2.11.1512201421300.28591@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:41467 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752063AbbLTP2E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 20 Dec 2015 10:28:04 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1512201421300.28591@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, X86 Kernel <x86@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>

On Sun, Dec 20, 2015 at 02:28:48PM +0100, Thomas Gleixner wrote:
> So this is a copy of the above !SMP inline. What's wrong with providing:
> 
>  int rmwmsrl_safe(msr_no, clear_mask, set_mask)
> 
> in x86/lib/msr.c and make the !SMP variant of rdmsrl_safe_on_cpu() and that
> variant for the SMP case a simple wrapper around it?
> 
> static void remote_rmwmsrl_safe(void *info)
> {
> 	struct msr_action *ma = info;
> 
> 	return rmwmsrl_safe(ma->msr, ma->clear_mask, ma->set_mask);
> }
> 
> No gotos, no pointless code duplication. Just simple.

TBH, I find this new "rmwmsrl" interface (the name is unreadable, btw)
silly:

It provides a plain read-modify-write on a MSR and nothing more but
patch 2 immediately shows that this interface is insufficient for the
other cases, i.e. package_power_limit_irq_save() for example, where you
need to do something more like check bits or error handling.

So there we do smp_call_function_single() with a function which does the
MSR accesses and whatever else is needed.

So why add the former interface in the first place?

Having driver-specific functions do whatever it is required and then
using a single IPI to run them is much cleaner than adding that
unfortunate function which doesn't really suffice.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
