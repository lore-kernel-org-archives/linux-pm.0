From: Luca Abeni <luca.abeni@unitn.it>
Subject: Re: [RFCv6 PATCH 09/10] sched: deadline: use deadline bandwidth in
 scale_rt_capacity
Date: Tue, 15 Dec 2015 14:21:56 +0100
Message-ID: <567013F4.8010301@unitn.it>
References: <1449641971-20827-1-git-send-email-smuckle@linaro.org>
 <1449641971-20827-10-git-send-email-smuckle@linaro.org>
 <20151214151729.GQ6357@twins.programming.kicks-ass.net>
 <CAKfTPtAVmS6BHWcGz4cB0bpEE91QzU5sSmMWZB9j_vpK0qjwHg@mail.gmail.com>
 <20151214221231.39b5bc4e@luca-1225C>
 <CAKfTPtDT----aVGF-3T90PZQQvsOJay_Y-js19W+NNZpvk7J_w@mail.gmail.com>
 <566FD446.1080004@unitn.it>
 <20151215122304.GB6357@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151215122304.GB6357@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, Ingo Molnar <mingo@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

On 12/15/2015 01:23 PM, Peter Zijlstra wrote:
> On Tue, Dec 15, 2015 at 09:50:14AM +0100, Luca Abeni wrote:
>> Strictly speaking, the active utilisation must be updated when a task
>> wakes up and when a task sleeps/terminates (but when a task sleeps/terminates
>> you cannot decrease the active utilisation immediately: you have to wait
>> some time because the task might already have used part of its "future
>> utilisation").
>> The active utilisation must not be updated when a task is throttled: a
>> task is throttled when its current runtime is 0, so it already used all
>> of its utilisation for the current period (think about two tasks with
>> runtime=50ms and period 100ms: they consume 100% of the time on a CPU,
>> and when the first task consumed all of its runtime, you cannot decrease
>> the active utilisation).
>
> Hehe, this reminds me of the lag tracking in EEVDF/WF2Q/BFQ etc., that
> had similar issues.
Yes, I remember EEVDF and similar algorithms also needed to keep track of
the current lag (and to reset it at a later time respect to the "task is
blocking" event). I do not remember the exact details, but I "borrowed" the
"0-lag time" name from one of those papers :)


				Luca
