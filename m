From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2] x86: Load __USER_DS into DS/ES after resume
Date: Thu, 18 Jun 2015 11:13:58 +0200
Message-ID: <20150618091358.GA23135@gmail.com>
References: <20150612075013.GA8759@gmail.com>
 <20150614074922.GA30290@gmail.com>
 <20150616091333.GA6448@amd>
 <49474860.PXIRr69qmi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:33764 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356AbbFRJOD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Jun 2015 05:14:03 -0400
Received: by wiwd19 with SMTP id d19so16365849wiw.0
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2015 02:14:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <49474860.PXIRr69qmi@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>, Linus Torvalds <torvalds@linux-foundation.org>, Denys Vlasenko <dvlasenk@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, the arch/x86 maintainers <x86@kernel.org>, linux-pm@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, Brian Gerst <brgerst@gmail.com>, Peter Anvin <hpa@zytor.com>


* Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> On Tuesday, June 16, 2015 11:13:33 AM Pavel Machek wrote:
> > > > That second KERNEL should be USER.
> > > 
> > > Yeah, doh :-/ Updated patch below.
> > > 
> > > Thanks,
> > > 
> > > 	Ingo
> > 
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > Tested-by: Pavel Machek <pavel@ucw.cz>
> > 
> > [of course, it worked for me before, so I only tested it also works
> > with the patch.]
> > 
> > Rafael, can you apply it?
> 
> Yes, I can, but I thought Ingo would take it into the tip tree.
> 
> Ingo, what's your plan regarding this one?

Feel free to push it!

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
