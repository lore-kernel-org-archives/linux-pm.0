From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [1/11] issue 1: Missing power topology information in scheduler
Date: Tue, 14 Jan 2014 18:09:50 +0100
Message-ID: <20140114170950.GK7572@laptop.programming.kicks-ass.net>
References: <1387557951-21750-1-git-send-email-morten.rasmussen@arm.com>
 <20131222151905.GA3250@mgross-Lenovo-Yoga-2-Pro>
 <20131230140024.GB2936@e103034-lin>
 <2069135.fZ7bEevDcs@vostro.rjw.lan>
 <20140114162114.GE3000@e103034-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:39276 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbaANRJ5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2014 12:09:57 -0500
Content-Disposition: inline
In-Reply-To: <20140114162114.GE3000@e103034-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, mark gross <markgross@thegnar.org>, "mingo@kernel.org" <mingo@kernel.org>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, Jan 14, 2014 at 04:21:15PM +0000, Morten Rasmussen wrote:
> > This appears to be a property of the workload that the scheduler can't really
> > learn by itself (it can't possibly know, unless told somehow, that t0 is going
> > to go to sleep shortly after t1 has been started).
> > 
> > It looks like that might be covered by a new thread flag meaning "start my
> > children on the same CPU".  Or a clone flag meaning "run this child on the same
> > CPU".
> 
> It could work for multithreaded applications, but I'm not sure if it would
> work for Android muddleware threads. Android audio playback as described
> in another post exhibits a pattern similar to the above. It may not be
> possible to have a parent/child setup for the Android audio subsystem
> threads that gives the desired behaviour.

We used to have a guestimator at some point that would measure the
overlap (the time we keep running after waking another task), which we
used to auto select WF_SYNC.

The fact that we no longer have this only says that we weren't smart
enough to make it work reliable enough :-)

ISTR there were also people poking at having special FUTEX flags to
indicate such situations, but I can't remember whatever became of that.
