From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 0/8] PM / ACPI / i2c: Deploy runtime PM centric path for system sleep
Date: Thu, 31 Aug 2017 02:17:41 +0200
Message-ID: <3033151.kbPpEQGlRq@aspire.rjw.lan>
References: <1504018610-10822-1-git-send-email-ulf.hansson@linaro.org> <1957183.ZU1CWrAZoR@aspire.rjw.lan> <CAPDyKFosu8RYUUCiBn7+03b3TNmND-aCTqR=+svcvzCwhxw9+A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFosu8RYUUCiBn7+03b3TNmND-aCTqR=+svcvzCwhxw9+A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Jisheng Zhang <jszhang@marvell.com>, John Stultz <john.stultz@linaro.org>, Guodong Xu <guodong.xu@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>, Haojian Zhuang <haojian.zhuang@linaro.org>, Johannes Stezenbach <js@sig21.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Disclaimer: I'm falling asleep, so I probably shouldn't reply to email right
now, but tomorrow I may not be able to get to email at all, so I'll try anyway.

On Wednesday, August 30, 2017 11:57:28 AM CEST Ulf Hansson wrote:
> On 29 August 2017 at 22:19, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, August 29, 2017 4:56:42 PM CEST Ulf Hansson wrote:
> >> The i2c designware platform driver, drivers/i2c/busses/i2c-designware-platdrv.c,
> >> isn't well optimized for system sleep.
> >>
> >> What makes this driver particularly interesting is because it's a cross-SoC
> >> driver, which sometimes means there is an ACPI PM domain attached to the i2c
> >> device and sometimes not. The driver is being used on both x86 and ARM.
> >>
> >> In principle, to optimize the system sleep support in i2c driver, this series
> >> enables the proven runtime PM centric path for the i2c driver. However, to do
> >> that the ACPI PM domain also have to collaborate and understand this behaviour.
> >> From earlier versions, Rafael has also pointed out that also the PM core needs
> >> to be involved.
> >
> > Earlier today I realized that drivers pointing their ->suspend_late and
> > ->resume_early callbacks, respectively, to pm_runtime_force_suspend() and
> > pm_runtime_force_resume(), are fundamentally incompatible with any bus type
> > doing nontrivial PM and with almost any nontrivial PM domains, for two reasons.
> >
> > First, it basically requires the bus type or PM domain to expect that its
> > ->runtime_suspend callback may or may not be indirectly invoked from its
> > own ->suspend_late callback, depending on the driver (and analogously
> > for ->runtime_resume and ->resume early), which is insane.
> >
> > Second, it is a layering violation, because it makes the driver effectively
> > override the upper layer's decisions about what code to run.
> 
> You are right that for more complex bus types and PM domains, those
> needs to play along. So that is what I am trying to implement for the
> ACPI PM domain in this series.

Well, "play along" is a bit of an understatement here.

They would need to turn into horrible mess and that's not going to happen.

> The generic PM domain, is simple in this regards. There is only a
> minor adaptation for the ->runtime_suspend|resume() callbacks, which
> avoids validating dev_pm_qos constraints during system sleep. Nothing
> special is needed in ->suspend_late|noirq callbacks, etc.
> 
> For most other simple bus types, like the platform bus, spi, i2c,
> amba, no particular adoptions is needed at all. Instead those just
> trust the drivers to do the right thing.

They are the trivial ones.

> Before we had the direct_complete path, using the
> pm_runtime_force_suspend|resume() helpers, was the only good way for
> these kind of drivers, to in an optimized manner, deal with system
> sleep when runtime PM also was enabled for their devices. Now this
> method has become widely deployed, unfortunate whether you like it or
> not.

So can you please remind me why the _force_ wrappers are needed?

In particular, why can't drivers arrange their callbacks the way I did that
in https://patchwork.kernel.org/patch/9928583/ ?

> Besides the slightly better optimizations you get when using
> pm_runtime_force_suspend|resume(), comparing to the direct_complete
> path - I think it's also worth to consider, how easy it becomes for
> drivers to deploy system sleep support. In many cases, only two lines
> of code is needed to add system sleep support in a driver.

You are doing a wrong comparison here IMO.  You essentially are comparing two
bandaids with each other and arguing that one of them somehow is better.

What about doing something which is not a bandaid instead?

> Now, some complex code always needs to be implemented somewhere. When
> using the runtime PM centric path, that code consist of the
> pm_runtime_force_suspend|resume() helpers itself - and some
> adaptations in buses/PM domains in cases when those needs special
> care.
> 
> My point is, the runtime PM centric path, allows us to keep the
> complex part of the code at a few centralized places, instead of
> having it spread/duplicated into drivers.
> 
> So yes, you could consider it insane, but to me and many others, it
> seems to work out quite well.

Because it only has been used with trivial middle layer code so far
and I'm quite disappointed that you don't seem to see a problem here. :-/

I mean something like

PM core => bus type / PM domain ->suspend_late => driver ->suspend_late

is far more straightforward than

PM core => bus type / PM domain ->suspend_late => driver ->suspend_late =>
	bus type / PM domain ->runtime_suspend => driver ->runtime_suspend

with the bus type / PM domain having to figure out somehow at the
->suspend_late time whether or not its ->runtume_suspend is going to be invoked
in the middle of it.

Apart from this just being aesthetically disgusting to me, which admittedly is
a matter of personal opinion, it makes debugging new driver code harder (if it
happens to not work) and reviewing it almost impossible, because now you need
to take all of the tangling between callbacks into accont and sometimes not
just for one bus type / PM domain.

> Yeah, and the laying violation is undoubtedly the most controversial
> part of the runtime PM centric path - I agree to that! The
> direct_complete path don't have this, as you implemented it. :-)
> 
> On the other hand, one could consider that these upper layers, in many
> cases anyway needs to play along with the behavior of the driver. So,
> I guess it depends on how one see it.
> 
> >
> > That's why I'm afraid that we've reached a dead end here. :-(
> 
> That's said news. Is was really hoping I could find a way to move this
> forward. You don't have any other ideas on how I can adjust the series
> to make you happy?

So to be precise, patches [2-3/8] are basically fine by me.  Patch [4/8]
sort of works too, but I'd do the splitting slightly differently and I don't
see much value in it alone.

The rest of the ACPI changes is mostly not acceptable to me, mostly because
of what is done to the PM domain's ->runtime_suspend/resume and
->suspend_late/->resume_early callbacks.

I guess the only way that could be made work for me would be by not using
_force_suspend/resume() at all, but that would defeat the point, right?

I don't like the flag too, but that might be worked out.

Also, when I looked at _force_suspend/resume() again, I got concerned.
There is stuff in there that shouldn't be necessary in a driver's
->late_suspend/->early_resume and some things in there just made me
scratch my head.

Thanks,
Rafael

