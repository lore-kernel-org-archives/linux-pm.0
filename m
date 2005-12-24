From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Re: Hotplug events during sleep transition
Date: Fri, 23 Dec 2005 16:23:46 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0512231544530.28944-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0512231122310.17020-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============26055055073768107=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0512231122310.17020-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============26055055073768107==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Fri, 23 Dec 2005, Alan Stern wrote:

> On Fri, 23 Dec 2005, Patrick Mochel wrote:
>
> > > I agree with Dmitry.  Many drivers don't need to do anything special for
> > > suspend, or only need to cancel an outstanding input request.  Rather than
> > > go through every single driver and add a minimal (and possibly erroneous)
> > > suspend routine, it's much easier just to unbind these drivers.
> >
> > So why not fix the subsystems to do the equivalent of an unbinding, from
> > a tear-down and reinitialization standpoint? That way, you don't have to
> > force the core to contort itself simply for the fact that you want to push
> > in a thumbtack with a sledgehammer?
>
> That sounds very dangerous.  You would end up with a situation where the
> driver thinks it has been unbound but the core thinks it is still bound.
> Not to mention that some drivers, as part of their unbind routines, unbind
> themselves from other interfaces -- these would be true, actual
> unbindings.

What? No, you are trying to make it sound way more complicated than it
needs to be. I didn't say anything about unbinding - I was only talking
about tearing down the device (aka 'shutting down the device' aka
'quiescing the device' aka 'whatever the ->remove() routine does to the
device').

If there was a way to do that, then you wouldn't need to unbind/rebind the
driver to the device. See next paragraph.

> > Think about what is happening. It's been discovered that shutting down the
> > device and reinitializing the device performs all the correct actions to
> > get the device up and running again after a suspend/resume cycle.
>
> ?  I don't follow you at all.  What does shutting down the device have to
> do with what we're talking about?  I'm trying to unbind a _driver_, not do
> anything to the _device_.  As far as I know, the device doesn't need any
> sort of special treatment to work okay with suspend/resume.

Then what is the point of unbinding in the first place. If the device
doesn't need any special treatment, then all you're doing is tinkering
with data structures, which should be completely unnecessary (unless for
some reason the data structures are left in some incomplete state, which
is cause for greater alarm).

The reason why it makes sense to unbind/rebind drives is because the
device accesses on ->remove() and ->probe() do enough to put the device to
bed and bring back up again. (Note that's the context I was speaking with
for the last couple of mesages.) Any other reason to unbind/rebind seems
very fishy.

> >  All you have to do for each suspend routine is mimic that effect. It
> > arguably doesn't require any serious knowledge about the device - it
> > only needs a copy of the ->probe() and ->remove() routines (or the
> > functional equivalent for those devices), without the allocation and
> > freeing of data structures.
>
> Why go to all the trouble of copying probe and remove when we can call the
> actual existing routines?

Because all you want to do is stop and start the device. Unbinding and
rebinding do a whole lot more. A device does an entire round trip through
the driver core, which does a lot of crap. There are several memory
allocations, perhaps dozens of sysfs files created, and a handful of locks
taken adn lists traversed.

No, it's not on the fast path, but it's just simply inefficient. Not to
mention that even if you do get the userspace notification correct, you're
unnecessarily creating work to do for devices that have not really been
removed and re-added.

> > In fact, this sounds an awful lot like the ->start() / ->stop() methods
> > that have been proposed over the years. I would say that it's time to give
> > that concept some serious thought and start implementing them in drivers.
> > That way, for devices that don't actually do hardware PM, we can still get
> > them down and back up again, without having to worry about those scary
> > ->suspend()/->resume() methods. :-)
>
> Start and stop are no more or less scary than suspend and resume.

It was a joke, based on the fact that you're treating the PM calls as some
hideous monster. C'mon, it can't be that hard to implement something that
does the exact same device acceses as happen in ->probe() and ->remove().

>  _Any_ routine that hasn't been implemented and subjected to testing is
> going to be less reliable than one that has been around and in use for a
> long time (such as probe and resume).  Furthermore, I don't see any
> advantage to changing both the core (to add start and stop) as well as
> changing all the drivers, as opposed to simply changing all the drivers
> (to add suspend and resume).

For the record, the changes to the core are trivial. And, I wasn't
advocating that we change the core and every driver to add ->start() and
->stop() in lieu of simply adding ->suspend() and ->resume(). I think that
they should all be added in due time.

> > I don't find justification to your argument in avoiding to fix drivers. We
> > don't change the core when it means the impact would be to change every
> > driver. And, we shouldn't change the core to avoid fixing a subset of
> > drivers. The number of drivers that it affects should not be 100% of them.
>
> The issue of registering and unregistering devices during a sleep
> transition has come up before.  It's not going to go away.  We should
> find a good way to deal with it.

Like fix the drivers so that they don't have to be unregistered and
re-registered? That seems like a proper long term solution.

>  Changing the core hotplug support so that new unfrozen processes don't
> get started up while everything else is frozen seems to me like a fairly
> small, cheap way of getting things to work properly.

Sure, it should be easy. Stop the hotplug thread; or just kill it.

Regardless, it doesn't change the fact that the drivers are still not
working properly. They exhibit working behavior, but they are strictly
dependent on the behavior of an independent subsystem. So now we have to
make changes to the hotpug code simply to accomodate some other
half-implemented code.

That's a dangerous situtation, because it could prevent us from changing
the hotplug code (or any other subsystem that must be changed to
accomodate incomplete PM implementations) in the future.

Sure, it's a small change now, and there are "lots of drivers" that would
have to be fixed otherwise. But, what happens in 5 years when we want to
do something totally different, and people are still ignoring the call to
implement suspend/resume support (that is now 10 years old). Breaking all
the drivers then will be a lot more painful than buckling down and fixing
them now.

> Furthermore, Greg KH has stated that many (or even most) USB drivers
> shouldn't need to have special support for suspend/resume added.  I'm not
> sure whether he intended that these drivers should be unbound during a
> suspend, but that's the easiest way to handle them.

Fine, see below.

> > And, as I mentioned before, it should be +/- simple, and without any of
> > the (unknown) side-effects of binding/unbinding. You said 'possibly
> > erroneous', but I fail to see how this would be any more dangerous than
> > unbinding/binding.
>
> Binding and unbinding have been part of every USB driver from the day they
> were first written.  They have gotten _lots_ of testing and are known to
> work well.  The same cannot be said for new suspend/resume routines.

And, this is going to help that disparity how?

People have been avoiding adding PM support for five years now. By a
stroke of luck, USB didn't need it, and things just worked. So, what now?
Do we tiptoe around that in the rest of the driver/PM/hotplug core, or do
not worry about the shortcomings of some drivers, accept the fact there is
going to be some work to do, and do things right?

I say the latter. And, I say that there should be no hotplug events during
suspend/resume.

If some drivers require that they be unbound before suspend, then I have a
very simple solution - do it in userspace. It's damn easy to unload the
driver module, then to reload it again. Push it on to the distros. Write
some scripts. Create a black/white/blue list of drivers that must be
unloaded. Problem solved. Not only that, but it also prevents us from
getting hotplug events during the suspend transition.

Thanks,


	Patrick


--===============26055055073768107==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============26055055073768107==--
