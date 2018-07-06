From: Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [RFC PATCH v4 08/12] sched: Add over-utilization/tipping point
 indicator
Date: Fri, 6 Jul 2018 12:49:30 +0100
Message-ID: <7559d0e2-7c5d-3bd3-6123-51fc9a4ca0d4@arm.com>
References: <20180628114043.24724-1-quentin.perret@arm.com>
 <20180628114043.24724-9-quentin.perret@arm.com>
 <20180706114158.GU2458@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180706114158.GU2458@hirez.programming.kicks-ass.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Quentin Perret <quentin.perret@arm.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/07/18 12:41, Peter Zijlstra wrote:
> On Thu, Jun 28, 2018 at 12:40:39PM +0100, Quentin Perret wrote:
>> @@ -698,6 +698,9 @@ struct root_domain {
>>  	/* Indicate more than one runnable task for any CPU */
>>  	bool			overload;
> 
> While there, make that an int.

That's what I've done at [1] - I guess that's the fun part of having those
two patch sets in flight at the same time...

[1]: https://lore.kernel.org/lkml/1530699470-29808-8-git-send-email-morten.rasmussen@arm.com/

> 
>> +	/* Indicate one or more cpus over-utilized (tipping point) */
>> +	int			overutilized;
>> +
>>  	/*
>>  	 * The bit corresponding to a CPU gets set here if such CPU has more
>>  	 * than one runnable -deadline task (as it is below for RT tasks).
>> -- 
>> 2.17.1
>>
