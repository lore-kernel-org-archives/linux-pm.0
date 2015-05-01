From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 0/1] speeding up cpu_up()
Date: Sat, 2 May 2015 00:47:29 +0200
Message-ID: <20150501224729.GN10239@pd.tnic>
References: <1429404795-23260-1-git-send-email-lenb@kernel.org>
 <20150420071556.GB14315@gmail.com>
 <CAJvTdKnYbJbun_UJXbGgKuh7DEBXoQdD6Unbm=Jopuw_C_U4ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:47497 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbbEAWrh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 1 May 2015 18:47:37 -0400
Content-Disposition: inline
In-Reply-To: <CAJvTdKnYbJbun_UJXbGgKuh7DEBXoQdD6Unbm=Jopuw_C_U4ng@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>
Cc: Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>

On Fri, May 01, 2015 at 02:42:39PM -0700, Len Brown wrote:
> On Mon, Apr 20, 2015 at 12:15 AM, Ingo Molnar <mingo@kernel.org> wrote:
> 
> > So instead of playing games with an ancient delay, I'd suggest we
> > install the 10 msec INIT assertion wait as a platform quirk instead,
> > and activate it for all CPUs/systems that we think might need it, with
> > a sufficiently robust and future-proof quirk cutoff condition.
> >
> > New systems won't have the quirk active and thus won't have to have
> > this delay configurable either.
> 
> Okay, at this time, I think the quirk would apply to:
> 
> 1. Intel family 5 (original pentium) -- some may actually need the quirk
> 2. Intel family F (pentium4) -- mostly b/c I don't want to bother
> finding/testing p4
> 3. All AMD (happy to narrow down, if somebody can speak for AMD)

Aravind and I could probably test on a couple of AMD boxes to narrow down.

@Aravind, see here:

https://lkml.kernel.org/r/87d69aab88c14d65ae1e7be55050d1b689b59b4b.1429402494.git.len.brown@intel.com

You could ask around whether a timeout is needed between the assertion
and deassertion of INIT done by the BSP when booting other cores.

If not, we probably should convert, at least modern AMD machines, to the
no-delay default.

> I'd keep the cmdline override, in case we break something,
> or somebody wants to optimize/test.  (Though I'll update units to
> usec, rather than msec.,
> so we can go below 1ms without going to 0)
> I don't think we need the config option, just a #define to document the quirk.
> 
> What do you think?
> 
> Len Brown, Intel Open Source Technology Center
> 

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
