From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] x86: Load __USER_DS into DS/ES after resume
Date: Tue, 16 Jun 2015 23:40:08 +0200
Message-ID: <49474860.PXIRr69qmi@vostro.rjw.lan>
References: <20150612075013.GA8759@gmail.com> <20150614074922.GA30290@gmail.com> <20150616091333.GA6448@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64569 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753155AbbFPVOK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jun 2015 17:14:10 -0400
In-Reply-To: <20150616091333.GA6448@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Denys Vlasenko <dvlasenk@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, the arch/x86 maintainers <x86@kernel.org>, linux-pm@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, Brian Gerst <brgerst@gmail.com>, Peter Anvin <hpa@zytor.com>

On Tuesday, June 16, 2015 11:13:33 AM Pavel Machek wrote:
> > > That second KERNEL should be USER.
> > 
> > Yeah, doh :-/ Updated patch below.
> > 
> > Thanks,
> > 
> > 	Ingo
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Tested-by: Pavel Machek <pavel@ucw.cz>
> 
> [of course, it worked for me before, so I only tested it also works
> with the patch.]
> 
> Rafael, can you apply it?

Yes, I can, but I thought Ingo would take it into the tip tree.

Ingo, what's your plan regarding this one?

Rafael

