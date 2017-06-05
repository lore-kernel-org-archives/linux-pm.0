From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC] cpuidle: menu: nearby timer use lightest state; allow
 state 0 to be disabled
Date: Mon, 5 Jun 2017 17:40:03 +1000
Message-ID: <20170605174003.18266685@roar.ozlabs.ibm.com>
References: <20170530162631.9073-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33762 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751321AbdFEHkP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jun 2017 03:40:15 -0400
Received: by mail-pf0-f195.google.com with SMTP id f27so19812152pfe.0
        for <linux-pm@vger.kernel.org>; Mon, 05 Jun 2017 00:40:14 -0700 (PDT)
In-Reply-To: <20170530162631.9073-1-npiggin@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, linux-pm@vger.kernel.org

On Wed, 31 May 2017 02:26:31 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> I've found the menu driver does not allow state0 to properly be disabled
> because of all this poll logic selecting the first state and then trying
> to iterate over subsequent states. Ripping most of that out and simplifying
> it solved that issue but raised more questions about polling logic.
> 
> Firstly polling logic is there only on architectures which define
> ARCH_HAS_CPU_RELAX, which is only x86. Seems like if we think a
> timer is so close that no powersave should be done, then surely just
> picking the lightest mode (whether that is polling or something else)
> would be best.
> 
> But looking further into it, it seems maybe like some x86 hack (as
> the comments and changelog in 7884084f3bcc and subsequent attempts to
> work around Atom and broken firmware suggests). I would have thought
> such broken hard/firmware should get workarounds applied to fix the
> state values rather than add such logic?
> 
> On the other hand, if (CPUIDLE_DRIVER_STATE_START > 0) is shorthand for
> if (x86 hacks), that's fine I'm happy to leave that alone and just work
> with the else parts...
> 
> This is just a draft, but it does what I want at least with regard to
> disabling state0 for testing.

Ping, any thoughts on these issues?

Thanks,
Nick
