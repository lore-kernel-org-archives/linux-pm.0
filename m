From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Re: Hotplug events during sleep transition
Date: Fri, 23 Dec 2005 07:35:49 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0512230722510.19327-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0512231018040.15462-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============089829349382668067=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0512231018040.15462-100000@netrider.rowland.org>
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

--===============089829349382668067==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Fri, 23 Dec 2005, Alan Stern wrote:

> On Thu, 22 Dec 2005, Dmitry Torokhov wrote:
>
> > On Thursday 22 December 2005 22:49, Patrick Mochel wrote:
> > >
> > > On Thu, 22 Dec 2005, Alan Stern wrote:
> > >
> > > > I'm not so sure this approach really qualifies as a "hack".  If a driver
> > > > doesn't have explicit support for suspend/resume, the best way to quiesce
> > > > it is to unbind it.  The only alternative is to fail all of its I/O
> > > > requests, which seems much less reliable.
> > >
> > > Hmm, the best way to queisce it seems to be to fix the driver. Sure, that
> > > doesn't solve your problems now, but that is the ideal solution, no? Until
> > > then, band-aids like unbinding the device from the driver is only a remedy
> > > to a symptom; not a cure..
> > >
> >
> > Quite often unbinding is easiest and also correct way. I would love to be
> > able to just unbind serio port/input device and have it recreated later.
> > Unfortunately X/GPM do not [yet?] support hotplugging of devices so kernel
> > has to compensate.
>
> I agree with Dmitry.  Many drivers don't need to do anything special for
> suspend, or only need to cancel an outstanding input request.  Rather than
> go through every single driver and add a minimal (and possibly erroneous)
> suspend routine, it's much easier just to unbind these drivers.

So why not fix the subsystems to do the equivalent of an unbinding, from
a tear-down and reinitialization standpoint? That way, you don't have to
force the core to contort itself simply for the fact that you want to push
in a thumbtack with a sledgehammer?

Think about what is happening. It's been discovered that shutting down the
device and reinitializing the device performs all the correct actions to
get the device up and running again after a suspend/resume cycle. All you
have to do for each suspend routine is mimic that effect. It arguably
doesn't require any serious knowledge about the device - it only needs a
copy of the ->probe() and ->remove() routines (or the functional
equivalent for those devices), without the allocation and freeing of data
structures.

In fact, this sounds an awful lot like the ->start() / ->stop() methods
that have been proposed over the years. I would say that it's time to give
that concept some serious thought and start implementing them in drivers.
That way, for devices that don't actually do hardware PM, we can still get
them down and back up again, without having to worry about those scary
->suspend()/->resume() methods. :-)

I don't find justification to your argument in avoiding to fix drivers. We
don't change the core when it means the impact would be to change every
driver. And, we shouldn't change the core to avoid fixing a subset of
drivers. The number of drivers that it affects should not be 100% of them.

And, as I mentioned before, it should be +/- simple, and without any of
the (unknown) side-effects of binding/unbinding. You said 'possibly
erroneous', but I fail to see how this would be any more dangerous than
unbinding/binding.

If these drivers are maintained, then the maintainers should have no
problem doing what's mentioned above. In fact, some janitors could
probably do it. If the drivers are unmaintained, then perhaps they don't
belong in the kernel anyway?

Thanks,


	Patrick


--===============089829349382668067==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============089829349382668067==--
