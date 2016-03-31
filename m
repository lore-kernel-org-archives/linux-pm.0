From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] sched/fair: move cpufreq hook to
 update_cfs_rq_load_avg()
Date: Thu, 31 Mar 2016 12:47:05 +0200
Message-ID: <20160331104705.GG3430@twins.programming.kicks-ass.net>
References: <1458606068-7476-1-git-send-email-smuckle@linaro.org>
 <56F91D56.4020007@arm.com>
 <56F95D10.4070400@linaro.org>
 <56F97856.4040804@arm.com>
 <56F98832.3030207@linaro.org>
 <20160330193544.GD407@worktop>
 <CAKfTPtCPfd2-jGDn-9ZLjNKTni4czuvrkH7KFh5L2EtDeTQE5A@mail.gmail.com>
 <20160331093408.GB12845@twins.programming.kicks-ass.net>
 <CAKfTPtCuDQz8KxndwA1Kx4Xe-DohuUOhYXXabBDsp7r8j6cPgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:45015 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755560AbcCaKrI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Mar 2016 06:47:08 -0400
Content-Disposition: inline
In-Reply-To: <CAKfTPtCuDQz8KxndwA1Kx4Xe-DohuUOhYXXabBDsp7r8j6cPgw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Steve Muckle <steve.muckle@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

On Thu, Mar 31, 2016 at 11:50:40AM +0200, Vincent Guittot wrote:
> > In what case? Assuming you talk about a remove wakeup, no. Only if that
> > wakeup results in a preemption, which isn't a given.
> 
> yes, i was speaking about a remote wakeup.
> In the ttwu_queue_remote,  there is a call to smp_send_reschedule. Is
> there another way to add a remote task in the wake list ?

Right, but at that point we don't yet know how much util will change.

And doing that IPI unconditionally is expensive; see:

  518cd6234178 ("sched: Only queue remote wakeups when crossing cache boundaries")

13% regression on TCP_RR.
