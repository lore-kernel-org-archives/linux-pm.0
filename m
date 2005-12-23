From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hotplug events during sleep transition
Date: Fri, 23 Dec 2005 11:52:03 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0512231122310.17020-100000@netrider.rowland.org>
References: <Pine.LNX.4.50.0512230722510.19327-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============18292266904380106=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.50.0512230722510.19327-100000@monsoon.he.net>
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

--===============18292266904380106==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 23 Dec 2005, Patrick Mochel wrote:

> > I agree with Dmitry.  Many drivers don't need to do anything special for
> > suspend, or only need to cancel an outstanding input request.  Rather than
> > go through every single driver and add a minimal (and possibly erroneous)
> > suspend routine, it's much easier just to unbind these drivers.
> 
> So why not fix the subsystems to do the equivalent of an unbinding, from
> a tear-down and reinitialization standpoint? That way, you don't have to
> force the core to contort itself simply for the fact that you want to push
> in a thumbtack with a sledgehammer?

That sounds very dangerous.  You would end up with a situation where the
driver thinks it has been unbound but the core thinks it is still bound.  
Not to mention that some drivers, as part of their unbind routines, unbind
themselves from other interfaces -- these would be true, actual 
unbindings.

> Think about what is happening. It's been discovered that shutting down the
> device and reinitializing the device performs all the correct actions to
> get the device up and running again after a suspend/resume cycle.

?  I don't follow you at all.  What does shutting down the device have to 
do with what we're talking about?  I'm trying to unbind a _driver_, not do 
anything to the _device_.  As far as I know, the device doesn't need any 
sort of special treatment to work okay with suspend/resume.

>  All you
> have to do for each suspend routine is mimic that effect. It arguably
> doesn't require any serious knowledge about the device - it only needs a
> copy of the ->probe() and ->remove() routines (or the functional
> equivalent for those devices), without the allocation and freeing of data
> structures.

Why go to all the trouble of copying probe and remove when we can call the
actual existing routines?

> In fact, this sounds an awful lot like the ->start() / ->stop() methods
> that have been proposed over the years. I would say that it's time to give
> that concept some serious thought and start implementing them in drivers.
> That way, for devices that don't actually do hardware PM, we can still get
> them down and back up again, without having to worry about those scary
> ->suspend()/->resume() methods. :-)

Start and stop are no more or less scary than suspend and resume.  _Any_
routine that hasn't been implemented and subjected to testing is going to
be less reliable than one that has been around and in use for a long time
(such as probe and resume).  Furthermore, I don't see any advantage to
changing both the core (to add start and stop) as well as changing all the
drivers, as opposed to simply changing all the drivers (to add suspend and
resume).

> I don't find justification to your argument in avoiding to fix drivers. We
> don't change the core when it means the impact would be to change every
> driver. And, we shouldn't change the core to avoid fixing a subset of
> drivers. The number of drivers that it affects should not be 100% of them.

The issue of registering and unregistering devices during a sleep 
transition has come up before.  It's not going to go away.  We should 
find a good way to deal with it.  Changing the core hotplug support so 
that new unfrozen processes don't get started up while everything else is 
frozen seems to me like a fairly small, cheap way of getting things to 
work properly.

Furthermore, Greg KH has stated that many (or even most) USB drivers 
shouldn't need to have special support for suspend/resume added.  I'm not 
sure whether he intended that these drivers should be unbound during a 
suspend, but that's the easiest way to handle them.

> And, as I mentioned before, it should be +/- simple, and without any of
> the (unknown) side-effects of binding/unbinding. You said 'possibly
> erroneous', but I fail to see how this would be any more dangerous than
> unbinding/binding.

Binding and unbinding have been part of every USB driver from the day they 
were first written.  They have gotten _lots_ of testing and are known to 
work well.  The same cannot be said for new suspend/resume routines.

> If these drivers are maintained, then the maintainers should have no
> problem doing what's mentioned above. In fact, some janitors could
> probably do it. If the drivers are unmaintained, then perhaps they don't
> belong in the kernel anyway?

I'll leave that for Greg to answer.

Alan Stern


--===============18292266904380106==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============18292266904380106==--
