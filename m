From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFCv5 PATCH 18/46] arm: topology: Define TC2 energy and provide
 it to the scheduler
Date: Wed, 12 Aug 2015 19:47:53 +0100
Message-ID: <55CB94D9.9000107@arm.com>
References: <1436293469-25707-1-git-send-email-morten.rasmussen@arm.com> <1436293469-25707-19-git-send-email-morten.rasmussen@arm.com> <20150812103320.GW19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([146.101.78.143]:34863 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751161AbbHLSr5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 12 Aug 2015 14:47:57 -0400
In-Reply-To: <20150812103320.GW19282@twins.programming.kicks-ass.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <Morten.Rasmussen@arm.com>
Cc: "mingo@redhat.com" <mingo@redhat.com>, "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "yuyang.du@intel.com" <yuyang.du@intel.com>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, Juri Lelli <Juri.Lelli@arm.com>, "sgurrappadi@nvidia.com" <sgurrappadi@nvidia.com>, "pang.xunlei@zte.com.cn" <pang.xunlei@zte.com.cn>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>

On 12/08/15 11:33, Peter Zijlstra wrote:
> On Tue, Jul 07, 2015 at 07:24:01PM +0100, Morten Rasmussen wrote:
>> +static struct capacity_state cap_states_cluster_a7[] = {
>> +	/* Cluster only power */
>> +	 { .cap =  150, .power = 2967, }, /*  350 MHz */
>> +	 { .cap =  172, .power = 2792, }, /*  400 MHz */
>> +	 { .cap =  215, .power = 2810, }, /*  500 MHz */
>> +	 { .cap =  258, .power = 2815, }, /*  600 MHz */
>> +	 { .cap =  301, .power = 2919, }, /*  700 MHz */
>> +	 { .cap =  344, .power = 2847, }, /*  800 MHz */
>> +	 { .cap =  387, .power = 3917, }, /*  900 MHz */
>> +	 { .cap =  430, .power = 4905, }, /* 1000 MHz */
>> +	};
> 
> So can I suggest a SCHED_DEBUG validation of the data provided?

Yes we can do that.

> 
> Given the above table, it _never_ makes sense to run at .cap=150, it
> equally also doesn't make sense to run at .cap = 301.
>

Absolutely right.


> So please add a SCHED_DEBUG test on domain creation that validates that
> not only is the .cap monotonically increasing, but the .power is too.

The requirement for current EAS code to work is even higher. We're not
only requiring monotonically increasing values for .cap and .power but
that the energy efficiency (.cap/.power) is monotonically decreasing.
Otherwise we can't stop the search for a new appropriate OPP in
find_new_capacity() in case .cap >= current 'max. group usage' because
we can't assume that this OPP will be the most energy efficient one.

For the example above we get .cap/.power = [0.05 0.06 0.08 0.09 0.1 0.12
0.1 0.09] so only the last 3 OPPs [800, 900, 1000 Mhz] make sense from
this perspective on our TC2 test chip platform.

So we should check for monotonically decreasing (.cap/.power) values.

