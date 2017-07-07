From: Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH v2 3/6] cpufreq: schedutil: ensure max frequency while
 running RT/DL tasks
Date: Thu, 6 Jul 2017 22:26:36 -0700
Message-ID: <CAJWu+ooRMN2iKBHJwE8Rvby4H64__m3ASvZv7_J_FCEB1dVDhw@mail.gmail.com>
References: <1499189651-18797-1-git-send-email-patrick.bellasi@arm.com>
 <1499189651-18797-4-git-send-email-patrick.bellasi@arm.com>
 <20170705060136.GO3532@vireshk-i7> <20170705134126.GD2659@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170705134126.GD2659@e110439-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Andres Oportus <andresoportus@google.com>, Todd Kjos <tkjos@android.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steve Muckle <smuckle.linux@gmail.com>, Brendan Jackman <brendan.jackman@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On Wed, Jul 5, 2017 at 6:41 AM, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
[..]
>
>> But what about clearing the sched-class's flag from .pick_next_task() callback
>> when they return NULL ?
>>
>> What about something like this instead (completely untested), with which we
>> don't need the 2/3 patch as well:
>
> Just had a fast check but I think something like that can work.
> We had an internal discussion with Brendan (in CC now) which had a
> similar proposal.
>
> Main counter arguments for me was:
> 1. we wanna to reduce the pollution of scheduling classes code with
>    schedutil specific code, unless strictly necessary
> 2. we never had a "clear bit" semantics for flags updates
>
> Thus this proposal seemed to me less of a discontinuity wrt the
> current interface. However, something similar to what you propose
> below should also work. Let's collect some more feedback...
>

I was going to say something similar. I feel its much cleaner if the
scheduler clears the flags that it set, thus taking "ownership" of the
flag. I feel that will avoid complication like this where the governor
has to peek into what's currently running and such (and also help with
the suggestion I made for patch 2/3.

Maybe the interface needs an extension for "clear flag" semantics?

thanks,

-Joel
