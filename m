From: Douglas Raillard <douglas.raillard@arm.com>
Subject: Re: [RFC PATCH 0/7] sched/cpufreq: Make schedutil energy aware
Date: Mon, 13 May 2019 14:52:49 +0100
Message-ID: <054f34d5-1b88-9337-501f-321519f5d27c@arm.com>
References: <20190508174301.4828-1-douglas.raillard@arm.com>
 <CAOh2x=k23D_FefOnmLjExj1d+UiothgOmyUk=1mqFknpHNwWGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOh2x=k23D_FefOnmLjExj1d+UiothgOmyUk=1mqFknpHNwWGg@mail.gmail.com>
Content-Language: en-GB-large
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, quentin.perret@arm.com, patrick.bellasi@arm.com, Dietmar Eggemann <dietmar.eggemann@arm.com>, rjw@rjwysocki.net
List-Id: linux-pm@vger.kernel.org

Hi Viresh, Rafael,

On 5/13/19 8:12 AM, Viresh Kumar wrote:
> On Wed, May 8, 2019 at 11:57 PM <douglas.raillard@arm.com> wrote:
>>
>> From: Douglas RAILLARD <douglas.raillard@arm.com>
>>
>> Make schedutil cpufreq governor energy-aware.
> 
> Hi Douglas,
> 
> I was wondering on why the cpufreq maintainers weren't cc'd for this set and
> then I noticed that get_maintainers doesn't report us at all for schedutil :(
>
> I have sent a patch to fix that, but please include us as well in the
> future even
> if get_maintainers doesn't report us :)

Looks like it was a mix of me not checking my checklist and get_maintainers
not catching it, I'll make sure both of you are in CC next time :)

> 
> --
> viresh

Thanks,
Douglas
