From: Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH] sched/fair: schedutil: update only with all info available
Date: Thu, 12 Apr 2018 11:06:35 -0700
Message-ID: <CAJWu+oo3j-i0AsbRxkp5t8aiEWQezbEQL5FmHTS1p+aUJBx77w@mail.gmail.com>
References: <20180406172835.20078-1-patrick.bellasi@arm.com>
 <CAKfTPtCkZ1x-LS7sfJ7K2cgsKK=hYnDo1Fi3toPcGT0331Vpog@mail.gmail.com>
 <20180410110412.GG14248@e110439-lin> <CAKfTPtAJQgA7w+2PRwhrY1xzsVH9CUt-wZurc+9qdmMLopYfUQ@mail.gmail.com>
 <20180411101517.GL14248@e110439-lin> <CAKfTPtBKPx0o7AfEMsJv998aCggYQzsOnxmy-qu6B8UULCZabA@mail.gmail.com>
 <CAJWu+orqbT0n+dHabinf=kWN8Frh+3VH6cpc6ADit_BDhFFhTQ@mail.gmail.com> <CAKfTPtAkcATqmahtuc046GC6sw1084PFokx+Nb8Z3ucBPPCeFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKfTPtAkcATqmahtuc046GC6sw1084PFokx+Nb8Z3ucBPPCeFQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, Peter Zijlstra <peterz@infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, Steve Muckle <smuckle@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 12, 2018 at 12:01 AM, Vincent Guittot
<vincent.guittot@linaro.org> wrote:

>>
>> Also that aside, the "running util" is what was used to drive the CFS
>> util before Peter's patch (8f111bc357a). That was accounting the
>> blocked and decaying utilization but that patch changed the behavior.
>> It seems logical we should just use that not check for h_nr_running
>> for CFS so we don't miss on the decayed  utilization. What is the use
>> of checking h_nr_running or state of runqueue for CFS? I am sure to be
>> missing something here. :-(
>
> As Peter mentioned, the change in commit (8f111bc357a) was to remove
> the test that was arbitrary removing the util_avg of a cpu that has
> not been updated since a tick
>
> But with the update of blocked idle load, we don't need to handle the
> case of stalled load/utilization

Thanks a lot for the clarification. It makes sense now.

- Joel
