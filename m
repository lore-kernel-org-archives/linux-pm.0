From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: dev->status.power and future of DPM_
Date: Thu, 14 May 2009 17:36:55 +0200
Message-ID: <200905141736.56215.rjw@sisk.pl>
References: <aec7e5c30905130329t5610c8d1x925d554b833dedcc@mail.gmail.com>
	<200905131522.31882.rjw@sisk.pl>
	<aec7e5c30905132118m265245f4u9d9581b3fde788f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <aec7e5c30905132118m265245f4u9d9581b3fde788f6@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, Paul Walmsley <paul@pwsan.com>
List-Id: linux-pm@vger.kernel.org

On Thursday 14 May 2009, Magnus Damm wrote:
> Hi Rafael,
> 
> 2009/5/13 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Wednesday 13 May 2009, Magnus Damm wrote:
> >> I'm a bit interested in modifying dev->status.power to reflect the
> >> current device power state. Basically getting rid of DPM_PREPARING,
> >> DPM_RESUMING, DPM_SUSPENDING and DPM_OFF_NOIRQ (they seem to be fairly
> >> unused anyway),
> >
> > Please read drivers/base/power/main.c once again _carefully_ and rethink
> > your observation above.
> 
> Sorry about typos above, it shold be dev->power.status and DPM_OFF_IRQ.

Ah.  That still doesn't sound good, though.  The reason is, on error in
dpm_power_down() the devices that had their callbacks executed go to
OFF_IRQ, while the others stay at OFF, so when device_power_up() is called
to clean up things, it won't touch them.

> So I read through the code again. How about this matrix:
> 
> (function, in-function-change-DPM_, after-DPM_ [error-DPM_])
> 
> device_suspend(), PREPARING/SUSPENDING/OFF/ON, OFF [ON]

You can transition from PREPARING to either SUSPENDING or ON, depending on
whether or not there's an error.  Next, you can either go from SUSPENDING to
OFF, or stay at SUSPENDING (on error), So, the after-DPM is always OFF I'd say.
 Also, the error DPM may be ON or SUSPENDING.

> device_power_down(), OFF_IRQ/OFF, OFF_IRQ, [OFF/unchanged]

Here we go from OFF to OFF_IRQ (you have the other way around).

> device_power_up(), OFF, OFF/unchanged

Here we go from OFF_IRQ to OFF or stay at whatever was set before.

> device_resume(), RESUMING/ON, ON/unchanged

This is more complicated, depending on the situation it is called in.  If that
is during resume, we go from OFF (or OFF_IRQ) to RESUMING and next to ON.
In turn, if that is during _suspend_ on error condition, we go from SUSPENDING
to RESUMING and then to ON.  The final state is always ON.

> Basically, dev->power.status seems to represent the soon to be state
> of each device. For instance, before calling prepare() PREPARING is
> set. Have a look at the JPG that I attached in the previous email.

The meaning of the DPM_ constants is explained in a comment in
include/linux/pm.h .  They are related to device driver callbacks rather than
to the core functions above.

> Am I misunderstanding?

Well, I tried to explain that in detail above. :-)
 
> I'd like to keep the state of each device somewhere.
> 
> >> and instead using the following states:
> >>
> >> DPM_ON - default operational state
> >> DPM_FROZEN - set after PMSG_FREEZE
> >> DPM_OFF - set after PMSG_HIBERNATE
> >> DPM_SUSPENDED - set after PMSG_SUSPEND
> >
> > The PMSG_* things are only used to pass information between the
> > suspend/hibernation core and the functions in drivers/base/power/main.c .
> > They are also used by the legacy suspend callbacks of device drivers, but
> > drivers are encouraged to use struct dev_pm_ops objects instead.
> > And struct dev_pm_ops contains also  the .prepare()/.complete() callbacks that
> > you don't seem to be taking into consideration.
> 
> Thanks for your explanation. I think I understand the PMSG_ stuff. I'm
> aware of dev_pm_ops, they are used in sme of my upstream drivers. As
> for prepare()/complete() - I am taking them into consideration. Please
> check the JPG again.

Yes, sorry.

> > What exactly is the purpose of the changes you're suggesting?
> 
> Earlier this year I've focused on adding power management to the
> SuperH architecture. So in upstream 2.6.30 we now have suspend to disk
> and suspend to ram working for most sleep modes. Currently I'm
> focusing on run time power management (cpu idle, clock framework) and
> deeper sleep modes. This is all upstream activity.

OK

> Entering deeper sleep modes will result in that parts of the SoC get
> powered off. This is true for SuperH Mobile and SoCs from other
> vendors as well. Before turning off power to a certain part of the SoC
> we have to save the state of all the devices located there. And after
> powering up we need to restore the state of each device.
> dev_pm_ops->freeze() and ->restore() seem like good candidates for
> doing that.

OK there, but you need to take the bus type level into consideration.  Namely,
on suspend we have, for example:

dpm_suspend(PMSG_FREEZE) -> bus type freeze() -> driver freeze()

Now, the bus type freeze() need not be suitable for your run-time PM, so you'd
probably call the driver freeze() directly.  However, the DPM_* flags tell the
core which _bus_ _type_ callback has been called last, so I don't think you can
generally reuse them for the run-time case.  Thus I think there should be a
separate flag for the run-time PM.

Of course, there's the question how to make the run-time PM and
suspend/hibernation play well together and I think it may be done by teaching
the bus type freeze() and friends about the runtime PM flag.

I agree that it might make sense to introduce the run-time PM flag at the core
level so that various bus types don't reinvent the wheel each time they decide
to implement run-time PM.

> So I'd like to be able to freeze individual devices independently of
> each other. And then there's lots of architecture specific work that
> needs to be done. =)

Yes, there is.

> >> On top of this I'd like to allow device drivers to mark devices as
> >> idle. And if a device is marked idle then I'd like to allow power
> >> management code to perform freeze() on a single device. After that
> >> marking the device frozen using DPM_FROZEN. poweroff() may also be
> >> called to perform some partial system suspend. It gets more
> >> complicated of course, but I guess we need a way to know the state of
> >> each device regardless.
> >
> > We have discussed that for several times already IIRC and the conclusion has
> > always been that such things should better be done at the bus type level, not
> > at the core level.
> 
> Doing things at the bus type level sounds fine with me. I'm mainly
> interested in platform devices.

Fine.

> > If you look at the PCI power management code, you'll notice that the drivers'
> > PM callbacks are not called directly by the core, but they are called by the
> > PCI bus type PM callbacks which in turn carry out some bus-specific operations
> > before or after executing the drivers' callbacks.  However, these bus-specific
> > operations generally need not be suitable for run-time power management of
> > devices (they are designed with system-wide power transitions in mind).
> > Also, such things as PM events signalling (eg. a device has been suspended
> > at run time, but there's activity on the device which causes it to notify the
> > kernel and the device signals the event somehow) tend to be bus-specific or
> > platform-specific.
> 
> Right. Seems like a good design to me.
> 
> Most things seem to be driven from system wide suspend/resume though.
> I'm more interested in performing partial system suspend during
> runtime. From for instance cpuidle.

That, IMO, may be done by applying the run-time PM handling to each of the
devices in question.

> > USB, where run-time power management has already been
> > implemented, is a good example too.
> 
> That's great, but it doesn't help us entering deep sleep states on our SoCs. =)

Well, you still can have a look at it and see how it's done. :-)

Thanks,
Rafael
