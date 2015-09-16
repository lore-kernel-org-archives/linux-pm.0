From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] driver core: Ensure proper suspend/resume ordering
Date: Wed, 16 Sep 2015 15:22:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1509161503470.1993-100000@iolanthe.rowland.org>
References: <20150916131641.GA13618@ulmo>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150916131641.GA13618@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 16 Sep 2015, Thierry Reding wrote:

> > > Perhaps moving to the end of the list needs to be a little smarter. That
> > > is it could check whether the device has been prepared for suspension or
> > > not and only move when it hasn't?
> > 
> > Maybe.  But doesn't that mean it won't solve your problem completely?
> 
> It would solve the problem completely if probing was prohibited during
> the suspend/resume cycle. But if that were true there'd be no need to
> special-case in the first place.

It's possible that this approach will help.  We'll see.

It would also help if your patch checked to see if the device has any 
children, and avoided moving it to the end of the list if it does.  In 
fact, that might be sufficient to avoid almost all problems.

> > > Then again, shouldn't the core even prohibit new probes once the suspend
> > > has been triggered? Sounds like asking for a lot of trouble if it didn't
> > > ...
> > 
> > The core prohibits new devices from being registered.  It does not 
> > prohibit probes of existing devices, because they currently do not 
> > affect the dpm_list.
> 
> My understanding was that the core was guaranteed not to call suspend or
> resume callbacks for devices that haven't completed probe.

No, that's not so.  The core invokes suspend and resume callbacks for 
all registered devices.

>  At least I've
> never seen any driver code specifically check in their suspend or resume
> callbacks that they've been probed successfully.

Now that wouldn't make any sense, would it?  A driver's suspend or
resume callback wouldn't be invoked in the first place unless the
driver had already been probed for that device.  So there's no point in
checking whether the probe has occurred.

>  Allowing probes while a
> suspend is happening sounds racy.

Yes, it does.  It definitely isn't a good idea.

During a sleep transition all user threads are frozen.  So are some
kernel threads, but not all of them.  It's possible that one of the
running kernel threads might want to do a probe -- something in a
workqueue, for example.  That's the only way it could happen.

> > In general, we rely on subsystems not to do any probing once a device 
> > is suspended.  It's probably reasonable to ask them not to do any 
> > probing once a device has gone through the "prepare" stage.
> 
> Perhaps the reason why we seem to be talking across purposes is that I
> haven't thought much about devices where the bus does all the heavy
> lifting. So suspending the device from a bus' perspective makes sense
> even if the device hasn't been bound.

Yes.

> And yes, I agree that preventing a probe for a device that has been
> prepared for suspension sounds like a very reasonable thing to do.
> 
> > > > There's also an issue about other types of dependencies.  For instance,
> > > > it's conceivable that device B might be discovered and depend on device
> > > > A, even before A has been bound to a driver.  (B might be discovered by 
> > > > A's subsystem rather than A's driver.)  In that case, moving A to the 
> > > > end of the list would cause B to come before A even though B depends on 
> > > > A.  Of course, deferred probing already has this problem.
> > > 
> > > But that's exactly the problem that I'm seeing.
> > 
> > Not quite.
> > 
> > >  B isn't discovered by
> > > A's subsystem, but the type of dependency is the same. A in this case
> > > would be the GPIO controller and B the gpio-keys device. B clearly
> > > depends on A, but deferred probe currently moves A to the end of the
> > > list but not A, hence why the problem occurs.
> > 
> > The difference is that in my example, B can be probed before A.  In
> > your case it can't.  Therefore the patch works for your case but not
> > for mine.
> 
> How would that even work in practice? Essentially you have a dependency
> between two devices and no way of guaranteeing any ordering. Either the
> dependency is completely optional, in which case the ordering of the
> dpm_list must be irrelevant to the interaction, or the drivers make too
> many assumptions and it is only working by accident.

Rafael gave a good example.  A device behind a PCIe port can't be
detected until the port has been registered, so the port will always
get on the dpm_list before the other device does.  But both devices can
be added before the port has been probed.

This dependency is not optional and it is guaranteed.  But it's not 
related to anything the drivers do.

> > > That's also a problem that I think this patch solves. By moving every
> > > device to the end of the list before it is probed we ensure that the
> > > dpm_list is ordered in the same way as the probe order. For this to work
> > > the precondition of course is that drivers know about the dependencies
> > > and will defer probe if necessary.
> > 
> > Do I understand correctly?  You're saying a driver must defer a probe
> > if the device it's probing depends on another device which hasn't
> > been bound yet.  That does not sound like a reasonable sort of
> > requirement -- we might know about the dependency but we shouldn't have
> > to check whether the prerequisite device has been bound.
> 
> I guess that depends on the kind of dependency you have. For most cases
> that I'm aware of the dependencies are required dependencies. That is, a
> consumer uses a resource registered by a provider. The provider will
> register the resource at probe time, so if the consumer is probed before
> the provider, then the resource it needs isn't there. For a required
> dependency that implies that the consumer must defer probe until the
> provider has been bound because it simply can't continue without getting
> access to the resource first.

Okay.  It would be a good idea to restrict your patch to handle only 
that particular kind of dependency, if you can think of any way to do 
this.

> I'm slightly confused by your statement. If a consumer depends on a
> provider for a resource, how can we finish the consumer's probe without
> checking that the provider has been bound? It's true that we don't
> technically check for the device to have been bound, but the end result
> is the same.
> 
> Unless I misunderstand what you're saying we'd need to have some
> mechanism to notify the consumer (after it's been probed) that the
> provider of it's resource has become available.

You misunderstand me.  Yes, I agree that your patch handles the case 
where a consumer depends on a provider for a resource.  But it doesn't 
handle the case where one device depends on another for something other 
than a resource (or perhaps for a resource that can be provided even in 
the absence of a driver).

Alan Stern
