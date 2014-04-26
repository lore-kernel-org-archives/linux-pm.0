From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/3] sched: idle: Add sched balance option
Date: Sat, 26 Apr 2014 02:18:58 +0200
Message-ID: <15044031.LGKXdkz8J7@vostro.rjw.lan>
References: <1398342291-16322-1-git-send-email-daniel.lezcano@linaro.org> <2713863.BLQTYQm2Oa@vostro.rjw.lan> <20140425132055.GC11096@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58402 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750802AbaDZACf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Apr 2014 20:02:35 -0400
In-Reply-To: <20140425132055.GC11096@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Amit Kucheria <amit.kucheria@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@elte.hu>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Friday, April 25, 2014 03:20:55 PM Peter Zijlstra wrote:
> On Fri, Apr 25, 2014 at 01:46:53PM +0200, Rafael J. Wysocki wrote:
> 
> _trim_ emails!!! one of these days I'm going to write a bot to flame
> your head of if there's excessive quoting.

Words ...

> > 
> > Well, so now the question is whether or not we relly want to always
> > go to the "power" (or "energy efficiency" if you will) mode if the system
> > is on battery.  That arguably may not be a good thing even for energy
> > efficiency depending on how exactly the modes are defined.
> 
> Nobody is talking about always. But in general it seems a good enough
> approach. Hell, many of the AC/BAT switches in todays power management
> crap things are not always right.
> 
> Do I want it to dim the LCD further when I unplug the laptop -- mostly
> no, but still it does. And the most annoying one is that it reduces the
> screen blank time to something near 5 seconds or so.
> 
> Why would this be any different?

And why do we have to do things that we hate it when they are done by others?

> If you know what you want you can turn the knob.
> 
> > So in my opinion it's too early to add things like that at this point.
> 
> Meh.. 

Seriously, I'm not even sure if we really need that stuff to be honest.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
