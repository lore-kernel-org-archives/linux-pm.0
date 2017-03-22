From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / runtime: Use synchronous runtime PM call in rpm_put_suppliers()
Date: Wed, 22 Mar 2017 21:56:51 +0100
Message-ID: <CAJZ5v0ihYQp4_oJCu3Tugbqrm=68hcxdg8-yUphbCXCUw3UzPw@mail.gmail.com>
References: <CGME20170322092305eucas1p20d2a6dfede483210febea5b5e0ff68db@eucas1p2.samsung.com>
 <1490174570-18345-1-git-send-email-m.szyprowski@samsung.com> <CAPDyKFq+mTvruQb5ifj3etMxSCWgDZTZ6ebGkk84UCQDqjR4-A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFq+mTvruQb5ifj3etMxSCWgDZTZ6ebGkk84UCQDqjR4-A@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, linux-clk <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 22, 2017 at 12:34 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 22 March 2017 at 10:22, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>> rpm_put_suppliers() might be called as a result of pm_runtime_put_sync()
>> call, where the called explicitly wants to perform the operation in
>> synchronous way to avoid some deadlocks related to concurrent code
>> execution in the PM workers. However the current code for handling device
>> links always use asynchronous calls. This patch changes it to always use
>> the synchronous calls.
>
> This is a good idea! It is better to leave the decision to the "leaf"
> node of whether to use asynchronous mode or not.

One immediate concern that I have is that this happens in an SRCU
read-side critical section and sync runtime suspend can take arbitrary
amount of time, especially if those devices have suppliers etc.  You
may very well wait for an entire subtree to suspend synchronously
here.

Moreover, if the suppliers have parents, those parents won't be
suspended synchronously anyway, so this only addresses the first level
of hierarchy in that case.

Also the behavior for suppliers follows the behavior for parents and I
don't quite see the reason for these two cases to behave differently
in principle.

>>
>> This patch fixes the potential deadlock, which appears during adding
>> runtime PM support to clock framework, which uses global mutex, which is
>> reentrant only for the current process, so trying to execute runtime PM
>> callback from the worker results in deadlock (the mentioned mutex is
>> already taken by the current process, which waits for execution of PM
>> worker).
>
> This just tells that the locking mechanism for clocks are fragile.

Right.

We seem to be working around problems in there with this patch.

> Whether it is a good motivation for this change, I am not sure.
>
> In either case, I like the change!

Why exactly do you like it?

Thanks,
Rafael
