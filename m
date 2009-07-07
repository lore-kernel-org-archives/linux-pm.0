From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Introduce core framework for
	run-time PM of I/O devices (rev. 8)
Date: Wed, 8 Jul 2009 00:07:37 +0200
Message-ID: <200907080007.38595.rjw__26625.4868045964$1247004593$gmane$org@sisk.pl>
References: <200907060252.12755.rjw@sisk.pl>
	<aec7e5c30907070812n7b418c9bobf64a5259cb6c58d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <aec7e5c30907070812n7b418c9bobf64a5259cb6c58d@mail.gmail.com>
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 07 July 2009, Magnus Damm wrote:
> Hi Rafael,
> 
> On Mon, Jul 6, 2009 at 9:52 AM, Rafael J. Wysocki<rjw@sisk.pl> wrote:
> > Hi,
> >
> > There's a rev. 8 of the run-time PM framework patch.
> >
> > Highlights:
> > * I did my best to follow the design we've recently discussed.
> > * pm_runtime_[get|put]() and the sync versions call
> >  pm_[request|runtime]_[resume|idle](), because I don't see much point
> >  manipulating the usage counter alone.
> > * pm_runtime_disable() carries out a (synchronous) wake-up if there's a
> >  resume request pending.
> >
> > Comments welcome.
> 
> I've now jumped from v5 to v8 and I feel that the code is getting
> cleaner and cleaner. Very nice.

That's mostly thanks to Alan.

> My intention was to post a SuperH prototype last week, but I got side
> tracked with other stuff. And today I ran into some problems related
> to probe() that I'd like to ask about right away. At this point I've
> got a few device drivers converted and some simple bus
> runtime_suspend()/runtime_resume() code that stop and start clocks.
> 
> Issue 1:
> ------------
> Device drivers which do not perform any hardware access in probe()
> work fine. During software setup in probe() the runtime pm code is
> initialized with the following:
> 
> +	pm_suspend_ignore_children(&dev->dev, true);
> +	pm_runtime_set_suspended(&dev->dev);
> +	pm_runtime_enable(&dev->dev);
> 
> Before accessing hardware I perform:
> +	pm_runtime_resume(pd->dev);
> 
> When done with the hardware I do:
> +	pm_runtime_suspend(pd->dev);
> 
> Not so complicated. Am I supposed to initialize something else as well?
> 
> All good with the code above, but there seem to be some issue with how
> usage_count is counted up and down and when runtime_disabled is set:
> 
> 1. pm_runtime_init(): usage_count = 1, runtime_disabled = true
> 2. driver_probe_device(): pm_runtime_get_sync()
> 3. pm_runtime_get_sync(): usage_count = 2
> 4. device driver probe(): pm_runtime_enable()
> 5. pm_runtime_enable(): usage_count = 1
> 6. driver_probe_device(): pm_runtime_put()
> 7. pm_runtime_put(): usage_count = 0
> 
> I expect runtime_disabled = false in 7. Modifying the get/put calls to
> do enable/disable may work around the issue, but that's probably not
> what you guys want.

Sure, that's my mistake.  I should have used a separate counter for
disable/enable, but I thought usage_counter would be sufficient.  Will fix.

> Issue 2:
> ------------
> I cannot get any bus ->runtime_resume() callbacks from probe(). This
> also seems related to usage_count and pm_runtime_get_sync() in
> driver_probe_device(). Basically, from probe(), calling
> pm_runtime_resume() after pm_runtime_set_suspended() results in error
> and not in a ->runtime_resume() callback. Some device drives access
> hardware in probe(), so the ->runtime_resume() callback is needed at
> that point to turn on clocks before the hardware can be accessed.

I think the problem is that pm_runtime_get_sync() in driver_probe_device()
calls ->runtime_resume(), so the device is active from the core's point of
view when you call pm_runtime_resume() from probe().

Hmm.  OK, perhaps we should just increment usage_count in
driver_device_probe() to prevent suspends from happening at that time, without
calling ->runtime_resume() so that the driver can do it by itself.  I'll do
that in the next version.

> Random thought:
> -------------------------
> The runtime_pm_get() and runtime_pm_put() look very nice. I assume
> that inteface is supposed to be used by bus code. I wonder if it would
> be cleaner to use a similar counter based interface from the driver
> instead of the pm_runtime_idle()/suspend()/resume()...
> 
> Let me know what you think!

In fact I thought drivers could also use pm_runtime_[get|put]() and the 'sync'
versions.  At least, I don't see why not at the moment (well, I'm a bit tired
right now ...).

However, I'm now thinking it should work like this:

* pm_runtime_get() increments usage_count and if it was zero before the
  incrementation, it calls pm_request_resume() (pm_runtime_resume() is called
  by the 'sync' version).

* pm_runtime_put() decrements usage_count and if it's zero after the
  decrementation, it calls pm_request_idle() (pm_runtime_idle() is called by
  the 'sync' version).

* The 'suspend' callbacks won't succeed for usage_count > 0.

This way we would avoid calling the 'suspend' and 'idle' functions each time
unnecessarily, but then usage_count would have to be modified under the
spinlock only.

Best,
Rafael
