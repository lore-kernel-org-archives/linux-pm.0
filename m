From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v3 03/14] sched/core: uclamp: add CPU's clamp groups
 accounting
Date: Wed, 15 Aug 2018 12:59:54 +0200
Message-ID: <ccd9c53f-55f7-a285-39eb-4303888dafcd@arm.com>
References: <20180806163946.28380-1-patrick.bellasi@arm.com>
 <20180806163946.28380-4-patrick.bellasi@arm.com>
 <a24def9b-57bb-d072-5064-0421076d2e43@arm.com>
 <20180814164905.GG2605@e110439-lin>
 <7c45c1a8-24cb-6798-5b6f-3b5dfc9b490d@arm.com>
 <20180815105428.GA7388@e110439-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180815105428.GA7388@e110439-lin>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>, Suren Baghdasaryan <surenb@google.com>
List-Id: linux-pm@vger.kernel.org

On 08/15/2018 12:54 PM, Patrick Bellasi wrote:
> On 15-Aug 11:37, Dietmar Eggemann wrote:
>> On 08/14/2018 06:49 PM, Patrick Bellasi wrote:
>>> Hi Dietmar!
>>>
>>> On 14-Aug 17:44, Dietmar Eggemann wrote:
>>>> On 08/06/2018 06:39 PM, Patrick Bellasi wrote:

[..]

>> If this is only for testing/debugging, I would suggest a simple one line
>> BUG_ON()
> 
> These are (eventually) considered as recoverable errors... thus,
> AFAIK, using BUG_ON is overkilling and discouraged:
>    https://elixir.bootlin.com/linux/latest/source/include/asm-generic/bug.h#L42

Not sure about that. If this refcounting is out of sync, that's 
indicating a serious issue here for me which should be fixed.

>> You find CONFIG_SCHED_DEBUG=y in production kernels as well.
> 
> AFAIK, that setting is discouraged for production kernels...
> Moreover, it's still better to WARN sometimes on a production kernel
> the crash the device, isnt't it?

IMHO, if this is something which should not happen at all, a BUG_ON() is 
the right thing to do here. And you get the call stack to investigate 
why it hit.
