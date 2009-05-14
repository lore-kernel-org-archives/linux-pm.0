From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: dev->status.power and future of DPM_
Date: Thu, 14 May 2009 11:14:17 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0905141101220.3004-100000@iolanthe.rowland.org>
References: <aec7e5c30905132118m265245f4u9d9581b3fde788f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <aec7e5c30905132118m265245f4u9d9581b3fde788f6@mail.gmail.com>
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

On Thu, 14 May 2009, Magnus Damm wrote:

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
> 
> So I read through the code again. How about this matrix:
> 
> (function, in-function-change-DPM_, after-DPM_ [error-DPM_])
> 
> device_suspend(), PREPARING/SUSPENDING/OFF/ON, OFF [ON]
> device_power_down(), OFF_IRQ/OFF, OFF_IRQ, [OFF/unchanged]
> device_power_up(), OFF, OFF/unchanged
> device_resume(), RESUMING/ON, ON/unchanged
> 
> Basically, dev->power.status seems to represent the soon to be state
> of each device.

No, that's wrong.  It doesn't represent the state of the device at all,
in spite of its name.  Rather, it is a record of which messages have
been sent (or are about to be sent) from the PM core to the device's
driver.

> For instance, before calling prepare() PREPARING is
> set. Have a look at the JPG that I attached in the previous email.
> 
> Am I misunderstanding?

Yes.

> I'd like to keep the state of each device somewhere.

You can't, or at least, you can't keep it anywhere under dev->power.  
That's because the "state" is very device-specific or bus-specific.  
It's not possible to come up with any sort of general indicator that
applies to all devices.

> Earlier this year I've focused on adding power management to the
> SuperH architecture. So in upstream 2.6.30 we now have suspend to disk
> and suspend to ram working for most sleep modes. Currently I'm
> focusing on run time power management (cpu idle, clock framework) and
> deeper sleep modes. This is all upstream activity.
> 
> Entering deeper sleep modes will result in that parts of the SoC get
> powered off. This is true for SuperH Mobile and SoCs from other
> vendors as well. Before turning off power to a certain part of the SoC
> we have to save the state of all the devices located there. And after
> powering up we need to restore the state of each device.
> dev_pm_ops->freeze() and ->restore() seem like good candidates for
> doing that.

dev_pm_ops->freeze() and ->restore() are meant to be used by the PM
core.  It's not up to the PM core to keep track of the device state;
that job belongs to the device's driver.

> So I'd like to be able to freeze individual devices independently of
> each other. And then there's lots of architecture specific work that
> needs to be done. =)

Be careful of your choice of words.  Do you really mean "freeze"?  
That's very different from going to a low-power state.  In fact, a 
"frozen" device generally should remain at full power.  Being "frozen" 
simply means that the device isn't doing I/O or DMA.

> Doing things at the bus type level sounds fine with me. I'm mainly
> interested in platform devices.

Sure, that's fine.  But it means you can't use the fields in
dev->power.  You have to add new fields to the bus-specific or
platform-specific data structures.

> > USB, where run-time power management has already been
> > implemented, is a good example too.
> 
> That's great, but it doesn't help us entering deep sleep states on our SoCs. =)

It should, because it provides an example of how your code ought to be 
structured.

Alan Stern
