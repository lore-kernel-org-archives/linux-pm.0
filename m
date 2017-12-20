From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2 1/8] sched/cpufreq_schedutil: make use of DEADLINE
 utilization signal
Date: Wed, 20 Dec 2017 13:51:40 +0100
Message-ID: <20171220125140.awxsp5r6hhrv7c6j@hirez.programming.kicks-ass.net>
References: <20171204102325.5110-1-juri.lelli@redhat.com>
 <20171204102325.5110-2-juri.lelli@redhat.com>
 <20171205150935.GL31247@e110439-lin>
 <20171205152424.GC15085@localhost.localdomain>
 <20171205163409.GN31247@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:45742 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754746AbdLTMwD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Dec 2017 07:52:03 -0500
Content-Disposition: inline
In-Reply-To: <20171205163409.GN31247@e110439-lin>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>, mingo@redhat.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, tglx@linutronix.de, vincent.guittot@linaro.org, rostedt@goodmis.org, luca.abeni@santannapisa.it, claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it, bristot@redhat.com, mathieu.poirier@linaro.org, tkjos@android.com, joelaf@google.com, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, alessio.balsini@arm.com, Juri Lelli <juri.lelli@arm.com>, Ingo Molnar <mingo@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>

On Tue, Dec 05, 2017 at 04:34:10PM +0000, Patrick Bellasi wrote:
> On 05-Dec 16:24, Juri Lelli wrote:
> However, I'm not an expert, on those systems can we really set a
> minimum guaranteed performance level?

If you look at the Intel SDM, Volume 3, 14.4 Hardware-Controlled
Performance States (HWP), which is the Intel implementation of ACPI
CPPC.

You'll see that IA32_HWP_CAPABILITIES has a Guaranteed_Performance field
and describes that upon changes to this frequency we will receive
notifications (Interrupts).

If you then look at IA32_HWP_REQUEST, you'll see a Minimum_Performance
field, which we can raise up-to the guaranteed level, and would/should
contain the DEADLINE stuff.

HWP_REQUEST also includes a Desired_Performance field, which is where we
want to be for DL+CFS.

Trouble is that cpufreq doesn't yet support the various CPPC fields. So
we have this comment here at the input side stating what we'd want to do
once cpufreq itself grows the interface bits.
