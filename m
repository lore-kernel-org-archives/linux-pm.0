From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: pm_runtime_enable() in ->probe()
Date: Mon, 3 Nov 2014 15:06:44 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1411031501210.8744-100000@iolanthe.rowland.org>
References: <7hwq7ci5hu.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:50151 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753393AbaKCUGp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Nov 2014 15:06:45 -0500
In-Reply-To: <7hwq7ci5hu.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

[CC: list drastically trimmed]

On Mon, 3 Nov 2014, Kevin Hilman wrote:

> >> All that said there is a logical error related to calling pm_runtime_enable()
> >> and its derivatives from ->probe() that I've been overlooking pretty much
> >> from the start.
> >> 
> >> Namely, really_probe() sets dev->driver to drv before calling ->probe()
> >> for either the bus type or the driver itself, so if the driver's probe
> >> calls pm_runtime_enable(), it will execute the driver's own runtime PM
> >> resume callback before the driver can check whether or not it wants to handle
> >> the device in the first place.  That doesn't sound quite right to me.
> >> 
> >> This means we need a different mechanism to ensure that the device will
> >> be accessible to the driver and/or the bus type in ->probe().
> >> 
> >> At one point we had pm_runtime_get_sync() before really_probe() in
> >> driver_proble_device() IIRC, but people complained about it, so we dropped it
> >> and put a barrier in there instead, but that's not sufficient.
> >
> > So we actually had pm_runtime_get_noresume() before the barrier, but then
> > we dropped it due to complaints.
> >
> >> We need to explicitly ensure that the device won't be powered off while
> >> ->probe() is in progress *but* we need to avoid calling the driver's runtime
> >> PM resume callback before ->probe() returns.
> >
> > I wonder, then, if we just need to do pm_runtime_get_sync() instead of the
> > barrier and then pm_runtime_put() instead of pm_request_idle() in
> > driver_probe_device()?
> 
> Won't we still have the same problems in the case of ->probe failure
> that were fixed by removing those calls[1]?
> 
> IOW, after the driver's ->probe returns failure, it's no longer safe to
> call the driver's runtime PM callbacks, since they may be accessing
> resources that no longer exits.
> 
> Hmm, thinking a little more, maybe this kind of failure is a good time
> for the driver to use pm_runtime_force_suspend(), then later when the PM
> core does the _put(), it will see the device aleady suspended and there
> shouldn't be any problems.
> 
> So I think I'm OK with this approach, in theory.

I still think this needs to be handled at the level of the subsystem 
and device driver, not at the level of the PM core.  If somebody needs 
to insure that the device won't be powered off while the probe routine 
is running, the subsystem/driver should take care of it.

After all, as Kevin points out, sometimes we really _do_ want the
device to end up powered-down when the probing is finished.  There's
no way the PM core can guess what the driver layer will want in the
end.

Alan Stern

