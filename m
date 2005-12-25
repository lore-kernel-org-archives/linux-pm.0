From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hotplug events during sleep transition
Date: Sat, 24 Dec 2005 21:56:58 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0512242115030.9591-100000@netrider.rowland.org>
References: <Pine.LNX.4.50.0512231544530.28944-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============74739716976819048=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0512231544530.28944-100000@monsoon.he.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============74739716976819048==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 23 Dec 2005, Patrick Mochel wrote:

> > > So why not fix the subsystems to do the equivalent of an unbinding, from
> > > a tear-down and reinitialization standpoint? That way, you don't have to
> > > force the core to contort itself simply for the fact that you want to push
> > > in a thumbtack with a sledgehammer?
> >
> > That sounds very dangerous.  You would end up with a situation where the
> > driver thinks it has been unbound but the core thinks it is still bound.
> > Not to mention that some drivers, as part of their unbind routines, unbind
> > themselves from other interfaces -- these would be true, actual
> > unbindings.
> 
> What? No, you are trying to make it sound way more complicated than it
> needs to be. I didn't say anything about unbinding -

I can't resist pointing out that you _did_ say, just above: "So why not
fix the subsystems to do the equivalent of an unbinding...".

>  I was only talking
> about tearing down the device (aka 'shutting down the device' aka
> 'quiescing the device' aka 'whatever the ->remove() routine does to the
> device').
> 
> If there was a way to do that, then you wouldn't need to unbind/rebind the
> driver to the device. See next paragraph.

> Then what is the point of unbinding in the first place. If the device
> doesn't need any special treatment, then all you're doing is tinkering
> with data structures, which should be completely unnecessary (unless for
> some reason the data structures are left in some incomplete state, which
> is cause for greater alarm).
> 
> The reason why it makes sense to unbind/rebind drives is because the
> device accesses on ->remove() and ->probe() do enough to put the device to
> bed and bring back up again. (Note that's the context I was speaking with
> for the last couple of mesages.) Any other reason to unbind/rebind seems
> very fishy.

The way you wrote this indicates you don't understand the problem we're 
trying to solve, so I'd better explain more fully.

We're not worried about quiescing the device, putting it to bed, or
whatever.  That will happen just fine, all by itself.

The problem is that the _driver_ needs to be quiesced.  It shouldn't try
to do any I/O during a system sleep.  Partly because any attempted I/O
will fail once the USB device has been suspended, partly because during a
short time interval (between suspending the USB interface and suspending
the USB device) the I/O will succeed but still shouldn't occur, and partly
because the attempt will leave the driver in a not-well-defined error
state.

Now perhaps things aren't quite so strict.  With many drivers it might be 
okay to let them deal with I/O failures.  It's not elegant, though.

> Because all you want to do is stop and start the device.

Stop and start the _driver_, not the device.  But maybe you regard those
two phrases as meaning the same thing.

>  Unbinding and
> rebinding do a whole lot more. A device does an entire round trip through
> the driver core, which does a lot of crap. There are several memory
> allocations, perhaps dozens of sysfs files created, and a handful of locks
> taken adn lists traversed.

No, you're thinking of unregistering and re-registering a device or
driver.  Unbinding and rebinding is much simpler, although still somewhat
complex.

> No, it's not on the fast path, but it's just simply inefficient. Not to
> mention that even if you do get the userspace notification correct, you're
> unnecessarily creating work to do for devices that have not really been
> removed and re-added.

Again, this concerns drivers and not devices.  But yes, it is extra work.


> > The issue of registering and unregistering devices during a sleep
> > transition has come up before.  It's not going to go away.  We should
> > find a good way to deal with it.
> 
> Like fix the drivers so that they don't have to be unregistered and
> re-registered? That seems like a proper long term solution.

Unbound and rebound, not unregistered and re-registered.  Yes, changing 
all the drivers would mean we could avoid unbinding and rebinding them.  
It's not at all clear that this would an optimal solution, however, in 
terms of either code size or maintainability.

> Sure, it should be easy. Stop the hotplug thread; or just kill it.
> 
> Regardless, it doesn't change the fact that the drivers are still not
> working properly. They exhibit working behavior, but they are strictly
> dependent on the behavior of an independent subsystem. So now we have to
> make changes to the hotpug code simply to accomodate some other
> half-implemented code.
> 
> That's a dangerous situtation, because it could prevent us from changing
> the hotplug code (or any other subsystem that must be changed to
> accomodate incomplete PM implementations) in the future.
> 
> Sure, it's a small change now, and there are "lots of drivers" that would
> have to be fixed otherwise. But, what happens in 5 years when we want to
> do something totally different, and people are still ignoring the call to
> implement suspend/resume support (that is now 10 years old). Breaking all
> the drivers then will be a lot more painful than buckling down and fixing
> them now.

Well, the hotplug thread thing is now a separate issue.  And maybe one we
don't need to worry about...

> > Furthermore, Greg KH has stated that many (or even most) USB drivers
> > shouldn't need to have special support for suspend/resume added.  I'm not
> > sure whether he intended that these drivers should be unbound during a
> > suspend, but that's the easiest way to handle them.
> 
> Fine, see below.

> > Binding and unbinding have been part of every USB driver from the day they
> > were first written.  They have gotten _lots_ of testing and are known to
> > work well.  The same cannot be said for new suspend/resume routines.
> 
> And, this is going to help that disparity how?
> 
> People have been avoiding adding PM support for five years now. By a
> stroke of luck, USB didn't need it, and things just worked. So, what now?
> Do we tiptoe around that in the rest of the driver/PM/hotplug core, or do
> not worry about the shortcomings of some drivers, accept the fact there is
> going to be some work to do, and do things right?
> 
> I say the latter. And, I say that there should be no hotplug events during
> suspend/resume.
> 
> If some drivers require that they be unbound before suspend, then I have a
> very simple solution - do it in userspace. It's damn easy to unload the
> driver module, then to reload it again. Push it on to the distros. Write
> some scripts. Create a black/white/blue list of drivers that must be
> unloaded. Problem solved. Not only that, but it also prevents us from
> getting hotplug events during the suspend transition.

At this point I'm starting to feel like the proverbial 
"man-in-the-middle".  Recently I submitted a patch adding suspend/resume 
support to the usblp driver.  Greg objected to it because it added 
explicit checks for whether the driver was suspended before starting up 
I/O operations.  He said that such checks did not belong in USB drivers, 
they belonged in the USB core.  (You can read his original comments in

http://marc.theaimsgroup.com/?l=linux-usb-devel&m=113418897301873&w=2

.)  So now what should we do?

	Require userspace to rmmod usblp before suspending?

	Add suspend and resume methods to usblp, but make it so they
	only cancel outstanding I/O, while relying on usbcore to fail
	any new I/O requests?

Neither of those feels good to me.  The only other options I can think of 
are:

	Unbind usblp in lieu of suspending it.

	Make usblp check whether it is suspended before submitting any
	I/O requests.

These have been ruled out by you and Greg.

Alan Stern


--===============74739716976819048==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============74739716976819048==--
