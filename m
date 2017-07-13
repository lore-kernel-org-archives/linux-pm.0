From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 02/10] cpufreq: provide data for frequency-invariant
 load-tracking support
Date: Thu, 13 Jul 2017 09:49:47 +0200
Message-ID: <20170713074947.qf47l3mskfuch7ec@hirez.programming.kicks-ass.net>
References: <20170706094948.8779-1-dietmar.eggemann@arm.com>
 <20170712092755.GD1679@vireshk-i7>
 <20170712111426.lmbwowbrvjl55aft@hirez.programming.kicks-ass.net>
 <14176128.txNmPKaVBr@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:40424 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751356AbdGMHuW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2017 03:50:22 -0400
Content-Disposition: inline
In-Reply-To: <14176128.txNmPKaVBr@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>

On Thu, Jul 13, 2017 at 01:13:43AM +0200, Rafael J. Wysocki wrote:

> I *guess* the concern is that in the new model there is no control over the
> time of requesting the frequency change and when the change actually
> happens.

There isn't in any case. If some brilliant hardware designer shares the
regulator's I2C bus with another device that requires 'big' transfers
(say a DSP) we're hosed whichever way around.

> IIUC the whole point of making the governor thread an RT or DL one is to
> ensure that the change will happen as soon as technically possible, because if
> it doesn't happen in a specific time frame, it can very well be skipped entirely.

So I think the interrupt driven thing can actually do better than the
rt-mutex based one, and I cannot think of a case where it would do
worse.

The I2C completion interrupt can splice in the pending request at the
earliest opportunity, even though the mutex owner might still think it
owns things.

And if that is not possible, it'll still be as fast as waiting for the
mutex to be released (or ever so slightly faster, because it will not
quiesce the bus like it would otherwise at the end of a transfer).
