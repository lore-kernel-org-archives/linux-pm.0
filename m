From: Patrick Mochel <mochel-og82NyAXoxR0I81aPRRTmR2eb7JE58TQ@public.gmane.org>
Subject: Re: Some thoughts on suspend/resume development
Date: Fri, 11 Mar 2005 09:38:11 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0503110921070.31362-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0503051036440.22405-100000@netrider.rowland.org>
	<Pine.LNX.4.50.0503080831160.31139-100000@monsoon.he.net>
	<1110341383.12485.57.camel@localhost.localdomain>
	<Pine.LNX.4.50.0503090522140.9502-100000@monsoon.he.net>
	<1110405526.12485.130.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============82043535812601198=="
In-Reply-To: <1110405526.12485.130.camel-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Adam Belay <abelay-Et1tbQHTxzrQT0dZR+AlfA@public.gmane.org>
Cc: Linux-pm mailing list <linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--===============82043535812601198==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Wed, 9 Mar 2005, Adam Belay wrote:

> On Wed, 2005-03-09 at 05:54 -0800, Patrick Mochel wrote:
> > On Tue, 8 Mar 2005, Adam Belay wrote:

> > In general, we will always want to try to power down children, but even if
> > we can't, we still want to try to power down the parents. They just have
> > to know when it's safe to do it, which requires some extra checking, but
> > recall that parent devices are less common than leaf devices and the
> > checks can be done for an entire class of devices (like all PCI-PCI
> > bridges) and re-used for each instance.
> >
> > All in all, though, this is a corner case, and not neceesary in the
> > immediate future.
>
> I think we need to power down the individual devices even if they don't
> have a driver.  Cutting off the power domain without first powering down
> its children may possibly reduce the operating life of the devices.  If
> the power domain is turned off then context is lost anyway, so nothing
> is gained by leaving them on.
>
> The ideal solution is to have a driver for every device to save and
> restore state (though not always possible).  The model I suggested
> (start, open, etc) allows the user to disable a device while keeping the
> driver bound to it.  Therefore, even if the user has decided to not use
> the device, its power can be properly managed anyway.

Agreed. To do this, we need some sort of default driver to save
configuration space, or to handle it by the bus's layer.

This was suggested a very long time ago, but the consensus was that it's
imperative that all drivers be the master of their own destiny, and that
we don't do e.g. pci_save_state() for every driver on their behalf. That
said, we can a) leave drivers to control the call when they're bound to a
device, b) do it by default for devices that don't have a driver, and c)
add some sort of blacklist for devices that are buggy and don't handle it
well.

> > > > This would be doing something like partial-tree suspends, but I'm not sure
> > > > if this is best done in the kernel or in userspace with a proper tool.
> > >
> > > The basic strategy would be to lower the state of each child device, and
> > > then when all children are in a lower state, lower the parent (the power
> > > domain) to the least common denominator power state.  I think this would
> > > have to be done in the kernel because userspace may not be able to
> > > operate during this transition.
> >
> > Why not?
>
> Lets say the userspace program is located on a storage device.  If the
> program disables the device, it may not be able to complete the process
> and disable the remaining devices (of course the access could enable the
> storage device again, but then the suspend will also fail).
> Furthermore, it may not be able to handle the resume procedure.  In
> short, I'm worried that a userspace utility will not be able to manage
> hardware that it requires for its own operation.

Fair enough, I was just wondering.

> > > > > A common problem facing all drivers that do auto suspend is how to set
> > > > > the inactivity timeout.  Two possible answers are: add an attribute
> > > > > file in the /sys/.../power directory (so different devices can have
> > > > > different timeouts), or add a driver module parameter (so all devices
> > > > > using the same driver will have the same timeout).
> > >
> > > Each class could have its own policies, complete with timeout values.  In
> > > sysfs, the user could select which policy should be used. (e.g. performance,
> > > normal, powersave).
> >
> > I would think it would be better to have a per-device policy that is
> > perhaps derived from the bus. You want a different timeout value for each
> > device state, which is bus-specific. The concepts of 'performance',
> > 'powersave', and 'normal' are policy decisions that are best left for the
> > UI. The only thing the kernel should care about are the specific values of
> > the timers. What each threshold is, is system-specific and should be able
> > to be adjusted. It should also be a requirement of the UI that it apply
> > the same policy (performanc, normal, powesave, etc) to all devices in a
> > specific class.
>
> So you'd like specific timer values to be sysfs entries?

Yes. The kernel should only implement the mechanism, not the policy or the
UI. That's what utilties are for. :)

> > For a parent device, remember that those are rare compared to the majority
> > of other device they are bridge devices that understand the semantics of
> > devices on the other side of them. It is up to them to decide if/when they
> > should power down, and how much.
>
> Ok, but they still need to show what power state they require of their
> parent device.  I suppose they should be responsible for knowing about
> the power-states of any parent bus-type they might have.

Yes. They play two roles - a client of one bus type and a host of another.
On the one hand, they're requiring power from someone, and on the other,
they're providing for a set of devices. For the former, they are not much
different than any other device on the bus; it's just that they have
different semantics for knowing when they can power off.


	Pat


--===============82043535812601198==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

_______________________________________________
linux-pm mailing list
linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
http://lists.osdl.org/mailman/listinfo/linux-pm

--===============82043535812601198==--
