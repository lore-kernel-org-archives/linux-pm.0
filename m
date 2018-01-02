From: Claudio Scordino <claudio@evidence.eu.com>
Subject: Re: [PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates
Date: Tue, 2 Jan 2018 14:31:51 +0100
Message-ID: <1afd8769-8f51-184f-221d-4ce68f90371d@evidence.eu.com>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
 <20171220155625.lopjlsbvss3qgb4d@hirez.programming.kicks-ass.net>
 <84cc5951-45c4-3dd6-4f4f-fa5d11e6d1f6@evidence.eu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f181.google.com ([209.85.128.181]:36647 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752080AbeABNbe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jan 2018 08:31:34 -0500
Received: by mail-wr0-f181.google.com with SMTP id u19so42135378wrc.3
        for <linux-pm@vger.kernel.org>; Tue, 02 Jan 2018 05:31:34 -0800 (PST)
In-Reply-To: <84cc5951-45c4-3dd6-4f4f-fa5d11e6d1f6@evidence.eu.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>

Hi Peter,

Il 31/12/2017 10:43, Claudio Scordino ha scritto:
> Hi all,
> 
> Il 20/12/2017 16:56, Peter Zijlstra ha scritto:
>> On Wed, Dec 20, 2017 at 04:30:29PM +0100, Peter Zijlstra wrote:
>>>
>>> So I ended up with the below (on top of Juri's cpufreq-dl patches).
>>>
>>> It compiles, but that's about all the testing it had.
>>
>> Should all be available at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/core
>>
>> compile tested only, I suppose the 0day bot will let me know soon enough
>> :-)
> 
> I'm going to do some testing from Tuesday.

The rebase looks good to me.

Tested on Odroid XU4 (ARM big.LITTLE), no regressions found.

Many thanks and best regards,

           Claudio
