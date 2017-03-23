From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] PM / runtime: Use synchronous runtime PM call in
 rpm_put_suppliers()
Date: Thu, 23 Mar 2017 11:31:16 +0100
Message-ID: <3b74f606-31ea-e11c-2887-a8cf1fde1eb6@samsung.com>
References: <CGME20170322092305eucas1p20d2a6dfede483210febea5b5e0ff68db@eucas1p2.samsung.com>
 <1490174570-18345-1-git-send-email-m.szyprowski@samsung.com>
 <CAPDyKFq+mTvruQb5ifj3etMxSCWgDZTZ6ebGkk84UCQDqjR4-A@mail.gmail.com>
 <CAJZ5v0ihYQp4_oJCu3Tugbqrm=68hcxdg8-yUphbCXCUw3UzPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-reply-to: <CAJZ5v0ihYQp4_oJCu3Tugbqrm=68hcxdg8-yUphbCXCUw3UzPw@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-clk <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On 2017-03-22 21:56, Rafael J. Wysocki wrote:
> On Wed, Mar 22, 2017 at 12:34 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 22 March 2017 at 10:22, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>>> rpm_put_suppliers() might be called as a result of pm_runtime_put_sync()
>>> call, where the called explicitly wants to perform the operation in
>>> synchronous way to avoid some deadlocks related to concurrent code
>>> execution in the PM workers. However the current code for handling device
>>> links always use asynchronous calls. This patch changes it to always use
>>> the synchronous calls.
>> This is a good idea! It is better to leave the decision to the "leaf"
>> node of whether to use asynchronous mode or not.
> One immediate concern that I have is that this happens in an SRCU
> read-side critical section and sync runtime suspend can take arbitrary
> amount of time, especially if those devices have suppliers etc.  You
> may very well wait for an entire subtree to suspend synchronously
> here.
>
> Moreover, if the suppliers have parents, those parents won't be
> suspended synchronously anyway, so this only addresses the first level
> of hierarchy in that case.
>
> Also the behavior for suppliers follows the behavior for parents and I
> don't quite see the reason for these two cases to behave differently
> in principle.

Well, then I don't get why do we really have pm_runtime_put_sync() if it
doesn't guarantee synchronous suspend operations. This might be really 
tricky
to debug locking issues if one assumes that suspend operation has been
finished, but it is still being performed in parallel by the worker.

>>> This patch fixes the potential deadlock, which appears during adding
>>> runtime PM support to clock framework, which uses global mutex, which is
>>> reentrant only for the current process, so trying to execute runtime PM
>>> callback from the worker results in deadlock (the mentioned mutex is
>>> already taken by the current process, which waits for execution of PM
>>> worker).
>> This just tells that the locking mechanism for clocks are fragile.
> Right.
>
> We seem to be working around problems in there with this patch.

Not really. This problem will reappear always if re-entrant locks are used.
Clocks are just one of such frameworks, which use such locking mechanism.

Maybe propagating flags from the caller will be a better approach in this
case? So if caller wants synchronous call, it will be properly propagated,
otherwise, the current behavior will take place. Using pm_runtime_put_sync
is not that common, so probably in most cases callers have a good reason
for that. It would make sense to apply this also to operations on parents.

>> Whether it is a good motivation for this change, I am not sure.
>>
>> In either case, I like the change!
> Why exactly do you like it?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

