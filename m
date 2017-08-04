From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: update timer frequencies
Date: Fri, 4 Aug 2017 12:28:43 +0530
Message-ID: <cd7ddf4e-ecde-8450-99c4-80932a7952d8@synopsys.com>
References: <1489137441.2333.46.camel@synopsys.com>
 <alpine.DEB.2.20.1703101113370.3681@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay4.synopsys.com ([198.182.47.9]:39009 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbdHDG7H (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Aug 2017 02:59:07 -0400
In-Reply-To: <alpine.DEB.2.20.1703101113370.3681@nanos>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "john.stultz@linaro.org" <john.stultz@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Peter Zijlstra <peterz@infradead.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>

Hi Thomas,

On 03/10/2017 03:58 PM, Thomas Gleixner wrote:
> Vlad,
> 
> On Fri, 10 Mar 2017, Vlad Zakharov wrote:
>>
>> I am trying to implement a cpufreq driver for ARC CPUs.  The point is
>> that ARC timers (including those are used for timekeeping) are driven by
>> the same clock as ARC CPU core(s).
> 
> To be honest: That's broken by design and you really should go and tell
> your hardware folks to fix that. Proper timekeeping is essential for any
> Operating System (not only Linux).
> 
> It's well known for more than TWO decades that changing the frequency of
> the timekeeper clocksource is a complete disaster, but obviously every
> hardware vendor has to learn that the hard way instead of simply learning
> from history.
> 
...
> 
> Your hardware design is broken by making the clocksource clock depend on
> the CPU frequency. Tell your hardware people to fix that or just use a
> seperate independent clocksource.

The hardware is being changed and I had a couple of questions to help do it right:

1. The clocksource timers TIMER1, GFRC, RTC etc will now be clocked independent of 
core using a fixed clk. Is there some magic freq value which best works so we can 
recommend that to implementors. AFAIKR ARM has 24 MHz.

2. I'm not sure if the timer generating interrupts (periodic or oneshot) needs to 
be fed invariant fixed clk or dynamic core clk. Naively it should follow the core 
- but what happens to scheduled timers (say TCP timeouts): if this clk changes - 
they need to be canceled/updated. If it doesn't then the notion of timing is 
broken ? I'm likely not thinking this through correctly.

Thx,
-Vineet
