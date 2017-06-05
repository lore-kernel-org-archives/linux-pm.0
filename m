From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFC] cpuidle: menu: nearby timer use lightest state; allow state 0 to be disabled
Date: Mon, 05 Jun 2017 14:58:18 +0200
Message-ID: <28814050.hW7zW6Hoc6@aspire.rjw.lan>
References: <20170530162631.9073-1-npiggin@gmail.com> <20170605174003.18266685@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:46182 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751326AbdFENFQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jun 2017 09:05:16 -0400
In-Reply-To: <20170605174003.18266685@roar.ozlabs.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, linux-pm@vger.kernel.org

On Monday, June 05, 2017 05:40:03 PM Nicholas Piggin wrote:
> On Wed, 31 May 2017 02:26:31 +1000
> Nicholas Piggin <npiggin@gmail.com> wrote:
> 
> > I've found the menu driver does not allow state0 to properly be disabled
> > because of all this poll logic selecting the first state and then trying
> > to iterate over subsequent states. Ripping most of that out and simplifying
> > it solved that issue but raised more questions about polling logic.
> > 
> > Firstly polling logic is there only on architectures which define
> > ARCH_HAS_CPU_RELAX, which is only x86. Seems like if we think a
> > timer is so close that no powersave should be done, then surely just
> > picking the lightest mode (whether that is polling or something else)
> > would be best.
> > 
> > But looking further into it, it seems maybe like some x86 hack (as
> > the comments and changelog in 7884084f3bcc and subsequent attempts to
> > work around Atom and broken firmware suggests). I would have thought
> > such broken hard/firmware should get workarounds applied to fix the
> > state values rather than add such logic?
> > 
> > On the other hand, if (CPUIDLE_DRIVER_STATE_START > 0) is shorthand for
> > if (x86 hacks), that's fine I'm happy to leave that alone and just work
> > with the else parts...
> > 
> > This is just a draft, but it does what I want at least with regard to
> > disabling state0 for testing.
> 
> Ping, any thoughts on these issues?

Not yet, sorry for the delay.

I'll get to this as soon as I can.

Thanks,
Rafael
