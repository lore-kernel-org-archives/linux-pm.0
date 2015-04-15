From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/3] cpuidle: Store the idle start time stamp
Date: Wed, 15 Apr 2015 14:42:46 +0200
Message-ID: <20150415124246.GW5029@twins.programming.kicks-ass.net>
References: <1429092024-20498-1-git-send-email-daniel.lezcano@linaro.org>
 <20150415102057.GR5029@twins.programming.kicks-ass.net>
 <552E5992.2050404@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:35145 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534AbbDOMm4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Apr 2015 08:42:56 -0400
Content-Disposition: inline
In-Reply-To: <552E5992.2050404@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, nicolas.pitre@linaro.org

On Wed, Apr 15, 2015 at 02:29:06PM +0200, Daniel Lezcano wrote:
> On 04/15/2015 12:20 PM, Peter Zijlstra wrote:
> >On Wed, Apr 15, 2015 at 12:00:22PM +0200, Daniel Lezcano wrote:
> >>+	target_state->idle_stamp = ktime_to_us(ktime_get());
> >
> >ktime_get_ns();
> >
> 
> Hmm, sounds like I missed we are dealing with different units (us / ns) in
> cpuidle / sched.
> 
> Would it make sense to store the time into a ktime structure instead and use
> the relevant function depending on the place we are inspecting the value
> from ?

Why would you ever want to use us? Does ARM enjoy calculating /1000?

Ah, I see the !scalar ktime got whacked, good! At which point the u64 ns
and ktime are the same. That said I prefer the u64 over ktime because
its easier to manipulate.

