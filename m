From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH RFC] sched,idle: teach select_idle_sibling about idle
 states
Date: Fri, 3 Oct 2014 14:52:26 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1410031432210.5311@knanqh.ubzr>
References: <1409844730-12273-1-git-send-email-nicolas.pitre@linaro.org> <1409844730-12273-3-git-send-email-nicolas.pitre@linaro.org> <542B277D.7050103@redhat.com> <alpine.LFD.2.11.1409301904150.5311@knanqh.ubzr> <20141002131548.6cd377d5@cuia.bos.redhat.com>
 <1412317384.5149.19.camel@marge.simpson.net> <20141003075012.GF10583@worktop.programming.kicks-ass.net> <542EB29A.2050704@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:37350 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbaJCSw3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Oct 2014 14:52:29 -0400
Received: by mail-qc0-f180.google.com with SMTP id x3so1458783qcv.25
        for <linux-pm@vger.kernel.org>; Fri, 03 Oct 2014 11:52:28 -0700 (PDT)
In-Reply-To: <542EB29A.2050704@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rik van Riel <riel@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Mike Galbraith <umgwanakikbuti@gmail.com>, Ingo Molnar <mingo@redhat.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org

On Fri, 3 Oct 2014, Rik van Riel wrote:

> We have 3 different goals when selecting a runqueue for a task:
> 1) locality: get the task running close to where it has stuff cached
> 2) work preserving: get the task running ASAP, and preferably on a
>    fully idle core
> 3) idle state latency: place the task on a CPU that can start running
>    it ASAP
> 
> We may also consider the interplay of the above 3 to have an impact on
> 4) power use: pack tasks on some CPUs so other CPUs can go into deeper
>    idle states

In my mind the actual choice is between (1) and (2).  Once you decided 
on (2) then obviously you should imply (3) all the time. And by having 
(3) then (4) should be a natural side effect by not selecting idle CPUs 
randomly.

By selecting (1) you already have (4).

The deficient part right now is (3) as a consequence of (2).  Fixing 
(3) should not have to affect (1).

> The current implementation is a "compromise" between (1) and (2),
> with a strong preference for (2), falling back to (1) if no fully
> idle core is found.
> 
> My ugly hack isn't any better, trading off (1) in order to be better
> at (2) and (3). Whether it even affects (4) remains to be seen.

(4) is greatly influenced by (3) on mobile platforms, especially those 
with a cluster topology.  This might not be as significant on server 
type systems, although performance should benefit as well from the 
smaller wake-up latency.

On a mobile system losing 10% performance to save 20% on power usage 
might be an excellent compromise.  Maybe not so on a server system where 
performance is everything.


Nicolas
