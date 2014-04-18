From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [RFC PATCHC 3/3] sched/fair: use the idle state info to choose
 the idlest cpu
Date: Fri, 18 Apr 2014 12:00:44 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1404181159010.980@knanqh.ubzr>
References: <1396009796-31598-1-git-send-email-daniel.lezcano@linaro.org> <1396009796-31598-4-git-send-email-daniel.lezcano@linaro.org> <alpine.LFD.2.11.1404012208110.1571@knanqh.ubzr> <534FDCDC.6000806@linaro.org> <alpine.LFD.2.11.1404171138470.980@knanqh.ubzr>
 <534FFBB3.8050601@linaro.org> <alpine.LFD.2.11.1404171207531.980@knanqh.ubzr> <20140418093845.GD11096@twins.programming.kicks-ass.net> <535116FC.5070700@linaro.org> <20140418125344.GX11182@twins.programming.kicks-ass.net> <535122EE.7030803@linaro.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:59575 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbaDRQAq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Apr 2014 12:00:46 -0400
Received: by mail-qc0-f176.google.com with SMTP id m20so1845025qcx.35
        for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2014 09:00:45 -0700 (PDT)
In-Reply-To: <535122EE.7030803@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, mingo@elte.hu, rjw@rjwysocki.net, linux-pm@vger.kernel.org, alex.shi@linaro.org, vincent.guittot@linaro.org, morten.rasmussen@arm.com

On Fri, 18 Apr 2014, Daniel Lezcano wrote:

> On 04/18/2014 02:53 PM, Peter Zijlstra wrote:
> > I suppose so; its still a bit like we won't but we will :-)
> >
> > So we _will_ actually expose coupled C states through the topology bits,
> > that's good.
> 
> Ah, ok. I think I understood where the confusion is coming from.
> 
> A couple of definitions for the same thing :)
> 
> 1. Coupled C-states : *mechanism* implemented in the cpuidle framework:
> drivers/cpuidle/coupled.c
> 
> 2. Coupled C-states : *constraint* to reach a cluster power down state, will
> be described through the topology and could be implemented by different
> mechanism (MCPM, handmade sync, cpuidle-coupled-c-state, firmware).
> 
> We want to expose 2. not 1. to the scheduler.

I couldn't explain it better.

Sorry for creating confusion.


Nicolas
