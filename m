From: Joel Fernandes <joelaf@google.com>
Subject: Re: [RFC v3 5/5] sched/{core,cpufreq_schedutil}: add capacity
 clamping for RT/DL tasks
Date: Wed, 15 Mar 2017 16:40:07 -0700
Message-ID: <CAJWu+ooCmyx7PNXhzrDsUQM=eU1zxo8F3gyp2ihpabpREk5vfg@mail.gmail.com>
References: <1488292722-19410-1-git-send-email-patrick.bellasi@arm.com>
 <1488292722-19410-6-git-send-email-patrick.bellasi@arm.com>
 <CAEi0qNkn8xS=8vzStXjtJVwYwiXiu4vefZwe3VQPUVqz72YiKw@mail.gmail.com>
 <20170315114052.GB18557@e110439-lin> <CAJWu+opgLoa3EGdhQKXSi+dkQjXtc62tKmTL0krXxpqJp+PjPQ@mail.gmail.com>
 <20170315144449.GH31499@e106622-lin> <CAJWu+orSQbyDxN4O6wk8SYj-t5FyUZA4aO0GQqm8Fgujwr9+Lw@mail.gmail.com>
 <20170315162414.GI31499@e106622-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170315162414.GI31499@e106622-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@arm.com>
Cc: Patrick Bellasi <patrick.bellasi@arm.com>, "Joel Fernandes (Google)" <joel.opensrc@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Andres Oportus <andresoportus@google.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 15, 2017 at 9:24 AM, Juri Lelli <juri.lelli@arm.com> wrote:
[..]
>
>> > However, trying to quickly summarize how that would work (for who is
>> > already somewhat familiar with reclaiming bits):
>> >
>> >  - a task utilization contribution is accounted for (at rq level) as
>> >    soon as it wakes up for the first time in a new period
>> >  - its contribution is then removed after the 0lag time (or when the
>> >    task gets throttled)
>> >  - frequency transitions are triggered accordingly
>> >
>> > So, I don't see why triggering a go down request after the 0lag time
>> > expired and quickly reacting to tasks waking up would have create
>> > problems in your case?
>>
>> In my experience, the 'reacting to tasks' bit doesn't work very well.
>
> Humm.. but in this case we won't be 'reacting', we will be
> 'anticipating' tasks' needs, right?

Are you saying we will start ramping frequency before the next
activation so that we're ready for it?

If not, it sounds like it will only make the frequency request on the
next activation when the Active bandwidth increases due to the task
waking up. By then task has already started to run, right?

Thanks,
Joel
