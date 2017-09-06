From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 0/8] PM / ACPI / i2c: Deploy runtime PM centric path for system sleep
Date: Wed, 06 Sep 2017 02:52:59 +0200
Message-ID: <1883292.VFru06qUYG@aspire.rjw.lan>
References: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org> <1668277.7DWLdgHGid@aspire.rjw.lan> <CAPDyKFpX3Owk4H=0SqgfspXZd9TmdL_ANOZftXRq6HPjrT2ctQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpX3Owk4H=0SqgfspXZd9TmdL_ANOZftXRq6HPjrT2ctQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, September 4, 2017 2:55:37 PM CEST Ulf Hansson wrote:
> [...]
> 
> >> > So can you please remind me why the _force_ wrappers are needed?
> >>
> >> See below.
> >>
> >> >
> >> > In particular, why can't drivers arrange their callbacks the way I did that
> >> > in https://patchwork.kernel.org/patch/9928583/ ?
> >>
> >> I was preparing a reply to that patch, but let me summarize that here instead.
> >>
> >> Let me be clear, the patch is an improvement of the behavior of the
> >> driver and it addresses the issues you point out in the change log.
> >> Re-using the runtime PM callbacks for system sleep, is nice as it
> >> avoids open coding, which is of curse also one of the reason of using
> >> pm_runtime_force_suspend|resume().
> >>
> >> Still there are a couple of things I am worried about in this patch.
> >> *)
> >> To be able to re-use the same callbacks for system sleep and runtime
> >> PM, some boilerplate code is added to the driver, as to cope with the
> >> different conditions inside the callbacks. That pattern would become
> >> repeated to many drivers dealing with similar issues.
> >
> > I'm not worried about that as long as there are good examples and
> > documented best practices.
> >
> > There aren't any right now, which is a problem, but that certainly is
> > fixable.
> >
> >> **)
> >> The ->resume_early() callback powers on the device, in case it was
> >> runtime resumed when the ->suspend_late() callback was invoked. That
> >> is in many cases completely unnecessary, causing us to waste power and
> >> increase system resume time, for absolutely no reason. However, I
> >> understand the patch didn't try to address this, but to really fix
> >> this, there has to be an even closer collaboration between runtime PM
> >> and the system sleep callbacks.
> >
> > I don't quite agree and here's why.
> >
> > If a device was not runtime-suspended right before system suspend, then quite
> > likely it was in use then.  Therefore it is quite likely to be resumed
> > immediately after system resume anyway.
> 
> Unfortunate, to always make that assumption, leads to a non-optimized
> behavior of system sleep. I think we can do better than that!
> 
> Let me give you a concrete example, where the above assumption would
> lead to an non-optimized behavior.
> 
> To put an MMC card into low power state during system suspend
> (covering eMMC, SD, SDIO) the mmc core needs to send a couple of
> commands over the MMC interface to the card, as to conform with the
> (e)MMC/SD/SDIO spec. To do this, the mmc driver for the mmc controller
> must runtime resume its device, as to be able to send the commands
> over the interface.
> 
> Now, when the system resumes, there is absolutely no reason to runtime
> resume the device for the MMC controller, just because it was runtime
> resumed during system suspend. Instead that is better to be postponed
> to when the MMC card is really needed and thus via runtime PM instead.

Yes, in this particular case it makes more sense to defer the resume of
the device, but there also are cases in which doing that leads to
suboptimal behavior.

> This scenario shouldn't be specific to only MMC controllers/cards, but
> should apply to any external devices/controllers that needs some
> special treatment to be put into low power state during system
> suspend. Particularly also when those external devices may be left in
> that low power state until those are really needed. A couple of cases
> I know of pops up in my head, WiFi chips, persistent storage devices,
> etc. There should be plenty.
> 
> Another common case, is when a subsystem core layer flushes a request
> queue during system suspend, which may cause a controller device to be
> runtime resumed. Making the assumption that, because flushing the
> queue was done during system suspend, we must also power up the
> controller during system resume, again would lead to a non-optimized
> behavior.

I understand that.

However, from a driver perspective, the most straightforward thing to do
is to restore the previous state of the device during system resume,
because that guarantees correctness.  Anything else is tricky and need to
be done with extra care.  Drivers *must* know what they are doing when
they are doing such things.

> >
> > Now, if that's just one device, it probably doesn't matter, but if there are
> > more devices like that, they will be resumed after system suspend when they
> > are accessed and quite likely they will be accessed one-by-one rather than in
> > parallel with each other, so the latencies related to that will add up.  In
> > that case it is better to resume them upfront during system resume as they will
> > be resumed in parallel with each other then.  And that also is *way* simpler.
> >
> > This means that the benefit from avoiding to resume devices during system
> > resume is not quite so obvious and the whole point above is highly
> > questionable.
> 
> I hope my reasoning above explains why I think it shouldn't be
> considered as questionable.
> 
> If you like, I can also provide some real data/logs - showing you
> what's happening.
> 

That's not necessary, this behavior can be useful and there are arguments for
doing it in *some* cases, but all of this argumentation applies to devices
that aren't going to be used right after system resume.  If they *are* going
to be used then, it very well may be better to resume them as part of
system resume instead of deferring that.

The tricky part is that at the point the resume callbacks run it is not known
whether or not the device is going to be accessed shortly and the decision made
either way may be suboptimal.

[Note: I know that people mostly care about seeing the screen on, but in fact
they should *also* care about the touch panel being ready to respond to
touches, for example.  If it isn't ready and the system suspends again
after a while because of that, the experience is somehwat less than fantastic.]

> >>
> >> So, to remind you why the pm_runtime_force_suspend|resume() helpers is
> >> preferred, that's because both of the above two things becomes taken
> >> care of.
> >
> > And that is why there is this stuff about parents and usage counters, right?
> 
> Correct. Perhaps this commit tells you a little more.
> 
> commit 1d9174fbc55ec99ccbfcafa3de2528ef78a849aa
> Author: Ulf Hansson <ulf.hansson@linaro.org>
> Date:   Thu Oct 13 16:58:54 2016 +0200
> 
>     PM / Runtime: Defer resuming of the device in pm_runtime_force_resume()
> 
> [...]
> 
> >> >
> >> > PM core => bus type / PM domain ->suspend_late => driver ->suspend_late
> >> >
> >> > is far more straightforward than
> >> >
> >> > PM core => bus type / PM domain ->suspend_late => driver ->suspend_late =>
> >> >         bus type / PM domain ->runtime_suspend => driver ->runtime_suspend
> >> >
> >> > with the bus type / PM domain having to figure out somehow at the
> >> > ->suspend_late time whether or not its ->runtume_suspend is going to be invoked
> >> > in the middle of it.
> >> >
> >> > Apart from this just being aesthetically disgusting to me, which admittedly is
> >> > a matter of personal opinion, it makes debugging new driver code harder (if it
> >> > happens to not work) and reviewing it almost impossible, because now you need
> >> > to take all of the tangling between callbacks into accont and sometimes not
> >> > just for one bus type / PM domain.
> >>
> >> I am wondering that perhaps you may be overlooking some of the
> >> internals of runtime PM. Or maybe not? :-)
> >>
> >> I mean, the hole thing is build upon that anyone can call runtime PM
> >> functions to runtime resume/suspend a device.
> >
> > Well, right in general, except that _force_suspend/resume() invoke
> > *callbacks* and *not* runtime PM functions.
> 
> I am considering pm_runtime_force_suspend|resume() being a part of the
> runtime PM API, except that those may be called only during system
> sleep.
> 
> Comparing a call to pm_runtime_resume(); this may trigger rpm_resume()
> to invoke the callbacks. To me, the difference is that the conditions
> looked at in rpm_resume(), when runtime PM is enabled, becomes
> different for system sleep when runtime PM is disabled - and that is
> taken care of in pm_runtime_force_suspend|resume().

So actually invoking runtime PM from a *driver* ->suspend callback for the
same device it was called for is fishy at best and may be a bug.  I'm not
sure why I had been thinking that it might have been fine at all.  It isn't.

The reason why is because runtime PM *potentially* involves invoking middle
layer callbacks an they generally may look like

->runtime_resume:
	(1) do A
	(2) call driver ->runtime_resume
	(3) do B

Now, a middle layer ->suspend callback generally may look like this:

->suspend:
	(1) do C
	(2) call driver ->suspend
	(3) do D

and if you stick the middle layer ->runtime_suspend invocation into the
driver ->suspend (which effectively is what running runtime PM in there means),
you get something like

do C
...
do A
call driver ->runtime_resume
do B
...
do D

and there's no guarantee whatever that "do C" can go before "do A" and
"do B" can go before "do D".  That depends on how the middle layer is designed
and there may be good reasons for how it works.

> >
> >> Doing that, makes the
> >> hierarchy of the runtime PM callbacks being walked and invoked, of
> >> course properly managed by the runtime PM core.
> >>
> >> My point is that, the runtime PM core still controls this behavior,
> >> even when the pm_runtime_force_suspend|resume() helpers are being
> >> invoked. The only difference is that it allows runtime PM for the
> >> device to be disabled, and still correctly invoked the callbacks. That
> >> is what it is all about.
> >
> > So why is it even useful to call ->runtime_suspend from a middle layer
> > in pm_runtime_force_suspend(), for example?
> 
> Perhaps I don't understand the question correctly.
> 
> Anyway, the answer I think of, is probably because of the same reason
> to why the runtime PM core invokes it, when it runs rpm_suspend() for
> a device. My point is, we want the similar behavior.

Not really.  The context is different, so why to expect the behavior to be
the same?

> [...]
> 
> >> >
> >> > Also, when I looked at _force_suspend/resume() again, I got concerned.
> >> > There is stuff in there that shouldn't be necessary in a driver's
> >> > ->late_suspend/->early_resume and some things in there just made me
> >> > scratch my head.
> >>
> >> Yes, there are some complexity in there, I will be happy to answer any
> >> specific question about it.
> >
> > OK
> >
> > Of course they require runtime PM to be enabled by drivers using them as
> > their callbacks, but I suppose that you realize that.
> >
> > Why to disabe/renable runtime PM in there in the first place?  That should
> > have been done by the core when these functions are intended to be called.
> 
> The reason is because we didn't want to re-strict them to be used only
> in ->suspend_late() and ->resume_early(), but also for ->suspend() and
> ->resume(), which is when runtime PM still is enabled.

Well, that means disabling runtime PM for some devices earlier which isn't
particularly consistent overall.

> >
> > Second, why to use RPM_GET_CALLBACK in there?
> 
> To follow the same rules/hierarchy, as being done in rpm_suspend|resume().

No, you don't use the same hierarchy, which is the key point of my objection.

You run *already* in the context of a middle layer PM callback, so by very
definition it is *not* the same situation as running runtime PM elsewhere.

This is the second or maybe even the third time I have repeated this point
and I'm not going to do so again.

> >
> > Next, how is the parent actually runtime-resumed by pm_runtime_force_resume()
> > which the comment in pm_runtime_force_suspend() talks about?
> 
> I think the relevant use case here is when a parent and a child, both
> have subsystems/drivers using pm_runtime_force_suspend|resume(). If
> that isn't the case, we expect that the parent is always resumed
> during system resume.

Why?

> It's a bit fragile approach, so we perhaps we
> should deal with it, even if the hole thing is used as opt-in.
> 
> Anyway, let's focus on the case which I think is most relevant to your question:
> 
> A couple of conditions to start with.
> *) The PM core system suspends a child prior a parent, which leads to
> pm_runtime_force_suspend() being called for the child first.
> **) The PM core system resumes a parents before a child, thus
> pm_runtime_force_resume() is called for the parent first.
> 
> In case a child don't need to be resumed when
> pm_runtime_force_resume() is called for it, likely doesn't its parent.
> However, to control that, in system suspend the
> pm_runtime_force_suspend() increases the usage counter for the parent,
> as to indicate if it needs to be resumed when
> pm_runtime_force_resume() is called for it.

OK, I see.

Why is usage_count > 1 used as the condition to trigger this behavior?

Thanks,
Rafael

