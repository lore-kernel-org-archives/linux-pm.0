From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 0/8] PM / ACPI / i2c: Deploy runtime PM centric path for system sleep
Date: Mon, 04 Sep 2017 02:17:21 +0200
Message-ID: <1668277.7DWLdgHGid@aspire.rjw.lan>
References: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org> <3033151.kbPpEQGlRq@aspire.rjw.lan> <CAPDyKFqAqiDcdwEOwEu1m7icnP8MijYf4UNrMqN9YhNbug_upg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:47613 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753046AbdIDA0J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 3 Sep 2017 20:26:09 -0400
In-Reply-To: <CAPDyKFqAqiDcdwEOwEu1m7icnP8MijYf4UNrMqN9YhNbug_upg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>

On Friday, September 1, 2017 12:42:35 PM CEST Ulf Hansson wrote:
> On 31 August 2017 at 02:17, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > Disclaimer: I'm falling asleep, so I probably shouldn't reply to email right
> > now, but tomorrow I may not be able to get to email at all, so I'll try anyway.
> >
> > On Wednesday, August 30, 2017 11:57:28 AM CEST Ulf Hansson wrote:
> >> On 29 August 2017 at 22:19, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >> > On Tuesday, August 29, 2017 4:56:42 PM CEST Ulf Hansson wrote:
> >> >> The i2c designware platform driver, drivers/i2c/busses/i2c-designware-platdrv.c,
> >> >> isn't well optimized for system sleep.
> >> >>
> >> >> What makes this driver particularly interesting is because it's a cross-SoC
> >> >> driver, which sometimes means there is an ACPI PM domain attached to the i2c
> >> >> device and sometimes not. The driver is being used on both x86 and ARM.
> >> >>
> >> >> In principle, to optimize the system sleep support in i2c driver, this series
> >> >> enables the proven runtime PM centric path for the i2c driver. However, to do
> >> >> that the ACPI PM domain also have to collaborate and understand this behaviour.
> >> >> From earlier versions, Rafael has also pointed out that also the PM core needs
> >> >> to be involved.
> >> >
> >> > Earlier today I realized that drivers pointing their ->suspend_late and
> >> > ->resume_early callbacks, respectively, to pm_runtime_force_suspend() and
> >> > pm_runtime_force_resume(), are fundamentally incompatible with any bus type
> >> > doing nontrivial PM and with almost any nontrivial PM domains, for two reasons.
> >> >
> >> > First, it basically requires the bus type or PM domain to expect that its
> >> > ->runtime_suspend callback may or may not be indirectly invoked from its
> >> > own ->suspend_late callback, depending on the driver (and analogously
> >> > for ->runtime_resume and ->resume early), which is insane.
> >> >
> >> > Second, it is a layering violation, because it makes the driver effectively
> >> > override the upper layer's decisions about what code to run.
> >>
> >> You are right that for more complex bus types and PM domains, those
> >> needs to play along. So that is what I am trying to implement for the
> >> ACPI PM domain in this series.
> >
> > Well, "play along" is a bit of an understatement here.
> >
> > They would need to turn into horrible mess and that's not going to happen.
> 
> I absolutely agree, there must be no mess what so ever!
> 
> But, I don't want to give up yet, I still believe I can make this
> series into a nice couple of changes for the ACPI PM domain.

Well, as far as I'm concerned, this is not going to get any further.

> Especially if you continue giving me your guidance.
> 
> >
> >> The generic PM domain, is simple in this regards. There is only a
> >> minor adaptation for the ->runtime_suspend|resume() callbacks, which
> >> avoids validating dev_pm_qos constraints during system sleep. Nothing
> >> special is needed in ->suspend_late|noirq callbacks, etc.
> >>
> >> For most other simple bus types, like the platform bus, spi, i2c,
> >> amba, no particular adoptions is needed at all. Instead those just
> >> trust the drivers to do the right thing.
> >
> > They are the trivial ones.
> 
> Yes.
> 
> However, the platform bus is also very commonly used in kernel. I
> think that's an important thing to consider.

Well, so is ACPI, and PCI.

And the platform bus doesn't do any kind of PM handling by itself,
whereas the above do.  Therefore trying to look at the platform bus as
an example to follow by them is rather not useful IMO.

> >
> >> Before we had the direct_complete path, using the
> >> pm_runtime_force_suspend|resume() helpers, was the only good way for
> >> these kind of drivers, to in an optimized manner, deal with system
> >> sleep when runtime PM also was enabled for their devices. Now this
> >> method has become widely deployed, unfortunate whether you like it or
> >> not.
> >
> > So can you please remind me why the _force_ wrappers are needed?
> 
> See below.
> 
> >
> > In particular, why can't drivers arrange their callbacks the way I did that
> > in https://patchwork.kernel.org/patch/9928583/ ?
> 
> I was preparing a reply to that patch, but let me summarize that here instead.
> 
> Let me be clear, the patch is an improvement of the behavior of the
> driver and it addresses the issues you point out in the change log.
> Re-using the runtime PM callbacks for system sleep, is nice as it
> avoids open coding, which is of curse also one of the reason of using
> pm_runtime_force_suspend|resume().
> 
> Still there are a couple of things I am worried about in this patch.
> *)
> To be able to re-use the same callbacks for system sleep and runtime
> PM, some boilerplate code is added to the driver, as to cope with the
> different conditions inside the callbacks. That pattern would become
> repeated to many drivers dealing with similar issues.

I'm not worried about that as long as there are good examples and
documented best practices.

There aren't any right now, which is a problem, but that certainly is
fixable.

> **)
> The ->resume_early() callback powers on the device, in case it was
> runtime resumed when the ->suspend_late() callback was invoked. That
> is in many cases completely unnecessary, causing us to waste power and
> increase system resume time, for absolutely no reason. However, I
> understand the patch didn't try to address this, but to really fix
> this, there has to be an even closer collaboration between runtime PM
> and the system sleep callbacks.

I don't quite agree and here's why.

If a device was not runtime-suspended right before system suspend, then quite
likely it was in use then.  Therefore it is quite likely to be resumed
immediately after system resume anyway.

Now, if that's just one device, it probably doesn't matter, but if there are
more devices like that, they will be resumed after system suspend when they
are accessed and quite likely they will be accessed one-by-one rather than in
parallel with each other, so the latencies related to that will add up.  In
that case it is better to resume them upfront during system resume as they will
be resumed in parallel with each other then.  And that also is *way* simpler.

This means that the benefit from avoiding to resume devices during system
resume is not quite so obvious and the whole point above is highly
questionable.

> 
> So, to remind you why the pm_runtime_force_suspend|resume() helpers is
> preferred, that's because both of the above two things becomes taken
> care of.

And that is why there is this stuff about parents and usage counters, right?

I'm not liking it at all.

> 
> >
> >> Besides the slightly better optimizations you get when using
> >> pm_runtime_force_suspend|resume(), comparing to the direct_complete
> >> path - I think it's also worth to consider, how easy it becomes for
> >> drivers to deploy system sleep support. In many cases, only two lines
> >> of code is needed to add system sleep support in a driver.
> >
> > You are doing a wrong comparison here IMO.  You essentially are comparing two
> > bandaids with each other and arguing that one of them somehow is better.
> 
> I just wanted to compare against something...
> 
> >
> > What about doing something which is not a bandaid instead?
> 
> I don't have a problem working on something new, but I am not sure
> what that should be.
> 
> Unless you re-consider moving forward in some form, with the current
> suggested approach for the ACPI PM domain, can you give me some
> pointers on what you have in mind?

Yes.

Do what was indended from the start and make drivers re-use runtime
PM callbacks for ->suspend_late and ->resume_early.

First, that can be done.

Second, it is *conceptually* much more straightforward than things like
_force_suspend/resume().

Next, the drivers have full control on what they do in that case and
can be made work with any middle-layer core easily enough.

No layering violations, no insane callback chains.

> To remind you of my current view, the direct_complete path is useful
> for PM domains, like the ACPI PM domain as it impacts all its devices.
> Using pm_runtime_force_suspend|resume() offers the next steps to

I completely disagree at this point.

So to be clear, the invocation of moddle-layer callbacks instead of
*driver* callbacks in pm_runtime_force_suspend|resume() is a grave mistake.
They would have been almost possible to work with had they just invoke
driver callbacks.

OTOH I'm starting to think that direct_complete is only theoretically useful
and may not be actually set very often in practice, whereas it adds significant
complexity to the code, so I'm not sure about it any more.

> achieve a fully optimized behavior of a device during system sleep, as
> already been proven by now. It would be great to both options
> supported by the ACPI PM domain.

No.

> Another related thing that is causing lots of problems during system
> sleep of devices, but not related to optimizations, is to have the
> correct order of how to suspend/resume the devices. We have talked
> about this, but it's a separate problem and it's rather a deployment
> issue, than having to implements something entirely new (we have
> supplies/consumers links you invented for this).

Yes, that is a separate issue.

> >
> >> Now, some complex code always needs to be implemented somewhere. When
> >> using the runtime PM centric path, that code consist of the
> >> pm_runtime_force_suspend|resume() helpers itself - and some
> >> adaptations in buses/PM domains in cases when those needs special
> >> care.
> >>
> >> My point is, the runtime PM centric path, allows us to keep the
> >> complex part of the code at a few centralized places, instead of
> >> having it spread/duplicated into drivers.
> >>
> >> So yes, you could consider it insane, but to me and many others, it
> >> seems to work out quite well.
> >
> > Because it only has been used with trivial middle layer code so far
> > and I'm quite disappointed that you don't seem to see a problem here. :-/
> >
> > I mean something like
> >
> > PM core => bus type / PM domain ->suspend_late => driver ->suspend_late
> >
> > is far more straightforward than
> >
> > PM core => bus type / PM domain ->suspend_late => driver ->suspend_late =>
> >         bus type / PM domain ->runtime_suspend => driver ->runtime_suspend
> >
> > with the bus type / PM domain having to figure out somehow at the
> > ->suspend_late time whether or not its ->runtume_suspend is going to be invoked
> > in the middle of it.
> >
> > Apart from this just being aesthetically disgusting to me, which admittedly is
> > a matter of personal opinion, it makes debugging new driver code harder (if it
> > happens to not work) and reviewing it almost impossible, because now you need
> > to take all of the tangling between callbacks into accont and sometimes not
> > just for one bus type / PM domain.
> 
> I am wondering that perhaps you may be overlooking some of the
> internals of runtime PM. Or maybe not? :-)
> 
> I mean, the hole thing is build upon that anyone can call runtime PM
> functions to runtime resume/suspend a device.

Well, right in general, except that _force_suspend/resume() invoke
*callbacks* and *not* runtime PM functions.

> Doing that, makes the
> hierarchy of the runtime PM callbacks being walked and invoked, of
> course properly managed by the runtime PM core.
> 
> My point is that, the runtime PM core still controls this behavior,
> even when the pm_runtime_force_suspend|resume() helpers are being
> invoked. The only difference is that it allows runtime PM for the
> device to be disabled, and still correctly invoked the callbacks. That
> is what it is all about.

So why is it even useful to call ->runtime_suspend from a middle layer
in pm_runtime_force_suspend(), for example?

> >
> >> Yeah, and the laying violation is undoubtedly the most controversial
> >> part of the runtime PM centric path - I agree to that! The
> >> direct_complete path don't have this, as you implemented it. :-)
> >>
> >> On the other hand, one could consider that these upper layers, in many
> >> cases anyway needs to play along with the behavior of the driver. So,
> >> I guess it depends on how one see it.
> >>
> >> >
> >> > That's why I'm afraid that we've reached a dead end here. :-(
> >>
> >> That's said news. Is was really hoping I could find a way to move this
> >> forward. You don't have any other ideas on how I can adjust the series
> >> to make you happy?
> >
> > So to be precise, patches [2-3/8] are basically fine by me.  Patch [4/8]
> > sort of works too, but I'd do the splitting slightly differently and I don't
> > see much value in it alone.
> >
> > The rest of the ACPI changes is mostly not acceptable to me, mostly because
> > of what is done to the PM domain's ->runtime_suspend/resume and
> > ->suspend_late/->resume_early callbacks.
> >
> > I guess the only way that could be made work for me would be by not using
> > _force_suspend/resume() at all, but that would defeat the point, right?
> 
> Yes, it would.
> 
> >
> > I don't like the flag too, but that might be worked out.
> 
> Yeah, I am open to any suggestion.
> 
> >
> > Also, when I looked at _force_suspend/resume() again, I got concerned.
> > There is stuff in there that shouldn't be necessary in a driver's
> > ->late_suspend/->early_resume and some things in there just made me
> > scratch my head.
> 
> Yes, there are some complexity in there, I will be happy to answer any
> specific question about it.

OK

Of course they require runtime PM to be enabled by drivers using them as
their callbacks, but I suppose that you realize that.

Why to disabe/renable runtime PM in there in the first place?  That should
have been done by the core when these functions are intended to be called.

Second, why to use RPM_GET_CALLBACK in there?

Next, how is the parent actually runtime-resumed by pm_runtime_force_resume()
which the comment in pm_runtime_force_suspend() talks about?

> 
> The main thing is, that it tries to conform to the regular rules set
> by the runtime PM core when runtime PM is enabled for the device - and
> then apply those to the device when runtime PM has been disabled for
> it.

Sorry, I'm not sure what this means really ...

> Again, thanks for being patient and reviewing!

Well, no problem.

Thanks,
Rafael
