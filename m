From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [RFCv7 PATCH 00/10] sched: scheduler-driven CPU frequency
 selection
Date: Wed, 30 Mar 2016 18:35:23 -0700
Message-ID: <56FC7EDB.707@linaro.org>
References: <1456190570-4475-1-git-send-email-smuckle@linaro.org>
 <20160330004506.GB22689@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:32984 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753595AbcCaBf1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Mar 2016 21:35:27 -0400
Received: by mail-pa0-f45.google.com with SMTP id zm5so54026998pac.0
        for <linux-pm@vger.kernel.org>; Wed, 30 Mar 2016 18:35:26 -0700 (PDT)
In-Reply-To: <20160330004506.GB22689@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Yuyang Du <yuyang.du@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>

Hi Yuyang,

This series was dropped in favor of Rafael's schedutil. But on the
chance that you're still curious about the test setup used to quantify
the series I'll explain below.

On 03/29/2016 05:45 PM, Yuyang Du wrote:
> Hi Steve,
> 
> On Mon, Feb 22, 2016 at 05:22:40PM -0800, Steve Muckle wrote:
>> The number of times the busy
>> duration exceeds the period of the periodic workload (an "overrun") is
>> also recorded.
> 
> Could you please explain more about overrun?

Each of the 16 workloads is periodic. The period of the workload may not
be long enough to fit the busy ("run") duration at lower CPU
frequencies. If the governor has not raised the CPU frequency high
enough, the busy duration will exceed the period of the workload. This
is an "overrun" and in this synthetic workload represents a deadline
being missed.

>> SCHED_OTHER workload:
>>  wload parameters	  ondemand        interactive     sched	
>> run	period	loops	OR	OH	OR	OH	OR	OH
>> 1	100	100	0	62.07%	0	100.02%	0	78.49%
>> 10	1000	10	0	21.80%	0	22.74%	0	72.56%
>> 1	10	1000	0	21.72%	0	63.08%	0	52.40%
>> 10	100	100	0	8.09%	0	15.53%	0	17.33%
>> 100	1000	10	0	1.83%	0	1.77%	0	0.29%
>> 6	33	300	0	15.32%	0	8.60%	0	17.34%
>> 66	333	30	0	0.79%	0	3.18%	0	12.26%
>> 4	10	1000	0	5.87%	0	10.21%	0	6.15%
>> 40	100	100	0	0.41%	0	0.04%	0	2.68%
>> 400	1000	10	0	0.42%	0	0.50%	0	1.22%
>> 5	9	1000	2	3.82%	1	6.10%	0	2.51%
>> 50	90	100	0	0.19%	0	0.05%	0	1.71%
>> 500	900	10	0	0.37%	0	0.38%	0	1.82%
>> 9	12	1000	6	1.79%	1	0.77%	0	0.26%
>> 90	120	100	0	0.16%	1	0.05%	0	0.49%
>> 900	1200	10	0	0.09%	0	0.26%	0	0.62%
>  
> Could you please also explain what we can learn from the wload vs. OH/OR
> results?

These results are meant to show how the governors perform across varying
workload intensities and periodicities. Higher overhead (OH) numbers
indicate that the completion times of each period of the workload were
closer to what they would be when run at fmin (100% overhead would be as
slow as fmin, 0% overhead would be as fast as fmax). And as described
above, overruns (OR) indicate that the governor was not responsive
enough to finish the work in each period of the workload.

These are just performance metrics so they only tell half the story.
Power is not factored in at all.

This provides a quick sanity check that the governor under test (in this
case, the now defunct schedfreq, or sched for short) performs similarly
to two of the most commonly used governors, ondemand and interactive, in
steady state periodic workloads. In the data above sched looks good for
the most part with the second test case being the biggest exception.

thanks,
Steve

