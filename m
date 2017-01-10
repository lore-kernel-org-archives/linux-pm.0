From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [RFC PATCH 1/5] regulator: Extend the power-management APIs
Date: Tue, 10 Jan 2017 09:33:55 +0100
Message-ID: <20170110093355.700f8225@bbrezillon>
References: <1480687036-5037-1-git-send-email-boris.brezillon@free-electrons.com>
        <1480687036-5037-2-git-send-email-boris.brezillon@free-electrons.com>
        <20170109191758.7zzxeh45pvwiw3jo@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:53084 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757458AbdAJIeJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jan 2017 03:34:09 -0500
In-Reply-To: <20170109191758.7zzxeh45pvwiw3jo@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org

Hi Mark,

On Mon, 9 Jan 2017 19:17:58 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Dec 02, 2016 at 02:57:12PM +0100, Boris Brezillon wrote:
> 
> > The idea to solve #2 is to allow runtime changes. Since this kind of
> > change is likely to have an impact on the whole system, we require the
> > board to explicitly state that runtime changes are allowed (using a DT
> > property).  
> 
> > Allowing runtime changes, may also be a problem if devices are not
> > suspended in the correct order: a device using a regulator should be
> > suspended before the regulator itself, otherwise we may change the
> > regulator state while it's still being used.
> > Hopefully, this problem will be solved with the work done on device
> > dependency description.  
> 
> I'm not sure that adding an extra property is going to help with the
> problems here - the system already has to provide explicit support for
> setting the suspend configuration so that should be enough.

I'm not a big fan of this DT property either, but after our discussion
on IRC I had the feeling you wanted it to be as safe as possible, and
since changing the regulator config at runtime is far more dangerous
than asking the regulator to enter a specific state after everything has
been suspended, I thought you would prefer to have an extra property
stating that entering suspend state at runtime is authorized (meaning
it's safe to do it). 

> However it
> *is* a bit more than just making sure that the device suspend ordering
> is good (though that's definitely part of it), there will be things
> kicked off by hardware signalling without software knowing about it.

Do you have an example, so that I can understand the use case?

> 
> Anything that doesn't affect a hardware supported runtime state probably
> needs to be split off and handled separately as that's the much more
> risky bit

Just to be sure, you mean regulator devices that do not support the
->set_suspend_xx() hooks, right?

>, moving changing of suspend mode earlier isn't going to cause
> too much grief, that patch should just be split out and can probably
> just go straight in.

Yes, I just thought it would be clearer to have everything implemented
in the same function. Since calling ->set_suspend_xx() does not have
any impact on the runtime state, it can be called whenever we want
(assuming we can still communicate with the regulator device to
configure this suspend state).
But if you prefer to have it split out in 2 different function, with the
'set suspend mode' bits called from the regulator_suspend_begin(), I'm
fine with that.

> 
> > + * This function should be called from the regulator driver ->suspend() hook
> > + * and after the platform has called regulator_suspend_begin() to properly set
> > + * the rdev->suspend.target field.  
> 
> Requring these functions to be called from every single driver seems
> like we're doing something wrong - if we're going to do this we should
> find some way to loop over all regulators and apply any unapplied
> changes.

I agree. Actually, I forgot that we had PM ops at the device class
level. Maybe we could just move these generic ->suspend()/->resume()
implementation here.

> Batching things up at the end of suspend would also mean that
> we'd be able to minimise the chances that we get the ordering wrong.

Unfortunately that's not possible, for the exact same reason calling
regulator_suspend_prepare() from the platform ->prepare() hook did not
work for me: at that point, all devices have been suspended, and this
includes the i2c controller which we're using to communicate with the
PMIC exposing those regulators.
This leaves 2 solutions:

1/ Apply the suspend state earlier (before the devices ->suspend()
   hooks have been called)
2/ Rely on the device model dependency graph, and enter the suspend
   state when the regulator device is being suspended (this is the
   solution I'm proposing in this patch).

Solution #1 is acceptable if we omit the case where one regulator
consumer (another device) is depending on the regulator to be setup
properly until the device has been suspended. But this still leaves the
'apply suspend state as late as possible' problem, and in this regards,
solution #1 is clearly not the best option.

Solution #2 might not be perfect right now, but it should benefit from
all the work done by Rafael on 'device dependency tracking' and
'suspend/resume ordering'.

> 
> For the target bit...  we should be able to find some way to figure out
> what kind of suspend we're doing without the platform being involved, a
> callback from the PM core would be helpful here.

Yep, I agree. Rafael, what's your opinion?

Thanks for your comments.

Boris
