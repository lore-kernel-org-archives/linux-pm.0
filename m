From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: schedule_timeout sleeps too long after dividing CPU frequency
Date: Tue, 12 May 2015 16:50:04 +0100
Message-ID: <20150512155004.GP2067@n2100.arm.linux.org.uk>
References: <55520F0F.5010906@free.fr>
 <CAKohpo=eMA6L9=jK=bAnbFuDxcdtpQNub0WFnSy6MOqB3jOdjA@mail.gmail.com>
 <555218C7.5050602@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:39920 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933045AbbELPuR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 May 2015 11:50:17 -0400
Content-Disposition: inline
In-Reply-To: <555218C7.5050602@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, cpufreq <cpufreq@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux PM <linux-pm@vger.kernel.org>

On Tue, May 12, 2015 at 05:14:15PM +0200, Mason wrote:
> This ties in to another thread I started in LAKML:
> ("High-resolution timers not supported when using smp_twd on Cortex A9")
> 
> $ git show 5388a6b2 arch/arm/kernel/smp_twd.c
> commit 5388a6b266e9c3357353332ba0cd5549082887f1
> Author: Russell King <rmk+kernel@arm.linux.org.uk>
> Date:   Mon Jul 26 13:19:43 2010 +0100
> 
>     ARM: SMP: Always enable clock event broadcast support
>     
>     The TWD local timers are unable to wake up the CPU when it is placed
>     into a low power mode, eg. C3.  Therefore, we need to adapt things
>     such that the TWD code can cope with this.
>     
>     We do this by always providing a broadcast tick function, and marking
>     the fact that the TWD local timer will stop in low power modes.  This
>     means that when the CPU is placed into a low power mode, the core
>     timer code marks this fact, and allows an IPI to be given to the core.
> 
> This mentions a "broadcast tick function" (of which I know nothing).
> Is this what you're referring to?

No.  This has nothing to do with low power modes.

How this works depends on how your kernel is configured, but essentially
it's something like this:

* The CPU which will be idling sets its local timer to wake up after N
  counter cycles, where N is calculated from the timer frequency.

* When the local timer fires, the CPU is kicked out of the idle loop, and
  it reads the current system time.  If the current system time indicates
  that the software timer set in schedule_timeout() has fired, that
  software timer fires.

If the local timer changes frequency without the idling CPU being woken
up, then the problem you're referring to can happen.

As you're not giving much information about your system (including
indicating where we might see some source code) we're not able to help
more than providing above descriptions.  Maybe if you posted your
patches so far to support the project you're working on, we could
provide better answers.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
