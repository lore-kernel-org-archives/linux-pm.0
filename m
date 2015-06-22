From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] x86: Load __USER_DS into DS/ES after resume
Date: Mon, 22 Jun 2015 16:06:48 +0200
Message-ID: <2087839.xQcnh0uO8K@vostro.rjw.lan>
References: <20150612075013.GA8759@gmail.com> <49474860.PXIRr69qmi@vostro.rjw.lan> <20150618091358.GA23135@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44470 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754400AbbFVNkn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2015 09:40:43 -0400
In-Reply-To: <20150618091358.GA23135@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@linux-foundation.org>, Denys Vlasenko <dvlasenk@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, the arch/x86 maintainers <x86@kernel.org>, linux-pm@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, Brian Gerst <brgerst@gmail.com>, Peter Anvin <hpa@zytor.com>

On Thursday, June 18, 2015 11:13:58 AM Ingo Molnar wrote:
> 
> * Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> 
> > On Tuesday, June 16, 2015 11:13:33 AM Pavel Machek wrote:
> > > > > That second KERNEL should be USER.
> > > > 
> > > > Yeah, doh :-/ Updated patch below.
> > > > 
> > > > Thanks,
> > > > 
> > > > 	Ingo
> > > 
> > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > > Tested-by: Pavel Machek <pavel@ucw.cz>
> > > 
> > > [of course, it worked for me before, so I only tested it also works
> > > with the patch.]
> > > 
> > > Rafael, can you apply it?
> > 
> > Yes, I can, but I thought Ingo would take it into the tip tree.
> > 
> > Ingo, what's your plan regarding this one?
> 
> Feel free to push it!
> 
> Acked-by: Ingo Molnar <mingo@kernel.org>

OK, applied, thanks!

Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
