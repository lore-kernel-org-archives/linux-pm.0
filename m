From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: update timer frequencies
Date: Fri, 4 Aug 2017 11:38:05 +0200
Message-ID: <20170804093805.z5y2o6t6wp34ywln@hirez.programming.kicks-ass.net>
References: <1489137441.2333.46.camel@synopsys.com>
 <alpine.DEB.2.20.1703101113370.3681@nanos>
 <cd7ddf4e-ecde-8450-99c4-80932a7952d8@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:55606 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751306AbdHDJiM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Aug 2017 05:38:12 -0400
Content-Disposition: inline
In-Reply-To: <cd7ddf4e-ecde-8450-99c4-80932a7952d8@synopsys.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "john.stultz@linaro.org" <john.stultz@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>

On Fri, Aug 04, 2017 at 12:28:43PM +0530, Vineet Gupta wrote:

> The hardware is being changed and I had a couple of questions to help do it right:

Awesome ;-)

> 2. I'm not sure if the timer generating interrupts (periodic or oneshot)
> needs to be fed invariant fixed clk or dynamic core clk. Naively it should
> follow the core - but what happens to scheduled timers (say TCP timeouts):
> if this clk changes - they need to be canceled/updated. If it doesn't then
> the notion of timing is broken ? I'm likely not thinking this through
> correctly.

Please keep the timers on the very same clock as your clocksource.
clockevent and clocksource having different (and possibly) drifting
timelines is painful.

Having them on the same clock makes everything so much easier, since you
_know_ what time it is when they fire and won't have to recompute and
possibly rearm the timer.
