From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / core: Clear the direct_complete flag on errors
Date: Thu, 4 Oct 2018 22:57:08 +0200
Message-ID: <CAJZ5v0jqb1iScje5PajN7F5EL4SQ0oMd4gFhss+=vYRHnogVhA@mail.gmail.com>
References: <61559514.Vym8FNvob2@aspire.rjw.lan> <CAPDyKFoUdQRUYQ0qb5WM=Bi-F_4Fe8VEPNYZGu2ezMPj_wxoPg@mail.gmail.com>
 <CAJZ5v0ih4Hn5W-dTzOayMyMfLMe=djKVhxBcoQ=7oJz6QnpTJQ@mail.gmail.com> <CAPDyKFqMHVvyrjDzoC+QbSLbtdMYcfzDenb+uWTu+Fr-awbU1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFqMHVvyrjDzoC+QbSLbtdMYcfzDenb+uWTu+Fr-awbU1A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, alcooperx@gmail.com, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 4, 2018 at 8:48 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On 4 October 2018 at 19:47, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Thu, Oct 4, 2018 at 3:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >>
> >> On 4 October 2018 at 11:08, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >> >
> >> > If __device_suspend() returns early on an error or pending wakeup
> >> > and the power.direct_complete flag has been set for the device
> >> > already, the subsequent device_resume() will be confused by it
> >> > and it will call pm_runtime_enable() incorrectly, as runtime PM
> >> > has not been disabled for the device by __device_suspend().
> >>
> >> I think it would be fair to mention that is related to the async
> >> suspend path, in dpm_suspend().
> >
> > OK, fair enough.
> >
> >> >
> >> > To avoid that, clear power.direct_complete if __device_suspend()
> >> > is not going to disable runtime PM for the device before returning.
> >>
> >> Overall, by looking at the behavior in dpm_suspend() of async
> >> suspended devices, it does look a bit fragile to me.
> >>
> >> My worries is that we put asynced suspended devices in the
> >> dpm_suspended_list, no matter if the device was successfully suspended
> >> or not. This differs from the no-async path.
> >
> > That's because this was the most straightforward way to organize that
> > (otherwise you need to worry about the list locking with respect to
> > the async suspends etc and you really need to preserve the ordering
> > there).
>
> I understand about the lock, but not sure if that is something to
> worry about, at least from contention point of view, if that is what
> you mean?

The contention may not be a problem, but there would be some extra
overhead related to the dragging of the lock cache line between CPUs.

> In regards to the order, is that really problem for async enabled devices?

You may be underestimating the problem somewhat.

For example, say you have 4 devices, A which is the parent of B and C,
and D which is a child of C.  Say that D depends on B too, but it
cannot be a child of it and there's no device link between B and D.
[For instance, the driver of A has registered both B and C, and the
driver of C has registered D, but it doesn't know about the dependency
between D and B.]  Also say that A, B and C are all async, but D is
sync and all A, B, C are before D in the original list order.

dpm_suspend() will get to A, B and C only after dealing with D.  It
will then start to suspend B and C almost at the same time and A will
wait for both of them.  So far so good.

Next, A will resume first, B and C after it, and D after C.  Say that
B is somewhat faster to resume, but it actually adds itself back to
the list after C and D (as they don't wait for it).  The resume of C
and D succeeds (because B is already there physically), but the
ordering of the list is now A->C->D->B and there will be trouble
during the next suspend, because B will be suspending in parallel with
D which depends on it.

In this case you have to guarantee that D and B will not be reordered,
but it generally is hard without an explicit "link" between them -
unless the original ordering of the list is preserved entirely.

> >
> >> In the long run, maybe we should change that instead?
> >
> > Is there anything wrong with it really?
>
> No, besides complexity. :-)

And how exactly are you measuring the "complexity" here?

> My, point was that we could potentially simplify the code in
> device_resume() and in __device_suspend(), as the behavior would them
> becomes more deterministic.

No, it wouldn't be more deterministic.  In fact, it would then become
less deterministic and provably so if you take consecutive
suspend-resume cycles into account.  In principle, the order in which
devices are handled might be different every time then and sorry, but
I'm failing to see how that can be regarded as "more deterministic".

> device_resume() will never be called unless __device_suspend() has succeeded for the device.

Which doesn't matter.  What matters is that (and which is the case
already) the resume callbacks will not be invoked without invoking the
suspend callbacks for the device beforehand.
