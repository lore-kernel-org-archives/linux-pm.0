From: Jiri Kosina <jikos@kernel.org>
Subject: Re: 4.8-rc1: resume from hibernation doesn't work
Date: Tue, 9 Aug 2016 22:13:39 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1608092213010.22028@cbobk.fhfr.pm>
References: <alpine.LNX.2.00.1608091038220.22028@cbobk.fhfr.pm> <alpine.LNX.2.00.1608091051470.22028@cbobk.fhfr.pm> <20160808215854.GA6867@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45863 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932299AbcHIUNm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 9 Aug 2016 16:13:42 -0400
In-Reply-To: <20160808215854.GA6867@xo-6d-61-c0.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Garnier <thgarnie@google.com>

On Mon, 8 Aug 2016, Pavel Machek wrote:

> 64-bit kernel, I assume?
> 
> I believe that is known:
> 
> From: "Rafael J. Wysocki" <rafael@kernel.org>
> To: Thomas Garnier <thgarnie@google.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Borislav Petkov <bp@suse.de>, "Rafael J. Wysocki"
>        	<rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, the arch/x86 maintainers
>         <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Yinghai Lu
>        	<yinghai@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
>         <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
>         Pavel Machek <pavel@ucw.cz>, Kernel Hardening <kernel-hardening@lists.openwall.com>,
>         Borislav Petkov <bpetkov@suse.de>
> Subject: Re: [Resend][PATCH] x86/power/64: Always create temporary identity mapping correctly

Yeah, I've noticed that thread in the meantime and everything is happening 
there now, thanks.

> >>>> Suggested-by: Yinghai Lu <yinghai@kernel.org>
> >>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >>>> Acked-by: Yinghai Lu <yinghai@kernel.org>
> >>>> ---
> >>>>
> >>>> This is sort of urgent, because hibernation doesn't work with KASLR on x86-64
> >>>> in 4.8-rc1 AFAICS and this should make them work together again.
> >>>>
> >>>> Unless anyone sees any problems with it, I'll queue it up for 4.8-rc2.
> >>>> 
> >>>> Thomas, would it be possible to test it with KASLR enabled, please?
> 
> So yes, testing the patch from that thread would be helpful.

Unfortunately it doesn't fix the issue.

-- 
Jiri Kosina
SUSE Labs

