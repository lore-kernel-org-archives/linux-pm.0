From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC v3 0/5] Add capacity capping support to the CPU controller
Date: Wed, 12 Apr 2017 14:15:14 +0200
Message-ID: <20170412121514.GE3093@worktop>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <20170320145131.GA3623@htj.duckdns.org>
 <20170320172233.GA28391@e110439-lin>
 <20170410073622.2y6tnpcd2ssuoztz@hirez.programming.kicks-ass.net>
 <20170411175833.GI29455@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:38072 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751218AbdDLMP1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Apr 2017 08:15:27 -0400
Content-Disposition: inline
In-Reply-To: <20170411175833.GI29455@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Paul Turner <pjt@google.com>, Vincent Guittot <vincent.guittot@linaro.org>, John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@android.com>, Tim Murray <timmurray@google.com>, Andres Oportus <andresoportus@google.com>, Joel Fernandes <joelaf@google.com>, Juri Lelli <juri.lelli@arm.com>, Chris Redpath <chris.redpath@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>

On Tue, Apr 11, 2017 at 06:58:33PM +0100, Patrick Bellasi wrote:
> We should consider also that at the CPUFreq side we already expose
> knobs like scaling_{min,max}_freq which are much more platform
> dependant than capacity.

So I've always objected to these knobs.

That said; they are a pre-existing user interface so changing them isn't
really feasible much.

But at the very least we should integrate them properly. Which for
schedutil would mean they have to directly modify the relevant CPU
capacity values. Is this currently done? (I think not.)
