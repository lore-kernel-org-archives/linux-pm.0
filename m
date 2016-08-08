From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 4.8-rc1: resume from hibernation doesn't work
Date: Mon, 8 Aug 2016 23:58:54 +0200
Message-ID: <20160808215854.GA6867@xo-6d-61-c0.localdomain>
References: <alpine.LNX.2.00.1608091038220.22028@cbobk.fhfr.pm>
 <alpine.LNX.2.00.1608091051470.22028@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49853 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbcHIULP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Aug 2016 16:11:15 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1608091051470.22028@cbobk.fhfr.pm>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Garnier <thgarnie@google.com>

On Tue 2016-08-09 10:54:15, Jiri Kosina wrote:
> On Tue, 9 Aug 2016, Jiri Kosina wrote:
> 
> > current Linus' tree (HEAD 65ea11ec6, so basically 4.8-rc1+) has broken 
> > resume from hibernation on my x200s.
> > 
> > Suspend works correctly, resuming proceeds up to the point where it 
> > reports 100% of reading of the hibernation image, and afterwards the 
> > machine reboots (tripple fault ... dunno, I don't really see any kernel 
> > messages between the report of reading the hibernation image and reboot).
> > 
> > 4.7-rc4 is fine on this machine, so I thought I'd bisect it, but 
> > unfortunately at some point in the bisection process, the hibernation 
> > itself breaks, so there is not really a way for me to bisect it.
> > 
> > Any ideas which patches to try to revert?
> 
> Okay, turning off CONFIG_RANDOMIZE_MEMORY makes the problem go away and 
> machine resumes properly (and yes, I am running a kernel that already 
> contains c226fab474).
> 
> Adding Thomas Garnier to CC as well.

64-bit kernel, I assume?

I believe that is known:

From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Thomas Garnier <thgarnie@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki"
       	<rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, the arch/x86 maintainers
        <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Yinghai Lu
       	<yinghai@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
        <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
        Pavel Machek <pavel@ucw.cz>, Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Borislav Petkov <bpetkov@suse.de>
Subject: Re: [Resend][PATCH] x86/power/64: Always create temporary identity mapping correctly
...

>>>> Suggested-by: Yinghai Lu <yinghai@kernel.org>
>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>> Acked-by: Yinghai Lu <yinghai@kernel.org>
>>>> ---
>>>>
>>>> This is sort of urgent, because hibernation doesn't work with KASLR on x86-64
>>>> in 4.8-rc1 AFAICS and this should make them work together again.
>>>>
>>>> Unless anyone sees any problems with it, I'll queue it up for 4.8-rc2.
>>>> 
>>>> Thomas, would it be possible to test it with KASLR enabled, please?

So yes, testing the patch from that thread would be helpful.

Thanks,
										Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
