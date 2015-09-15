From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Tue, 15 Sep 2015 15:18:19 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509151505040.1420-100000@iolanthe.rowland.org>
References: <20150915161047.GC25966@ulmo.nvidia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:56141 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751070AbbIOTSU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2015 15:18:20 -0400
In-Reply-To: <20150915161047.GC25966@ulmo.nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 15 Sep 2015, Thierry Reding wrote:

> > There are a few things to watch out for.  Since the dpm_list gets
> > modified during system sleep transitions, we would have to make sure
> > that nothing gets probed during those times.  In principle, that's what
> > the "prepare" stage is meant for, but there's still a race.  As long as
> > no other kernel thread (such as the deferred probing mechanism) tries
> > to probe a device once everything has been frozen, we should be okay.
> > But if not, there will be trouble -- after the ->prepare callback runs, 
> > the device is no longer on the dpm_list and so we don't want this patch 
> > to put it back on that list.
> 
> Perhaps moving to the end of the list needs to be a little smarter. That
> is it could check whether the device has been prepared for suspension or
> not and only move when it hasn't?

Maybe.  But doesn't that mean it won't solve your problem completely?

> Then again, shouldn't the core even prohibit new probes once the suspend
> has been triggered? Sounds like asking for a lot of trouble if it didn't
> ...

The core prohibits new devices from being registered.  It does not 
prohibit probes of existing devices, because they currently do not 
affect the dpm_list.

In general, we rely on subsystems not to do any probing once a device 
is suspended.  It's probably reasonable to ask them not to do any 
probing once a device has gone through the "prepare" stage.

> > There's also an issue about other types of dependencies.  For instance,
> > it's conceivable that device B might be discovered and depend on device
> > A, even before A has been bound to a driver.  (B might be discovered by 
> > A's subsystem rather than A's driver.)  In that case, moving A to the 
> > end of the list would cause B to come before A even though B depends on 
> > A.  Of course, deferred probing already has this problem.
> 
> But that's exactly the problem that I'm seeing.

Not quite.

>  B isn't discovered by
> A's subsystem, but the type of dependency is the same. A in this case
> would be the GPIO controller and B the gpio-keys device. B clearly
> depends on A, but deferred probe currently moves A to the end of the
> list but not A, hence why the problem occurs.

The difference is that in my example, B can be probed before A.  In
your case it can't.  Therefore the patch works for your case but not
for mine.

> That's also a problem that I think this patch solves. By moving every
> device to the end of the list before it is probed we ensure that the
> dpm_list is ordered in the same way as the probe order. For this to work
> the precondition of course is that drivers know about the dependencies
> and will defer probe if necessary.

Do I understand correctly?  You're saying a driver must defer a probe
if the device it's probing depends on another device which hasn't
been bound yet.  That does not sound like a reasonable sort of
requirement -- we might know about the dependency but we shouldn't have
to check whether the prerequisite device has been bound.

> > An easy way to check for this sort of thing would be to verify that a 
> > device about to be probed doesn't have any children.  This wouldn't 
> > catch all the potential dependencies, but it would be a reasonable 
> > start.  Do we currently check that after a device has been unbound, it 
> > doesn't have any remaining children?  We should do that too.
> 
> I think that would cover the other half of the cases where deferred
> probe isn't implemented because drivers are written with the assumption
> that children will be instantiated after their parent has been probed.
> 
> But it won't catch all the cases where there is no parent-child
> relationship between the depender and the dependee.

No, it won't catch all cases.  But the cases it does catch are ones 
where your patch is likely to cause trouble, so it would be good to 
know about them.

Alan Stern

