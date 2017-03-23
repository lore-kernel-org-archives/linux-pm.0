From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / runtime: Use synchronous runtime PM call in rpm_put_suppliers()
Date: Thu, 23 Mar 2017 13:47:46 +0100
Message-ID: <CAPDyKFot3C1C1k45JovwKHFkvTJAFvdetoE8_ADAhMCkFw3hPA@mail.gmail.com>
References: <CGME20170322092305eucas1p20d2a6dfede483210febea5b5e0ff68db@eucas1p2.samsung.com>
 <1490174570-18345-1-git-send-email-m.szyprowski@samsung.com>
 <CAPDyKFq+mTvruQb5ifj3etMxSCWgDZTZ6ebGkk84UCQDqjR4-A@mail.gmail.com> <CAJZ5v0ihYQp4_oJCu3Tugbqrm=68hcxdg8-yUphbCXCUw3UzPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0ihYQp4_oJCu3Tugbqrm=68hcxdg8-yUphbCXCUw3UzPw@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-clk <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 22 March 2017 at 21:56, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Mar 22, 2017 at 12:34 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 22 March 2017 at 10:22, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>> rpm_put_suppliers() might be called as a result of pm_runtime_put_sync()
>>> call, where the called explicitly wants to perform the operation in
>>> synchronous way to avoid some deadlocks related to concurrent code
>>> execution in the PM workers. However the current code for handling device
>>> links always use asynchronous calls. This patch changes it to always use
>>> the synchronous calls.
>>
>> This is a good idea! It is better to leave the decision to the "leaf"
>> node of whether to use asynchronous mode or not.
>
> One immediate concern that I have is that this happens in an SRCU
> read-side critical section and sync runtime suspend can take arbitrary
> amount of time, especially if those devices have suppliers etc.  You
> may very well wait for an entire subtree to suspend synchronously
> here.

Yes that's a problem. Can we address that somehow?

>
> Moreover, if the suppliers have parents, those parents won't be
> suspended synchronously anyway, so this only addresses the first level
> of hierarchy in that case.
>
> Also the behavior for suppliers follows the behavior for parents and I
> don't quite see the reason for these two cases to behave differently
> in principle.

Yes, you are right!

We shouldn't change this for suppliers unless we also change this for parents.

>
>>>
>>> This patch fixes the potential deadlock, which appears during adding
>>> runtime PM support to clock framework, which uses global mutex, which is
>>> reentrant only for the current process, so trying to execute runtime PM
>>> callback from the worker results in deadlock (the mentioned mutex is
>>> already taken by the current process, which waits for execution of PM
>>> worker).
>>
>> This just tells that the locking mechanism for clocks are fragile.
>
> Right.
>
> We seem to be working around problems in there with this patch.
>
>> Whether it is a good motivation for this change, I am not sure.
>>
>> In either case, I like the change!
>
> Why exactly do you like it?

Okay, let me try to elaborate.

For the async runtime PM suspend/idle case (including runtime PM autosuspend):
When a driver for a children/consumer decides to use the async runtime
PM APIs, I assume it's because the driver expects the device to be
used in some kind of a "bursty" manner. Meaning it doesn't make sense
to save power in-between every request, but instead leave the device
powered for little while after a request has been served. The purpose
is often to avoid the wakeup-latency for *each* request, when these
comes in bursts.

For these cases the driver has already traded some power savings for
improved performance of requests in bursts. When this trade is done
for the children/consumer, I think it seems reasonable to not further
defer the parent/supplier to be be runtime suspended/idled, as that
would further trade power for performance, which is what happens when
rpm_idle|suspend() decides to punt this to a work.

Moreover, scheduling a work for each parent/supplier seems suboptimal
to me, as in the async case we are already executing from within a
work. In cases of a higher level of device hierarchy, several works
becomes scheduled.

For the sync runtime PM suspend/idle case:
When a driver for a children/consumers decides to use the sync runtime
PM APIs, it's most likely because it wants the device to enter its low
power state as soon as possible. In other words, there is no need to
trade power for performance, either because power is more important
than performance or because the wakeup latency is negligible. To me, I
think it seems reasonable to respect this policy for parents/suppliers
as well instead of always punting to a work.

Kind regards
Uffe
