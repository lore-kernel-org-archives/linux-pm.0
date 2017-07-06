From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v1 0/8] SCHED_DEADLINE freq/cpu invariance and OPP
 selection
Date: Thu, 6 Jul 2017 18:15:12 +0200
Message-ID: <20170706161511.c7mf633xkez6d6sj@hirez.programming.kicks-ass.net>
References: <20170705085905.6558-1-juri.lelli@arm.com>
 <20170706115715.6154d823@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:52893 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbdGFQP0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Jul 2017 12:15:26 -0400
Content-Disposition: inline
In-Reply-To: <20170706115715.6154d823@gandalf.local.home>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Juri Lelli <juri.lelli@arm.com>, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, andresoportus@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, patrick.bellasi@arm.com

On Thu, Jul 06, 2017 at 11:57:15AM -0400, Steven Rostedt wrote:
> On Wed,  5 Jul 2017 09:58:57 +0100
> Juri Lelli <juri.lelli@arm.com> wrote:
> 
> > Hi,
> > 
> > v1 of the RFC set implementing frequency/cpu invariance and OPP selection for
> 
> It would be nice if you specify what "OPP" stands for. A quick google
> search shows "Other Peoples Privates", which isn't the type of
> selection I would be looking for.

Its ARM speak for P-state. It stands for OPerating Point or something
like that. But yes, I too always play the Naughty by Nature song in my
head when I read that.
