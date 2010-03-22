From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: runtime PM ops and PCMCIA bus
Date: Mon, 22 Mar 2010 11:38:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1003221045130.1606-100000__36943.7277703129$1269272494$gmane$org@iolanthe.rowland.org>
References: <20100321224546.GA23626@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100321224546.GA23626@comet.dominikbrodowski.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Magnus Damm <damm@igel.co.jp>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-pcmcia@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Sun, 21 Mar 2010, Dominik Brodowski wrote:

> Hey!
> 
> On the PCMCIA bus, implementing runtime PM "should" be simple.

Ha!  There always are lots of little issues that make it more 
complicated than it seems...

> However, there's a major caveat: the bus must be able to
> force devices to suspend, or force them to resume during
> runtime. Let's discuss this in detail:
> 
> (1) Converting the PCMCIA bus to dev_pm_ops seems easy:
> 
>     pcmcia_dev_suspend() needs to get rid of its second argument,
>     then it's just a 
> 
>     SET_SYSTEM_SLEEP_PM_OPS(pcmcia_dev_suspend, pcmcia_dev_resume)

Yes.

> (2) Whenever two functions local to drivers/pcmcia/ds.c --
>     runtime_suspend() or runtime_resume() -- are called,
>     we need to force a synchronous call to pcmcia_dev_suspend(),
>     or to pcmcia_dev_resume(). Currently, we do this by taking
>     device_lock() and calling the function manually.

That seems like the right thing to do.  (Except that I don't know what 
your device_lock() routine is for.)

> (3) However, it'd be much nicer to be able to use the new runtime
>     PM interface.

I don't understand.  Aren't runtime_suspend() and runtime_resume(), as 
mentioned above, already part of your runtime PM interface?  Or at 
least, intended to be part of your runtime PM interface?

> As the PCMCIA bus can always suspend,

Is that really literally true?  Don't you run into trouble if you try
to suspend while a data transfer is taking place?  And if you've got a 
whole series of transfers going on, does it really make sense to 
suspend after each individual transfer, only to resume immediately when 
the next transfer comes along?

How long should a pcmcia device have to remain idle before suspending 
it will actually end up saving energy?

How does your driver determine when the device becomes idle (and just
as important, stops being idle)?

>     pcmcia_dev_idle() might only contain a call to
> 
> 	pm_schedule_suspend(dev, 0) - or pm_runtime_suspend() ?

pm_schedule_suspend(dev, 0) is exactly the same as
pm_request_suspend(dev).  Either way involves going through a
workqueue, whereas pm_runtime_suspend() invokes the runtime_suspend
method directly.  So there's no reason not to call
pm_runtime_suspend().

>     To enable it, we should add
> 
>        pm_runtime_set_active(&p_dev->dev);
>        pm_runtime_enable(&p_dev->dev);
> 
>     in pcmcia_device_add().

Yes.

> (4) What is then to be done to modify runtime_suspend() / runtime_resume() ?
>     Is it:
> 
> + static int runtime_suspend(struct device *dev)
> + {
> + 	pm_runtime_put_noidle(dev);
> + 	return pm_runtime_suspend(dev);
> + }

This makes no sense at all.  pm_runtime_suspend() calls your 
runtime_suspend() function, not the other way around.

> + static int runtime_resume(struct device *dev)
> + {
> + 	return pm_runtime_get_sync(dev);
> + }

Likewise.

>     or more something like
> 
> 
> +  static int runtime_suspend(struct device *dev)
> + {
> + 	return pm_runtime_put_sync(dev);
> + }
> + 
> + static int runtime_resume(struct device *dev)
> + {
> + 	return pm_runtime_get_sync(dev);
> + }

Ditto.  As far as I can see, those routines don't need to be changed at 
all -- except perhaps to avoid suspending the device while it is being 
used.  Maybe your device_lock() handles that.

>     and modifying pcmcia_dev_idle() to call pm_runtime_suspend() instead of
>     pm_schedule_suspend()?

That's correct assuming you want to suspend right away when 
pcmcia_dev_idle() runs.

> (5) Another problem I'm seeing with the put/get approach: there are three
>     different callpaths where runtime_suspend() / runtime_resume() might
>     be called.[*] However, each one decreases the counter, which might get < 0.

The counter should never become negative; if it does, there's a bug in
your driver.  Every decrement should match a corresponding increment,
just like with refcounts.  And the device should never be
runtime-suspended unless the counter is 0.

>     What to do? Using pm_runtime_suspended seems racy...

What exactly is the problem?  Are you worried about the
pcmcia_store_pm_state() routine?  It's not clear to me that the routine
is needed.  One of the background assumptions behind the runtime PM
framework is that users don't tell the system when to suspend devices.  
Instead, the system automatically suspends devices when it realizes
they aren't being used.

Note that suspending a device is different from turning it off.  When a
device is off, it stays off -- it doesn't get turned on automatically
when a process tries to use it.  But a runtime-suspended device _does_
get resumed automatically as needed.

So if pcmcia_store_pm_state() is meant to turn the device off, then it
shouldn't use the runtime PM framework.  If it is meant only to suspend
the device then it shouldn't exist.

> (6) As pcmcia_dev_resume() is used -- as per UNIVERSAL_DEV_PM_OPS -- what is
>     needed there to set the runtime PM state correctly if we do not wake up
>     the device during system sleep suspend?

Why would you wake up the device during a system sleep suspend?  
Surely you want to _suspend_ the device at that time.

Perhaps you meant to ask about setting the runtime PM state correctly 
during system sleep _resume_?  That is handled for you automatically by 
the UNIVERSAL_DEV_PM_OPS routines -- and it requires you always to wake 
up the device during a resume from system sleep, even if the device had 
been runtime-suspended when the sleep began.

> Pseudo patch -- untested and probably broken [see at least (5) above]
> attached. Any feedback is most welcome.
> 
> Best,
> 	Dominik
> 
> [*] 1) by echoing the state into a device sysfs file.
>     2) by echoing the state into a socket sysfs file.

See above.

>     3) during "resets" of the socket -- we need to suspend devices
>            first, then physically reset the socket, then resume the devices
> 	   on the card.

Temporary resets like these should be done without affecting the 
devices' runtime PM state.  Call your pcmcia_dev_suspend() and 
pcmcia_dev_resume() routines directly without going through the runtime 
PM framework.  At the end of the reset, since the devices have been 
resumed, you should inform the runtime PM core by doing:

	pm_runtime_disable(dev);
	pm_runtime_set_active(dev);
	pm_runtime_enable(dev);

You do have to worry about the possibility that the PM core might issue
a runtime suspend or runtime resume request while the reset is in
progress.  How you deal with that depends on the way your driver and
subsystem are designed.  One possible approach is to call
pm_runtime_get_sync(dev) before starting the reset and
pm_runtime_put_sync(dev) after everything is finished.

> diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
> index caca50e..551fcdb 100644
> --- a/drivers/pcmcia/Kconfig
> +++ b/drivers/pcmcia/Kconfig
> @@ -20,6 +20,7 @@ if PCCARD
>  config PCMCIA
>  	tristate "16-bit PCMCIA support"
>  	select CRC32
> +	select PM_RUNTIME

This seems very wrong.  Why do you need it?  Can't the pcmcia subsystem 
work correctly without runtime PM support?  Hasn't it been working 
correctly that way all along?

The other changes involve things discussed above, so there's no need to 
repeat them here.

Alan Stern
