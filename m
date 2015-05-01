From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 0/1] speeding up cpu_up()
Date: Fri, 1 May 2015 14:42:39 -0700
Message-ID: <CAJvTdKnYbJbun_UJXbGgKuh7DEBXoQdD6Unbm=Jopuw_C_U4ng@mail.gmail.com>
References: <1429404795-23260-1-git-send-email-lenb@kernel.org>
	<20150420071556.GB14315@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:36155 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbbEAVml (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2015 17:42:41 -0400
In-Reply-To: <20150420071556.GB14315@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: X86 ML <x86@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>

On Mon, Apr 20, 2015 at 12:15 AM, Ingo Molnar <mingo@kernel.org> wrote:

> So instead of playing games with an ancient delay, I'd suggest we
> install the 10 msec INIT assertion wait as a platform quirk instead,
> and activate it for all CPUs/systems that we think might need it, with
> a sufficiently robust and future-proof quirk cutoff condition.
>
> New systems won't have the quirk active and thus won't have to have
> this delay configurable either.

Okay, at this time, I think the quirk would apply to:

1. Intel family 5 (original pentium) -- some may actually need the quirk
2. Intel family F (pentium4) -- mostly b/c I don't want to bother
finding/testing p4
3. All AMD (happy to narrow down, if somebody can speak for AMD)

I'd keep the cmdline override, in case we break something,
or somebody wants to optimize/test.  (Though I'll update units to
usec, rather than msec.,
so we can go below 1ms without going to 0)
I don't think we need the config option, just a #define to document the quirk.

What do you think?

Len Brown, Intel Open Source Technology Center
